**To be able to use this script you need to have a working installation of the UNIX password store with password entries inside**

# login (mainstream explanation)

## Log in to a website

Unlocks your password store and then opens the login url to a website. If firefox or another browser can communicate with your password store then it certain situations the browser can log you automatically in. In other cases you need to manually select the account you want to log in exspecially if you have more than one account on one site. Imagine the following story:

You have your LinkedIn credentials in your password store as an entry called "linkedin" and the firefox addon "PassFF" installed (in firefox) and want to log into your LinkedIn profile. And you're tired opening firefox and going the LinkedIn login page on your own. Glad that you installed the scripts here and so you just do ALT+Space to open krunner and you type in `login linkedin` (case insensitive). Magically but not surprisingly you will be prompted for your password store certificate password and if you enter it correctly then firefox will open with the GitHub login url in the address bar. If you now have `PassFF` firefox addon configured properly and only one login for this site then it should fill in the credentials on its own, hit the login button to log you finally in to do you a favor.

**To be able to execute `login linkedin` you need an entry in your password store called "linkedin" or "LinkedIn" (case-insensitive).**

## Log into your file cloud

Unlocks your password store, establishes a connection to the server (file hoster) supporting SSH connections and then opening the remote file storage in your file browser. Imagine the following story:

You have your credentials to a file hosting service supporting SSH connections in your password store as an entry called "myFileSky". You just do ALT+Space to open krunner and you type in `login myfilesky` (we don't want to hit the capital letters key). Magically but not surprisingly you will be prompted for your password store certificate password and if you enter it correctly then your file browser will show up and lets you navigate through your files you stored in the cloud as if they were locally on your computer.

# login (techy explanation)

Opens the login url to a website, initiates a SSH connection or connects to a remote file system via sftp depending on the context you provide.

`login` and `remote` share the same codebase.

The `login` command works hand in hand with the [*standard unix password manager*](https://www.passwordstore.org/). It looks at your password store by utilizing `pass` which handles the store to find the name of the password entry you requested. Once found it will decrypt it and open the login url referenced there in firefox.

**Your story:** You have your GitHub credentials in your password store and the firefox addon "PassFF" installed (in firefox) and want to log in to Github to do good software coding stuff. And you're tired opening firefox and going to GitHub login page on your own. Glad that you installed the scripts here into your `PATH` and so you just do ALT+Space to open krunner and you type in `login github`. Magically but not surprisingly you will be prompted for your password store certificate password and if you enter it correctly then firefox will open with the GitHub login url in the address bar. If you now have `PassFF` firefox addon configured properly and only one login for this site then it should fill in the credentials on its own, hit the login button to log you finally in to do you a favor.

**Your second story:** You're an admin of thousand and one night servers and sick remembering the ssh commands to access each as you please or need. But you are a good admin and therefore stored each ssh command in an pgp file on its own. Glad that you installed the scripts here into your `PATH` and so you just do ALT+Space to open krunner and you type in `login personalserver` and say krunner that it should open you a terminal so you can interact with it. Magically but not surprisingly you will be prompted for your password store certificate password and if you enter it correctly then it opens the terminal displaying the ssh command it is going to execute. Now SSH does it usual job you love it for. The same applies also to sftp connections.

## Syntax

`<name>` = Replace with the name of the gpg file in your password store. The search behind is **case-insensitive** and **recursive**. E.g. `login github` is the same as `login GitHub` as long as the pgp file has the name `GiThUb` or `gitHUB` etc. Never ever add the file extension `.pgp` because we're running Linux and can do better than our enemy users running Windows.

`login <name>`

Log in to a site: `login <name>` e.g. `login github` or `login GitHub`.

Log in to a server (only if executed in the foreground): `login <name>` e.g. `login personalServer` or `login Personalserver`.
Log in to a server and issue a single command: `login <name> <command to execute remotely (it is allowed that the command contains whitespaces but explicit quoting is not required)>` e.g. `login personalserver sudo apt update && sudo apt upgrade` or `login PersonalSERVER sudo apt update && sudo apt upgrade`.

Log in to a remote file system (only if executed in the background): `login <name>` e.g. `login personalServer` or `login Personalserver`.

You execute this script in the background if you call it in krunner without saying krunner to execute it in a terminal window.

You execute this script in the foreground if you call it in krunner and saying krunner to execute it in a terminal window or if you call it directly from inside the terminal.

## only retrieve password

`login <name> --password-only` prints out the password to stdout only. No connection to server will be tried. For example will `login personalServer --password-only` print out the password of `personalServer` only.

## Internal logic

1. You use the syntax `login <name>` e.g. `login GitHub` or `login github` as long as you have a gpg file named `GitHub` or `github` or even `Github`.

2. The script lists all content in your password store using `tree` and performs a case-insensitive search for the `<name>` you provided.

3. When there is more than just one result it simply takes the first one.

4. It prepares the result for `pass` which requires a special notation for gpg password files.

5. `pass` asks you for the password of the certificate to be able to decrypt the content of the password file found and selected.

6. It determines the execution context:
   
   1. if executed in the background
      
      1. , a second argument provided to the `login` command and the `ssh` / `sftp` protocol being used in the `url` tag of the password file then it will initiate a **ssh connection** to the server to execute the command given as the second up until the last argument. The exit code of that command is then returned back just as it would have been run on your own system.
      
      2. the `ssh` / `sftp` protocol being used in the `url` tag of the password file then it will initiate a **sftp connection** to the server referenced in the url. Provided that the second argument will be left empty.
      
      3. and the `https` protocol being used in the `url` tag of the password file then it will open the url in firefox.
   
   2. if executed in the foreground
      
      1. a second argument provided to the `login` command and the `ssh` / `sftp` protocol being used in the `url` tag of the password file then it will initiate a **ssh connection** to the server to execute the command given as the second up until the last argument.
      
      2. the `ssh` / `sftp` protocol being used in the `url` tag of the password file then it will initiate a **ssh connection** to the server referenced in the url. Provided that the second argument will be left empty.
      
      3. and the `https` protocol being used in the `url` tag of the password file then it will open the url in firefox.

For it to work this script requires the password store to be at `~/.password-store` and decryption/enryption to be working. But also `pass` must display a graphical (GUI) prompt where you need to enter the password for your certificate you use for that password store.

If you want to just type `login github` your password file must have the name (file extension inclusive) `GitHub.pgp` or `github.pgp` or `gitHub.pgp` . But `Github-private.pgp` is then not allowed. So here the thumb rule comes:

- `login github` --> `GitHub.pgp` or `github.pgp` or `gitHub.pgp`

- `login <name>` --> `<Name>.pgp` or `<nAmE>.pgp` etc.

Please note the case-insensitive search!

### GPG File containing url

Your pgp file e.g. for GitHub should have the following format:

```gpg
<your very very secure machine cryptographically generated password>
username: your_email@your_domain
url: https://github.com/login
```

### GPG File containing ssh command

Your pgp file e.g. for your personal server should have at least the following format:

```gpg
<your very very secure machine cryptographically generated password>
url: ssh://your_username@your_domain
```

```gpg
<your very very secure machine cryptographically generated password>
url: ssh://your_username@your_domain:2705
```

or similiar.

### GPG File containing `portforward:`

This allows `login` to port forward using the `-L` argument switch

```gpg
<your very very secure machine cryptographically generated password>
url: ssh://your_username@your_domain:2705
portforward: 8085:127.0.0.1:80
```

or multiple `portforwards`‘s to use `-L` ssh argument switch multiple times to open multiple port forwards

```gpg
<your very very secure machine cryptographically generated password>
url: ssh://your_username@your_domain:2705
portforward: 8085:127.0.0.1:80
portforward: 8080:127.0.0.1:8476
```

