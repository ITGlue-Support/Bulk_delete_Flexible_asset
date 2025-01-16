$api_key = Read-Host "Enter your API key"
$Flexible_asset_temp_id = Read-Host "Enter Flexible asset template ID"
$count = 0
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("x-api-key", "$api_key")
$headers.Add("Content-Type", "application/vnd.api+json")

$response = Invoke-RestMethod "https://api.itglue.com/flexible_assets?filter[flexible-asset-type-id]=$Flexible_asset_temp_id&page[size]=1000&page[number]=$totalpage" -Method 'GET' -Headers $headers

$totalpage = $response.meta.'total-pages'

for($i=1; $i -le $totalpage; $i++){

$response = Invoke-RestMethod "https://api.itglue.com/flexible_assets?filter[flexible-asset-type-id]=$Flexible_asset_temp_id&page[size]=1000&page[number]=$i" -Method 'GET' -Headers $headers

ForEach ($item in $response.data.id){

Write-Host $item

$PatchUrl = "https://api.itglue.com/flexible_assets/"+$item

$response = Invoke-RestMethod $PatchUrl -Method 'DELETE' -Headers $headers

$count++
Write-Host "item count:" $count



}

}
