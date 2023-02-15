$objs = Import-Csv -Delimiter "," sqlsrv.csv
foreach($item in $objs) {
$sqlsrv = $item.InstanceName +", " + $item.Port 
sqlcmd -H $sqlsrv -i ComponentsInstalled.sql -U test -P P@ssword1 -s"|" | findstr /v /c:"---" > output\ComponentsInstalled.csv
sqlcmd -H $sqlsrv -i ServerProperties.sql -U test -P P@ssword1 -s"|" | findstr /v /c:"---" > output\ServerProperties.csv
sqlcmd -H $sqlsrv -i Features.sql -U test -P P@ssword1 -s"|" | findstr /v /c:"---" > output\Features.csv 
}