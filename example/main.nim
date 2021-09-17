#[
  Created at: 07/04/2021 11:12:25 Sunday
  Modified at: 09/17/2021 01:07:50 AM Friday

        Copyright (C) 2021 Thiago Navarro
  See file "license" for details about copyright
]#

{.experimental: "codeReordering".}

import jsconsole
import gm_api
import asyncjs
import jsffi


when isMainModule:
  const metadataBlock = genMetadataBlock(
    name = "Userscript example",
    nameTranslations = {"pt-br": "Exemplo de userscript"},
    description = "A simple example to test the GM bindings in Nim",
    descriptionTranslations = {"pt-br": "Um simples exemplo para testar bindings para o GM no Nim"},
    grant = [
      GmPermitions.info,
      GmPermitions.listValues,
      GmPermitions.setValue,
      GmPermitions.getValue,
      GmPermitions.notification,
      GmPermitions.openInTab,
      GmPermitions.registerMenuCommand,
      GmPermitions.setClipboard,
      GmPermitions.xmlHttpRequest,
    ],
    require = [
      # "https://arantius.com/misc/greasemonkey/imports/greasemonkey4-polyfill.js",
    ],
    resource = {
      "avatar": "https://gitea.com/avatars/be2da4e8a9cbffdc433db9058105a1ce?size=112"
    },
    homepageUrl = "http://localhost/home",
    supportUrl = "http://localhost/support",
    version = "0.1.0",
    author = "Thisago",
    runAt = GmRunAt.docStart,
    icon = "https://gitea.com/avatars/be2da4e8a9cbffdc433db9058105a1ce?size=112",
    match = [
      "*://localhost/*",
    ],
    `include` = [
      "*://127.0.0.1/*",
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
  discard main()

proc main {.async.} =
  # console.log(GM.info()) # Not working
  console.log(await GM.listValues())
  console.log(await GM.getValue("a", "unknown"))
  console.log(unsafeWindow)
  GM.registerMenuCommand("testMenu", (proc() =
    console.log("menu clicked")),
  "t")
  GM.registerMenuCommand("copy 'Nim' to clipboard", (proc() =
    GM.setClipboard("Nim")
    console.log "copied"),
  "t")
  # console.log GM.xmlHttpRequest()
  GM.notification("text", "title", onclick = (proc() =
    console.log("CLICK")
    GM.openInTab("http://localhost", false)),
  ondone = (proc() =
    console.log("DONE")))

  GM.notification("second", "title", onclick = (proc() =
    console.log("CLICK")))

  await GM.setValue("a", "test")
  console.log(await GM.listValues())

  GM.xmlHttpRequest("http://localhost/", "GET", onload = (proc(a: JsObject) =
      console.log a),
    headers = {
      "referrer": "about:blank"
    })
