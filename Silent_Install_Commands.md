<b>1. Skype without startup entry</b><br>
1.1. Download Skype MSI from <a href>http://www.skype.com/go/getskype-msi</a> <br>
1.2. Use the following silent install command to install for all users: <br>
<code>msiexec /I SkypeSetup.msi /qn ALLUSERS=1  TRANSFORMS=:RemoveStartup.mst</code></br>

<b>2. Adobe Acrobat Reader</b><br>
2.1. Download Acrobat Reader from <a href>https://get.adobe.com/reader/enterprise/</a><br>
2.2. Use the following silent install command to install for all users: <br>
<code>AcroRdrDCXXXXXXX_xx_XX.exe /sAll /rs</code></br>
2.3. Update Acrobat Reader installation with MSP files:<br>
2.3.1. Download location:<br>
<a href>https://helpx.adobe.com/acrobat/kb/install-updates-reader-acrobat.html</a><br>
2.3.2. Silent install command:<br>
<code>msiexec /update AcroRdrDCUpdXXXXXXXXXX.msp /passive /norestart</code><br>

<b>3. Adobe Flash Player (NPAPI and PPAPI) with EXE installers</b><br>
3.1. Direct download location:<br>
3.1.1. NPAPI for Firefox<br>
<a href>https://fpdownload.macromedia.com/pub/flashplayer/latest/help/install_flash_player.exe</a><br>
3.1.2. PPAPI for Chrome and Opera<br>
<a href>https://fpdownload.macromedia.com/pub/flashplayer/latest/help/install_flash_player_ppapi.exe</a><br>
3.2. Silent install commands for all users:<br>
<code>install_flash_player.exe -install</code><br>
<code>install_flash_player_ppapi.exe -install</code><br>

<b>4. FileZilla client</b><br>
4.1. Download location:<br>
<a href>https://filezilla-project.org/download.php?type=client</a><br>
4.2. Silent install command for all users:<br>
<code>FileZilla_X.XX.XX_winXX-setup.exe /S /user=all</code>

<b>5. Git for Windows</b><br>
5.1. Download location:<br>
<a href>https://git-scm.com/downloads</a><br>
5.2. Silent install command for all users:<br>
<code>Git-X.XX.XX-XX-bit.exe /SP- /VERYSILENT /components="icons,icons\desktop,ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh"</code><br>
<b>6. Google Chrome browser</b><br>
6.1. Download location:<br>
<a href>https://enterprise.google.com/chrome/chrome-browser/</a><br>
6.2. Silent install command for all users:<br>
<code>msiexec /I GoogleChrome.msi /qn /norestart</code>

<b>7. 7-Zip</b><br>
7.1. Download location:<br>
<a href>http://www.7-zip.org/download.html</a><br>
7.2. Silent install command for all users:<br>
<code>7zXXXX-xXX.exe /S</code><br>

<b>8. K-Lite Codec Pack</b><br>
8.1. Download location (use Mega edition):<br>
<a href>https://www.codecguide.com/download_kl.htm</a><br>
8.2. Create unattended installation file by starting "Unattended Wizard"<br>
with this command <code>K-Lite_Codec_Pack_XXXX_Mega.exe /unattended</code><br>
More info can be found here--><a href>http://www.codecguide.com/silentinstall.htm</a><br>
8.3. Use generated command line file to perform silent installation for all users.<br>
You can edit the file to suit your needs and add updates for K-Lite.<br>
Here is a sample code from edited unattended file:<br>
<code>@echo Installing: K-Lite Mega Codec Pack<br>
@"%~dp0K-Lite_Codec_Pack_1360_Mega.exe" /verysilent /norestart /LoadInf="%~dp0klcp_mega_unattended.ini"<br>
@"%~dp0klcp_update_1363_20171030.exe" /verysilent /norestart<br>
@echo Done!</code><br>

<b>9. Mozilla Firefox and Thunderbird</b><br>
9.1. Download location (all languages) for Firefox:<br>
<a href>https://www.mozilla.org/en-US/firefox/all/</a><br>
Download location (all languages) for Thunderbird:<br>
<a href>https://www.mozilla.org/en-US/thunderbird/all/</a><br>
9.2. Silent install command for all users:<br>
<code>Sestup.exe -ms</code>

<b>10. Notepad ++</b><br>
10.1. Download location:<br>
<a href>https://notepad-plus-plus.org/download</a><br>
10.2. Silent install command for all users:<br>
<code>npp.X.X.X.Installer.exe /S</code><br>

<b>11. Oracle Java Runtime Environment (JRE)</b><br>
11.1. Download location:<br>
<a href>https://www.java.com/en/download/manual.jsp</a><br>
11.2. Silent install command for all users:<br>
<code>jre-XuXXX-windows-XXXX.exe /s</code><br>

<b>12. Putty</b><br>
12.1. Download location:<br>
<a href>https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html</a><br>
12.2. Silent install command for all users:<br>
<code>msiexec /I putty-X.XX-installer.msi /qn /norestart</code><br>

<b>13. QBittorrent</b><br>
13.1. Download location (use Fosshub):<br>
<a href>https://www.qbittorrent.org/download.php</a><br>
13.2. Silent install command for all users:<br>
<code>qbittorrent_X.X.XX_setup.exe /S</code><br>

<b>14. Visual Studio Code</b><br>
14.1. Download location:<br>
<a href>https://code.visualstudio.com/#alt-downloads</a><br>
14.2. Silent install command for all users:<br>
<code>VSCodeSetup-xXX-X.XX.X.exe /SP- /VERYSILENT /mergetasks="desktopicon,addcontextmenufiles,addcontextmenufolders,addtopath,!runcode"</code><br>
Reference:<a href>https://github.com/Microsoft/vscode/blob/master/build/win32/code.iss</a><br>

<b>15. VLC Media Player</b><br>
15.1. Download location:<br>
<a href>https://www.videolan.org/vlc/download-windows.html</a><br>
15.2. Silent install command for all users:<br>
<code>vlc-X.X.X-win32.exe /L=1033 /S /V/qn</code><br>
Reference:<a href>https://wiki.videolan.org/Documentation:Installing_VLC/</a><br>

<b>16. WinSCP Client</b><br>
13.1. Download location:<br>
<a href>https://winscp.net/eng/download.php#download2</a><br>
13.2. Silent install command for all users:<br>
<code>WinSCP-X.XX.X-Setup.exe /SP- /VERYSILENT</code><br>