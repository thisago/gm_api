#[
  Created at: 07/04/2021 10:58:31 Sunday
  Modified at: 07/04/2021 01:23:49 PM Sunday
]#

type
  GmType = object
  GmInfo* = object
    ## All data returned from `GM.info()`
    uuid*: cstring
    scriptMetaStr*: cstring
    scriptWillUpdate*: bool
    scriptHandler*: cstring
    version*: cstring
    platform*: GmInfoPlatform

  GmInfoArch* = enum
    ## The possible architectures
    arm, mips, mips64, `x86-32`, `x86-64`
  GmInfoOs* = enum
    ## The possible operating systems
    android, cros, linux, mac, openbsd, win

  GmInfoPlatform* = object
    ## The information about the client platform
    arch*: GmInfoArch
    browserName*: cstring
    browserVersion*: cstring
    os*: GmInfoOs

proc info*(gm: GmType): GmInfo {.importcpp.}

let GM* {.importc, noDecl.}: GmType

# Metadata block

type
  GmPermitions* {.pure.} = enum
    info, getValue, setValue, deleteValue, listValues, addValueChangeListener,
      removeValueChangeListener, getResourceText, getResourceURL, addStyle,
      openInTab, registerMenuCommand, unregisterMenuCommand, notification,
      setClipboard, xmlhttpRequest, download, winClose, winFocus

  GmRunAt* {.pure.} = enum
    ## Decide when the script will execute.
    docStart,
    docBody,
    docEnd,
    docIdle
  GmInjectInto* {.pure.} = enum
    ## Decide which context the script will be injected into.
    page, content, `auto`

proc `$`*(self: GmPermitions): string =
  case self:
  of GmPermitions.info: "GM.info"
  of GmPermitions.getValue: "GM.getValue"
  of GmPermitions.setValue: "GM.setValue"
  of GmPermitions.deleteValue: "GM.deleteValue"
  of GmPermitions.listValues: "GM.listValues"
  of GmPermitions.addValueChangeListener: "GM.addValueChangeListener"
  of GmPermitions.removeValueChangeListener: "GM.removeValueChangeListener"
  of GmPermitions.getResourceText: "GM.getResourceText"
  of GmPermitions.getResourceURL: "GM.getResourceURL"
  of GmPermitions.addStyle: "GM.addStyle"
  of GmPermitions.openInTab: "GM.openInTab"
  of GmPermitions.registerMenuCommand: "GM.registerMenuCommand"
  of GmPermitions.unregisterMenuCommand: "GM.unregisterMenuCommand"
  of GmPermitions.notification: "GM.notification"
  of GmPermitions.setClipboard: "GM.setClipboard"
  of GmPermitions.xmlhttpRequest: "GM.xmlhttpRequest"
  of GmPermitions.download: "GM.download"
  of GmPermitions.winClose: "window.close"
  of GmPermitions.winFocus: "window.focus"

proc `$`*(self: GmRunAt): string =
  case self:
  of GmRunAt.docStart: "document-start"
  of GmRunAt.docBody: "document-body"
  of GmRunAt.docEnd: "document-end"
  of GmRunAt.docIdle: "document-idle"

from strformat import fmt
from strutils import join, unindent, replace

proc genMetadataBlock*(
  # project
  name: string;                                              ## Required *
  nameTranslations: openArray[(string, string)] = [];        ## Optional
  namespace = "Violentmonkey Scripts";                       ## Optional
  description = "New Nim userscript";                        ## Optional
  descriptionTranslations: openArray[(string, string)] = []; ## Optional
  version = "1.0.0";                                         ## Optional
  author = "You";                                            ## Optional
  icon = "";                                                 ## Optional
  require: openArray[string] = [];                           ## Optional
  resource: openArray[(string, string)] = [];                ## Optional
  supportUrl = "";                                           ## Optional
  homepageUrl = "";                                          ## Optional


  # matching
  match: openArray[string] = ["*://*/*"]; # # Default matches everything
  excludeMatch: openArray[string] = [];                      ## Optional
  `include`: openArray[string] = [];       ## Optional (prefers `match`)
  exclude: openArray[string] = [];  ## Optional (prefers `excludematch`)

  # Advanced
  grant: openArray[GmPermitions] = []; ## Optional
  runAt = GmRunAt.docIdle;            ## Optional
  downloadUrl = "";                   ## Optional
  noFrames = false
): string {.compileTime.} =
  ## Generates the userscript metadata block and returns it
  var metadatas = newSeq[string]()

  # helpers
  proc newMetadata(key, value: string): string =
    fmt"// @{key} " & value.replace("\n", "\\n")
  proc addMeta(key, value: string) =
    if value.len > 0: metadatas.add newMetadata(key, value)

  # adding

  # project
  addMeta("name", name)
  for (key, name) in nameTranslations: addMeta(fmt"name:{key}", name)
  addMeta("namespace", namespace)
  addMeta("description", description)
  for (key, desc) in descriptionTranslations: addMeta(fmt"description:{key}", desc)
  addMeta("version", version)
  addMeta("author", author)
  addMeta("icon", icon)
  for req in require: addMeta(fmt"require", req)
  for (key, res) in resource: addMeta("resource", fmt"{key} {res}")
  addMeta("supportURL", supportUrl)
  addMeta("homepageURL", homepageUrl)

  # matching
  for mat in match: addMeta("match", mat)
  for exclMat in excludeMatch: addMeta("exclude-match", exclMat)
  for incl in `include`: addMeta("include", incl)
  for excl in exclude: addMeta("exclude", excl)

  # advanced
  if grant.len > 0:
    for perm in grant: addMeta("grant", $perm)
  else: addMeta("grant", "none")
  addMeta("run-at", $runAt)
  addMeta("downloadURL", downloadUrl)
  if noFrames: addMeta("noframes", "")

  # return
  result = fmt"""// ==UserScript==
               {metadatas.join("\n")}
               // ==/UserScript==
               // Metadata automatically generated""".unindent
