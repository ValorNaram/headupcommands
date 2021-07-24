# flatinstall

**Your story:** You've got a fancy installation reference file from your best friend and stored it in your "Downloads" folder. Now you press ALT+Space and type in 'flatinstall flatpak' and let krunner open it in a konsole info so you can see the output. You approve the installation of that fancy tool. After installation the script moves the reference file from your Downloads to your trash folder. It is then up to you to decide to empty the trash and to delete that file for eternity from your hard drive. Now you have that fancy tool installed and you both can start doing things streight away.

## Syntax

That commands requires you to say krunner it should execute it in the foreground. This command requires the flatpak reference file (`.flatpakref`) to be stored into your Downloads folder.

Install a flatpak app: `flatinstall`

## Internal logic

1. You execute `flatinstall`
2. The script lists all content in your "Downloads" folder using `tree` and performs a case-insensitive search for a file with extension `.flatpakref`.
3. When there is more than just one result it simply takes the first one.
4. It prepares the result for `flatpak` which requires a special notation for their reference files.
5. It throws the ball of control over to flatpak
6. Flatpak throws the ball of control back and this script does the necessary cleanup.

For it to work it requires "~/Downloads" folder to exist and to be writeable. It also requires flatpak to be set up and the `.flatpakref` reference file you want to use for installation to be in the said folder because the script searches only there for it.
