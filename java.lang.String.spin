{
  Module Name: java.lang.String.spin

  Author(s):   Michael O'Brien

  See end of file for terms of use and MIT License

  Description:
               This file is an interface to the string handling object STREngine
               
  References:

  Design Issues:

  Revision Log:
   20101130: 0.1: template creation
}

DAT
  TxtFWdate   byte "Nov 30, 2010",0
  
CON
  ' Usage: all constants start with an _ and are capitalized
  ' Firmware Version
  FWmajor       = 0
  FWminor       = 1

  ' Processor Settings
  _clkmode = xtal1 + pll16x     'Use the PLL to multiple the external clock by 16
  _xinfreq = 5_000_000          'An external clock of 5MHz. is used (80MHz. operation)

  ' System Definitions     
  ' I/O Definitions of Spinneret Web Server Module

VAR

OBJ
  STREngine : "STREngine.spin"
PUB putCharacter(character) '' 4 Stack longs
  STREngine.putCharacter(character) '' 4 Stack longs
PUB getCharacters '' 4 Stack Longs
  STREngine.getCharacters '' 4 Stack Longs
PUB alphabeticallyBefore(characters, charactersBefore) '' 5 Stack Longs
  STREngine.alphabeticallyBefore(characters, charactersBefore) '' 5 Stack Longs
PUB alphabeticallyAfter(characters, charactersAfter) '' 5 Stack Longs
  STREngine.alphabeticallyAfter(characters, charactersAfter) '' 5 Stack Longs
PUB startsWithCharacter(charactersToSearch, characterToFind) '' 5 Stack Longs
  STREngine.startsWithCharacter(charactersToSearch, characterToFind) '' 5 Stack Longs
PUB startsWithCharacters(charactersToSearch, charactersToFind)
  STREngine.startsWithCharacters(charactersToSearch, charactersToFind)
PUB endsWithCharacter(charactersToSearch, characterToFind) '' 5 Stack Longs
  STREngine.endsWithCharacter(charactersToSearch, characterToFind) '' 5 Stack Longs
PUB endsWithCharacters(charactersToSearch, charactersToFind)
  STREngine.endsWithCharacters(charactersToSearch, charactersToFind)
PUB findCharacter(charactersToSearch, characterToFind) '' 5 Stack Longs
  STREngine.findCharacter(charactersToSearch, characterToFind) '' 5 Stack Longs
PUB replaceCharacter(charactersToSearch, characterToReplace, characterToReplaceWith) '' 11 Stack Longs
  STREngine.replaceCharacter(charactersToSearch, characterToReplace, characterToReplaceWith) '' 11 Stack Longs
PUB replaceAllCharacter(charactersToSearch, characterToReplace, characterToReplaceWith) '' 17 Stack Longs
  STREngine.replaceAllCharacter(charactersToSearch, characterToReplace, characterToReplaceWith) '' 17 Stack Longs
PUB findCharacters(charactersToSearch, charactersToFind) | index '' 6 Stack Longs
  STREngine.findCharacters(charactersToSearch, charactersToFind) '' 6 Stack Longs 
PUB replaceCharacters(charactersToSearch, charactersToReplace, charactersToReplaceWith) '' 12 Stack Longs
  STREngine.replaceCharacters(charactersToSearch, charactersToReplace, charactersToReplaceWith) '' 12 Stack Longs
PUB replaceAllCharacters(charactersToSearch, charactersToReplace, charactersToReplaceWith) '' 18 Stack Longs
  STREngine.replaceAllCharacters(charactersToSearch, charactersToReplace, charactersToReplaceWith) '' 18 Stack Longs
PUB trimCharacters(characters) '' 4 Stack Longs
  STREngine.trimCharacters(characters) '' 4 Stack Longs
PUB tokenizeCharacters(characters) '' 4 Stack Longs
  STREngine.tokenizeCharacters(characters) '' 4 Stack Longs
PUB charactersToLowerCase(characters) '' 4 Stack Longs
  STREngine.charactersToLowerCase(characters) '' 4 Stack Longs
PUB charactersToUpperCase(characters) '' 4 Stack Longs
  STREngine.charactersToUpperCase(characters) '' 4 Stack Longs
PUB numberToDecimal(number, length) '' 5 Stack Longs
  STREngine.numberToDecimal(number, length) '' 5 Stack Longs
PUB numberToHexadecimal(number, length) '' 5 Stack Longs
  STREngine.numberToHexadecimal(number, length) '' 5 Stack Longs 
PUB numberToBinary(number, length) '' 5 Stack Longs
  STREngine.numberToBinary(number, length) '' 5 Stack Longs
PUB decimalToNumber(characters) | buffer, counter '' 6 Stack Longs.
  STREngine.decimalToNumber(characters) '' 6 Stack Longs.
PUB hexadecimalToNumber(characters) | index '' 5 Stack Longs.
  STREngine.hexadecimalToNumber(characters) '' 5 Stack Longs.
PUB binaryToNumber(characters) | index '' 5 Stack Longs.
  STREngine.binaryToNumber(characters) '' 5 Stack Longs.
DAT

{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}