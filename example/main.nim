#[
  Created at: 07/04/2021 11:12:25 Sunday
  Modified at: 07/04/2021 01:21:14 PM Sunday
]#

import jsconsole
import gm_api

when isMainModule:
  const metadataBlock = genMetadataBlock(
    name = "Userscript example\nconsole.log('test')",
    nameTranslations = {"pt-br": "Exemplo de userscript"},
    description = "A simple example to test the GM bindings in Nim",
    descriptionTranslations = {"pt-br": "Um simples exemplo para testar os bindings do GM no Nim"},
    grant = [
      GmPermitions.info
    ],
    require = [
      # "http://127.0.0.1/u3/apache/www/libs/button/button.js",
    ],
    resource = {
      "customCss": "http://127.0.0.1/u3/apache/www/libs/button/button.css"
    },
    homepageUrl = "http://localhost/home",
    supportUrl = "http://localhost/support",
    version = "0.1.0",
    author = "Thisago",
    runAt = GmRunAt.docStart,
    icon = "https://gitea.com/avatars/be2da4e8a9cbffdc433db9058105a1ce?size=112",
    match = [
      "*://localhost/*",
      "*://127.0.0.1/*",
    ],
    `include` = [
      "*://localhost/*",
      "*://localhost/",
    ],
    excludeMatch = [
      "*://duckduckgo/*",
      "*://bing/",
    ],
    exclude = [
      "*://google/*",
      "*://bing/",
    ],
    downloadUrl = "file:///data/os/dev/nim/lib/gm_api/example/main.js",

  )
  {.emit: metadataBlock.} # Use the metadatablock into js code

  console.log metadataBlock
  console.log(GM.info())
