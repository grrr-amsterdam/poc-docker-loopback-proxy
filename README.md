# Docker Loopback Proxy
________________________________________________________________________________
Proof-of-Concept Docker Compose setup which enables a container in the cluster, f.i. running php, to address another container acting as a proxy / ingress controller. This is natively possible, but not using the same hostname from both within the network and from the outside.


## Why?
________________________________________________________________________________
Because this enables you to f.i. use an Nginx container in combination with a php container, running a dynamic site and a static site generator. The static site generator can use the same hostname as you would from outside of the Docker network, allowing you to use not-so-smart Static Site Generators, lacking configuration options.


## Alternative solutions
________________________________________________________________________________
This could theoretically also be done with a dual Docker setup, defining proxy network routing requests, and a shielded internal network. However, this has other cons, one being the requirement of a newer Docker Compose version.


## The fiddlings - how do they work?
________________________________________________________________________________
It adds a mock `.localhost` entry to a specified container (f.i. `myproject.localhost`). 