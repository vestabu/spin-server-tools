{
  Module Name: template.spin

  Author(s):   Michael O'Brien

  See end of file for terms of use and MIT License

  Description:
               This file is a standard object module template.
               
  References:

  Design Issues:

  Revision Log:
   20101201: 0.1: JSR-154 interface template
}

DAT
  TxtFWdate   byte "Dec 01, 2010",0
'    * String identifier for Basic authentication. Value "BASIC"
    BASIC_AUTH byte "BASIC"
'    * String identifier for Form authentication. Value "FORM"
    FORM_AUTH byte "FORM"
'    * String identifier for Client Certificate authentication. Value "CLIENT_CERT"
    CLIENT_CERT_AUTH byte "CLIENT_CERT"
'    * String identifier for Digest authentication. Value "DIGEST"
    DIGEST_AUTH byte "DIGEST"
  
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
' ServletRequest
PUB getAttribute(aString)
PUB getAttributeNames
PUB getCharacterEncoding
PUB getContentLength
PUB getContentType
PUB getInputStream
PUB getLocalAddr
PUB getLocale
PUB getLocales
PUB getLocalName
PUB getLocalPort
PUB getParameter(AString)
PUB getParameterMap
PUB getParameterNames
PUB getParameterValues(AString)
PUB getProtocol
PUB getReader
PUB getRealPath(AString)
PUB getRemoteAddr
PUB getRemoteHost
PUB getRemotePort
PUB getRequestDispatcher(AString)
PUB getScheme
PUB getServerName
PUB getServerPort
PUB isSecure
PUB removeAttribute(AString)
PUB setAttribute(AString, Object)
PUB setCharacterEncoding(AString)
' HttpServletRequest
PUB getAuthType
PUB getContextPath
PUB getCookies
PUB getDateHeader(aString)
PUB getHeader(aString)
PUB getHeaderNames
PUB getHeaders(aString)
PUB getIntHeader(aString)
PUB getMethod
PUB getPathInfo
PUB getPathTranslated
PUB getQueryString
PUB getRemoteUser
PUB getRequestedSessionId
PUB getRequestURI
PUB getRequestURL
PUB getServletPath
'PUB getSession
PUB getSession(boolean)
PUB getUserPrincipal
PUB isRequestedSessionIdFromCookie
'PUB isRequestedSessionIdFromUrl
PUB isRequestedSessionIdFromURL
PUB isRequestedSessionIdValid
PUB isUserInRole(aString)

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