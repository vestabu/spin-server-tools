{
  Module Name: template.spin

  Author(s):   Michael O'Brien

  See end of file for terms of use and MIT License

  Description:
               This file is an interface to the PST.spin serial port comm object
               
  References:

  Design Issues:

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
''
''     Parallax Serial Terminal
''    Control Character Constants
''─────────────────────────────────────
  CS = 16  ''CS: Clear Screen      
  CE = 11  ''CE: Clear to End of line     
  CB = 12  ''CB: Clear lines Below 

  HM =  1  ''HM: HoMe cursor       
  PC =  2  ''PC: Position Cursor in x,y          
  PX = 14  ''PX: Position cursor in X         
  PY = 15  ''PY: Position cursor in Y         

  NL = 13  ''NL: New Line        
  LF = 10  ''LF: Line Feed       
  ML =  3  ''ML: Move cursor Left          
  MR =  4  ''MR: Move cursor Right         
  MU =  5  ''MU: Move cursor Up          
  MD =  6  ''MD: Move cursor Down
  TB =  9  ''TB: TaB          
  BS =  8  ''BS: BackSpace          
           
  BP =  7  ''BP: BeeP speaker          


VAR

OBJ
  PST: "Parallax Serial Terminal.spin"
  
PUB Start(baudrate) : okay
  PST.Start(baudrate)
PUB StartRxTx(rxpin, txpin, mode, baudrate) : okay
  PST.StartRxTx(rxpin, txpin, mode, baudrate)
PUB Stop
  PST.Stop
PUB Char(bytechr)
  PST.Char(bytechr)
PUB Chars(bytechr, count)
  PST.Chars(bytechr, count)
PUB CharIn : bytechr
  PST.CharIn
PUB Str(stringptr)
  PST.Str(stringptr)
PUB StrIn(stringptr)
  PST.StrIn(stringptr)
PUB StrInMax(stringptr, maxcount)
  PST.StrInMax(stringptr, maxcount)
PUB Dec(value) | i, x
  PST.Dec(value)
PUB DecIn : value
  PST.DecIn
PUB Bin(value, digits)
  PST.Bin(value, digits)
PUB BinIn : value
  PST.BinIn
PUB Hex(value, digits)
  PST.Hex(value, digits)
PUB HexIn : value
  PST.HexIn
PUB Clear
  PST.Clear
PUB ClearEnd
  PST.ClearEnd
PUB ClearBelow
  PST.ClearBelow
PUB Home
  PST.Home
PUB Position(x, y)
  PST.Position(x, y)
PUB PositionX(x)
  PST.PositionX(x)
PUB PositionY(y)
  PST.PositionY(y)
PUB NewLine
  PST.NewLine
PUB LineFeed
  PST.LineFeed
PUB MoveLeft(x)
  PST.MoveLeft(x)
PUB MoveRight(x)
  PST.MoveRight(x)
PUB MoveUp(y)
  PST.MoveUp(y)
PUB MoveDown(y)
  PST.MoveDown(y)
PUB Tab
  PST.Tab
PUB Backspace
  PST.Backspace
PUB Beep
  PST.Beep
PUB RxCount : count
  PST.RxCount
PUB RxFlush
  PST.RxFlush
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
