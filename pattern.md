# Progressive cipher
Some texts are not encoded with the basic ciphers. They are mostly done incrementally (char by char) and with a specific pattern, hence the name progressive cipher.

This tool makes it easy to solve such caesar ciphers
Here are a group of patterns planned to be used by the tool
**The tool intends on using colon-delimted strings for patterns**


**LINEAR PATTERN** `KEY:STEP`

Add STEP to KEY for each letter.
``` bash
echo "hello" | caesar -p 3:1
#This means start with 3 and increment +1 for each letter.
#Formula: 3,4,5,6,7...
output: kiqrv
```

**CYCLIC PATTERN** `KEY:STEP:CYCLE`

Add STEP to KEY for each letter, reset every CYCLE
``` bash
echo "hello" | caesar -p 3:1:2
#This means start with 3, increment +1 for each letter every two letters
#Formula: 3,4,3,4,3,4....3,4
output: kiopr
```


**BLOCK PATTERN** `KEY:STEP::BLOCK`

Same KEY for BLOCK chars, increment by STEP
``` bash
echo "hello world" | caesar -p 3:4::2
#This means start with 3, increment +4 for every two letters
#Formula: 3,3,7,7,11,11,15,15,19,19...
output: khssz hdgew
```

**CUSTOM SEQUENCE PATTERN** `A,B,C,D..`

This means repeat the exact sequence of keys
``` bash
echo "hello" | caesar -p 4,7,3
#Formula: 4,7,3,4,7,3,4,7,3...
output: llopv
```


