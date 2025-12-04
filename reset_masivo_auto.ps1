Import-Module ActiveDirectory

$prefijo = "Edgewell."   # 9 caracteres
$longitudTotal = 15
$numerosNecesarios = $longitudTotal - $prefijo.Length  # 6 números

$rutaUsuarios = "C:\Users\garciaca\Downloads\usuarios.txt"
$rutaReporte  = "C:\Users\garciaca\Downloads\reporte_passwords.csv"

$usuarios = Get-Content $rutaUsuarios | Sort-Object -Unique

$reporte = @()

foreach ($usuario in $usuarios) {

    $passwordNumeros = -join ((0..9) | Get-Random -Count $numerosNecesarios)
    $passwordFinal = "$prefijo$passwordNumeros"

    try {

        $existe = Get-ADUser -Identity $usuario -ErrorAction Stop

        Set-ADAccountPassword `
            -Identity $usuario `
            -NewPassword (ConvertTo-SecureString $passwordFinal -AsPlainText -Force) `
            -Reset

        Set-ADUser -Identity $usuario -ChangePasswordAtLogon $true
        Unlock-ADAccount -Identity $usuario

        Write-Host "✅ Password cambiada: $usuario" -ForegroundColor Green

        $reporte += [PSCustomObject]@{
            Usuario    = $usuario
            Password   = $passwordFinal
            Estado     = "Correcto"
        }

    }
    catch {
        Write-Host "❌ ERROR con usuario: $usuario" -ForegroundColor Red

        $reporte += [PSCustomObject]@{
            Usuario    = $usuario
            Password   = "NO APLICÓ"
            Estado     = "ERROR"
        }
    }
}

$reporte | Export-Csv $rutaReporte -NoTypeInformation -Encoding UTF8

Write-Host "`n📁 Reporte generado en: $rutaReporte" -ForegroundColor Cyan
