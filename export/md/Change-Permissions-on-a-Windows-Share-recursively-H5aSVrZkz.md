# Change Permissions on a Windows Share recursively


## On the linux side
* ssh into nsc1 as root
* navigate to folder that you want to change permission on 
* verify current permissions of folder  

This command does Recursive ownership change for **user:group**

 **Replace admin_pe as whatever admin you are**

```
chown -R 'NSCSITE\admin_pe:NSCSITE\domain admins' [Folder Name]
```

* Note: Don't forget to use the single quotes because of the space in "domain admins"
 
## On the windows side

* Log into windows as admin_pe 

* Goto properties -> Advance Security Settins on the folder you wish to change.

![](https://hd.newspring.org/uploads/94900b48-ab9c-4bf9-887f-08e89ac17a92.png)

* Click Disable Inheritance

![](https://hd.newspring.org/uploads/d6069d21-1be7-4b27-8b66-0dbb5619013f.png)

* Select "Remove all inherited permissions from this object."

![](https://hd.newspring.org/uploads/30aae674-1eaa-40e4-b138-6296a9b45ce2.png)
* Select Replace all child objects ...

Then Click Apply
![](https://hd.newspring.org/uploads/e52446b5-50a3-4543-be54-157665c27f53.png)

Make changes to the permissions as nessary
(Everyone Read Only for example)

* Log out of ssh




After that have a great day!!!



