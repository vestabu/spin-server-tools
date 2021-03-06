{
  Module Name: template.spin

  Author(s):   Michael O'Brien

  See end of file for terms of use and MIT License

  Description:
               This file is a standard object module template.
               
  References:

  Design Issues:

   20101201: 0.1: JSR-154 interface template
}

DAT
  TxtFWdate   byte "Dec 01, 2010",0
  
'     Server status codes see RFC 2068.
'     * Status code (100) indicating the client can continue.
     SC_CONTINUE long 100
    
'     * Status code (101) indicating the server is switching protocols
'     * according to Upgrade header.
     SC_SWITCHING_PROTOCOLS long 101

'     * Status code (200) indicating the request succeeded normally.
     SC_OK long 200

'     * Status code (201) indicating the request succeeded and created
'     * a new resource on the server.
     SC_CREATED long 201

'     * Status code (202) indicating that a request was accepted for
'     * processing, but was not completed.
     SC_ACCEPTED long 202

'     * Status code (203) indicating that the meta information presented
'     * by the client did not originate from the server.
'     SC_NON_AUTHORITATIVE_INFORMATION (>30 char)
     SC_NON_AUTHORITATIVE_INFO long 203

'     * Status code (204) indicating that the request succeeded but that
'     * there was no new information to return.
     SC_NO_CONTENT long 204

'     * Status code (205) indicating that the agent <em>SHOULD</em> reset
'     * the document view which caused the request to be sent.
     SC_RESET_CONTENT long 205

'     * Status code (206) indicating that the server has fulfilled
'     * the partial GET request for the resource.
     SC_PARTIAL_CONTENT long 206

'     * Status code (300) indicating that the requested resource
'     * corresponds to any one of a set of representations, each with
'     * its own specific location.
     SC_MULTIPLE_CHOICES long 300

'     * Status code (301) indicating that the resource has permanently
'     * moved to a new location, and that future references should use a
'     * new URI with their requests.
     SC_MOVED_PERMANENTLY long 301

'     * Status code (302) indicating that the resource has temporarily
'     * moved to another location, but that future references should
'     * still use the original URI to access the resource.
'     * This definition is being retained for backwards compatibility.
'     * SC_FOUND is now the preferred definition.
     SC_MOVED_TEMPORARILY long 302

'    * Status code (302) indicating that the resource reside
'    * temporarily under a different URI. Since the redirection might
'    * be altered on occasion, the client should continue to use the
'    * Request-URI for future requests.(HTTP/1.1) To represent the
'    * status code (302), it is recommended to use this variable.
     SC_FOUND long 302

'     * Status code (303) indicating that the response to the request
'     * can be found under a different URI.
     SC_SEE_OTHER long 303

'     * Status code (304) indicating that a conditional GET operation
'     * found that the resource was available and not modified.
     SC_NOT_MODIFIED long 304

'     * Status code (305) indicating that the requested resource
'     * <em>MUST</em> be accessed through the proxy given by the
'     * <code><em>Location</em></code> field.
     SC_USE_PROXY long 305

'     * Status code (307) indicating that the requested resource 
'     * resides temporarily under a different URI. The temporary URI
'     * <em>SHOULD</em> be given by the <code><em>Location</em></code> 
'     * field in the response.
      SC_TEMPORARY_REDIRECT long 307

'     * Status code (400) indicating the request sent by the client was
'     * syntactically incorrect.
     SC_BAD_REQUEST long 400

'     * Status code (401) indicating that the request requires HTTP
'     * authentication.
     SC_UNAUTHORIZED long 401

'     * Status code (402) reserved for future use.
     SC_PAYMENT_REQUIRED long 402

'     * Status code (403) indicating the server understood the request
'     * but refused to fulfill it.
     SC_FORBIDDEN long 403

'     * Status code (404) indicating that the requested resource is not
'     * available.
     SC_NOT_FOUND long 404

'     * Status code (405) indicating that the method specified in the
'     * <code><em>Request-Line</em></code> is not allowed for the resource
'     * identified by the <code><em>Request-URI</em></code>.
     SC_METHOD_NOT_ALLOWED long 405

'     * Status code (406) indicating that the resource identified by the
'     * request is only capable of generating response entities which have
'     * content characteristics not acceptable according to the accept
'     * headers sent in the request.
     SC_NOT_ACCEPTABLE long 406

'     * Status code (407) indicating that the client <em>MUST</em> first
'     * authenticate itself with the proxy.
'     SC_PROXY_AUTHENTICATION_REQUIRED > 30 char
     SC_PROXY_AUTHENTICATION_REQ long 407

'     * Status code (408) indicating that the client did not produce a
'     * request within the time that the server was prepared to wait.
     SC_REQUEST_TIMEOUT long 408

'     * Status code (409) indicating that the request could not be
'     * completed due to a conflict with the current state of the
'     * resource.
     SC_CONFLICT long 409

'     * Status code (410) indicating that the resource is no longer
'     * available at the server and no forwarding address is known.
'     * This condition <em>SHOULD</em> be considered permanent.
     SC_GONE long 410

'     * Status code (411) indicating that the request cannot be handled
'     * without a defined <code><em>Content-Length</em></code>.
     SC_LENGTH_REQUIRED long 411

'     * Status code (412) indicating that the precondition given in one
'     * or more of the request-header fields evaluated to false when it
'     * was tested on the server.
     SC_PRECONDITION_FAILED long 412

'     * Status code (413) indicating that the server is refusing to process
'     * the request because the request entity is larger than the server is
'     * willing or able to process.
     SC_REQUEST_ENTITY_TOO_LARGE long 413

'     * Status code (414) indicating that the server is refusing to service
'     * the request because the <code><em>Request-URI</em></code> is longer
'     * than the server is willing to interpret.
     SC_REQUEST_URI_TOO_LONG long 414

'     * Status code (415) indicating that the server is refusing to service
'     * the request because the entity of the request is in a format not
'     * supported by the requested resource for the requested method.
     SC_UNSUPPORTED_MEDIA_TYPE long 415

'     * Status code (416) indicating that the server cannot serve the
'     * requested byte range.
'     SC_REQUESTED_RANGE_NOT_SATISFIABLE > 30 char
     SC_REQUESTED_RANGE_NOT_SAT long 416

'     * Status code (417) indicating that the server could not meet the
'     * expectation given in the Expect request header.
     SC_EXPECTATION_FAILED long 417

'     * Status code (500) indicating an error inside the HTTP server
'     * which prevented it from fulfilling the request.
     SC_INTERNAL_SERVER_ERROR long 500

'     * Status code (501) indicating the HTTP server does not support
'     * the functionality needed to fulfill the request.
     SC_NOT_IMPLEMENTED long 501

'     * Status code (502) indicating that the HTTP server received an
'     * invalid response from a server it consulted when acting as a
'     * proxy or gateway.
     SC_BAD_GATEWAY long 502

'     * Status code (503) indicating that the HTTP server is
'     * temporarily overloaded, and unable to handle the request.
     SC_SERVICE_UNAVAILABLE long 503

'     * Status code (504) indicating that the server did not receive
'     * a timely response from the upstream server while acting as
'     * a gateway or proxy.
     SC_GATEWAY_TIMEOUT long 504

'     * Status code (505) indicating that the server does not support
'     * or refuses to support the HTTP protocol version that was used
'     * in the request message.
     SC_HTTP_VERSION_NOT_SUPPORTED long 505  


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

' ServletResponse
PUB flushBuffer
PUB getBufferSize
PUB getCharacterEncoding
PUB getContentType
PUB getLocale
PUB getOutputStream
PUB getWriter
PUB isCommitted
PUB reset
PUB resetBuffer
PUB setBufferSize(int)
PUB setCharacterEncoding(aString)
PUB setContentLength(int)
PUB setContentType(aString)
PUB setLocale(Locale)
' HTTPServletResponse
PUB addCookie(Cookie)
PUB addDateHeader(aString, along)
PUB addHeader(aString, aString2)
PUB addIntHeader(aString, int)
PUB containsHeader(aString)
PUB encodeRedirectURL(aString)
PUB encodeURL(aString)
'PUB sendError(int)
PUB sendError(int, aString)
PUB sendRedirect(aString)
PUB setDateHeader(aString, along)
PUB setHeader(aString, aString2)
PUB setIntHeader(aString, int)
PUB setStatus(int)
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