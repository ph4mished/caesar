
proc caesarEncode*(text: string, shift: int): string =
  result = newString(text.len)
  
  for i, c in text:
    if c in {'a'..'z'}:
      result[i] = chr((ord(c) - ord('a') + shift) mod 26 + ord('a'))
    elif c in {'A'..'Z'}:
      result[i] = chr((ord(c) - ord('A') + shift) mod 26 + ord('A'))
    else:
      result[i] = c

#Caesar cipher decoding
proc caesarDecode*(text: string, shift: int): string =
  caesarEncode(text, 26 - shift)