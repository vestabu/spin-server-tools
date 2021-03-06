{
  Module Name: org.spinserver.Server.spin

  Author(s):   Michael O'Brien

  See end of file for terms of use and MIT License

  Description:
               This file is a the entry point for the HTTP Daemon server.
               
  References:

  Design Issues:

  Revision Log:
   20101124: 0.1: template creation based on Timothy's W5100 driver
             This module (httpd) started in the spirit of the Apache HTTPD open source web server (since 1996)
   20101101: started implementing interfaces for the JSR-154 Servlet 2.4 specification
             (Session, Servlet, Request, Response, RequestDispatcher)
             
}

DAT
  TxtFWdate   byte "Dec 02, 2010",0
                                
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
  TCP        : "org.spinserver.EthernetConnector.spin"
  Session    : "javax.servlet.http.Session.spin"
  Request    : "javax.servlet.http.HttpServletRequest.spin"
  Response   : "javax.servlet.http.HttpServletResponse.spin"
  Dispatcher : "javax.servlet.RequestDispatcher.spin"
  Servlet    : "javax.servlet.http.HttpServlet.spin"          

{
    Module: entry point
}
PUB main | cog1
  ' The design pattern here is a quick dispatch and return
  ' the web server core must be available at all times to service new requests (up to 4 simultaneos for the W5100)
  ' this is the first process to start in cog 0 (any cog loaded with an object that uses assembly will use 2 cogs)
  ' cog 1 = propeller adapter to W5100 driver
  cog1 := TCP.Start(80,192,168,0,1,192,168,0,184,$00,$08,$DC,$16,$EF,$06)
  TCP.LedOn
  TCP.Listen
  ' we will never get here
  'TCP.LedOff             

PUB Start : okay

PUB Stop : okay

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