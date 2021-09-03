# Powershell WebRequest with HMAC Auth

Wraps around Powershells Invoke-WebRequest command, generates HMAC for payload and adds it to header of the request.


### example 

pwshHMACWebRequest.ps1 -Key "private HMAC Key" -JsonPayload "Body of WebRequest" -URL "URL you wish to request" -Method "Method of your request"


