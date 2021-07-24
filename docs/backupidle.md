# backupidle

The `backupidle` powers off or reboots your system if the following conditions are true

- Program `rsync` not running (anymore)
  
  - `rsync` is a common tool used for backing up and keeping directories across different systems in sync. Since `rsync` syncs across systems, all files will be stored locally for offline use.

- Program `syncthing` not running (anymore) or if `syncthing` has finished syncronizing but is still running.
  
  - Just like `rsync` but provides a more modern look and allows easy syncronizarion across multiple systems with different operating systems without the need of an intermediate server. `syncthing` uses peer to peer technology to sync to the systems.

**Your story:** You came from vacation and already transfered all your photos to your laptop. Now you want to sync them to another workstation so you turn it on. You already set up syncthing on these two systems so they know and love each other. But you want the workstation to turn itself off when finished receiving the photos via syncthing so you execute `backupidle poweroff` on it.

## Syntax

Power off system after syncronization has been finished: `backupidle poweroff`

Reboot system after syncronization has been finished: `backupidle reboot`

## Internal logic

1. Retrieving API key from syncthing when installed and running

2. Periodically checking if `syncthing` is running and if yes then checking if it downloads files from another devices.

3. Periodically checking if `rsync` is running.

4. Running the action specified as argument when step 1 and 2 result both in `false`.
