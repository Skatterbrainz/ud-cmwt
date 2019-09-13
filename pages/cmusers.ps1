New-UDPage -Name "cmusers" -Content {
	New-UDGrid -Title "Configuration Manager Users" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmusers" |
			Select-Object UserName,FullName,UPN,SID,DateCreated | Out-UDGridData
	}
}
