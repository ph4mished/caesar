import strutils, terminal, strformat

let version = "0.1.0"
let VERSION* = fmt " caesar v{version} \n Author: Jonathan B. Owusu (https://github.com/ph4mished/caesar)"



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
  result.add(" -d, --decode".alignLeft(30) & "Decode caesar cipher\n")
  result.add(" -h, --help".alignLeft(30) & "Show this help.\n")
  result.add(" -v, --version ".alignLeft(30) & "Show version information.\n\n\n")

  #examples
  
  result.add("====== EXAMPLES =====".center(terminalWidth()) & "\n")
  result.add("  # Encoding\n")
  result.add("    caesar my_file.txt -k 23\n\n")
  result.add("  # Text Encoding\n")
  result.add("    echo 'hello world' | caesar -k 23\n\n")
 

  result.add("  # Decoding\n")
  result.add("    caesar enc_file.txt -d -k 5\n\n")
  result.add("  # Text Decoding\n")
  result.add("    echo 'uryyb jbeyq' | caesar -k 13 -d\n\n")

  result.add(" NOTE: input containing spaces or special characters should be placed in quotes.\n\n")
