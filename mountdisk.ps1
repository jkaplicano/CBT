$Disks = get-disk | where partitionstyle -eq 'raw' | sort number
	
	$letters = 70..90 | foreach-object { [char]$_ }
	$count = 0
	$labels = "data1", "data2" 
	
	Foreach ($disk in $disks) {
		$driveletter = $letters[$count].tostring()
		$disk |
		Initialize-disk -partitionstyle mbr -passthru |
		Newpartition -usemaximumsize -driveletter $driveletter |
		Format-volume -filesystem ntfs -newfilesystemlabel $labels[$count] -confirm:$false -force
		$count++
}
