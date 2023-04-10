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
    homepageUrl = "https://example.com/home",
    supportUrl = "https://example.com/support",
    version = "0.1.0",
    author = "Thisago",
    runAt = GmRunAt.docStart,
    icon = "https://git.ozzuu.com/avatars/74711a273f7822e03d8802980c725d85?size=870",
    excludeMatch = [
      "*://duckduckgo/*",
      "*://bing/",
    ],
    exclude = [
      "*://google/*",
      "*://bing/",
    ],
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
    GM.openInTab("https://example.com", false)),
  ondone = (proc() =
    console.log("DONE")))

  GM.notification("second", "title", onclick = (proc() =
    console.log("CLICK")))

  await GM.setValue("a", "test")
  console.log(await GM.listValues())

  GM.xmlHttpRequest("https://example.com", "GET", onload = (proc(a: JsObject) =
      console.log a),
    headers = {
      "referrer": "about:blank"
    })
