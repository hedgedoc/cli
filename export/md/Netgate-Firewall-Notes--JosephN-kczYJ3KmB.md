# Netgate Firewall Notes -JosephN



## Netgate Firewall Serial Port Guide (macOS)

1. Open the mac and open the terminal
2. Connect console port to the Mac. (USB-Mini)
3. Run the command
```
ls /dev/tty.usb*
```
4. A new option should of appeared
5. Use the command 

```
sudo screen <console port> 115200
```
6. You should be entered into the console of the device

Official Netgate Docs: [Netgate Website](https://docs.netgate.com/pfsense/en/latest/solutions/xg-7100/connect-to-console.html)

## Connecting to web interface
*This requires a device with an ethernet port (or USB to ethernet adapter)*
1. Set static IP on device on your device (192.168.1.20) *Can be different than that 