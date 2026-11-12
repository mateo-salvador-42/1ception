all:
	docker compose -f srcs/docker-compose.yml up
down:
	docker compose -f srcs/docker-compose.yml down --rmi all
clean:
	docker compose -f srcs/docker-compose.yml down --rmi all -v
re:
	$(MAKE) clean && $(MAKE) all

