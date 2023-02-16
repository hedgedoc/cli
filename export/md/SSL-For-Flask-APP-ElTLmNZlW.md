# SSL For Flask APP

First Generate self signed SSL Cert

```
openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout priv_key.pem -days 3650

```

Then add to python application's app.run command eg.

```
app.run(debug=True, ssl_context=('cert.pem', 'priv_key.pem'), host='0.0.0.0', port='443')
```


ssl_context=('cert.pem', 'priv_key.pem')

Don't forget to add to firewall.

```
ufw allow 443
```
Cockpit -- You have to go to the Networking tab and then to firewall and add https
