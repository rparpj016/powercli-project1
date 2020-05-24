#Synopsis 
#Date : 30/06/2019
#Author : Roshan Joseph
#Modified by : Roshan Joseph
# This script will  will take computer names from text file and a random complex password is generated and it will check for whether server is online and will change the admin password .Passwords and server status are saved to a csv file.

#Please note that user running script should have administrator privileges in the server.


$computers = Get-Content -path "D:\Scripts\AdminPasswordchange\computers.txt"

foreach ($Computer in $Computers) {

$Computer = $Computer.toupper()
$Isonline = "OFFLINE"
$Status = "SUCCESS"
$StatsError ="Failed"
if((Test-Connection -ComputerName $Computer -count 1 -ErrorAction 0)) {
$Isonline = "ONLINE"
} else { $StatsError= "`t$Computer is OFFLINE" }
 
try {
$account = [ADSI]("WinNT://$Computer/Administrator,user")
$password = -join $(1..15 | %{[char]$(Get-Random $(33..126))})
$account.psbase.invoke("setpassword",$password)
$StatsError="Administrator Password changed successfully"
}
catch {
$status = "FAILED"
$StatsError="$_"
}
 
$obj = New-Object -TypeName PSObject -Property @{
ComputerName = $Computer
IsOnline = $Isonline
PasswordChangeStatus = $Status
DetailedStatus=$StatsError
Password=$password
}
 
$obj | Select ComputerName, IsOnline, PasswordChangeStatus,DetailedStatus,Password
$obj | Export-Csv -Append -Path "D:\Scripts\AdminPasswordchange\output.csv"
}
 

