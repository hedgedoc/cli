# codimd-cli

A tiny CLI to perform common operations on [CodiMD](https://github.com/hackmdio/codimd) (formerly known as HackMD).

## Install

```bash
git clone https://github.com/hackmdio/codimd-cli

# Add the following to your ~/.bashrc or shell profile
export PATH=/path/to/codimd-cli/bin:$PATH
export HACKMD_SERVER='https://codimd.example.com'

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

### Help contribute more!

We'd love a PR for any one of these commands!

 - `hackmd inviteuser <email_to_invite>`
 - `hackmd chmod <permissions> <note_id>`
 - `hackmd chown <user> <note_id>`
 - `hackmd delete <note_id>`
 - `hackmd list --all` list all notes on the server by id: title
 - `hackmd list <user_email>` list notes for a given user by id: title
 - `hackmd search <query>` find a note ids matching a given query
