# See the file "LICENSE", included in this repository, for details about the copyright.
# (c) Copyright 2020 Caillaud Régis

import asynchttpserver, asyncdispatch, strutils
import textReply, jsonReply, types

when isMainModule:
  echo("Hello, World!")

proc extractUrl(s: string): seq[string] =
  var vecStr = s.split("/")
  var parameters = vecStr[1 .. ^1]
  echo parameters
  result = parameters

var server = newAsyncHttpServer()

proc cb(req: Request) {.async.} =
  let params = extractUrl(req.url.path)
  let path = params[0]
  let data = params[1 .. ^1]

  try:
# cast HttpHeaders to a sequence of string to allow multiple reply in case of multiple compatible accept
    let acceptType : seq[string] = cast[seq[string]](req.headers["accept"])
    for atype in acceptType:
      case atype:
        of "application/json":
          let headers = newHttpHeaders([("Content-Type", "application/json")])
          var res: Res = foaasReplyJson(path, data)
          await req.respond(res.code, res.msg, headers)
        of "text/plain", "text/html":
          let headers = newHttpHeaders([("Content-Type", "text/plain")])
          var res: Res = foaasReplyText(path, data)
          await req.respond(res.code, res.msg, headers)
  except KeyError:
    echo "wrong accept header"


waitFor server.serve(Port(8080), cb)
