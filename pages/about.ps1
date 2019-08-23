New-UDPage -Name "About" -Icon info -Content {
    New-UDCard -Title "About CMWT" -Content {
        New-UDParagraph -Text "CMWT $($Cache:ConnectionInfo.AppVersion) is still in early development."
    }
}