$objs = Import-Csv -Delimiter "," sqlsrv.csv
$foldername = ""
foreach($item in $objs) {
    $sqlsrv = $item.InstanceName +", " + $item.Port 
    $obj = sqlcmd -H $sqlsrv -i foldername.sql -U test -P P@ssword1 | findstr /v /c:"---"
    $splitobj = $obj[1].Split('')
    $values = $splitobj | ForEach-Object { if($_.Trim() -ne '') { $_ } }

    $dbversion = $values[0]                                                                                                                                                                       
    $machinename = $values[1]                                                                                                                                                                       
    $dbname = $values[2]                                                                                                                                                                       
    $instancename = $values[3]                                                                                                                                                                       
    $current_ts = $values[4]  
    
    $op_version = '4.2.0'                                                                                                                                                                     

    #$folderop = sqlcmd -H $sqlsrv -i foldername.sql -U test -P P@ssword1 | findstr /v /c:"---"
    $foldername = 'opdb' + '_' + 'sqlsrv' + '_' + 'NoPerfCounter' + $dbversion + '_' + $op_version + '_' + $machinename + '_' + $dbname + '_' + $instancename + '_' + $current_ts
    
    New-Item -Name $foldername -ItemType Directory

    $compFileName = 'opdb' + '_' + 'ComponentsInstalled' + '_' + $dbversion + '_' + $machinename + '_' + $dbname + '_' + $instancename + '_' + $current_ts + '.csv'
    $srvFileName = 'opdb' + '_' + 'ServerProperties' + '_' + $dbversion + '_' + $machinename + '_' + $dbname + '_' + $instancename + '_' + $current_ts + '.csv'
    $blockingFeatures = 'opdb' + '_' + 'BlockingFeatures' + '_' + $dbversion + '_' + $machinename + '_' + $dbname + '_' + $instancename + '_' + $current_ts + '.csv'

    sqlcmd -H $sqlsrv -i ComponentsInstalled.sql -U test -P P@ssword1 -s"|" | findstr /v /c:"---" > $foldername\$compFileName
    sqlcmd -H $sqlsrv -i ServerProperties.sql -U test -P P@ssword1 -s"|" | findstr /v /c:"---" > $foldername\$srvFileName
    sqlcmd -H $sqlsrv -i Features.sql -U test -P P@ssword1 -m 1 -s"|" | findstr /v /c:"---" > $foldername\$blockingFeatures

    $zippedopfolder = $foldername + '.zip'
    Compress-Archive -Path $foldername -DestinationPath $zippedopfolder
    Remove-Item -Path $foldername -Recurse -Force
}
