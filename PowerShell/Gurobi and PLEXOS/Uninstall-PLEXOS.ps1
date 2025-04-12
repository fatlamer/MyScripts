#Uninstall PLEXOS (filename is always the same name)
Start-Process msiexec -ArgumentList "/x PLEXOS_Setup_x64.msi /qn /norestart" -NoNewWindow -Wait -ErrorAction SilentlyContinue