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
  nimble install https://git.ozzuu.com/thisago/gm_api
  ```

Or

- Manually
  ```bash
  git clone https://git.ozzuu.com/thisago/gm_api
  cd gm_api/
  nimble install
  ```

## TODO

- [ ] Change nimble url from gitea to github

## Projects using it

- [safeWriting](https://git.ozzuu.com/thisago/safeWriting)

## License

MIT
