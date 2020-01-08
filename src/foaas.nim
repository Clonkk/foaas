# See the file "LICENSE", included in this repository, for details about the copyright.
# (c) Copyright 2020 Caillaud Régis

import asynchttpserver, asyncdispatch, strutils, strformat, times, os
import dictionnary

when isMainModule:
  echo("Hello, World!")


const ERROR_UNSUPPORTED = "Not supported"
const ERROR_NOT_FOUND = "Ressource not found"

template time_it(code: untyped): untyped =
  block:
    let t0 = epochTime()
    let m = code
    let elapsed = epochTime() - t0
    let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
    echo("CPU Time=", elapsedStr, "s")
    m

type
  Res = tuple
    msg: string
    code: HttpCode

var server = newAsyncHttpServer()

proc extractUrl(s: string): seq[string] =
  var vecStr = s.split("/")
  var parameters = vecStr[1 .. ^1]
  echo parameters
  result = parameters

proc formatWord(path: string, data: seq[string]): string =
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

proc foaasReply(path: string, data: seq[string]): Res =
  try:
    # result = ( time_it(formatWord(path, data)), Http200)
    result = (formatWord(path, data), Http200)
  except KeyError:
    result = (ERROR_NOT_FOUND, Http404)
  except IndexError:
    result = ("Bad request", Http400)
  except:
    result = ("Unknown error", Http418)

proc cb(req: Request) {.async.} =
  let headers = newHttpHeaders([("Content-Type", "text/plain")])
  let params = extractUrl(req.url.path)
  let path = params[0]
  let data = params[1 .. ^1]
  var res: Res = foaasReply(path, data)
  await req.respond(res.code, res.msg, headers)

waitFor server.serve(Port(8080), cb)
