# codimd-cli

A tiny CLI to perform common operations on [CodiMD](https://github.com/hackmdio/codimd) (formerly known as HackMD).

For more background, see the initial [discussion](https://github.com/hackmdio/codimd/issues/808) on the main codimd repo.

## Install

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

### Help contribute more!

We'd love a PR for any one of these commands!

 - `codimd inviteuser <email_to_invite>`
 - `codimd chmod <permissions> <note_id>`
 - `codimd chown <user> <note_id>`
 - `codimd delete <note_id>`
 - `codimd list --all` list all notes on the server by id: title
 - `codimd list <user_email>` list notes for a given user by id: title
 - `codimd search <query>` find a note ids matching a given query
