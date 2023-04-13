# Define the servers to add the group to
$servers = @("SYVWTDBSTL25","SYVWTDB115X64","syvwpdbapgarr01","SYDGARTS02","SYVWTDBGARRAD22","sydgar121d","SYVWDBNTRSRT01","SYVWTDB117X64","SYVWTVDIMPL","SYVWTDBGARRAD26","SYVWTDBGARRAD21","syvwtdbgarrad27","sydgarradin17-clone","syvotdb117mrc_2","syvwtdbgarrad23","syvwtbusmtest02","syvrtdb117-mbl_old","syvctdb117_mrc_restored","SYVWTDBNTRSPR","syvotdb117x64","syvrtdb117-mbl","syswddbgar121","syvotdb117mrt","SYVWTDBOE117X64","sydgarradin16","SYDGARRADIN15","syvwtdbgarrad24","syvwdapgarrad01","SYVWDDBGARARD01","sydgarradin13","SYVWPAPGARRAD01","syvcdwwgarsvn02","syvodapgit01","sydgarfs01","sydhotdesk11","syswtapgarrad01")

# Define the group to add
$group = "security_garradin_access"

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
