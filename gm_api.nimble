# Package

version       = "0.2.3"
author        = "Thiago Navarro"
description   = "Bindings for Greasemonkey API and header generator"
license       = "MIT"
srcDir        = "src"

backend = "js"

# Dependencies

requires "nim >= 1.0.0"

task buildExample, "Builds the example":
  exec "nim js ./example/main.nim"

task buildExample_release, "Builds the example in release":
  exec "nim js -d:danger ./example/main.nim"
