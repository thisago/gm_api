# GM_api

Bindings to use GM api and create userscript headers on the fly

## See [changelog](changelog.md)

Avaliable functions:

- genMetadataBlock

- GM.info - Not working to me
- GM.getValue
- GM.setValue
- GM.deleteValue
- GM.listValues
- GM.notification
- GM.openInTab
- GM.registerMenuCommand
- GM.setClipboard
- GM.xmlHttpRequest

## Installation

Please choice one installation method:

- Automatically with nimble
  ```bash
  nimble install gm_api
  ```
  or
  ```bash
  nimble install https://github.com/thisago/gm_api
  ```

Or

- Manually
  ```bash
  git clone https://github.com/thisago/gm_api
  cd gm_api/
  nimble install
  ```

## Docs

See docs in [Github pages](https://thisago.github.io/gm_api/gm_api.html)

## TODO

- [ ] Change nimble url from gitea to github

## Projects using it

- [safeWriting](https://github.com/thisago/safeWriting)

## License

MIT
