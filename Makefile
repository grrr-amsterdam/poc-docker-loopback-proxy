LOCAL_URL        = http://poobar.localhost/index.php
TRAEFIK_URL      = http://docker.localhost:8080
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
	curl ${LOCAL_URL}

curl-from-internal:
	docker-compose exec php curl ${LOCAL_URL}

get-router-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${ROUTER_CONTAINER}

open-site:
	if command -v xdg-open 2>/dev/null; then xdg-open "${LOCAL_URL}"; else open "${LOCAL_URL}"; fi

# Open Traefik dashboard
open-admin:
	xdg-open "http://docker.localhost:8080"
	if command -v xdg-open 2>/dev/null; then xdg-open "${TRAEFIK_URL}"; else open "${TRAEFIK_URL}"; fi

ssh-php:
	docker-compose exec php sh

ssh-router:
	docker-compose exec router sh

ssh-web:
	docker-compose exec web sh
