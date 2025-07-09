# check_sunshine_update
# • returns 0  – update available (or not installed)
# • returns 1  – already up-to-date
# • returns 2+ – error conditions
check_sunshine_update() {
  local repo="LizardByte/Sunshine"
  local pkg="sunshine"                       # dpkg package name
  local asset="sunshine-ubuntu-24.04-amd64.deb"

  # --- fetch latest-release JSON ---
  local json
  if ! json=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest"); then
    echo "❌  Could not reach GitHub" >&2; return 2
  fi

  # --- extract tag (e.g. v0.23.2 → 0.23.2) ---
  local latest_ver
  latest_ver=$(jq -r '.tag_name' <<<"$json" | sed 's/^v//')
  [[ -z $latest_ver ]] && { echo "❌  Tag missing"; return 3; }

  # --- make sure the Ubuntu-24.04 asset is part of this release ---
  if ! jq -e --arg a "$asset" '.assets[] | select(.name==$a)' <<<"$json" >/dev/null; then
    echo "⚠️   Asset «$asset» not in latest release $latest_ver" >&2
    return 4
  fi

  # --- discover installed version (blank if not installed) ---
  local current_ver
  current_ver=$(dpkg-query -W -f='${Version}' "$pkg" 2>/dev/null || true)

  echo "Sunshine: current=${current_ver:-<not installed>}   latest=$latest_ver"

  if [[ -z $current_ver ]] || dpkg --compare-versions "$latest_ver" gt "$current_ver"; then
    echo "⬆️   Update available"
    # optional: automatically fetch the download URL
    # url=$(jq -r --arg a "$asset" '.assets[] | select(.name==$a).browser_download_url' <<<"$json")
    # echo "Download: $url"
    return 0
  else
    echo "✅  Already up-to-date"
    return 1
  fi
}

check_sunshine_update
