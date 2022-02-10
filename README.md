# hedgedoc-cli

A tiny CLI to perform common operations on [HedgeDoc](https://github.com/hedgedoc/server) (the largest open-source fork of HackMD).

For more background, see the initial [discussion](https://github.com/hackmdio/codimd/issues/808) on the hackmd codimd repo.

*There is an alternative, TypeScript-based CodiMD CLI for `hackmdio/codimd` maintained by the HackMD team here: https://github.com/hackmdio/codimd-cli.*  
*(it may or may not be compatible with the `hedgedoc/hedgedoc` server)*

## Installation

### Dependencies

- A HedgeDoc server running somewhere
- `curl` (install via `apt install curl` or `brew install curl` on Mac)
- `wget` (install via `apt install wget` or `brew install wget` on Mac)
- `jq` (install via `apt install jq` or `brew install jq` on Mac)

### Instructions

Clone the repository.

    $ git clone https://github.com/hedgedoc/cli

Enter the folder with the script.

    $ cd cli/bin

Optionally symlink the hedgedoc script somewhere into your $PATH to make it globally accessible. Otherwise you will have to provide the path to the script manually. This command might need admin rights (sudo)!

    $ ln -s $PWD/hedgedoc /usr/local/bin/hedgedoc

Check if the new command exists. You should see the documentation 

    $ hedgedoc

Set `HEDGEDOC_SERVER` environment variable to your server's URL. It defaults to `http://127.0.0.1:3000` Do this once on the command line or persist it in `.profile` and/or `.bashrc`.

    $ export HEDGEDOC_SERVER='https://hedgedoc.example.com'  

If you added the variable to `.profile` or `.bashrc`,  re-open the terminal to read the new variable.

Test your configuration by creating a new note with FREELY access and no login required. You will receive the generated `<note_id>` for the document like `3jXcabSfSNesbH6KT72ieg`.

**Caution: You won't have the right to delete the new document if not authenticated!**

    $ echo "# HedgeDoc!" > test.md
    $ hedgedoc import test.md

Check for the document in the browser by concatenating the
 address of your server and the `<note_id>`.

## Configuration and usage

### Variants of authentication

It's not necessary to authenticate against the server in order to make use of `hedgedoc-cli`. But without authentication you won't have access to the non-FREELY documents and everything that's accessible behind the login.

#### Authenticate with cookie

Authentication with a cookie is so far the only way if you login with GitLab and the like. Use browser extensions like [Get cookies.txt](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid) to store the cookie in `key.conf`.

Possible you have many lines in `key.conf`. You only need the line with `connect.sid` followed by a long hash!

Optionally add the HEDGEDOC_COOKIES_FILE environment variable to specify where cookies will be stored. It defaults to `~/.config/hedgedoc/key.conf`

```bash
# You can put this in .profile and/or .bashrc, too.
$ export HEDGEDOC_COOKIES_FILE=~/.config/hedgedoc/key.conf
```
#### Authenticate with email

```bash
$ hedgedoc login --email email@example.net p4sW0rD  # takes an email and password as optional args
$ hedgedoc login --email                            # or pass them via stdin prompt instead
```

#### Authenticate with LDAP

```bash
$ hedgedoc login --ldap username p4sW0rD            # takes a username and a password as optional args
$ hedgedoc login --ldap                             # or pass them via stdin prompt instead
```

#### Check if authentication works

If your authentication method is set up correctly the following commands will work.

### Get auth status, history, and logout

```bash
$ hedgedoc profile
You are logged in to a HedgeDoc server.

HEDGEDOC_SERVER=https://hedgedoc.example.com
HEDGEDOC_COOKIES_FILE=/Users/someuser/.config/hedgedoc/key.conf

USER_NAME=alice
USER_ID=abc93e9b-bf57-490f-a4c6-0d7a842b7cd4
USER_PHOTO=https://cdn.libravatar.org/avatar/ba8b1ebe25440cd38748639eebdc8eaf?s=96

$ hedgedoc history
ID  Title
fCbvG5pdSYOLobNN1SDUhg  Example-note-title
...

$ hedgedoc logout
```

Your hedgedoc auth session cookie is written to `$HEDGEDOC_COOKIES_FILE` (which defaults to `~/.config/hedgedoc/key.conf`).

You may need to log in again if:
 - your session expired
 - the hedgedoc server was restarted (which force-expires all sessions as a side-effect)
 - the  is`$HEDGEDOC_COOKIES_FILE` deleted, moved, or becomes unreadable by `hedgedoc-cli`

### Create/import a new note

```bash
$ hedgedoc import <input_path> [note_id]     # takes a local path to a text file, and an optional note id for the new note
qhmNmwmxSmK1H2oJmkKBQQ                     # returns <note_id> on success
```

You can open the new note on the server by going to `$HEDGEDOC_SERVER/<note_id>`.

The optional `note_id` is only available on servers with `allowFreeURL`
enabled.
Check the [documentation](https://docs.hedgedoc.org/configuration/#users-and-privileges)
for more information.

### Publish an existing note

```bash
$ hedgedoc publish qhmNmwmxSmK1H2oJmkKBQQ   # takes a <note_id>
S1ok9no3f                                 # returns public note id
```
You can open the published note on the server by going to `$HEDGEDOC_SERVER/s/<public_note_id>`.

### Export an existing note

```bash
$ hedgedoc export --pdf qhmNmwmxSmK1H2oJmkKBQQ             # takes a <note_id>, outputs to <note_id>.pdf by default
$ hedgedoc export --md qhmNmwmxSmK1H2oJmkKBQQ my_note.md   # or you can specify an output path explicitly
$ hedgedoc export --html qhmNmwmxSmK1H2oJmkKBQQ
$ hedgedoc export --slides qhmNmwmxSmK1H2oJmkKBQQ my_slides.zip
```


## API Endpoints

These server endpoints are used by this project and can be unstable and undocumented, but may be of use if you're developing your own projects that need API access to HedgeDoc.

 - `https://<hedgedoc_server>/login`
 - `https://<hedgedoc_server>/logout`
 - `https://<hedgedoc_server>/me`
 - `https://<hedgedoc_server>/history`  (requires auth)
 - `https://<hedgedoc_server>/new`
 - `https://<hedgedoc_server>/new/<note_id>`
 - `https://<hedgedoc_server>/<note_id>/publish`
 - `https://<hedgedoc_server>/<note_id>/download`
 - `https://<hedgedoc_server>/<note_id>/pdf`
 - `https://<hedgedoc_server>/<note_id>/slide`

## Help contribute!

We'd love a PR for any one of these commands!

 - `hedgedoc edit <note_id> < new_content.md`
 - `hedgedoc inviteuser <email_to_invite>`
 - `hedgedoc chmod <permissions> <note_id>`
 - `hedgedoc chown <user> <note_id>`
 - `hedgedoc delete <note_id>`
 - `hedgedoc list --all` list all notes on the server by id: title
 - `hedgedoc list <user_email>` list notes for a given user by id: title
 - `hedgedoc search <query>` find a note ids matching a given query

## Inspiration

If you want to build something with this CLI, here are some ideas that the community has requested:

**Import/Export:**

- **[Tests for HedgeDoc](https://github.com/hackmdio/codimd/issues/22): write some easy tests with the hedgedoc-cli**
- [Saving to local filesystem](https://github.com/hackmdio/codimd/issues/90): this is easy with `./hedgedoc export`
- [Export to PDF](https://github.com/hackmdio/codimd/issues/33): `./hedgedoc export --pdf <note_id> <output.pdf>` bam.
- [Arbitrary file upload](https://github.com/hackmdio/codimd/issues/261): we should support this with `./hedgedoc import <file.extension>`
- [Export slides as PDF](https://github.com/hackmdio/codimd/issues/241) & https://github.com/hackmdio/codimd/issues/545: we should add this to `./hedgedoc export --slides` once it's ready
- [Show all files in database](https://github.com/hackmdio/codimd/issues/640): `./hedgedoc list --all`
- [Import/export file in GitHub repository](https://github.com/hackmdio/codimd/issues/218): `wget <file from github> > file.md; ./hedgedoc import file.md`
- [API to download HTML](https://github.com/hackmdio/codimd/issues/515): works already `./hedgedoc export --html <note_id> note.html`
- [CLI for adding new note](https://github.com/hackmdio/codimd/pull/673): can be documented in the README with `hackmd` command
- ["Takeout" feature](https://github.com/hackmdio/codimd/issues/823): ability to download all user data with `./hedgedoc export`

**Permission management:**

- [Support permission of invitee only](https://github.com/hackmdio/codimd/issues/35): `./hedgedoc inviteuser --permissions r <user_email>` could work by first `chmod` and `chown`ing the note, then sending an email invite to that note
- [Find the notes by the owner](https://github.com/hackmdio/codimd/issues/653): `./hedgedoc list <user_email>` works as a rudimentary API to do this form the command line
- [Add user administration](https://github.com/hackmdio/codimd/issues/272): setup a script that creates all the users & their notes from .md files on disk, `chown` & `chmod`s them to their proper permissions, then invites all the users to join.  Would be possible to run this on a timer to do regularly as well.

**Sync backends:**

- [Import/Export with Github](https://github.com/hackmdio/codimd/issues/34): trigger `./hedgedoc import|export` script via timer or webhook upon github file modification
- [Import/Export with Evernote](https://github.com/hackmdio/codimd/issues/97): same deal as github/dropbox sync, write a script with import/export
- [Support for ownCloud](https://github.com/hackmdio/codimd/issues/245): same deal as github/dropbox sync, write a script with import/export
- [Support auto sync with dropbox](https://github.com/hackmdio/codimd/issues/124): write a script that does a full `import` and `export` or merge in whatever direction desired
- [Support auto sync with Google Drive](https://github.com/hackmdio/codimd/issues/275): write a script that does a full `import` and `export` or merge in whatever direction desired

