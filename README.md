# krunnercommands

Command Line scripts for krunner utilizing the "run command" functionality krunner has. All commands have been scripted into their own file and corresponds with the file name. For example if you want to look into the code behind the `login` command then feel free to look at the source code in file `login`.



## How to execute these commands

On KDE use the shortcut ALT+Space to open krunner and then type in the command which has been provided by a file here.

## Install

-- To be continued --

## Command Documentation

### login

`login` and `remote` share the same codebase.

The `login` command works hand in hand with the [_standard unix password manager_](https://www.passwordstore.org/). It looks at your password store by utilizing `pass` which handles the store to find the name of the password entry you requested. Once found it will decrypt it and open the login url referenced there in firefox.

**Your story:** You have your GitHub credentials in your password store and the firefox addon "PassFF" installed (in firefox) and want to log in to Github to do good software coding stuff. And you're tired opening firefox and going to GitHub login page on your own. Glad that you installed the scripts here into your `PATH` and so you just do ALT+Space to open krunner and you type in `login github`. Magically but not surprisingly you will be prompted for your password store certificate password and if you enter it correctly then firefox will open with the GitHub login url in the address bar. If you now have `PassFF` firefox addon configured properly and only one login for this site then it should fill in the credentials on its own, hit the login button to log you finally in to do you a favor.

#### Syntax

`<name>` = Replace with the name of the gpg file in your password store. The search behind is **case-insensitive** and **recursive**. E.g. `login github` is the same as `login GitHub` as long as the pgp file has the name `GiThUb` or `gitHUB` etc. Never ever add the file extension `.pgp` because we're running Linux and can do better than our enemy users running Windows.

`login <name>`

Log in to a site: `login <name>` e.g. `login github` or `login GitHub`.

#### Internal logic

1. You use the syntax `login <name>` e.g. `login GitHub` or `login github` as long as you have a gpg file named `GitHub` or `github` or even `Github`.

2. The script lists all content in your password store using `tree` and performs a case-insensitive search for the `<name>` you provided.

3. When there is more than just one result it simply takes the first one.

4. It prepares the result for `pass` which requires a special notation for gpg password files.

5. `pass` asks you for the password of the certificate to be able to decrypt the content of the password file found and selected.

6. It filters the result so we have only the line with the login url.

7. It removes the string `url: ` (note the whitespace at the end) and passes the rest (the login url) to firefox.

For it to work for e.g. being able to fetch the GitHub login url this script requires the password store to be at `~/.password-store` and decryption/enryption to be working. But also `pass` must display a graphical (GUI) prompt where you need to enter the password for your certificate you use for that password store.

If you want to just type `login github` your password file must have the name (file extension inclusive) `GitHub.pgp` or `github.pgp` or `gitHub.pgp` . But `Github-private.pgp` is then not allowed. So here the thumb rule comes:

- `login github` --> `GitHub.pgp` or `github.pgp` or `gitHub.pgp`

- `login <name>` --> `<Name>.pgp` or `<nAmE>.pgp` etc.

Please note the case-insensitive search!

Your pgp file e.g. for GitHub should have the following format:

```gpg
<your very very secure machine cryptographically generated password>
username: your_email@your_domain
url: https://github.com/login
```

### remote

`remote` and `login` share the same codebase.

The `remote` command works hand in hand with the [_standard unix password manager_](https://www.passwordstore.org/). It looks at your password store by utilizing `pass` which handles the store to find the name of the password entry you requested. Once found it will decrypt it and ssh to a remote interactive terminal.

**Your story:** You're an admin of thousand and one night servers and sick remembering the ssh commands to access each as you please or need. But you are a good admin and therefore stored each ssh command in an pgp file on its own. Glad that you installed the scripts here into your `PATH` and so you just do ALT+Space to open krunner and you type in `remote personalserver` and say krunner that it should open you a terminal so you can interact with it. Magically but not surprisingly you will be prompted for your password store certificate password and if you enter it correctly then it opens the terminal displaying the ssh command it is going to execute. Now SSH does it usual job you love it for.

#### Syntax

`<name>` = Replace with the name of the gpg file in your password store. The search behind is **case-insensitive** and **recursive**. E.g. `remote personalserver` is the same as `remote PersonalServer` as long as the pgp file has the name `PersonalServer` or `pErSonALsErVer` etc. Never ever add the file extension `.pgp` because we're running Linux and can do better than our enemy users running Windows.

`remote <name> [<remote command>]`

Log in to a server: `remote <name>` e.g. `remote personalServer` or `remote Personalserver`.
Log in to a server and issue a single command: `remote <name> <command to execute remotely (it is allowed that the command contains whitespaces but explicit quoting is not required)>` e.g. `remote personalserver sudo apt update && sudo apt upgrade` or `remote PersonalSERVER sudo apt update && sudo apt upgrade`.

#### Internal logic

1. You use the syntax `remote <name> [<remote command>]` e.g. `login personalServer`, `login PersonalSERVER`, `remote personalserver sudo apt update && sudo apt upgrade` or `remote PersonalSERVER sudo apt update && sudo apt upgrade` as long as you have a gpg file named `PeRsOnAlserver` or `personalserver` or even `PersonalSERVER`.

2. The script lists all content in your password store using `tree` and performs a case-insensitive search for the `<name>` you provided.

3. When there is more than just one result it simply takes the first one.

4. It prepares the result for `pass` which requires a special notation for gpg password files.

5. `pass` asks you for the password of the certificate to be able to decrypt the content of the password file found and selected.

6. It filters the result so we have only the line with the ssh command.

7. It removes the string `ssh ` (note the whitespace at the end) and passes the rest (the ssh login command) over to SSH.

For it to work for e.g. being able to fetch the server login SSH command this script requires the password store to be at `~/.password-store` and decryption/enryption to be working. But also `pass` must display a graphical (GUI) prompt where you need to enter the password for your certificate you use for that password store.

If you want to type `remote personalserver` (with or without command parameter does not matter) your password file must have the name (file extension inclusive) `personalserver.pgp`, `PersonalServer.pgp` or `personalServer.pgp` . But `server-personal.pgp` is then not allowed. So here the thumb rule comes (with or without command parameter does not matter):

- `remote personalserver` --> `personalserver.pgp`, `PersonalServer.pgp` or `personalServer.pgp`

- `remote <name>` --> `<Name>.pgp` or `<nAmE>.pgp` etc.

Please note the case-insensitive search!

Your pgp file e.g. for your personal server should have the following format:

```gpg
<your very very secure machine cryptographically generated password>
username: your_username@your_domain
ssh your_username@your_domain
```


```gpg
<your very very secure machine cryptographically generated password>
ssh your_username@your_domain
```


```gpg
<your very very secure machine cryptographically generated password>
username: your_username@your_domain
ssh your_username@your_domain -P 2705
```

or similiar.
