# Cohesity Shutdown
ssh support@10.10.10.170

10.10.10.170
~~~  
First Command Before we stop services
		iris_cli -username=admin -password=Your_pass cluster status 
Service checks To Stop 
		iris_cli -username=admin -password=Your_pass cluster stop 
To start 
		iris_cli -username=admin -password=Your_pass cluster start

Verify these are down before you go to IPMI and shutdown the cluster 

iris_cli -username=admin -password=Your_pass cluster status | grep bridge 
iris_cli -username=admin -password=Your_pass cluster status | grep magneto 
iris_cli -username=admin -password=Your_pass cluster status | grep Apollo 
iris_cli -username=admin -password=Your_pass cluster status | grep nexus

or

iris_cli -username=admin -password=********** cluster status | grep -E '(bridge|magneto|Apollo|nexus)'



~~~

10.10.10.180-184 
	System Power Control -->
			Remote Power Control 
					Operation -->
						Graceful Shutdown 
							    -- >
								Preform




Bring down Phones
Bring down Esxi 
Bring down Alma
Bring down Cohesity
Bring Down Netgate


								