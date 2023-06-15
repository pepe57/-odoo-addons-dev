@echo off
if "%1"=="down" (
    set UPDOWN=down
) else (
    set UPDOWN=up
)

docker-compose -p autostart-odoo-addons-dev -f .devcontainer/docker-compose.yml -f .devcontainer/odoo/docker-compose-autostart.yml %UPDOWN%

if "%1"=="down" (
    docker volume rm autostart-odoo-addons-dev_odoo-data
    docker volume rm autostart-odoo-addons-dev_postgres-data
)

pause