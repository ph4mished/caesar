import strutils, terminal, strformat

let version = "0.1.0"
let VERSION* = fmt " caesar v{version} \n Author: Jonathan B. Owusu (https://github.com/ph4mished/caesar)"



proc patternHelpMessage*(): string =
  result = ""
  
  result.add("===============================================================".center(terminalWidth()) & "\n")
  result.add(center(fmt "Caesar {version} - Pattern Reference", terminalWidth()) & "\n")
  result.add("===============================================================".center(terminalWidth()) & "\n")
  result.add(" Advanced key patterns for progressive and variant Caesar ciphers.\n\n")
   
  result.add(" \nUsage: caesar --pattern PATTERN <FILE> [OPTIONS] \n\n")
  
  
  result.add("===== PATTERN SYNTAX =====".center(terminalWidth()) & "\n")
  result.add("1. LINEAR INCREMENT\n")
  result.add(" KEY:STEP".alignLeft(30) & "Add STEP to KEY for each letter.\n")
  result.add("Example: '0:1'".alignLeft(30) & "0,1,2,3,4,5...\n")
  result.add("Example: '25:-1'".alignLeft(30) & "25,24,23,22...(count down)\n")
  result.add("Example: '3:2'".alignLeft(30) & "3,5,7,9,11...\n\n")

  result.add("2. CYCLIC INCREMENT\n")
  result.add(" KEY:STEP:CYCLE".alignLeft(30) & "Add STEP to KEY for each letter, reset every CYCLE\n")
  result.add("Example: '3:1:5'".alignLeft(30) & "3,4,5,6,7, 3,4,5,6,7...\n")
  result.add("Example: '0:3:4'".alignLeft(30) & "0,3,6,9, 0,3,6,9...\n\n")

  result.add("3. BLOCK PATTERN\n")
  result.add(" KEY:STEP::BLOCK".alignLeft(30) & "Same KEY for BLOCK chars, increment by STEP\n")
  result.add("Example: '5:1::3'".alignLeft(30) & "5,5,5, 6,6,6, 7,7,7...\n")
  result.add("Example: '3:2::4'".alignLeft(30) & "3,3,3,3, 5,5,5,5, 7,7,7,7...\n\n")

  result.add("4. CUSTOM SEQUENCE\n")
  result.add(" A,B,C,D...".alignLeft(30) & "Repeat exact sequence of keys\n")
  result.add("Example: '7,3,9'".alignLeft(30) & "7,3,9, 7,3,9, 7,3,9...\n")
  result.add("Example: '1,4,9,16'".alignLeft(30) & "1,4,9,16, 1,4,9,16, 1,4,9,16...\n\n")

  result.add("===== POSITION COUNTING =====".center(terminalWidth()) & "\n")
  result.add("By default, patterns use LETTER-ONLY position counting:\n")
  result.add(" 'a_b' => 'a'=position0, 'b'=position1 (underscore ignored)\n\n")
  result.add("Use --count flag for ALL-CHARACTER counting:\n")
  result.add(" 'a_b' => 'a'=position0, 'b'=position2 (underscore counts as position1)\n\n")
  
  

  

  #examples
  
  result.add("====== PRACTICAL EXAMPLES =====".center(terminalWidth()) & "\n")
  result.add("  # Common CTF Patterns\n")
  result.add("    caesar -p 0:1 my_file.txt     #Increment by 1 each letter.\n")
  result.add("    caesar -p 3:1:5 message.txt     #Decode cyclic pattern.\n")
  result.add("    caesar -p 5:1::3 flag.txt     #Same key for 3 chars.\n")
  result.add("    caesar -p 7,3,9 puzzle.txt     #Custom sequence\n\n")

  result.add("  # With Position Counting Options\n")
  result.add("    caesar -p 0:1 my_file.txt -c     #Count all\n")
  result.add("    caesar -p 0:1 message.txt    #Count only alpha-ascii letters\n\n")

  result.add("  # Mathematical Patterns\n")
  result.add("    '0:1'".alignLeft(12) & "= f(n) = n     #Linear.\n")
  result.add("    '3:1:5'".alignLeft(12) & "= f(n) = 3 + (n mod 5)     #Modulo cycle.\n")
  result.add("    '0:2'".alignLeft(12) & "= f(n) = 2n     #Even Numbers.\n")
  result.add("    '1:2'".alignLeft(12) & "= f(n) = 2n + 1    #Odd Numbers.\n\n")

  result.add("====== NOTE =====".center(terminalWidth()) & "\n")
  result.add(" - Keys wrap automatically modulo 26\n")
  result.add(" - Non-alpha-ascii letters (spaces, numbers, punctuations) are never shifted\n")
  result.add(" - Patterns work with both uppercase and lowercase letters\n\n")



proc helpMessage*(): string =
  result = ""
  
  result.add("===============================================================".center(terminalWidth()) & "\n")
  result.add(center(fmt "Caesar {version} - Caesar cipher encoding and decoding", terminalWidth()) & "\n")
  result.add("===============================================================".center(terminalWidth()) & "\n")
  result.add(" Encode or Decode file in Caesar cipher.\n\n")

  
  result.add(" \nUsage: caesar <FILE> [OPTIONS] \n\n")
  result.add(" Input may be a file path or stdin\n\n")
  result.add(" When no FILE is provided, read from standard input\n\n")
  
  
  result.add("===== ARGUMENT =====".center(terminalWidth()) & "\n")
  result.add(" <FILE>".alignLeft(30) & "File for caesar cipher encoding/decoding.\n\n")

  result.add("===== OPTIONS =====".center(terminalWidth()) & "\n")
  result.add(" -k, --key NUM".alignLeft(30) & "Key for cipher encoding or decoding [default: 3]\n")
  result.add(" -p, --pattern PATTERN".alignLeft(30) & "Advanced key patterns for cipher encoding or decoding(progressive cipher). Use 'caesar pattern --help' for complete reference\n")
  result.add(" -c, --count".alignLeft(30) & "Count all characters (including non-alpha-ascii letters) for position index.\n")
  result.add(" -d, --decode".alignLeft(30) & "Decode caesar cipher\n")
  result.add(" -h, --help".alignLeft(30) & "Show this help.\n")
  result.add(" -v, --version ".alignLeft(30) & "Show version information.\n\n\n")

  #examples
  
  result.add("====== EXAMPLES =====".center(terminalWidth()) & "\n")
  result.add("  # Encoding\n")
  result.add("    caesar my_file.txt -k 23\n\n")
  result.add("  # Text Encoding\n")
  result.add("    echo 'hello world' | caesar -k 23\n")
  result.add("  # Progressive Cipher Encoding\n")
  result.add("    echo 'hello world' | caesar -p 13:1\n\n")
 

  result.add("  # Decoding\n")
  result.add("    caesar enc_file.txt -d -k 5\n\n")
  result.add("  # Text Decoding\n")
  result.add("    echo 'uryyb jbeyq' | caesar -k 13 -d\n\n")
  result.add("  # Progressive Cipher Decoding\n")
  result.add("    echo 'usabf ohlgz' | caesar -p 13:1 -d\n\n")

  result.add(" NOTE: input containing spaces or special characters should be placed in quotes.\n\n")
