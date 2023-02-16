# Setting up Laptops    J. Nichols
## Windows 11 Laptop
### Initial Setup

1. Select Country/Region (United States)
2. Keyboard Layout (US) & Skip Second Keyboard Layout
3. Connect to NSC-ACCESS or NSC-Employee (Depending on needs). Windows will then begin checking for updates
4. Once computer has updated, agree to license agreement
5. Name the device (NSC-*Service Tag*), or appropriate device name depending on circumstance
6. Setup device for "Work or School"
7. Select "Sign-in options" followed by "Domain Join instead"
    * Name: admin
    * Password: ``` Contact admin for password ```
    * Security Questions: ``` Contact admin ```
8. If prompted for faster sign in options (Touch ID or Face ID) Select "Skip for now"
9. Decline all of Microsofts privacy settings (Select no on all questions followed by next)
10. When prompted to Protect your device select "Skip" in the bottom right. Upon skipping Windows will check for updates again. If prompted to install necassary Windows Updates.
### Arrival at the desktop
1. Open Edge
    * Decline all of the services offered
2. Download google chrome & SimpleHelp
    * Search Google Chrome 
    * remote.newspring.org/access
3. Run both the google chrome & simplehelp installers
4. Set Chrome as the default browser
5. Open taskbar settings (Personalization -> taskbar) and disable the chat, widgets, & task view buttons
6. Join the domain
    * Settings -> Accounts -> Access Work or school -> connect ->  Join to a local AD domain -> nscsite.org -> *Enter Credentials*
7. When prompted to add an account to the PC select "Skip" & Restart the device
8. Download appropriate software which varies from user to user
    * Ex: Printer Drivers, Office software, Adobe, CAD software, etc.
9. Install Driver updates, windows updates, as needed. If setting up a dell laptop use dells "Support Assist" Application to run these updates. Lenovo offers "Lenovo Commercial Vantage" which can also install drivers.
* Remember to make sure laptop is in the correct time zone
#### If Installing Office
* Microsoft preloads most new windows machines with a weird version of office that breaks the version we install from nsc1. This office MUST be uninstalled before running the installer on nsc1. Office can be uninstalled in the Programs & Features window of Control Panel
1. Navigate to nsc1 -> Shared -> NSC_IT -> Software -> Office 2016 Disc installer
2. Double click the office installer which will mount an installer on your device
3. Open the DVD drive and run the setup application
4. If you uninstalled the preinstalled version of office correctly you should be able to run the installer without any errors. If you did not uninstall the preinstalled Office correctly then the installer will throw an error
5. Once Office 2016 has been installed navigate to file explorer and eject the installer (as if it were a DVD/External Drive)

----

## Setting Up Windows 10
* Join laptop to employee WiFi
    * Select no when asked about being discoverable on the network
* Chose personal use over organizational use
    * This way we can create a local admin account before joining the domain
* Select "Offline Account"
* Choose Limited Experience
* Name: admin
* Password: ``` Contact admin for password ```
* Security Questions: ``` Contact admin ```
* Declined Windows 11 and any other bloatware/services/Privacy settingsmicrosoft offers
* Skip customize Experience
* Continue to decline all offers
#### Upon arrival at the desktop
* Open Edge
    * Decline all of the services offered
* Download google chrome & SimpleHelp
    * Search Google Chrome 
    * remote.newspring.org/access (Don't Run simplehelp yet)
* Run Throught the google chrome installer
* Change the laptop name to "NSC-*Service Tag*" (Located on bottom sticker under the laptop) (Don't Restart yet)
* If the laptop is a dell laptop open dells "Support Assist" in software to run drivers updates
    * If dell laptop does not have support assist navigate to dells website to download it
 ---- If device is using a NVIDIA card
* Check for Windows Updates
* Upon completed download of Windows Updates & Dell Drivers join the device to the domain (nscsite.org)
####  Restart
* Run Simplehelp (Should be in downoads folder)
* Once SimpleHelp has loaded
    * Under Machine group select Choose
    * Login
    * Add device to work stations machine group
* Save and then start remote access services
#### Adding Printers
* Navigate to \\nsc1\shared\PrinterDriver
* Run XeroxSmart Application
* Run through quick install with the appropriate printers
----

## Setting up MacBook Pro
* Opened MacBook and ran through setup
* Signed into WiFi (NSC-ACCESS) 
* Did not sign in with Apple ID instead made a computer account
* Opted out of Location services
* Selected Wichita KS for TimeZone
* Opted Out of sharing analytics
* Chose set up later for the screen time feature
* Opted out of Siri
* Selected set up touch ID **LATER**
* Enabled Dark Mode
* Completed initial MacBook Setup
* Navigated to settings -> Printers & Scanners
* Added the family ministiry printer via IP (10.10.10.64)
* Opened Safari and went to remote.newspring.org/access
* Downloaded remote software
* Ran the .dmg file & followed prompts 
* Select "open" when prompted if you want to open the app
* Click "Accept" when prompted with the disclaimer
* Clicked continue when prompted to input details
* When prompted to allow the application to record screen I opened system preferences & granted screen recording permission
    * Open System Preferences -> Security & Privacy -> Click lock in bottom left -> enter password -> Select remote support -> quit & reopen
* System also required control of accessibility features (DId not require relaunch of application)
* Opened Remote Access software
    * Under machine group -> Choose -> Select "Workstations"
    * Name the machine (NSC-"SerialNumber")
    * Under the security tab ensure macOS permissions have checkmarks by them (If not request permission and approve)
    * Start the remote access service
* Ran software update on macOS
    * Agreed to TOS
    * Typed in password
* After Updating to macOS 12.6 a Safari update became available (16.0) So I updated to that
* Created new user accounts 
    * Set them as administrator accounts


