#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo -----------------------------
	@echo start / stop / restart / stop-all
	@echo update
	@echo logs
	@echo workspace
	@echo stats
	@echo clean
	@echo -----------------------------

_header:
	@echo ----
	@echo Plex
	@echo ----

_urls: _header
	${info }
	@echo -----------------------------
	@echo [Plex] http://localhost:32400
	@echo -----------------------------

_start-command:
	@docker compose up -d --remove-orphans

start: _header _start-command _urls

stop:
	@docker compose stop

restart: stop start

stop-all:
	@docker stop $(shell docker ps -aq)

_pull:
	@docker compose pull

update: _pull _start-command

logs:
	@docker compose logs plex

workspace:
	@docker compose exec plex /bin/bash

stats:
	@docker stats

clean:
	@docker compose down -v --remove-orphans
