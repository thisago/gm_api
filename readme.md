<!--
  Created at: 07/04/2021 13:24:16 Sunday
  Modified at: 09/17/2021 01:15:59 AM Friday

        Copyright (C) 2021 Thiago Navarro
  See file "license" for details about copyright
-->

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

## TODO

- [ ] Change nimble url from gitea to github

## Projects using it

- [safeWriting](https://github.com/thisago/safeWriting)

## License

MIT
