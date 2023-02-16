# Create RPI Zero W 2 for Monorail

un: x
pw: pw

### Get localization set

```

sudo raspi-config 

```
* Update Raspi-Config
    * Update

* Set localization to US
    * Localization Options
        *WLAN Country Set
            * Choose US

* Enable SSH
    * Interface Options
        * SSH
Exit


``` 
sudo vim /etc/wpa_supplicant/wpa_supplicant.conf

```

```
country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 scan_ssid=1
 ssid="MyNetworkSSID"
 psk="Pa55w0rd1234"
}
```

sudo apt update

sudo apt install vim



