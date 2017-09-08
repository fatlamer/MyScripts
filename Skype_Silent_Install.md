<b>Silently install Skype without startup entry</b> <br>
1. Download Skype MSI from <a href>http://www.skype.com/go/getskype-msi</a> <br>
2. Use the following silent install command: <br>
<code>msiexec /I SkypeSetup.msi /qn ALLUSERS=1  TRANSFORMS=:RemoveStartup.mst</code>
