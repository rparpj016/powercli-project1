###Poweroff VMS###
##Adding first comment
 ###############Power off  VMS###############
     # Add the VM names to a text file and save it on a location for example C:\Scripts as Vmnames.txt
     foreach($vmName in (Get-Content -Path C:\scripts\vmnames.txt)){

    $vm = Get-VM -Name $vmName

    if($vm.Guest.State -eq "Running"){

       
       Shutdown-VMGuest -VM $vm -Confirm:$false

    }

    else{

        Stop-VM -VM $vm -Confirm:$false

    }

}

