# firefoxidle

`firefoxidle` powers off or reboots your system if the following conditions are true

- Program `firefox` not running or

- `firefox` is not performing a file download currently

**Your story:** You download a big file from the world wide web using firefox, you look at the remaining hours and you take a clock on your clock just to realize that you need to get to university soon so you better prepare yourself going out. Mhhh, wait! What about the download? You definitely want your computer to be turned off when the download finishes. But who can do that? You live alone but luckily you have this great script. You already started the download, ensured that your internet connection remains stable for a successfull download and now you execute `firefoxidle poweroff` and leave your computer alone for its unattended power off.

## Syntax

Power off system after download has been finished: `backupidle poweroff`

Reboot system after download has been finished: `backupidle reboot`

## Internal logic

1. Scanning the home directory for files containing `.part` which are temporally files which firefox creates which grow in file size as firefox downloads data.

2. It only takes the first result so warching only one firefox download is possible

3. Periodically checking if `firefox` is running
   
   1. If not then execute desired command e.g. the one for powering off the system

4. and periodically checking if firefox finished downloading files.
   
   1. If finish then execute desired command e.g. the one for powering off the system.
