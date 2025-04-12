**As this information is hard to find in learn.microsoft.com, here is what I was able to find:**</br>

**Variable:** updatepromptuser </br>
**Possible config:** True | False  (Default: False) </br>
**Explanation:** This specifies whether or not the user will see default GUI dialog before automatically applying the updates. </br>

**Variable:** forceappshutdown </br>
**Possible config:** True | False  (Default: False) </br>
**Explanation:** This specifies whether the user will be given the option to cancel out of the update. However, if this variable is set to True, then the applications will be shut down immediately and the update will proceed. </br>

**Variable:** displaylevel </br>
**Possible config:** True | False  (Default: True) </br>
**Explanation:** This specifies whether the user will see a user interface during the update. Setting this to false will hide all update UI (including error UI that is encountered during the update scenario). </br>

**Variable:** updatetoversion </br>
**Possible config:** 15.0.xxxx.xxxx  (Default: Install the latest released build) </br>
**Explanation:** This specifies the version to which Office needs to be updated to.  This can used to install a newer or an older version than what is presently installed.
A list of Click-to-Run version numbers is published at https://learn.microsoft.com/en-us/officeupdates/update-history-microsoft365-apps-by-date. </br>

**Variable:** changesetting /Channel</br>
**Possible config:** MonthlyEnteprprise (full list of channels https://learn.microsoft.com/en-us/deployoffice/updates/overview-update-channels)  </br>
**Explanation:** This changes Office Update channel for MS365 Apps for Enterprise . </br>