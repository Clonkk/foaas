# See the file "LICENSE", included in this repository, for details about the copyright.
# (c) Copyright 2020 Caillaud Régis

import asynchttpserver, strutils, times, os
import dictionnary

template time_it*(code: untyped): untyped =
  block:
    let t0 = epochTime()
    let m = code
    let elapsed = epochTime() - t0
    let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
    echo("CPU Time=", elapsedStr, "s")
    m

type
  Res* = tuple
    msg: string
    code: HttpCode

const ERROR_UNSUPPORTED* = "Not supported"
const ERROR_NOT_FOUND* = "Ressource not found"

proc formatWord*(path: string, data: seq[string]): string =
  let raw: seq[string] = getWord(path).split(":")
  var msg: string
  var it = 0
  for index, s in raw:
    if index mod 2 == 1:
      msg = msg & s.replace("<data>", data[it])
      inc(it)
    else:
      msg = $msg & s
  result = msg


