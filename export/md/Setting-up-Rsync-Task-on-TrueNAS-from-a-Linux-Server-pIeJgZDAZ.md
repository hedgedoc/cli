# Setting up Rsync Task on TrueNAS from a Linux Server

1. Create SSH Keypairs (Public and Private)
    * Under system -> SSH Keypairs -> Add 
    * Generate Keypair
2. Add newly generated public key to your remote linux server 
3. Create id_rsa paste in private key
    * Save File 
    * chmod 600 id_rsa
4. SSH into the remote linux server from the TrueNAS Shell 
    * Accept the fingerprint (YES)
5. Build the Rsync task using this example 
    * Please modify as needed (Directorys etc..) 


![](https://nsc-hd.nscsite.org/uploads/34543202-3041-496c-aa7c-e639de6a0a05.png)

6. Verify the task works by clicking on the drop down and  "Run Now"

![](https://nsc-hd.nscsite.org/uploads/c879bc3c-5735-44ce-8b11-f63b170305ab.png)
