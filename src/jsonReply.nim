# See the file "LICENSE", included in this repository, for details about the copyright.
# (c) Copyright 2020 Caillaud Régis

import json, strutils, strformat
import dictionnary, types, asynchttpserver

proc formatJson(path:string, data:seq[string]): string=
  let msg = formatWord(path, data)
  let splitMsg = msg.split("-")
  var jsonMsg = %*
    {"message": splitMsg[0], "subtitle": "-" & splitMsg[1]}
  result = $jsonMsg

proc foaasReplyJson*(path: string, data: seq[string]): Res =
  try:
    # result = ( time_it(formatJson(path, data)), Http200)
    result = (formatWord(path, data), Http200)
  except KeyError:
    result = (ERROR_NOT_FOUND, Http404)
  except IndexError:
    result = ("Bad request", Http400)
  except:
    result = ("Unknown error", Http418)


