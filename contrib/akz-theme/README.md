# AKZ development sources

Server installation: run `sudo bash install.sh` from the package root. Read [INSTALL.md](../../INSTALL.md) for prerequisites, supported paths and rollback behavior.

## Optional CSS editing

The server consumes `framework/html/themes/akz/css/akz-tailwind.css` directly. JavaScript is readable source. Only developers changing CSS need the pinned build tooling:

```sh
cd contrib/akz-theme
npm ci --ignore-scripts
npm run build:css
```

Commit the generated CSS with changes to `ui/*.css`; do not deploy raw Tailwind directives. Preflight is disabled and generated utility classes use the `tw-` prefix. Theme CSS loads after framework/module headers.

`manage.sh` is shared verbatim between the two editions; the wrappers select a fixed theme and operation. Keep both copies synchronized on main. Runtime files are independent of this development toolchain.
