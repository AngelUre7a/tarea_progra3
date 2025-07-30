docker ps -a --format "table {{.Names}}" | findstr "mariadb-healthy" >nul
if %ERRORLEVEL% EQU 0 (
    echo ℹ Contenedor MariaDB ya existe, iniciándolo...
    docker start mariadb-healthy

) else (
    echo 🆕 Creando nuevo contenedor MariaDB...
    docker run -d ^
      --name mariadb-healthy ^
      --network healthynet ^
      -e MYSQL_ROOT_PASSWORD=admin ^
      -e MYSQL_DATABASE=admin ^
      -e MYSQL_USER=admin ^
      -e MYSQL_PASSWORD=admin ^
      -p 3306:3306 ^
      --restart unless-stopped ^
      mariadb:11.0
)