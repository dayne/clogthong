# Clogthong Tools

Wedgie irritating your toes?  Get them unstuck with more tools.

## Submodules

Here’s an example where a gist is added as a submodule to a Git repository:

1. **Gist URL**: `https://gist.github.com/johndoe/abcdef123456.git`
2. **Target Directory in Repo**: `submodules/my-gist`

Commands:

```sh
cd /path/to/your/repo
git submodule add https://gist.github.com/johndoe/abcdef123456.git submodules/my-gist
git submodule update --init --recursive
git add .gitmodules submodules/my-gist
git commit -m "Added my-gist as a submodule"
git push origin main
```

That’s it! You’ve successfully added a gist as a submodule to your Git repository.

## Tools

### Ruby

### Chruby
