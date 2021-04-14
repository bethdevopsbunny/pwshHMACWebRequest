[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Key,
    [string]
    $JsonPayload,
    $URL,
    $Method


)


function Generate-HMAC {
  param (
     $RawBodyPayload,
     $Base64Key
  )
        
 $hmacsha = New-Object System.Security.Cryptography.HMACSHA256
 $hmacsha.key = [Convert]::FromBase64String($Base64Key)
 $signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($RawBodyPayload))
 $HMACValue = "HMAC " + [Convert]::ToBase64String($signature)
        
        
 return $HMACValue
        
}

$GeneratedHMAC  = Generate-HMAC -RawBodyPayload $JsonPayload -Base64Key $Key

$header = @{authorization=$GeneratedHMAC}
## use if auth with azure api service $header.Add("Ocp-Apim-Subscription-Key",")

try{
Invoke-WebRequest -Headers $header -Uri $URL -Body $JsonPayload -ContentType application/json -Method $Method
}
catch{
        # reads the body for of the response
        $streamReader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
        $ErrResp = $streamReader.ReadToEnd()
        $streamReader.Close()
	$errresp
}
