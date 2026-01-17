import strformat, help, caesar_engine, strutils, sequtils
import commodore


commandline:
  argument(input, string, false)
  exitoption(@["help", "h"], helpMessage())
  exitoption(@["version", "v"], VERSION)
  flag(decode, @["decode", "d"])
  flag(countAll, @["count", "c"])
  option(key, int, @["k", "key"], 3)
  option(pattern, string, @["p", "pattern"])
  subcommand(patternHelp, @["pattern"]):
    #This was only created for pattern help
    exitoption(@["help", "h"], patternHelpMessage())
  

proc caesarShift(text: string, pattern: string): string =
  ## Process text with pattern, character by character
  #var result = ""
  var letterIndex = 0  # Counts only letters
  
  # Helper: get key for current position
  proc getKey(pos: int, pat: string): int =
    if pat.contains(','):
      # "3,7,2"
      try:
        let parts = pat.split(',')
        let keys = parts.mapIt(parseInt(it.strip) mod 26)
        return keys[pos mod keys.len]
      except Exception as e:
          echo "Error: " & e.msg
          quit(1)
    
    elif pat.contains("::"):
      # "3::5" or "3:2::5"
      try:
        let blockParts = pat.split("::")
        let blockSize = parseInt(blockParts[1].strip)
        let blockNum = pos div blockSize
      
        var start, step: int
        if blockParts[0].contains(':'):
          let startStep = blockParts[0].split(':')
          start = parseInt(startStep[0].strip) mod 26
          step = parseInt(startStep[1].strip) mod 26
        else:
          start = parseInt(blockParts[0].strip) mod 26
          step = 1
      
        return (start + (blockNum * step)) mod 26
      except Exception as e:
          echo "Error: " & e.msg
          quit(1)
    
    elif pat.contains(':'):
      let parts = pat.split(':')
      case parts.len:
      of 2:
        # "3:1"
        try:
          let start = parseInt(parts[0].strip) mod 26
          let step = parseInt(parts[1].strip) mod 26
          return (start + (pos * step)) mod 26
        except Exception as e:
          echo "Error: " & e.msg
          quit(1)
      of 3:
        # "3:1:5"
        try:
          let start = parseInt(parts[0].strip) mod 26
          let step = parseInt(parts[1].strip) mod 26
          let cycle = parseInt(parts[2].strip)
          let posInCycle = pos mod cycle
          return (start + (posInCycle * step)) mod 26
        except Exception as e:
          echo "Error: " & e.msg
          quit(1)
      else:
        return 0  # Should not happen
    
    else:
      echo fmt "Error: Invalid pattern '{pat}': Use 'caesar pattern --help' for pattern reference"
      quit(1)
      # "3"
      #return parseInt(pat.strip) mod 26
  
  # Process each character
  for ch in text:
    if ch.isAlphaAscii():
      let key = getKey(letterIndex, pattern)
      let shift = if decode: -key else: key
      result.add(shiftChar(ch, shift))
    else:
      result.add(ch)

    if countAll:
      inc letterIndex
    elif ch.isAlphaAscii():
      inc letterIndex
  
  return result


    

when isMainModule:
  if decode:
    if pattern != "" and input == "":
      for line in stdin.lines():
        echo caesarShift(line, pattern)
      quit(0)

    if input == "":
      for line in stdin.lines():
        echo caesarDecode(line, key)
      quit(0)

    #For file
    if input.len > 0:
      try:
        if pattern != "":
          var file = open(input)
          defer: file.close()
          for line in file.lines:
            echo caesarShift(line, pattern)
          quit(0)
        else:
          echo caesarDecode(input.readFile(), key)
          quit(0)
      except Exception as e:
        echo fmt "ERROR: {e.msg}"
        echo "Note: Make sure the path exist and is a readable file(not a directory)"
        quit(1)
  else:
    if pattern != "" and input == "":
      for line in stdin.lines():
        echo caesarShift(line, pattern)
      quit(0)

    if input == "":
      for line in stdin.lines():
        echo caesarEncode(line, key)
      quit(0)
    
    #For file
    if input.len > 0:
      try:
        if pattern != "":
          var file = open(input)
          defer: file.close()
          for line in file.lines:
            echo caesarShift(line, pattern)
          quit(0)
        else:
          echo caesarEncode(input.readFile(), key)
          quit(0)
      except Exception as e:
        echo fmt "ERROR: {e.msg}"
        echo "Note: Make sure the path exist and is a readable file(not a directory)"
        quit(1)
    