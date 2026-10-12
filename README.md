# keila-ja

[Keila](https://github.com/pentacent/keila) with a Japanese translation of its
public pages: double opt-in confirmation, unsubscribe, expired link, thank-you
page. The admin interface stays as upstream ships it.

```
ghcr.io/v0idnil/keila:<keila version>-ja
```

A GitHub Action builds the official Keila release with this overlay applied, the
same way upstream builds its image (`ops/Dockerfile`, `WITH_EXTRA=1`). It runs
daily and builds every new upstream release that has no `-ja` image yet.

## Language selection

Keila picks the page language from `?lang=ja` on the link, then the session, then
the browser's `Accept-Language`. A Japanese mail template can force Japanese with
`{{ unsubscribe_link }}?lang=ja`.

## Contents

- `priv/gettext/ja/LC_MESSAGES/*.po`: the translations
- `apply.sh <keila-source-dir>`: copies them in and adds `"ja"` to the Gettext
  locales in `config/config.exs`. Fails if that file has changed shape.
- `.github/workflows/build.yml`: the build

Strings Keila adds in later versions show in English until they are translated
here. Nothing breaks.

## License

AGPL-3.0, like Keila. The image's source is Keila at the matching tag plus this
repository.
