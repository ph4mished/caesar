import strformat, help, caesar_engine
import commodore

commandline:
  argument(input, string, false)
  exitoption(@["help", "h"], helpMessage())
  exitoption(@["version", "v"], VERSION)
  flag(decode, @["decode", "d"])
  option(key, int, @["k", "key"], 3)
  


when isMainModule:

#read texts from stdin and file from input
  if decode:
    if input == "":
      for line in stdin.lines():
        echo caesarDecode(line, key)
      quit(0)
    
    if input.len > 0:
      try:
        echo caesarDecode(input.readFile(), key)
        quit(0)
      except Exception as e:
        echo fmt "ERROR: {e.msg}"
        echo "Note: Make sure the path exist and is a readable file(not a directory)"
        quit(1)
  else:
    if input == "":
      for line in stdin.lines():
        echo caesarEncode(line, key)
      quit(0)
    
    if input.len > 0:
      try:
        echo caesarEncode(input.readFile(), key)
        quit(0)
      except Exception as e:
        echo fmt "ERROR: {e.msg}"
        echo "Note: Make sure the path exist and is a readable file(not a directory)"
        quit(1)
    