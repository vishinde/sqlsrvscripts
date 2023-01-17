PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'c:\sqlsrvscripts\sqlsrvscripts-main\InstanceReview.ps1'"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'c:\sqlsrvscripts\sqlsrvscripts-main\DBAssess.ps1'"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'c:\sqlsrvscripts\sqlsrvscripts-main\SizingAssess.ps1'"

pause