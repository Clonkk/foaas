# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
#
import asynchttpserver, asyncdispatch, strutils, strformat

when isMainModule:
  echo("Hello, World!")

const ERROR_UNSUPPORTED = "Not supported"
const ERROR_NOT_FOUND = "Ressource not found"

type
  Res = tuple
    msg : string
    code : HttpCode

var server = newAsyncHttpServer()

proc extractUrl(s: string): seq[string]=
  var vecStr = s.split("/")
  var parameters = vecStr[1 .. ^1]
  echo parameters
  result = parameters

proc foaasReply(path:string, data:seq[string]): Res=
  try:
    case path:
      of "version"      :
        result = (msg: "2.0.0", code: Http200)
      of "operation"    :
        result = (msg: ERROR_UNSUPPORTED, code: Http501)
      of "anyway"       :
        result = (msg: fmt"Who the fuck are you anyway, {data[0]}, why are you stirring up so much trouble, and, who pays you? - {data[1]}", code: Http200)
      of "asshole"      :
        result = (msg: fmt"Fuck you, asshole. - {data[0]}", code: Http200)
      of "awesome"      :
        result = (msg: fmt"This is Fucking Awesome. - {data[0]}", code: Http200)
      of "back"         :
        result = (msg: fmt"{data[0]}, back the fuck off. - {data[1]}", code: Http200)
      of "bag"          :
        result = (msg: fmt"Eat a bag of fucking dicks. - {data[0]}", code: Http200)
      of "ballmer"      :
        result = (msg: fmt"Fucking {data[0]} is a fucking pussy. I'm going to fucking bury that guy, I have done it before, and I will do it again. I'm going to fucking kill {data[1]}. - {data[2]}", code: Http200)
      of "bday"         :
        result = (msg: fmt"Happy Fucking Birthday, {data[0]}. - {data[1]}", code: Http200)
      of "because"      :
        result = (msg: fmt"Why? Because fuck you, that's why. - {data[0]}", code: Http200)
      of "blackadder"   :
        result = (msg: fmt"{data[0]}, your head is as empty as a eunuch’s underpants. Fuck off! - {data[1]}", code: Http200)
      of "bm"           :
        result = (msg: fmt"Bravo mike, :name. - {data[0]}", code: Http200)
      of "bucket"       :
        result = (msg: fmt"Please choke on a bucket of cocks. - {data[0]}", code: Http200)
      of "bus"          :
        result = (msg: fmt"Christ on a bendy-bus, {data[0]}, don't be such a fucking faff-arse. - {data[1]}", code: Http200)
      of "bye"          :
        result = (msg: fmt"Fuckity bye! - {data[0]}", code: Http200)
      of "caniuse"      :
        result = (msg: fmt"Can you use :tool? Fuck no! - {data[0]}", code: Http200)
      of "chainsaw"     :
        result = (msg: fmt"Fuck me gently with a chainsaw, :name. Do I look like Mother Teresa? - {data[0]}", code: Http200)
      of "cocksplat"    :
        result = (msg: fmt"Fuck off {data[0]}, you worthless cocksplat - {data[1]}", code: Http200)
      of "cool"         :
        result = (msg: fmt"Cool story, bro. - {data[0]}", code: Http200)
      of "cup"          :
        result = (msg: fmt"How about a nice cup of shut the fuck up? - {data[0]}", code: Http200)
      of "dalton"       :
        result = (msg: fmt"{data[0]}: A fucking problem solving super-hero. - {data[1]}", code: Http200)
      of "deraadt"      :
        result = (msg: fmt"{data[0]} you are being the usual slimy hypocritical asshole... You may have had value ten years ago, but people will see that you don't anymore. - {data[1]}", code: Http200)
      of "diabetes"     :
        result = (msg: fmt"I'd love to stop and chat to you but I'd rather have type 2 diabetes. - {data[0]}", code: Http200)
      of "dosomething"  :
        result = (msg: fmt"{data[0]} the fucking {data[1]}! - {data[2]}", code: Http200)
      of "donut"        :
        result = (msg: fmt"{data[0]}, go and take a flying fuck at a rolling donut. - {data[1]}", code: Http200)
      of "equity"       :
        result = (msg: fmt"Equity only? long hours? zero pay? well {data[0]}, just sign me right the fuck up. - {data[1]}", code: Http200)
      of "everyone"     :
        result = (msg: fmt"Everyone can go and fuck off. - {data[0]}", code: Http200)
      of "everything"   :
        result = (msg: fmt"Fuck everything. - {data[0]}", code: Http200)
      of "family"       :
        result = (msg: fmt"Fuck you, your whole family, your pets, and your feces. - {data[0]}", code: Http200)
      of "fascinating"  :
        result = (msg: fmt"Fascinating story, in what chapter do you shut the fuck up? - {data[0]}", code: Http200)
      of "fewer"        :
        result = (msg: fmt"Go fuck yourself {data[0]}, you'll disappoint fewer people. - {data[1]}", code: Http200)
      of "field"        :
        result = (msg: fmt"And {data[0]} said unto {data[1]}, 'verily, cast thine eyes upon the field in which i grow my fucks', and {data[2]} gave witness unto the field, and saw that it was barren. - {data[3]}", code: Http200)
      of "flying"       :
        result = (msg: fmt"I don't give a flying fuck. - {data[0]}", code: Http200)
      of "ftfy"         :
        result = (msg: fmt"Fuck that, fuck you - {data[0]}", code: Http200)
      of "fts"          :
        result = (msg: fmt"Fuck that shit, {data[0]}. - {data[1]}", code: Http200)
      of "fyyff"        :
        result = (msg: fmt"Fuck you, you fucking fuck. - {data[0]}", code: Http200)
      of "gfy"          :
        result = (msg: fmt"Golf foxtrot yankee, {data[0]}. - {data[1]}", code: Http200)
      of "give"         :
        result = (msg: fmt"I give zero fucks. - {data[0]}", code: Http200)
      of "greed"        :
        result = (msg: fmt"The point is, ladies and gentleman, that {data[0]} -- for lack of a better word -- is good. {data[0]} is right. {data[0]} works. {data[0]} clarifies, cuts through, and captures the essence of the evolutionary spirit. {data[0]}, in all of its forms -- {data[0]} for life, for money, for love, knowledge -- has marked the upward surge of mankind. - {data[1]}", code: Http200)
      of "horse"        :
        result = (msg: fmt"Fuck you and the horse you rode in on. - {data[0]}", code: Http200)
      of "immensity"    :
        result = (msg: fmt"You can not imagine the immensity of the fuck i do not give. - {data[0]}", code: Http200)
      of "ing"          :
        result = (msg: fmt"Fucking fuck off, {data[0]}. - {data[1]}", code: Http200)
      of "jinglebells"  :
        result = (msg: fmt"Fuck you, fuck me, fuck your family. fuck your father, fuck your mother, fuck you and me. - {data[0]}", code: Http200)
      of "keep"         :
        result = (msg: fmt"{data[0]}: fuck off. and when you get there, fuck off from there too. then fuck off some more. keep fucking off until you get back here. then fuck off again. - {data[1]}", code: Http200)
      of "keepcalm"     :
        result = (msg: fmt"Keep the fuck calm and {data[0]}! - {data[1]}", code: Http200)
      of "king"         :
        result = (msg: fmt"Oh fuck off, just really fuck off you total dickface. christ, {data[0]}, you are fucking thick. - {data[1]}", code: Http200)
      of "life"         :
        result = (msg: fmt"Fuck my life. - {data[0]}", code: Http200)
      of "linus"        :
        result = (msg: fmt"{data[0]}, there aren't enough swear-words in the english language, so now i'll have to call you perkeleen vittupää just to express my disgust and frustration with this crap. - {data[1]}", code: Http200)
      of "logs"         :
        result = (msg: fmt"Check your fucking logs! - {data[0]}", code: Http200)
      of "look"         :
        result = (msg: fmt"{data[0]}, do i look like i give a fuck? - {data[1]}", code: Http200)
      of "looking"      :
        result = (msg: fmt"Looking for a fuck to give. - {data[0]}", code: Http200)
      of "madison"      :
        result = (msg: fmt"What you've just said is one of the most insanely idiotic things i have ever heard, {data[0]}. at no point in your rambling, incoherent response were you even close to anything that could be considered a rational thought. everyone in this room is now dumber for having listened to it. i award you no points {data[1]}, and may god have mercy on your soul. - {data[2]}", code: Http200)
      of "maybe"        :
        result = (msg: fmt"Maybe. maybe not. maybe fuck yourself. - {data[0]}", code: Http200)
      of "me"           :
        result = (msg: fmt"Fuck me. - {data[0]}", code: Http200)
      of "mornin"       :
        result = (msg: fmt"Happy fuckin' mornin! - {data[0]}", code: Http200)
      of "no"           :
        result = (msg: fmt"No fucks given. - {data[0]}", code: Http200)
      of "nugget"       :
        result = (msg: fmt"Well {data[0]}, aren't you a shining example of a rancid fuck-nugget. - {data[1]}", code: Http200)
      of "off"          :
        result = (msg: fmt"Fuck off, {data[0]}. - {data[1]}", code: Http200)
      of "off-with"     :
        result = (msg: fmt"Fuck off with {data[0]} - {data[1]}", code: Http200)
      of "outside"      :
        result = (msg: fmt"{data[0]}, why don't you go outside and play hide-and-go-fuck-yourself? - {data[1]}", code: Http200)
      of "particular"   :
        result = (msg: fmt"Fuck this {data[0]} in particular. - {data[1]}", code: Http200)
      of "pink"         :
        result = (msg: fmt"Well, fuck me pink. - {data[0]}", code: Http200)
      of "problem"      :
        result = (msg: fmt"What the fuck is your problem {data[0]}? - {data[1]}", code: Http200)
      of "programmer"   :
        result = (msg: fmt"Fuck you, i'm a programmer, bitch! - {data[0]}", code: Http200)
      of "pulp"         :
        result = (msg: fmt"{data[0]}, motherfucker, do you speak it? - {data[1]}", code: Http200)
      of "question"     :
        result = (msg: fmt"To fuck off, or to fuck off (that is not a question) - {data[0]}", code: Http200)
      of "ratsarse"     :
        result = (msg: fmt"I don't give a rat's arse. - {data[0]}", code: Http200)
      of "retard"       :
        result = (msg: fmt"You fucktard! - {data[0]}", code: Http200)
      of "ridiculous"   :
        result = (msg: fmt"That's fucking ridiculous - {data[0]}", code: Http200)
      of "rtfm"         :
        result = (msg: fmt"Read the fucking manual! - {data[0]}", code: Http200)
      of "sake"         :
        result = (msg: fmt"For fuck's sake! - {data[0]}", code: Http200)
      of "shakespeare"  :
        result = (msg: fmt"{data[0]}, thou clay-brained guts, thou knotty-pated fool, thou whoreson obscene greasy tallow-catch! - {data[1]}", code: Http200)
      of "shit"         :
        result = (msg: fmt"Fuck this shit! - {data[0]}", code: Http200)
      of "shutup"       :
        result = (msg: fmt"{data[0]}, shut the fuck up. - {data[1]}", code: Http200)
      of "single"       :
        result = (msg: fmt"Not a single fuck was given. - {data[0]}", code: Http200)
      of "thanks"       :
        result = (msg: fmt"Fuck you very much. - {data[0]}", code: Http200)
      of "that"         :
        result = (msg: fmt"Fuck that. - {data[0]}", code: Http200)
      of "think"        :
        result = (msg: fmt"{data[0]}, you think i give a fuck? - {data[1]}", code: Http200)
      of "thinking"     :
        result = (msg: fmt"{data[0]}, what the fuck were you actually thinking? - {data[1]}", code: Http200)
      of "this"         :
        result = (msg: fmt"Fuck this. - {data[0]}", code: Http200)
      of "thumbs"       :
        result = (msg: fmt"Who has two thumbs and doesnt give a fuck? {data[0]}. - {data[1]}", code: Http200)
      of "too"          :
        result = (msg: fmt"Thanks, fuck you too. - {data[0]}", code: Http200)
      of "tucker"       :
        result = (msg: fmt"Come the fuck in or fuck the fuck off. - {data[0]}", code: Http200)
      of "waste"        :
        result = (msg: fmt"I don't waste my fucking time with your bullshit {data[0]}! - {data[1]}", code: Http200)
      of "what"         :
        result = (msg: fmt"What the fuck‽ - {data[0]}", code: Http200)
      of "xmas"         :
        result = (msg: fmt"Merry fucking christmas, {data[0]}. - {data[1]}", code: Http200)
      of "yoda"         :
        result = (msg: fmt"Fuck off, you must, {data[0]}. - {data[1]}", code: Http200)
      of "you"          :
        result = (msg: fmt"Fuck you, {data[0]}. - {data[1]}", code: Http200)
      of "zayn"         :
        result = (msg: fmt"Ask me if i give a motherfuck ?!! - {data[0]}", code: Http200)
      of "zero"         :
        result = (msg: fmt"Zero, that's the number of fucks i give. - {data[0]}", code: Http200)
      else : result = (ERROR_NOT_FOUND, Http404)
  except IndexError:
    result = ("Bad request", Http400)
  except:
    result = ("Unknown error", Http418)

proc cb(req: Request) {.async.}=
  let headers = newHttpHeaders([("Content-Type","text/plain")])
  let params = extractUrl(req.url.path)
  let path = params[0]
  let data = params[1 .. ^1]
  var res: Res = foaasReply(path, data)

  await req.respond(res.code, res.msg, headers)

waitFor server.serve(Port(8080), cb)
