$objs = Import-Csv -Delimiter "," sqlsrv.csv
foreach($item in $objs) {
$sqlsrv = $item.InstanceName +", " + $item.Port 
#sqlcmd -H localhost,1433 -i ComponentsInstalled.sql -o output\ComponentsInstalled.csv -s"|"
sqlcmd -H $sqlsrv -i ComponentsInstalled.sql -o output\ComponentsInstalled.csv -U test -P P@ssword1 -s"|"
sqlcmd -H $sqlsrv -i ServerProperties.sql -o output\ServerProperties.csv -U test -P P@ssword1 -s"|"
}