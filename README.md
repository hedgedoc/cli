# codimd-cli

A tiny CLI to perform common operations on [CodiMD](https://github.com/codimd/server) (formerly known as HackMD).

For more background, see the initial [discussion](https://github.com/hackmdio/codimd/issues/808) on the main codimd repo.

## Install

Dependencies:
 - A CodiMD server running somewhere
 - `curl` (install via `apt install curl` or `brew install curl` on Mac)
 - `wget` (install via `apt install wget` or `brew install wget` on Mac)
 - `jq` (install via `apt install jq` or `brew install jq` on Mac)

```bash
git clone https://github.com/codimd/cli

# Add the following to your ~/.bashrc or shell profile
export PATH=/path/to/codimd-cli/bin:$PATH

# optionally add the CODIMD_SERVER environment variable to specify a server
# it defaults to 127.0.0.1:3000
export CODIMD_SERVER='https://codimd.example.com'  

# Test by creating a new note
codimd import test.md
```

## Documentation

### Create/import a new note
```bash
codimd import test.md                   # takes a markdown file
qhmNmwmxSmK1H2oJmkKBQQ                  # returns <note_id> on success
```

### Publish an existing note

```bash
codimd publish qhmNmwmxSmK1H2oJmkKBQQ   # takes a <note_id>
/s/S1ok9no3f                            # returns publish url
```

### Export an existing note

```bash
codimd export --pdf qhmNmwmxSmK1H2oJmkKBQQ my_note.pdf
codimd export --md qhmNmwmxSmK1H2oJmkKBQQ my_note.md
codimd export --html qhmNmwmxSmK1H2oJmkKBQQ my_note.html
codimd export --slides qhmNmwmxSmK1H2oJmkKBQQ my_slides.zip
```
*Note: you must specify the filename to export to as the second argument (with a correct extension), as the CodiMD CLI cannot determine the title of the note on its own.*

### Authenticate and get notes history

```bash
# optionally add the CODIMD_COOKIES_FILE environment variable to specify
# where cookies will be stored. It defaults to ~/.config/codimd-cli/key.conf
export CODIMD_COOKIES_FILE=~/.codimd-key.conf
```
#### Authenticate with email

```bash
codimd login --email email@example.net p4sW0rD  # takes an email and a password
```

#### Authenticate with LDAP

```bash
codimd login --ldap username p4sW0rD  # takes a username and a password
```

#### Get auth status, history, and logout

```bash
codimd profile
You are logged in $CODIMD_SERVER as email with id xxxx-xx[...]xxx.

codimd history
ID                      Name
0nAp3YRyTlyQ-N3N7lCk-w  Note_1
qhmNmwmxSmK1H2oJmkKBQQ  Note_2

codimd logout
```

## API Endpoints

These server endpoints are used by this project and can be unstable and undocumented, but may be of use if you're developing your own projects that need API access to CodiMD.

 - `https://<codimd_server>/login`
 - `https://<codimd_server>/logout`
 - `https://<codimd_server>/me`
 - `https://<codimd_server>/history`  (requires auth)
 - `https://<codimd_server>/new`
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
