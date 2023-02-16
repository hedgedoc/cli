# File Sharing on 45 Drives 
















Current setting for NSC-JBOD 

Advanced Settings ->

dos charset = cp866
unix charset = UTF8
mangled names = no
vfs objects = catia fruit streams_xattr
fruit:encoding = native
fruit:metadata = stream
fruit:zero_file_id = yes
fruit:nfs_aces = no




Current Settings for NSC1

Advancend Settings ->

vfs objects = catia fruit streams_xattr
fruit:encoding = native
fruit:metadata = stream
fruit:zero_file_id = yes
fruit:nfs_aces = no



+100

From the Samba documentation on the config option mangled names which you mention:
```
    This share-level option specifies whether Samba will mangle filenames for 8.3 clients. If the option is set to no, Samba will not mangle the names, and (depending on the client) they will either be invisible or appear truncated to those using 8.3 operating systems. The default value is yes. You can override it per share as follows:
```
---
![](https://hd.newspring.org/uploads/a4cbbe42-91be-4ec7-a43e-aa1d27e09396.png)
```
smbd
  fruit_readdir_attr: ad_convert() failed
PRIORITY	3
SYSLOG_FACILITY	3
SYSLOG_IDENTIFIER	smbd
SYSLOG_PID	13362
SYSLOG_RAW	<27>Nov 21 05:57:26 smbd[13362]:   fruit_readdir_attr: ad_convert() failed
SYSLOG_TIMESTAMP	Nov 21 05:57:26 
_BOOT_ID	c0077469cf3b4aaa9b653578c6c67e51
_CAP_EFFECTIVE	0
_CMDLINE	/usr/sbin/smbd --foreground --no-process-group
_COMM	smbd
_EXE	/usr/sbin/smbd
_GID	0
_HOSTNAME	nsc-jbod.nscsite.org
_MACHINE_ID	c6a6fa6bf4a645dbbf084d4a68be5698
_PID	13362
_SELINUX_CONTEXT	unconfined
_SOURCE_REALTIME_TIMESTAMP	1669010246658712
_SYSTEMD_CGROUP	/system.slice/smbd.service
_SYSTEMD_INVOCATION_ID	436c978e970f4488951f178e6b42c9ac
_SYSTEMD_SLICE	system.slice
_SYSTEMD_UNIT	smbd.service
_TRANSPORT	syslog
_UID	2004629
__CURSOR	s=a44bc129d8b64c599bdca4edb3d4b575;i=6e479;b=c0077469cf3b4aaa9b653578c6c67e51;m=925ae8f8a;t=5edf4bae0eb2f;x=e7321e0979a2c56f
__MONOTONIC_TIMESTAMP	39286902666
__REALTIME_TIMESTAMP	1669010246658863

```

---


```
smbd
  fruit_pwrite_meta_stream: On-demand create [Archive_32/2021/2021_LivingNativity_Scene05/.DS_Store:AFP_AfpInfo:$DATA] in write failed: No such file or directory
PRIORITY	3
SYSLOG_FACILITY	3
SYSLOG_IDENTIFIER	smbd
SYSLOG_PID	13362
SYSLOG_RAW	<27>Nov 21 05:57:26 smbd[13362]:   fruit_pwrite_meta_stream: On-demand create [Archive_32/2021/2021_LivingNativity_Scene05/.DS_Store:AFP_AfpInfo:$DATA] in write failed: No such file or directory
SYSLOG_TIMESTAMP	Nov 21 05:57:26 
_BOOT_ID	c0077469cf3b4aaa9b653578c6c67e51
_CAP_EFFECTIVE	0
_CMDLINE	/usr/sbin/smbd --foreground --no-process-group
_COMM	smbd
_EXE	/usr/sbin/smbd
_GID	0
_HOSTNAME	nsc-jbod.nscsite.org
_MACHINE_ID	c6a6fa6bf4a645dbbf084d4a68be5698
_PID	13362
_SELINUX_CONTEXT	unconfined
_SOURCE_REALTIME_TIMESTAMP	1669010246677464
_SYSTEMD_CGROUP	/system.slice/smbd.service
_SYSTEMD_INVOCATION_ID	436c978e970f4488951f178e6b42c9ac
_SYSTEMD_SLICE	system.slice
_SYSTEMD_UNIT	smbd.service
_TRANSPORT	syslog
_UID	2004629
__CURSOR	s=a44bc129d8b64c599bdca4edb3d4b575;i=6e47b;b=c0077469cf3b4aaa9b653578c6c67e51;m=925aed8ac;t=5edf4bae13450;x=35623410b41f38fb
__MONOTONIC_TIMESTAMP	39286921388
__REALTIME_TIMESTAMP	1669010246677584
```
