# hedgedoc-cli

A tiny CLI to perform common operations on [HedgeDoc](https://github.com/hedgedoc/server) (the largest open-source fork of HackMD).

For more background, see the initial [discussion](https://github.com/hackmdio/codimd/issues/808) on the codimd repo.

*There is an alternative, TypeScript-based HedgeDoc CLI for `hackmdio/codimd` maintained by the HackMD team here: https://github.com/hackmdio/codimd-cli.*  
*(it may or may not be compatible with the `hedgedoc/server` server)*

## Install

Dependencies:
 - A HedgeDoc server running somewhere
 - `curl` (install via `apt install curl` or `brew install curl` on Mac)
 - `wget` (install via `apt install wget` or `brew install wget` on Mac)
 - `jq` (install via `apt install jq` or `brew install jq` on Mac)

```bash
git clone https://github.com/hedgedoc/cli
cd cli/bin
# optionally symlink the hedgedoc script somewhere into your $PATH
ln -s $PWD/hedgedoc /usr/local/bin/hedgedoc

# set HEDGEDOC_SERVER environment variable to your server's URL
# it defaults to http://127.0.0.1:3000
export HEDGEDOC_SERVER='https://hedgedoc.example.com'  

# Test by creating a new note
hedgedoc login --email
hedgedoc import test.md
```

## Documentation

### Create/import a new note
```bash
$ codimd import <input_path> [note_id]     # takes a local path to a text file, and an optional note id for the new note
qhmNmwmxSmK1H2oJmkKBQQ                     # returns <note_id> on success
```
You can open the new note on the server by going to `$HEDGEDOC_SERVER/<note_id>`.

### Publish an existing note

```bash
$ codimd publish qhmNmwmxSmK1H2oJmkKBQQ   # takes a <note_id>
S1ok9no3f                                 # returns public note id
```
You can open the published note on the server by going to `$HEDGEDOC_SERVER/s/<public_note_id>`.

### Export an existing note

```bash
$ codimd export --pdf qhmNmwmxSmK1H2oJmkKBQQ             # takes a <note_id>, outputs to <note_id>.pdf by default
$ codimd export --md qhmNmwmxSmK1H2oJmkKBQQ my_note.md   # or you can specify an output path explicitly
$ codimd export --html qhmNmwmxSmK1H2oJmkKBQQ
$ codimd export --slides qhmNmwmxSmK1H2oJmkKBQQ my_slides.zip
```

### Authenticate and get notes history

```bash
# optionally add the HEDGEDOC_COOKIES_FILE environment variable to specify
# where cookies will be stored. It defaults to ~/.config/codimd-cli/key.conf
$ export HEDGEDOC_COOKIES_FILE=~/.config/codimd-cli/key.conf
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
You are logged in to a HedgeDoc server.

HEDGEDOC_SERVER=https://hedgedoc.example.com
HEDGEDOC_COOKIES_FILE=/Users/someuser/.config/codimd/key.conf

USER_NAME=alice
USER_ID=abc93e9b-bf57-490f-a4c6-0d7a842b7cd4
USER_PHOTO=https://cdn.libravatar.org/avatar/ba8b1ebe25440cd38748639eebdc8eaf?s=96

$ codimd history
ID  Title
fCbvG5pdSYOLobNN1SDUhg  Example-note-title
...

$ codimd logout
```

Your codimd auth session cookie is written to `$HEDGEDOC_COOKIES_FILE` (which defaults to `~/.config/codimd/key.conf`).

You may need to log in again if:
 - your session expired
 - the codimd server was restarted (which force-expires all sessions as a side-effect)
 - the  is`$HEDGEDOC_COOKIES_FILE` deleted, moved, or becomes unreadable by `codimd-cli`

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

- **[Tests for HedgeDoc](https://github.com/hackmdio/codimd/issues/22): write some easy tests with the codimd-cli**
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
