#Point to point communication using Vert-x Event Bus
##Usage
To start the sender run `./gradlew runS`  
To start the receiver run `./gradlew runR`
##Issues
Able to send and receive messages when both sender and receiver are running on the same machine. But when these are run on different machines (connected on the same local network with multicast enabled) exchange of message is not possible.
Peers can see each other through Hazelcast, which is visible because Hazelcast logs members in the cluster to console output.  
Also all firewalls have been disabled on both machines.    
