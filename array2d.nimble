# Package

version       = "0.1.0"
author        = "Avahe Kellenberger"
description   = "A 2D Array Implementation"
license       = "GPL-2.0-only"
srcDir        = "src"

# Dependencies

requires "nim >= 1.6.4"

when not defined(release):
  requires "https://github.com/avahe-kellenberger/nimtest"

task runtests, "Runs the test suite":
  exec "nimtest"
