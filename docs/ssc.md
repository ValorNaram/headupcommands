 # ssc (mainstream explanation)

## Save a useful resource e.g. a website

It saves a bookmark/shortcut into the `shortcuts` directory containing the content of the clipboard encrypted in your password store.

**User Story 1:** You use Moodle for your studies because that is there your lecturers are uploading their scripts etc. But you find that annoying that you need to click this, that, thus, thot and again this to get somewhere like to the scripts of your software engineering courses. You are already using `login <name of password file>` e.g. `login moodle` to log in to Moodle comfortably by just letting `login` open the login url and the firefox addon `PassFF` or another one to enter credentials automatically on the website. Now `login` can also decrypt & open the bookmarks you save with `ssc` for easier navigation and preventing the nasty _this, that, thus, thot and again this_ clicking.



## How to use

**This requires to install `headupcommands` (this repository) beforehand**

1. Open a website you would like to reach a bit faster and less error prone
2. Copy its url
3. Execute `ssc <name of the shortcut>` e.g. `ssc myfavwebsite` to save it.

Now you can execute `login <name of the shortcut saved>` e.g. `ssc myfavwebsite` to take a breath and to let technology open the url in Firefox and handle all additional logins (only when Firefox is set up this way).
