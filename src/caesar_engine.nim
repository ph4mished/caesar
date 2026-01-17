
proc shiftChar*(ch: char, shift: int): char = 
  if ch in {'A'..'Z'}:
    let base = ord('A')
    let pos = (ord(ch) - base + shift) mod 26
    if pos < 0:
      return chr(base + pos + 26) #handle negative wrap
    else:
      return chr(base + pos)

  elif ch in {'a'..'z'}:
    let base = ord('a')
    let pos = (ord(ch) - base + shift) mod 26
    if pos < 0:
      return chr(base + pos + 26)
    else:
      return chr(base + pos)
  else:
    #Not a letter, return unchanged
    return ch


proc caesarEncode*(text: string, shift: int): string =
  result = newString(text.len)
  
  for c in text:
    result.add(shiftChar(c, shift))


#Caesar cipher decoding
proc caesarDecode*(text: string, shift: int): string =
  caesarEncode(text, 26 - shift)
