import std/asyncjs
from std/dom import nil
from std/jsffi import JsObject, `[]=`, newJsObject

type
  GmObj = object
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

using
  gm: GmObj

type Callable = concept x
  x()

# Gm object export
let Gm* {.importc: "GM", noDecl.}: GmObj

# bindings
{.push importcpp.}
proc info*(gm: GmObj): GmInfo
  ## NOT WORKING
  ## Exposes this information (plus a bit more) to the user script.

# values
proc getValue*(gm; key: cstring; default = cstring ""): Future[cstring] {.async.}
  ## Retrieves stored values, see GM.setValue below.
proc setValue*(gm; key, value: cstring) {.async.}
  ## Permanently stores a value under a key, later available via GM.getValue.
proc deleteValue*(gm; key: cstring) {.async.}
  ## Deletes a value from chrome that was previously set.
proc listValues*(gm: GmObj): Future[seq[cstring]] {.async.}
  ## Retrieves an array of stored values' keys.

# # other
proc notification(gm; data: JsObject)
proc notification(gm; text: cstring; title, image = "".cstring;
                  onclick: Callable = proc())
  ## Opens a notification dialog.

proc openInTab*(gm; url: cstring; openInBackground = false)
  ## Opens a given URL in a new tab.
proc registerMenuCommand*(gm; caption: cstring; commandFunc: Callable;
                          accessKey: cstring)
  ## Adds an item to the "User Script Commands" section of the Monkey Menu.
proc setClipboard*(gm; text: cstring)
  ## Sets the contents of the clipboard.
proc xmlHttpRequest(gm; details: JsObject)

# proc addValueChangeListener*[T](
#   gm; name: cstring;
#   callback: proc(name, oldValue, newValue: cstring; remote: bool): T
# ) #[ {.hint: "Avaliable just for Violentmonkey".} ]#
{.pop.}

proc notification_placeholderCallback() = discard
proc notification*(gm; text: cstring; title, image = "".cstring;
                   onclick, ondone: Callable = notification_placeholderCallback) =
  ## Opens a notification dialog.
  var jsObj = newJsObject()
  jsObj["text"] = text
  jsObj["title"] = title
  jsObj["image"] = image
  jsObj["onclick"] = onclick
  jsObj["ondone"] = ondone
  GM.notification(jsObj)

type GmHttpResponse = concept x
  x(newJsObject())

proc xmlHttpRequest_placeholderCallback(x: JsObject) = discard
proc xmlHttpRequest*(gm; url, `method`: cstring;
                     binary = false; context = newJsObject(); data = "".cstring;
                     headers: openArray[(string, string)] = [],
                     overrideMimeType, user, password = "".cstring;
                     synchronous = false; timeout = 0; upload = newJsObject();
                     onabort, onerror, onload, onprogress, onreadystatechange,
                     ontimeout: GmHttpResponse = xmlHttpRequest_placeholderCallback) =
  ## A variant of XMLHttpRequest, this method allows skipping use the same-origin policy, enabling complex mashups.
  var jsObj = newJsObject()
  jsObj["url"] = url
  jsObj["method"] = `method`
  jsObj["binary"] = binary
  jsObj["context"] = context
  jsObj["data"] = data

  var jsHeaders = newJsObject()
  for i, (key, val) in headers:
    jsHeaders[key.cstring] = val.cstring

  jsObj["headers"] = jsHeaders

  jsObj["overrideMimeType"] = overrideMimeType
  jsObj["user"] = user
  jsObj["password"] = password

  # events
  jsObj["onabort"] = onabort
  jsObj["onerror"] = onerror
  jsObj["onload"] = onload
  jsObj["onprogress"] = onprogress
  jsObj["onreadystatechange"] = onreadystatechange
  jsObj["ontimeout"] = ontimeout
  GM.xmlHttpRequest(jsObj)

var unsafeWindow* {.importc, noDecl.}: dom.Window
  ## This object provides access to the raw JavaScript window scope of the content page. It is most commonly used to access JavaScript variables on the page.  
  ## hint: "This command can open certain security holes in your user script, and it is recommended to use this command sparingly."

# Metadata block
import ./gm_api/metadata
export metadata
