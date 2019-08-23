New-UDPage -Name "Home" -Icon home -DefaultHomePage -Content {
    New-UDRow {
        New-UDColumn -Content {
            New-UDCard -Image (New-UDImage -Path $(Join-Path (Split-Path $PSScriptRoot) 'assets/splash1.png') -Height 250)
        }
        New-UDColumn -Content {
            New-UDCard -Title "Welcome $($env:USERNAME)! Today is $(Get-Date -f 'dddd MMMM dd, yyyy')" -Content {
                New-UDParagraph -Text "Once upon a time"
            }
        }
    }
}