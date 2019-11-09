# Docker Loopback Proxy
Proof-of-Concept Docker Compose setup which enables a container in the cluster, f.i. running php, to address another container acting as a proxy / ingress controller. This is natively possible, but not using the same hostname from both within the network and from the outside.


## Why?
Because this enables you to f.i. use an Nginx container in combination with a php container, running a dynamic site and a static site generator. The static site generator can use the same hostname as you would from outside of the Docker network, allowing you to use not-so-smart Static Site Generators, lacking configuration options.


## Using it
1. Clone yourself. Now clone the repo.
```bash
git clone git@github.com:grrr-amsterdam/poc-docker-loopback-proxy
```

2. Skippy-dee-skip to the directory.
```bash
cd poc-docker-loopback-proxy
```

3. Fire up the Docker cluster. In style.
```bash
make up
```

4. In another terminal window, `curl` from your host to `index.php` on the `php` container, being routed through the nginx proxy. It should give you the html output of `phpinfo()`.
```bash
make curl
```

5. Now compare the previous output with a `curl` call to the same file, but now with the request originating from the `php` container from within the cluster.
```bash
make curl-from-internal
```

You can also use the other methods in the `Makefile`, like `make open-admin` to open the Traefik dashboard in your browser.


## The fiddlings - how do they work?
Suppose you make a call to `poobar.localhost` from your host. Because it's a `.localhost` domain, it loops back to `127.0.0.1` on port `80`.


This Docker cluster is set up to listen to those requests. It routes all edge requests through Traefik. When you then call `poobar.localhost`, Traefik is configured to direct these requests to the `web` container, running nginx.


Because it's a request for a `php` file, nginx knows it should call upon the `php` container, running `php-fpm` on the standard `9000` fastcgi port.


A shell script is triggered by `docker-compose.yml`, that adds a mock `.localhost` entry to the `hosts` file to the `php` container. Normally, a request to a `.localhost` domain from the `php` container would loop back to itself. After running the script, requests from the `php` container to `poobar.localhost` will route requests to the `router` container running Traefik.


This makes sure that a request ends up in the same place as it would if it came from you.



## Alternative solutions
This could theoretically also be done with a dual Docker setup, defining proxy network routing requests, and a shielded internal network. However, this has other cons, one being the requirement of a newer Docker Compose version.

