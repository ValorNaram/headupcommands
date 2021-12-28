# kThisp

**Say (almost) good bye from the *nasty* "Save", "Save as", "Export" and "Open" dialogs which come up when working with folders and or files <u>inside</u> an application like GIMP, LibreOffice, Open Broadcasting Studio (OBS).**

**Makes working with the *nasty* "Save", "Save as", "Export" and "Open" dialogs <u>easier</u> which come up when working with folders and or files <u>inside</u> an application like GIMP, LibreOffice, Open Broadcasting Studio (OBS)**

## What is that?

### Mainstream explanation / Non-techy explanation

**Only working on desktop environment *KDE* like <u>Kubuntu</u> ships by default which is not the same as Ubuntu**

This little but powerful script catches the directory in an active (focused) Dolphin¹ tab/window and creates a symbolic link² under your *Home* folder and calls that link *thispointer*. It also updates that link automatically if you currently work in another folder within Dolphin. This way the link *thispointer* always points to the directory you currently work in .You can then tell other programs about this symbolic link so they save files to the location the symbolic link points to. See the following examples to understand correctly:

**Example A**

1. You create a subfolder called *Impressions* in your *Pictures* folder and since you do that with Dolphin (file browser) you have that new folder now opened in Dolphin.
2. You open Firefox (you changed the default location of your downloads to the *thispointer* symbolic link already), open a webpage and click the *Download* button to download something from the website.
3. Firefox respects your setting which tells it to save downloads where the symbolic link *thispointer* points to and downloads the file to the location the symbolic link *thispointer* redirects to. In this case *thispointer* redirects to your folder *Impressions* inside your *Pictures* folder. That means Firefox downloads into the folder *Impressions* inside your *Pictures* folder.

**Example B** (that was my user story)

You are in the study hall and your professor just uploaded their slides and you need to get them fast to save & open them before the listening session begins. You create a subfolder somewhere in your *Studies* folder where you want to save the file and you open it with Dolphin. Since you're smart person you use the script `kThisp.py` which runs into the background. And to complete the setup you commanded Firefox to download files to the location the symbolic link *thispointer* redirects to. You log into the study platform, head to the location of the slides and download them. *thispointer* points to the said subfolder in your *Studies* folder because that's the folder you have currently opened and active in Dolphin. Firefox downloads these slides right into the currently opened folder in Dolphin because that is where the link *thispointer* points/redirects to. You see the PDF file with the slides popping up in your active Dolphin window/tab.

**Example C**

1. You have currently opened `Home --> Pictures --> Impressions` in a Dolphin tab/window which is active. The symbolic link *thispointer* redirects to that *Impressions* directory.
2. You now work in `Home --> Videos --> horror --> Sally Stich` and that corresponding Dolphin tab/window became the active one now.
   The symbolic link *thispointer* now redirects to that *Sally Stich* directory and **not more** to your  *Impressions* directory.

¹ Dolphin is KDEs' default file manager you use to browse & manage your files on your computer.

² A symbolic link is a reference to an existing directory or file on your computer. Under your *Desktop* folder you can create a symbolic link to point/redirect to your *Pictures* folder which is located under your *Home* folder. Click on that symbolic link and you will be taken to your *Pictures* folder as you know it.

### Techy explanation

This little but powerful script catches the directory in an active (focused) Dolphin tab/window and creates a symbolic link² under `/home/$USER/thispointer`. It also updates that link automatically if you currently work in another folder within Dolphin. This way the link *thispointer* always points to the directory you currently work in .You can then tell other programs about this symbolic link so they save files to the location the symbolic link points to. See the following examples to understand correctly:

**Example A**

1. You create the folder `/home/$USER/Pictures/Impressions` and open this path in dolphin.

2. You open Firefox (you changed the default location of your downloads to the *thispointer* symbolic link already), open a webpage and click the *Download* button to download something from the website.

3. Firefox respects your setting which tells it to save downloads where the symbolic link *thispointer* points to and downloads the file to the location the symbolic link *thispointer* redirects to. In this case *thispointer* redirects  `/home/$USER/Pictures/Impressions`. That means Firefox downloads into the folder `/home/$USER/Pictures/Impressions`.

   `/home/$USER/thispointer -->  /home/$USER/Pictures/Impressions`

**Example B** (that was my user story)

You are in the study hall and your professor just uploaded their slides and you need to get them fast to save & open them before the listening session begins. You create a subfolder somewhere in your *Studies* folder where you want to save the file and you open it with Dolphin. Since you're smart person you use the script `kThisp.py` which runs into the background. And to complete the setup you commanded Firefox to download files to the location the symbolic link *thispointer* redirects to. You log into the study platform, head to the location of the slides and download them. *thispointer* points to the said subfolder in your *Studies* folder because that's the folder you have currently opened and active in Dolphin. Firefox downloads these slides right into the currently opened folder in Dolphin because that is where the link *thispointer* points/redirects to. You see the PDF file with the slides popping up in your active Dolphin window/tab.

**Example C**

1. You have currently opened `/home/$USER/Pictures/Impressions` in a Dolphin tab/window which is active.

   `/home/$USER/thispointer --> /home/$USER/Pictures/Impressions`

2. You now work in `/home/$USER/Videos/horror/Sally\ Stich` and that corresponding Dolphin tab/window became the active one now.

   `/home/$USER/thispointer --> /home/$USER/Videos/horror/Sally\ Stich`

## How to install

1. Download this [script](../kThisp.py) (if not done already) and save it to a location you find appropriate.
1. Mark it as executable
2. Add it to your autostart settings to make it start when you log into your user account.
3. Restart your computer for changes to become active **or even better** start the script yourself.
4. Tell your programs to save or export files to `Home --> thispointer`. You may need to enter `/home/<replace this with your username>/thispointer` manually. Please replace the text `<replace this with your username>` with your username which you get when you execute `echo $USER` in a terminal/konsole.
