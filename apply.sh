#!/usr/bin/env bash
# Adds the Japanese translation to a Keila source tree.
#
# Usage: apply.sh <keila-source-dir>
#
# Copies priv/gettext/ja into the tree and adds "ja" to the :locales list of
# KeilaWeb.Gettext in config/config.exs. "ja" is deliberately NOT added to
# KeilaWeb.Gettext.available_locales/0: that list feeds the admin language
# menu, and only the public pages are translated.
#
# Fails loudly if config.exs no longer has the expected shape, so an upstream
# change breaks the build instead of silently shipping without Japanese.
# Dependencies: bash, perl, grep.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
src=${1:?usage: apply.sh <keila-source-dir>}
cfg="$src/config/config.exs"

[ -f "$cfg" ] || { echo "apply.sh: $cfg not found" >&2; exit 1; }

cp -R "$here/priv/gettext/ja" "$src/priv/gettext/"

has_ja() { perl -0ne 'exit(/config :keila, KeilaWeb\.Gettext,[^\]]*?locales: \[[^\]]*"ja"/s ? 0 : 1)' "$cfg"; }

if ! has_ja; then
  perl -0pi -e 's/(config :keila, KeilaWeb\.Gettext,[^\]]*?locales: \[)/$1"ja", /s' "$cfg"
fi
has_ja || { echo "apply.sh: could not add \"ja\" to the Gettext locales in $cfg" >&2; exit 1; }

echo "apply.sh: Japanese added to $src"
