<!--
  Created at: 07/04/2021 13:24:16 Sunday
  Modified at: 08/05/2021 01:37:42 PM Thursday
-->

# GM_api

Bindings to use GM api and create userscript headers on the fly

## See [changelog](changelog.md)

Version 0.2.0

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
  nimble install https://gitea.com/thisago/gm_api
  ```

Or

- Manually
  ```bash
  git clone https://gitea.com/thisago/gm_api
  cd gm_api/
  nimble install
  ```

## Projects using it

- [safeWriting](https://github.com/thisago/safeWriting)

## License

MIT
