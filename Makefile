LOCAL_URL = http://poobar.localhost
ROUTER_CONTAINER = router-poc

up:
	docker-compose up

stop:
	docker-compose stop

restart:
	docker-compose restart

down:
	docker-compose down

pull:
	docker-compose pull

curl:
	curl ${LOCAL_URL}/index.php

curl-from-internal:
	docker-compose exec php curl ${LOCAL_URL}/index.php

get-router-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${ROUTER_CONTAINER}

open-site:
	xdg-open "${LOCAL_URL}"

# Open Traefik dashboard
open-admin:
	xdg-open "http://docker.localhost:8080"

ssh-php:
	docker-compose exec php sh

ssh-router:
	docker-compose exec router sh

ssh-web:
	docker-compose exec web sh
