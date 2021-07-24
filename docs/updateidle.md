# updateidle

`updateidle` powers off or reboots your system if the following conditions are true

- Program `apt` not running

- Program `apt-get` not running

**Your story:** You currently update your system and this takes longer than you thought originally but with your eyes on the digital computer clock displayed in the middle of the topbar you realize that you need to leave the house now to get to your train. You want your computer to shut down when it finished the updates so you execute `updateidle poweroff` and run to your train.

## Syntax

Power off system after updates has been installed: `backupidle poweroff`

Reboot system after updates has been installed: `backupidle reboot`

## Internal logic

1. Periodically checking if `apt` is running.

2. Periodically checking if `apt-get` is running.

3. Running the action specified as argument when step 1 and 2 result both in `false`.
