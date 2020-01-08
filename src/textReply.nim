# See the file "LICENSE", included in this repository, for details about the copyright.
# (c) Copyright 2020 Caillaud Régis

import dictionnary, types, asynchttpserver
proc foaasReplyText*(path: string, data: seq[string]): Res =
  try:
    # result = ( time_it(formatWord(path, data)), Http200)
    result = (formatWord(path, data), Http200)
  except KeyError:
    result = (ERROR_NOT_FOUND, Http404)
  except IndexError:
    result = ("Bad request", Http400)
  except:
    result = ("Unknown error", Http418)


