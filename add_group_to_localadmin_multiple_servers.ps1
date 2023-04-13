# Define the servers to add the group to
$servers = @("server1","server2")

# Define the group to add
$group = "groupname"

# Loop through each server and add the group
foreach ($server in $servers) {
    # Check if the server is reachable
    if (Test-Connection -ComputerName $server -Quiet) {
        # Add the group to the local Administrators group on the server
        $admins = [ADSI]"WinNT://$server/Administrators"
        $newGroup = [ADSI]"WinNT://$group"
        $admins.PSBase.Invoke("Add",$newGroup.Path)
        Write-Host "Added group $group to server $server"
    } else {
        Write-Warning "Server $server is not reachable"
    }
}
