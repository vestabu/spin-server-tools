''**************************************
''
''  Brilldea W5100 Web Page Demo indirect Ver. 00.1
''
''  Timothy D. Swieter, P.E.
''  Brilldea - purveyor of prototyping goods
''  www.brilldea.com
''
''  Copyright (c) 2010 Timothy D. Swieter, P.E.
''  See end of file for terms of use and MIT License
''
''  Updated: June 26, 2010
''
''Description:
''
''      This is a demo of serving a web page using the W5100 IC and a Indirect Driver program in the Propeller. 
''
''Reference:
''
''To do:
''
''Revision Notes:
'' 0.1 Start of design
'' 20101119 Michael O'Brien
''          Modified for AJAX proof of concept
''
''**************************************
CON               'Constants to be located here
'***************************************                       
  '***************************************
  ' Firmware Version
  '***************************************
  FWmajor       = 0
  FWminor       = 1

DAT
  TxtFWdate   byte "June 26, 2010",0
  
CON

  '***************************************
  ' Processor Settings
  '***************************************
  _clkmode = xtal1 + pll16x     'Use the PLL to multiple the external clock by 16
  _xinfreq = 5_000_000          'An external clock of 5MHz. is used (80MHz. operation)

  '***************************************
  ' System Definitions     
  '***************************************

  _OUTPUT       = 1             'Sets pin to output in DIRA register
  _INPUT        = 0             'Sets pin to input in DIRA register  
  _HIGH         = 1             'High=ON=1=3.3V DC
  _ON           = 1
  _LOW          = 0             'Low=OFF=0=0V DC
  _OFF          = 0
  _ENABLE       = 1             'Enable (turn on) function/mode
  _DISABLE      = 0             'Disable (turn off) function/mode

{
  '***************************************
  ' I/O Definitions of PropNET Module
  '***************************************

  '~~~~Propeller Based I/O~~~~
  'W5100 Module Interface
  _WIZ_data0    = 0             'SPI Mode = MISO, Indirect Mode = data bit 0.
  _WIZ_miso     = 0
  _WIZ_data1    = 1             'SPI Mode = MOSI, Indirect Mode = data bit 1.
  _WIZ_mosi     = 1
  _WIZ_data2    = 2             'SPI Mode unused, Indirect Mode = data bit 2 dependent on solder jumper on board.
  _WIZ_data3    = 3             'SPI Mode = SCLK, Indirect Mode = data bit 3.
  _WIZ_sclk     = 3
  _WIZ_data4    = 4             'SPI Mode unused, Indirect Mode = data bit 4 dependent on solder jumper on board.
  _WIZ_data5    = 5             'SPI Mode unused, Indirect Mode = data bit 5 dependent on solder jumper on board.
  _WIZ_data6    = 6             'SPI Mode unused, Indirect Mode = data bit 6 dependent on solder jumper on board.
  _WIZ_data7    = 7             'SPI Mode unused, Indirect Mode = data bit 7 dependent on solder jumper on board.
  _WIZ_addr0    = 8             'SPI Mode unused, Indirect Mode = address bit 0 dependent on solder jumper on board.
  _WIZ_addr1    = 9             'SPI Mode unused, Indirect Mode = address bit 1 dependent on solder jumper on board.
  _WIZ_wr       = 10            'SPI Mode unused, Indirect Mode = /write dependent on solder jumper on board.
  _WIZ_rd       = 11            'SPI Mode unused, Indirect Mode = /read dependent on solder jumper on board.
  _WIZ_cs       = 12            'SPI Mode unused, Indirect Mode = /chip select dependent on solder jumper on board.
  _WIZ_int      = 13            'W5100 /interrupt dependent on solder jumper on board.  Shared with _OW.
  _WIZ_rst      = 14            'W5100 chip reset.
  _WIZ_scs      = 15            'SPI Mode SPI Slave Select, Indirect Mode unused dependent on solder jumper on board.

  'I2C Interface
  _I2C_scl      = 28            'Output for the I2C serial clock
  _I2C_sda      = 29            'Input/output for the I2C serial data  

  'Serial/Programming Interface (via Prop Plug Header)
  _SERIAL_tx    = 30            'Output for sending misc. serial communications via a Prop Plug
  _SERIAL_rx    = 31            'Input for receiving misc. serial communications via a Prop Plug
}
  '***************************************
  ' I/O Definitions of Spinneret Web Server Module
  '***************************************

  '~~~~Propeller Based I/O~~~~
  'W5100 Module Interface
  _WIZ_data0    = 0             'SPI Mode = MISO, Indirect Mode = data bit 0.
  _WIZ_miso     = 0
  _WIZ_data1    = 1             'SPI Mode = MOSI, Indirect Mode = data bit 1.
  _WIZ_mosi     = 1
  _WIZ_data2    = 2             'SPI Mode SPI Slave Select, Indirect Mode = data bit 2
  _WIZ_scs      = 2             
  _WIZ_data3    = 3             'SPI Mode = SCLK, Indirect Mode = data bit 3.
  _WIZ_sclk     = 3
  _WIZ_data4    = 4             'SPI Mode unused, Indirect Mode = data bit 4 
  _WIZ_data5    = 5             'SPI Mode unused, Indirect Mode = data bit 5 
  _WIZ_data6    = 6             'SPI Mode unused, Indirect Mode = data bit 6 
  _WIZ_data7    = 7             'SPI Mode unused, Indirect Mode = data bit 7 
  _WIZ_addr0    = 8             'SPI Mode unused, Indirect Mode = address bit 0 
  _WIZ_addr1    = 9             'SPI Mode unused, Indirect Mode = address bit 1 
  _WIZ_wr       = 10            'SPI Mode unused, Indirect Mode = /write 
  _WIZ_rd       = 11            'SPI Mode unused, Indirect Mode = /read 
  _WIZ_cs       = 12            'SPI Mode unused, Indirect Mode = /chip select 
  _WIZ_int      = 13            'W5100 /interrupt
  _WIZ_rst      = 14            'W5100 chip reset
  _WIZ_sen      = 15            'W5100 low = indirect mode, high = SPI mode, floating will = high.

  _DAT0         = 16
  _DAT1         = 17
  _DAT2         = 18
  _DAT3         = 19
  _CMD          = 20
  _SD_CLK       = 21
  
  _SIO          = 22            

  _LED          = 23            'UI - combo LED and button
  
  _AUX0         = 24            'MOBO Interface
  _AUX1         = 25
  _AUX2         = 26
  _AUX3         = 27

  'I2C Interface
  _I2C_scl      = 28            'Output for the I2C serial clock
  _I2C_sda      = 29            'Input/output for the I2C serial data  

  'Serial/Programming Interface (via Prop Plug Header)
  _SERIAL_tx    = 30            'Output for sending misc. serial communications via a Prop Plug
  _SERIAL_rx    = 31            'Input for receiving misc. serial communications via a Prop Plug

  '***************************************
  ' I2C Definitions
  '***************************************
  _EEPROM0_address = $A0        'Slave address of EEPROM

  '***************************************
  ' Debugging Definitions
  '***************************************
  
  '***************************************
  ' Misc Definitions
  '***************************************
  
  _bytebuffersize = 2048

'**************************************
VAR               'Variables to be located here
'***************************************

  'Configuration variables for the W5100
  byte  MAC[6]                  '6 element array contianing MAC or source hardware address ex. "02:00:00:01:23:45"
  byte  Gateway[4]              '4 element array containing gateway address ex. "192.168.0.1"
  byte  Subnet[4]               '4 element array contianing subnet mask ex. "255.255.255.0"
  byte  IP[4]                   '4 element array containing IP address ex. "192.168.0.13"

  'verify variables for the W5100
  byte  vMAC[6]                 '6 element array contianing MAC or source hardware address ex. "02:00:00:01:23:45"
  byte  vGateway[4]             '4 element array containing gateway address ex. "192.168.0.1"
  byte  vSubnet[4]              '4 element array contianing subnet mask ex. "255.255.255.0"
  byte  vIP[4]                  '4 element array containing IP address ex. "192.168.0.13"

  long  localSocket             '1 element for the socket number

  'Variables to info for where to return the data to
  byte  destIP[4]               '4 element array containing IP address ex. "192.168.0.16"
  long  destSocket              '1 element for the socket number

  'Misc variables
  byte  data[_bytebuffersize]
  long  stack[50]

  long  PageCount  
  
'***************************************
OBJ               'Object declaration to be located here
'***************************************

  'Choose which driver to use by commenting/uncommenting the driver.  Only one can be chosen.
  ETHERNET      : "Brilldea_W5100_Indirect_Driver_Ver006.spin"
  PST           : "javax.comm.SerialPort.spin"       'A terminal object wrapper interface to the object created by Parallax, used for debugging
  STR           :"java.lang.String.spin"             'A string processing utility

'***************************************
PUB Start(_port,_gw0,_gw1,_gw2,_gw3,_ip0,_ip1,_ip2,_ip3,_mac0,_mac1,_mac2,_mac3,_mac4,_mac5) | temp0, temp1, temp2, proc, ledState
'***************************************
''  First routine to be executed in the program
''  because it is first PUB in the file

  PauseMSec(2_000)              'A small delay to allow time to switch to the terminal application after loading the device

  '**************************************
  ' Start the processes in their cogs
  '**************************************

  'Start the terminal application
  'The terminal operates at 115,200 BAUD on the USB/COM Port the Prop Plug is attached to
  PST.Start(115_200)

  'Start the W5100 driver, counsumes 1 cog
  ETHERNET.StartINDIRECT(_WIZ_data0, _WIZ_addr0, _WIZ_addr1, _WIZ_cs, _WIZ_rd, _WIZ_wr,  _WIZ_rst, _WIZ_sen)

  '**************************************
  ' Initialize the variables
  '**************************************

  'The following variables can be adjusted by the demo user to fit in their particular network application.
  'Note the MAC ID is a locally administered address.   See Wikipedia MAC_Address 
  
  'MAC ID to be assigned to W5100
  MAC[0] := _mac0'$00
  MAC[1] := _mac1'$08
  MAC[2] := _mac2'$DC
  MAC[3] := _mac3'$16
  MAC[4] := _mac4'$EF
  MAC[5] := _mac5'$06
  'MAC[5] := $17

  'Subnet address to be assigned to W5100
  Subnet[0] := 255
  Subnet[1] := 255
  Subnet[2] := 255
  Subnet[3] := 0

  'IP address to be assigned to W5100
  IP[0] := _ip0'.192
  IP[1] := _ip1'.168
  IP[2] := _ip2'.0'4'0
  IP[3] := _ip3'.181'183

  'Gateway address of the system network
  Gateway[0] := _gw0'192
  Gateway[1] := _gw1'168
  Gateway[2] := _gw2'0'0
  Gateway[3] := _gw3'1

  'Local socket
  localSocket := _port'80 

  'Destination IP address - can be left zeros, the TCP demo echoes to computer that sent the packet
  destIP[0] := 0
  destIP[1] := 0
  destIP[2] := 0
  destIP[3] := 0

  destSocket := _port'80  
  
  '**************************************
  ' Begin
  '**************************************

  'Clear the terminal screen
  PST.Home
  PST.Clear
   
  'Draw the title bar
  PST.Str(string("    Prop/W5100 Web Page Serving Test ", PST#NL, PST#NL))

  'Set the W5100 addresses
  PST.Str(string("Initialize all addresses...  ", PST#NL))  
  SetVerifyMAC(@MAC[0])
  SetVerifyGateway(@Gateway[0])
  SetVerifySubnet(@Subnet[0])
  SetVerifyIP(@IP[0])

  'Addresses should now be set and displayed in the terminal window.
  'Next initialize Socket 0 for being the TCP server

  PST.Str(string("Initialize socket 0, port "))
  PST.dec(localSocket)
  PST.Str(string(PST#NL))

  'Testing Socket 0's status register and display information
  PST.Str(string("Socket 0 Status Register: "))
  ETHERNET.readIND(ETHERNET#_S0_SR, @temp0, 1)

  case temp0
    ETHERNET#_SOCK_CLOSED : PST.Str(string("$00 - socket closed", PST#NL, PST#NL))
    ETHERNET#_SOCK_INIT   : PST.Str(string("$13 - socket initalized", PST#NL, PST#NL))
    ETHERNET#_SOCK_LISTEN : PST.Str(string("$14 - socket listening", PST#NL, PST#NL))
    ETHERNET#_SOCK_ESTAB  : PST.Str(string("$17 - socket established", PST#NL, PST#NL))    
    ETHERNET#_SOCK_UDP    : PST.Str(string("$22 - socket UDP open", PST#NL, PST#NL))

  'Try opening a socket using a ASM method
  PST.Str(string("Attempting to open TCP on socket 0, port "))
  PST.dec(localSocket)
  PST.Str(string("...", PST#NL))
  
  ETHERNET.SocketOpen(0, ETHERNET#_TCPPROTO, localSocket, destSocket, @destIP[0])

  'Wait a moment for the socket to get established
  PauseMSec(500)

  'Testing Socket 0's status register and display information
  PST.Str(string("Socket 0 Status Register: "))
  ETHERNET.readIND(ETHERNET#_S0_SR, @temp0, 1)

  case temp0
    ETHERNET#_SOCK_CLOSED : PST.Str(string("$00 - socket closed", PST#NL, PST#NL))
    ETHERNET#_SOCK_INIT   : PST.Str(string("$13 - socket initalized/opened", PST#NL, PST#NL))
    ETHERNET#_SOCK_LISTEN : PST.Str(string("$14 - socket listening", PST#NL, PST#NL))
    ETHERNET#_SOCK_ESTAB  : PST.Str(string("$17 - socket established", PST#NL, PST#NL))    
    ETHERNET#_SOCK_UDP    : PST.Str(string("$22 - socket UDP open", PST#NL, PST#NL))

  'Try setting up a listen on the TCP socket
  PST.Str(string("Setting TCP on socket 0, port "))
  PST.dec(localSocket)
  PST.Str(string(" to listening", PST#NL))

  ETHERNET.SocketTCPlisten(0)

  'Wait a moment for the socket to listen
  PauseMSec(500)

  'Testing Socket 0's status register and display information
  PST.Str(string("Socket 0 Status Register: "))
  ETHERNET.readIND(ETHERNET#_S0_SR, @temp0, 1)

  case temp0
    ETHERNET#_SOCK_CLOSED : PST.Str(string("$00 - socket closed", PST#NL, PST#NL))
    ETHERNET#_SOCK_INIT   : PST.Str(string("$13 - socket initalized", PST#NL, PST#NL))
    ETHERNET#_SOCK_LISTEN : PST.Str(string("$14 - socket listening", PST#NL, PST#NL))
    ETHERNET#_SOCK_ESTAB  : PST.Str(string("$17 - socket established", PST#NL, PST#NL))    
    ETHERNET#_SOCK_UDP    : PST.Str(string("$22 - socket UDP open", PST#NL, PST#NL))

  PageCount := 0



PUB Listen | proc
  proc := 1 
  'Infinite loop of the server until we hear something
  repeat

    'Waiting for a client to connect
    PST.Str(string("Waiting for a client to connect....", PST#NL))

    'Testing Socket 0's status register and looking for a client to connect to our server
    repeat while !ETHERNET.SocketTCPestablished(0)

    'Connection established
    PST.Str(string("connection established..."))

    'Initialize the buffers and bring the data over
    bytefill(@data, 0, _bytebuffersize)    
    ETHERNET.rxTCP(0, @data)
    PST.Str(string("data recieved..."))
    PST.Str(@data) 'print out full HTTP request
    
    { FMO: 20101120 modify start}
    {
       This code change is only a proof of concept for an AJAX enabled client/server demo
       It requires proper file, request and response API handlers
       It also requires proper encapsulation modulues

       The AJAX design pattern is...
         1) the server serves out a html response containing both
            the client side JavaScript code and
            the HTML DOM processing code that displays dynamic XML data from the server
         2) the XMLHttpRequest object handles requests for XML data and parsing of the
            XML text response.
            It is up to the client-side developer to manipulate the DOM of the
            client page in response to what is recieved from an asynchronous GET request.
            In my case I respond both to mouse-overs and a timer request to send server requests.
            
       Currently this code works fine with Google Chrome (sometimes after a couple refreshes up to 10 sec after a propeller reset)
       The AJAX code works fine with IE from a desktop server but IE8 has issues with the line
          this._xmlHttp = new FactoryXMLHttpRequest()
          
    }    

    ' Get response is
    'GET /app?param=x&param2=y... HTTP/1.1

    if data[0] == "G"
     PageCount++
     ' very-hacky but until proper param work by Bean is used I am just ckecking for "any" get encoding
     ' this must match 
     if data[7] == "a"
       
       ' service AJAX XML response
       PST.Str(string("serving XML Async GET "))
       PST.dec(PageCount)
       PST.Str(string(PST#NL))
       ' Currently the XML tag schema is kind of irrelevant
       StringSend(0, string("<xml>"))
       StringSend(0, string("<data>"))
       ' this actual element text between tags will be parsed out by the client
       StringSend(0, STR.numberToDecimal(PageCount, 6))      
       StringSend(0, string("</data>"))      
       StringSend(0, string("</xml>"))       
     else 

      PST.Str(string("serving page "))
      PST.dec(PageCount)
      PST.Str(string(PST#NL))
       
      'Send the web page - hardcoded here
      'File
{ ' fmo commenting Timothy's code
      StringSend(0, string("<html><title>spinneret.cassidydevelopment.net</title>"))
      StringSend(0, string("<font face=Arial size=5>Welcome to spinneret.cassidydevelopment.net</font><br>"))
      StringSend(0, string("<font face=Arial size=4>Thanks Timothy Swieter<br><br><br>"))    
      StringSend(0, string("You are Visitor: "))
      StringSend(0, STR.numberToDecimal(PageCount, 5))
      StringSend(0, string("<br><br><br>"))
      StringSend(0, string("<u>Things I would like to do next:</u><br>"))
      StringSend(0, string("- Collect Visitor IP/MAC/Client Info<br>"))
      StringSend(0, string("- Handle Forms<br>"))
      StringSend(0, string("- Serve Multiple Files/Pages<br>"))
      StringSend(0, string("- Interact with the RTC<br>"))
      StringSend(0, string("- Interact with the uSD<br>"))
      StringSend(0, string("- Many Fun Things to Come :)"))     
      StringSend(0, string("</html>"))
 }     
 

      'StringSend(0, string(" <%@ page language='java' contentType='text/html",59," charset=ISO-8859-1'"))
      'StringSend(0, string("    pageEncoding='ISO-8859-1%>'"))
      proc := 0 ' this variable needs a for loop - but I need to get rid of the leading space when using numberToDecimal
      'StringSend(0, string("<!DOCTYPE html PUBLIC ",34,"-//W3C//DTD HTML 4.01 Transitional//EN",34,">"))
      StringSend(0, string("<html>"))
      StringSend(0, string("<head>"))
      'StringSend(0, string("        <meta http-equiv='Content-Type' content='text/html'",59,"; charset='ISO-8859-1'>"))
      'StringSend(0, string("        <meta http-equiv='Content-Style-Type' content='text/css'>"))
      'StringSend(0, string("        <meta http-equiv='expires' content='Wed, 26 Feb 1997 08:21:57 GMT'>")) ' expire to clear cache
      'StringSend(0, string("        <link rel='stylesheet' type='text/css' href='styles.css'>"))
      StringSend(0, string("<style type=text/css>",13,10))
      StringSend(0, string("  A:link {COLOR: #f0f000}",13,10))
      StringSend(0, string("  A:visited {COLOR: #00a0a0}",13,10))
      StringSend(0, string("  A:hover {COLOR: #f00000}",13,10))
      StringSend(0, string("  .hidden {VISIBILITY: hidden}",13,10))
      StringSend(0, string("  DIV {COLOR: #669966; FONT-FAMILY: Arial, Verdana, Helvetica}",13,10))
      StringSend(0, string("  .ref2-d {COLOR: #bfbfff; FONT-SIZE: 8pt; LINE-HEIGHT:10pt; TEXT-DECORATION: none }",13,10))
      StringSend(0, string("  .refdesc-d {COLOR: #f0f0ff; FONT-SIZE: 11pt; LINE-HEIGHT: 11pt; TEXT-DECORATION: none; text-indent: 3}",13,10))
      StringSend(0, string("  .refdesc {COLOR: #000080; FONT-SIZE: 11pt; LINE-HEIGHT: 11pt; TEXT-DECORATION: none; text-indent: 30}",13,10))
      StringSend(0, string("  .refdesc2 {COLOR: #000080; FONT-SIZE: 10pt; LINE-HEIGHT: 10pt; TEXT-DECORATION: none; text-indent: 30}",13,10))
      StringSend(0, string("  .refline {COLOR: #000000; FONT-SIZE: 12pt; LINE-HEIGHT: 12pt; TEXT-DECORATION: none }",13,10))
      StringSend(0, string("  .refdesc2-d {COLOR: #d0d0ff; FONT-SIZE: 10pt; LINE-HEIGHT: 10pt; TEXT-DECORATION: none; text-indent: 30}",13,10))
      StringSend(0, string("  .refline-d {COLOR: #ffffff; FONT-SIZE: 12pt; LINE-HEIGHT: 12pt; TEXT-DECORATION: none }",13,10))
      StringSend(0, string("  .ref {COLOR: #003f3f; FONT-SIZE: 8pt; LINE-HEIGHT: 10pt; TEXT-DECORATION: none }",13,10))
      StringSend(0, string("  .ref-d {COLOR: #00ffff; FONT-SIZE: 8pt; LINE-HEIGHT:10pt; TEXT-DECORATION: none }",13,10))
      StringSend(0, string("  .ref2 {COLOR: #00003f; FONT-SIZE: 8pt; LINE-HEIGHT: 10pt; TEXT-DECORATION: none }",13,10))
      StringSend(0, string("</style>",13,10))
            
      StringSend(0, string("<title>DataParallel Active Client</title>",13,10))
      'StringSend(0, string("<% int processingUnits = 16; %>"))
      StringSend(0, string("<script language=",34,"JavaScript",34," type=",34,"text/javascript",34,">"))
      StringSend(0, string(" function FactoryXMLHttpRequest() {",13,10))
      StringSend(0, string("           if(window.XMLHttpRequest) {",13,10))
      StringSend(0, string("                   // Mozilla",13,10))
      StringSend(0, string("                   return new XMLHttpRequest()",59,13,10))
      StringSend(0, string("           } else if(window.ActiveXObject) {",13,10))
      StringSend(0, string("                   try {",13,10))
      StringSend(0, string("                    // Internet Explorer only",13,10))
      StringSend(0, string("            return new ActiveXObject(",34,"Microsoft.XMLHTTP",34,")",59,13,10))
      StringSend(0, string("                   } catch (e) {",13,10))
      StringSend(0, string("                   }",13,10))
      StringSend(0, string("       }",13,10))
      StringSend(0, string("       // Verify Chrome, Firefox, Opera and Apple",13,10))
      StringSend(0, string("       throw new Error(",34,"Could not get an AJAX XMLHttpRequest Object",34,")",59,13,10))
      StringSend(0, string(" }  ",13,10))
      StringSend(0, string(" function Ajax() {",13,10))
      'StringSend(0, string("          new ActiveXObject(",34,"Microsoft.XMLHTTP",34,")"))'new FactoryXMLHttpRequest()",59,13,10))
      ' this line will not load in IE8 but works fine in Google Chrome                     
      StringSend(0, string("          this._xmlHttp = new FactoryXMLHttpRequest()",59,13,10))
      'StringSend(0, string("          this._xmlHttp = null"))'new ActiveXObject(",34,"Microsoft.XMLHTTP",34,")"))'new FactoryXMLHttpRequest()",59,13,10))
      StringSend(0, string(" }",13,10))
      StringSend(0, string(" // This code is loosely based on",13,10)) 
      StringSend(0, string(" // p.22 of Ajax Patterns and Best Practices by Christian Gross (2006)",13,10))
      StringSend(0, string(" // http://books.google.com/books?id=qNzBbUWhGM0C&printsec=frontcover&dq=ajax+patterns+and&cd=2#v=onepage&q&f=false",13,10))
      'StringSend(0, string(" // and http://www.w3schools.com/js/js_timing.asp",13,10)) 
      StringSend(0, string(" function AjaxUpdateEvent(elementId, status, statusText, responseText, responseXML) {",13,10))
      StringSend(0, string("         document.getElementById(elementId).innerHTML = responseText",59,13,10))
      StringSend(0, string(" }",13,10))
      StringSend(0, string(" // Timer variables",13,10))
      StringSend(0, string(" var timers = new Array()",59,13,10))
      StringSend(0, string(" var timerStateArray = new Array()",59,13,10))
      StringSend(0, string(" var ajax = new Array()",59,13,10))
      StringSend(0, string(" // initialize all arrays",13,10))
      'StringSend(0, string(" for (i=0",59,"i<<1>",59,"i=i+1) {",13,10))
      StringSend(0, string("     timerStateArray[0] = 0",59,13,10))
      StringSend(0, string("     ajax[0] = new Ajax()",59,13,10))
      StringSend(0, string("     ajax[0].complete = AjaxUpdateEvent",59,13,10))
      'StringSend(0, string(" }",13,10))
      StringSend(0, string(" function Ajax_call(url, elementId) {",13,10))
      StringSend(0, string("          var instance = this",59,13,10))
      StringSend(0, string("          this._xmlHttp.open('GET', url, true)",59,13,10))
      StringSend(0, string("         // inner anonymous function",13,10))
      StringSend(0, string("          this._xmlHttp.onreadystatechange = function() {",13,10))
      StringSend(0, string("                 switch(instance._xmlHttp.readyState) {",13,10))
      StringSend(0, string("                 case 1:",13,10))
      StringSend(0, string("                         instance.loading()",59,13,10))
      StringSend(0, string("                         break",59,13,10))
      StringSend(0, string("                 case 2:",13,10))
      StringSend(0, string("                         instance.loaded()",59,13,10))
      StringSend(0, string("                         break;",13,10))
      StringSend(0, string("                 case 3:",13,10))
      StringSend(0, string("                         instance.interactive()",59,13,10))
      StringSend(0, string("                         break",59,13,10))
      StringSend(0, string("                 case 4:",13,10))
      StringSend(0, string("                         // pass parameters",13,10))
      StringSend(0, string("                         instance.complete(",13,10))
      StringSend(0, string("                                         elementId,",13,10))
      StringSend(0, string("                                         instance._xmlHttp.status,",13,10))
      StringSend(0, string("                                         instance._xmlHttp.statusText,",13,10))
      StringSend(0, string("                                         instance._xmlHttp.responseText,",13,10))
      StringSend(0, string("                                         instance._xmlHttp.responseXML)",59,13,10))
      StringSend(0, string("                         break",59,13,10))
      StringSend(0, string("                 }",13,10))
      StringSend(0, string("         }",59,13,10))
      StringSend(0, string("         this._xmlHttp.send(null)",59,13,10))
      StringSend(0, string(" }",13,10))
      StringSend(0, string(" function Ajax_loading(){ }",13,10))
      StringSend(0, string(" function Ajax_loaded(){ }",13,10))
      StringSend(0, string(" function Ajax_interactive(){ }",13,10))
      StringSend(0, string(" function Ajax_complete(elementId, status, statusText, responseText, responseHTML){ }",13,10))
      StringSend(0, string(" // create static class functions",13,10))
      StringSend(0, string(" Ajax.prototype.loading = Ajax_loading",59,13,10))
      StringSend(0, string(" Ajax.prototype.loaded = Ajax_loaded",59,13,10))
      StringSend(0, string(" Ajax.prototype.interactive = Ajax_interactive",59,13,10))
      StringSend(0, string(" Ajax.prototype.complete = Ajax_complete",59,13,10))
                                                                                                                                                        StringSend(0, string(" Ajax.prototype.call = Ajax_call",59,13,10))
      StringSend(0, string(" // Base case: Switch the timer flag and call the main loop",13,10))
      StringSend(0, string(" function doTimer(url,cell,speed,elementId) {",13,10))
      StringSend(0, string("     if(!timerStateArray[cell]) {",13,10))
      StringSend(0, string("          timerStateArray[cell] = 1",59,13,10))
      StringSend(0, string("          timedCall(url,cell,speed,elementId)",59,13,10))
      StringSend(0, string("      }",13,10))
      StringSend(0, string(" }",13,10))
      StringSend(0, string(" // Main timing loop calls itself",13,10))
      StringSend(0, string(" function timedCall(url,cell,speed,elementId) {",13,10))
      StringSend(0, string("     ajax[cell].call(url,elementId)",59,13,10))
      StringSend(0, string("     if(timerStateArray[cell]) {",13,10))
      StringSend(0, string("           timers[cell] = setTimeout(function() { timedCall(url,cell,speed,elementId)",59," }, speed)",59," // no speed = max speed",13,10))
      StringSend(0, string("     }"))
      StringSend(0, string(" }"))
      StringSend(0, string("</script>"))
      StringSend(0, string("</head>",13,10))
      StringSend(0, string("<body text='#ffffff' bgcolor='#303030' link='#33D033' vlink='#D030D0' alink='#D03000'>",13,10))
      'StringSend(0, string("<!-- @&rnd=<%=String.valueOf(Math.random())%>')"-->"))
      StringSend(0, string(" <table border='0'>",13,10))
      'StringSend(0, string("        <%"))
      'StringSend(0, string("        for(int i=0;i<processingUnits;i++) {"))
      'StringSend(0, string("        out.println("<tr bgcolor=\"#2d1d4f\">");"))
      'StringSend(0, string("        out.println("<td><span id=\"" + i + "\" class=\"refdesc-d\">" + i + "</span>");"))
      'StringSend(0, string("        out.println("</td>");"))
      'StringSend(0, string("        out.println("<td><span id=\"b" + i + "\">");"))
      'StringSend(0, string("        out.println(" <button ");"))
      'StringSend(0, string("        out.println("onMouseOver=\"ajax[" + i + "].call('/dpservice/FrontController?action=demo&cell=" + i + "','" + i + "')\"  ");"))
      'StringSend(0, string("        out.println("onclick=\"doTimer('/dpservice/FrontController?action=demo&cell=" + i + "'," + i + ",200,'" + i + "')\">on</button>");"))
      'StringSend(0, string("        out.println(" <button ");"))
      'StringSend(0, string("        out.println("onclick=\"timerStateArray[" + i + "]=0\">off</button>");"))
      'StringSend(0, string("        out.println("</span>");"))
      'StringSend(0, string("        out.println("</td>");"))
      'StringSend(0, string("        out.println("</tr>");"))
      StringSend(0, string("        <tr bgcolor='#2d1d4f'>",13,10))
      StringSend(0, string("        <td><span id=",34))
      'StringSend(0, STR.numberToDecimal(proc, 0))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 0))      
      StringSend(0, string(34," class=",34,"refdesc-d",34,">"))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("        </span>",13,10))
      StringSend(0, string("        </td>",13,10))
      StringSend(0, string("        <td><span id=",34,"b0",34,">"))
      StringSend(0, string(" <button onMouseOver=",34,"ajax["))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("].call('0=ajax"))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("'",",'"))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("')",34,13,10))
      StringSend(0, string("         onclick=",34,"doTimer('0=ajax"))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("',"))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string(",200,'"))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("')",34,">on</button>",13,10))
      StringSend(0, string("        <button "))
      StringSend(0, string("onclick=",34,"timerStateArray["))
      StringSend(0, string("0"))'STR.numberToDecimal(proc, 1))
      StringSend(0, string("]=0",34,">off</button>",13,10))
      StringSend(0, string("        </span>",13,10))
      StringSend(0, string("        </td>",13,10))
      StringSend(0, string("        </tr>",13,10))
      'StringSend(0, string("        }"))        
      'StringSend(0, string("        %>"))
      StringSend(0, string(" </table>",13,10))
      StringSend(0, string(" <br/><br/><br/><br/><br/>"))
      StringSend(0, string(" <p class='ref2'>Make sure that 'Tools | Internet Options | Browsing History - is set to 'Every time I visit the webpage' instead of the default 'Automatically' so the XMLHttpRequest call will reach the server on subsequent calls.</p>",13,10))
      StringSend(0, string("</body>"))                                                                                                                  
      StringSend(0, string("</html>"))


    { FMO: 20101120 modify end }
       
    PauseMSec(5)

    'End the connection
    ETHERNET.SocketTCPdisconnect(0)

    PauseMSec(10)

    'Connection terminated
    ETHERNET.SocketClose(0)
    PST.Str(string("Connection complete", PST#NL, PST#NL))

    'Once the connection is closed, need to open socket again
    OpenSocketAgain
    
  return 'end of main

PUB LedOn
  dira[23] := 1
  outa[23] := 1
  PST.Str(string("LED on",PST#NL))  
PUB LedOff
  outa[_LED] := 0  
  PST.Str(string("LED off",PST#NL))  
'***************************************
PRI SetVerifyMAC(_firstOctet)
'***************************************

  'Set the MAC ID and display it in the terminal
  ETHERNET.WriteMACaddress(true, _firstOctet)

  
  PST.Str(string("  Set MAC ID........"))
  PST.hex(byte[_firstOctet + 0], 2)
  PST.Str(string(":"))
  PST.hex(byte[_firstOctet + 1], 2)
  PST.Str(string(":"))
  PST.hex(byte[_firstOctet + 2], 2)
  PST.Str(string(":"))
  PST.hex(byte[_firstOctet + 3], 2)
  PST.Str(string(":"))
  PST.hex(byte[_firstOctet + 4], 2)
  PST.Str(string(":"))
  PST.hex(byte[_firstOctet + 5], 2)
  PST.Str(string(PST#NL))

  'Wait a moment
  PauseMSec(500)
 
  ETHERNET.ReadMACAddress(@vMAC[0])
  
  PST.Str(string("  Verified MAC ID..."))
  PST.hex(vMAC[0], 2)
  PST.Str(string(":"))
  PST.hex(vMAC[1], 2)
  PST.Str(string(":"))
  PST.hex(vMAC[2], 2)
  PST.Str(string(":"))
  PST.hex(vMAC[3], 2)
  PST.Str(string(":"))
  PST.hex(vMAC[4], 2)
  PST.Str(string(":"))
  PST.hex(vMAC[5], 2)
  PST.Str(string(PST#NL))
  PST.Str(string(PST#NL))

  return 'end of SetVerifyMAC

'***************************************
PRI SetVerifyGateway(_firstOctet)
'***************************************

  'Set the Gatway address and display it in the terminal
  ETHERNET.WriteGatewayAddress(true, _firstOctet)

  PST.Str(string("  Set Gateway....."))
  PST.dec(byte[_firstOctet + 0])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 1])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 2])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 3])
  PST.Str(string(PST#NL))

  'Wait a moment
  PauseMSec(500)

  ETHERNET.ReadGatewayAddress(@vGATEWAY[0])
  
  PST.Str(string("  Verified Gateway.."))
  PST.dec(vGATEWAY[0])
  PST.Str(string("."))
  PST.dec(vGATEWAY[1])
  PST.Str(string("."))
  PST.dec(vGATEWAY[2])
  PST.Str(string("."))
  PST.dec(vGATEWAY[3])
  PST.Str(string(PST#NL))
  PST.Str(string(PST#NL))

  return 'end of SetVerifyGateway

'***************************************
PRI SetVerifySubnet(_firstOctet)
'***************************************

  'Set the Subnet address and display it in the terminal
  ETHERNET.WriteSubnetMask(true, _firstOctet)

  PST.Str(string("  Set Subnet......"))
  PST.dec(byte[_firstOctet + 0])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 1])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 2])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 3])
  PST.Str(string(PST#NL))

  'Wait a moment
  PauseMSec(500)

  ETHERNET.ReadSubnetMask(@vSUBNET[0])
  
  PST.Str(string("  Verified Subnet..."))
  PST.dec(vSUBNET[0])
  PST.Str(string("."))
  PST.dec(vSUBNET[1])
  PST.Str(string("."))
  PST.dec(vSUBNET[2])
  PST.Str(string("."))
  PST.dec(vSUBNET[3])
  PST.Str(string(PST#NL))
  PST.Str(string(PST#NL))

  return 'end of SetVerifySubnet

'***************************************
PRI SetVerifyIP(_firstOctet)
'***************************************

  'Set the IP address and display it in the terminal
  ETHERNET.WriteIPAddress(true, _firstOctet)

  PST.Str(string("  Set IP.........."))
  PST.dec(byte[_firstOctet + 0])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 1])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 2])
  PST.Str(string("."))
  PST.dec(byte[_firstOctet + 3])
  PST.Str(string(PST#NL))

  'Wait a moment
  PauseMSec(500)

  ETHERNET.ReadIPAddress(@vIP[0])
  
  PST.Str(string("  Verified IP......."))
  PST.dec(vIP[0])
  PST.Str(string("."))
  PST.dec(vIP[1])
  PST.Str(string("."))
  PST.dec(vIP[2])
  PST.Str(string("."))
  PST.dec(vIP[3])
  PST.Str(string(PST#NL))
  PST.Str(string(PST#NL))

  return 'end of SetVerifyIP

'***************************************
PRI StringSend(_socket, _dataPtr)
'***************************************

  ETHERNET.txTCP(0, _dataPtr, strsize(_dataPtr))

  return 'end of StringSend

'***************************************
PRI OpenSocketAgain
'***************************************

  ETHERNET.SocketOpen(0, ETHERNET#_TCPPROTO, localSocket, destSocket, @destIP[0])
  ETHERNET.SocketTCPlisten(0)

  return 'end of OpenSocketAgain
  
'***************************************
PRI PauseMSec(Duration)
'***************************************
''  Pause execution for specified milliseconds.
''  This routine is based on the set clock frequency.
''  
''  params:  Duration = number of milliseconds to delay                                                                                               
''  return:  none
  
  waitcnt(((clkfreq / 1_000 * Duration - 3932) #> 381) + cnt)

  return  'end of PauseMSec

'***************************************
DAT
'***************************************         

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