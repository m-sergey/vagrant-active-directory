# Create a self-signed certificate for the server
# based on https://infiniteloop.io/powershell-self-signed-certificate-via-self-signed-root-ca/

param
(
    [string]$hostName = "dc",
    [string]$domainName = "example.local"
)

Write-Output "Creating certifcate..."

$params = @{
    DnsName = "$hostName.$domainName"
    KeyLength = 2048
    KeyAlgorithm = 'RSA'
    HashAlgorithm = 'SHA256'
    KeyExportPolicy = 'Exportable'
    NotAfter = (Get-date).AddYears(2)
    CertStoreLocation = 'Cert:\LocalMachine\My'
}
$dcCert = New-SelfSignedCertificate @params

# Extra step needed since self-signed cannot be directly shipped to trusted root CA store
# if you want to silence the cert warnings on other systems you'll need to import the cert.der on them too
Export-Certificate -Cert $dcCert -FilePath "C:\vagrant\cert.der"
Import-Certificate -CertStoreLocation 'Cert:\LocalMachine\Root' -FilePath "C:\vagrant\rootCA.der"
