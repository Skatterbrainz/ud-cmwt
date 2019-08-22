New-UDPage -Name "Home" -Icon home -DefaultHomePage -Content {
    New-UDRow -EndPoint {
        New-UDColumn -Size 12 -Content {
            New-UDCard -Title "CMWT" -Content {
                New-UDParagraph "Welcome $($env:USERNAME)! Today is $(Get-Date)"
            }
        }
    }
}