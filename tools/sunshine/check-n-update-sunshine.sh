#-----------------------------------------------------------------------
# check_sunshine_update  → just compares versions (see previous message)
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# update_sunshine
# • returns 0 – updated (or freshly installed)
# • returns 1 – already current, nothing done
# • returns 2+ – error conditions
#-----------------------------------------------------------------------
update_sunshine() {
  local repo="LizardByte/Sunshine"
  local asset="sunshine-ubuntu-24.04-amd64.deb"
  local pkg="sunshine"

  # ── 1. Query GitHub release JSON (only once) ─────────────────────────
  local json
  if ! json=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest"); then
    echo "❌  Cannot reach GitHub" >&2; return 2
  fi

  # ── 2. Extract latest version + download URL ─────────────────────────
  local latest_ver
  latest_ver=$(jq -r '.tag_name' <<<"$json" | sed 's/^v//')
  [[ -z $latest_ver ]] && { echo "❌  Tag missing"; return 3; }

  local url
  url=$(jq -r --arg a "$asset" '.assets[] | select(.name==$a).browser_download_url' <<<"$json")
  [[ -z $url || $url == "null" ]] && { echo "⚠️  Asset «$asset» not found in release $latest_ver"; return 4; }

  # ── 3. Compare with installed version ───────────────────────────────
  local current_ver
  current_ver=$(dpkg-query -W -f='${Version}' "$pkg" 2>/dev/null || true)

  if [[ -n $current_ver ]] && ! dpkg --compare-versions "$latest_ver" gt "$current_ver"; then
    echo "✅  Sunshine is already up-to-date ($current_ver)"; return 1
  fi

  echo "⬇️  Downloading Sunshine $latest_ver …"
  local tmp="/tmp/$asset"
  if ! curl -fL -o "$tmp" "$url"; then
    echo "❌  Download failed"; return 5
  fi

  echo "📦  Installing (requires sudo)…"
  if ! sudo apt install -y "$tmp"; then
    echo "❌  apt install failed"; return 6
  fi

  # Optional: restart the daemon if it exists
  if systemctl list-units --type=service | grep -q '^sunshine\.service'; then
    sudo systemctl restart sunshine
  fi

  echo "🎉  Sunshine updated to $latest_ver"
  return 0
}

update_sunshine
