# codimd-cli

A tiny CLI to perform common operations on [CodiMD](https://github.com/hackmdio/codimd) (formerly known as HackMD).

For more background, see the initial [discussion](https://github.com/hackmdio/codimd/issues/808) on the main codimd repo.

## Install

Dependencies:
 - A CodiMD server running somewhere
 - `wget` (instiall via `apt install wget` or `brew install wget` on Mac)

```bash
git clone https://github.com/hackmdio/codimd-cli

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

#### Authenticate with ldap

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
