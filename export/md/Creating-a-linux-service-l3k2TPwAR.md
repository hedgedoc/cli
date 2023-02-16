# Creating a linux service
Turning it into a service

Let’s create a file called /etc/systemd/system/rot13.service:

```
[Unit]
Description=ROT13 demo service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=centos
ExecStart=/usr/bin/python3 /path/to/server.py

[Install]
WantedBy=multi-user.target
```


You’ll need to:

* set your actual username after User=
* set the proper path to your script in ExecStart=

That’s it. We can now start the service:

```
$ systemctl start rot13
```

And automatically get it to start on boot:

```
$ systemctl enable rot13
```


Notes for working on JBOD Server:
[Waitress on flask](https://dev.to/thetrebelcc/how-to-run-a-flask-app-over-https-using-waitress-and-nginx-2020-235c)




###### tags: `Linux` `Services`