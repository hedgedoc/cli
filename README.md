# codimd-cli

A tiny CLI to perform common operations on [CodiMD](https://github.com/codimd/server) (formerly known as HackMD).

For more background, see the initial [discussion](https://github.com/hackmdio/codimd/issues/808) on the main codimd repo.

*There is an alternative, TypeScript-based CodiMD CLI for `hackmdio/codimd` maintained by the HackMD team here: https://github.com/hackmdio/codimd-cli.*
*(it may or may not be compatible with the `codimd/server` server that this project`codimd/cli` is designed for)*

## Install

Dependencies:
 - A CodiMD server running somewhere
 - `curl` (install via `apt install curl` or `brew install curl` on Mac)
 - `wget` (install via `apt install wget` or `brew install wget` on Mac)
 - `jq` (install via `apt install jq` or `brew install jq` on Mac)

```bash
git clone https://github.com/codimd/cli
cd cli/bin
# optionally symlink the codimd script somewhere into your $PATH
ln -s $PWD/codimd /usr/local/bin/codimd

# set CODIMD_SERVER environment variable to your server's URL
# it defaults to http://127.0.0.1:3000
export CODIMD_SERVER='https://codimd.example.com'  

# Test by creating a new note
codimd login --email
codimd import test.md
```

## Documentation

### Create/import a new note
```bash
$ codimd import <input_path> [note_id]     # takes a local path to a text file, and an optional note id for the new note
qhmNmwmxSmK1H2oJmkKBQQ                     # returns <note_id> on success
```
You can open the new note on the server by going to `$CODIMD_SERVER/<note_id>`.

### Publish an existing note

```bash
$ codimd publish qhmNmwmxSmK1H2oJmkKBQQ   # takes a <note_id>
S1ok9no3f                                 # returns public note id
```
You can open the published note on the server by going to `$CODIMD_SERVER/s/<public_note_id>`.

### Export an existing note

```bash
$ codimd export --pdf qhmNmwmxSmK1H2oJmkKBQQ             # takes a <note_id>, outputs to <note_id>.pdf by default
$ codimd export --md qhmNmwmxSmK1H2oJmkKBQQ my_note.md   # or you can specify an output path explicitly
$ codimd export --html qhmNmwmxSmK1H2oJmkKBQQ
$ codimd export --slides qhmNmwmxSmK1H2oJmkKBQQ my_slides.zip
```

### Authenticate and get notes history

```bash
# optionally add the CODIMD_COOKIES_FILE environment variable to specify
# where cookies will be stored. It defaults to ~/.config/codimd-cli/key.conf
$ export CODIMD_COOKIES_FILE=~/.codimd-key.conf
```
#### Authenticate with email

```bash
$ codimd login --email email@example.net p4sW0rD  # takes an email and password as optional args
$ codimd login --email                            # or pass them via stdin prompt instead
```

#### Authenticate with LDAP

```bash
$ codimd login --ldap username p4sW0rD            # takes a username and a password as optional args
$ codimd login --ldap                             # or pass them via stdin prompt instead
```

#### Get auth status, history, and logout

```bash
$ codimd profile
You are logged in to a CodiMD server.

CODIMD_SERVER=https://docs.monadical.com
CODIMD_COOKIES_FILE=/Users/squash/.config/codimd/key.conf

USER_NAME=nick
USER_ID=adc93e0b-bf57-400f-a0c6-0c7a842b7cd7
USER_PHOTO=https://cdn.libravatar.org/avatar/aa8b1ebe25440bd38748639eebdc6eaf?s=96

$ codimd history
ID  Title
fCbvF5pdSYOLobNN0SDUhg  Example-note-title
...

$ codimd logout
```

Your codimd auth session cookie is written to `$CODIMD_COOKIES_FILE` (which defaults to `~/.config/codimd/key.conf`).

You may need to log in again if:
 - your session expired
 - the codimd server was restarted (which force-expires all sessions as a side-effect)
 - the  is`$CODIMD_COOKIES_FILE` deleted, moved, or becomes unreadable by `codimd-cli`

## API Endpoints

These server endpoints are used by this project and can be unstable and undocumented, but may be of use if you're developing your own projects that need API access to CodiMD.

 - `https://<codimd_server>/login`
 - `https://<codimd_server>/logout`
 - `https://<codimd_server>/me`
 - `https://<codimd_server>/history`  (requires auth)
 - `https://<codimd_server>/new`
 - `https://<codimd_server>/new/<note_id>`
 - `https://<codimd_server>/<note_id>/publish`
 - `https://<codimd_server>/<note_id>/download`
 - `https://<codimd_server>/<note_id>/pdf`
 - `https://<codimd_server>/<note_id>/slide`

## Help contribute!

We'd love a PR for any one of these commands!

 - `codimd edit <note_id> < new_content.md`
 - `codimd inviteuser <email_to_invite>`
 - `codimd chmod <permissions> <note_id>`
 - `codimd chown <user> <note_id>`
 - `codimd delete <note_id>`
 - `codimd list --all` list all notes on the server by id: title
 - `codimd list <user_email>` list notes for a given user by id: title
 - `codimd search <query>` find a note ids matching a given query

## Inspiration

If you want to build something with this CLI, here are some ideas that the community has requested:

**Import/Export:**

- **[Tests for CodiMD](https://github.com/hackmdio/codimd/issues/22): write some easy tests with the codimd-cli**
- [Saving to local filesystem](https://github.com/hackmdio/codimd/issues/90): this is easy with `./codimd export`
- [Export to PDF](https://github.com/hackmdio/codimd/issues/33): `./codimd export --pdf <note_id> <output.pdf>` bam.
- [Arbitrary file upload](https://github.com/hackmdio/codimd/issues/261): we should support this with `./codimd import <file.extension>`
- [Export slides as PDF](https://github.com/hackmdio/codimd/issues/241) & https://github.com/hackmdio/codimd/issues/545: we should add this to `./codimd export --slides` once it's ready
- [Show all files in database](https://github.com/hackmdio/codimd/issues/640): `./codimd list --all`
- [Import/export file in GitHub repository](https://github.com/hackmdio/codimd/issues/218): `wget <file from github> > file.md; ./codimd import file.md`
- [API to download HTML](https://github.com/hackmdio/codimd/issues/515): works already `./codimd export --html <note_id> note.html`
- [CLI for adding new note](https://github.com/hackmdio/codimd/pull/673): can be documented in the README with `hackmd` command
- ["Takeout" feature](https://github.com/hackmdio/codimd/issues/823): ability to download all user data with `./codimd export`

**Permission management:**

- [Support permission of invitee only](https://github.com/hackmdio/codimd/issues/35): `./codimd inviteuser --permissions r <user_email>` could work by first `chmod` and `chown`ing the note, then sending an email invite to that note
- [Find the notes by the owner](https://github.com/hackmdio/codimd/issues/653): `./codimd list <user_email>` works as a rudimentary API to do this form the command line
- [Add user administration](https://github.com/hackmdio/codimd/issues/272): setup a script that creates all the users & their notes from .md files on disk, `chown` & `chmod`s them to their proper permissions, then invites all the users to join.  Would be possible to run this on a timer to do regularly as well.

**Sync backends:**

- [Import/Export with Github](https://github.com/hackmdio/codimd/issues/34): trigger `./codimd import|export` script via timer or webhook upon github file modification
- [Import/Export with Evernote](https://github.com/hackmdio/codimd/issues/97): same deal as github/dropbox sync, write a script with import/export
- [Support for ownCloud](https://github.com/hackmdio/codimd/issues/245): same deal as github/dropbox sync, write a script with import/export
- [Support auto sync with dropbox](https://github.com/hackmdio/codimd/issues/124): write a script that does a full `import` and `export` or merge in whatever direction desired
- [Support auto sync with Google Drive](https://github.com/hackmdio/codimd/issues/275): write a script that does a full `import` and `export` or merge in whatever direction desired
