# Server Notes

### Main File Server

[NSC1](https://10.10.9.250:9090) -- NSC1  - 160 TB
[NSC1-IPMI](https://10.10.10.8) -- NSC1 - IPMI
---

### Archive Server
[NSC-JBOD](https://10.10.10.22:9090)  -- NSC-JBOD --275 TB
[NSC-JBOD-IPMI](https://10.10.10.23)  -- NSC-JBOD-IPMI

RDP Windows server for Backup 
nsc-backup.nscsite.org

---

### Backup Server  -- TrueNAS
[10.10.10.14](https://10.10.10.14)  -- Production      -- 58 TB - No Parity Disk 
[10.10.10.95](https://10.10.10.95)  -- Creative      -- 58 TB  - No Parity Disk
[10.10.10.210](https://10.10.10.210) -- East Building -- 59 TB - Z2
[10.100.0.100](https://10.100.0.100) -- Altispeed Data Center -- 116 TB - Z2
[10.10.10.190](https://10.10.10.190) -- Cohesity  -- 130 TB -- Cluster Based

 
### Virtual Host
[10.10.10.215](https://10.10.10.215:9090) -- Alma Host
[10.10.10.11](https://10.10.10.11)  -- ESXI


### Other Misc Servers
[NSC-Unifi.nscsite.org](https://NSC-Unifi.nscsite.org:9090)

[KW Check-in Lighting](http://10.10.9.252:9999)

Security Server
10.10.9.238  -- CONNECT THRU RDP






######	tags: `Server`