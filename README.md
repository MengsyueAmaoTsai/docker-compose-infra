# RichillCapital Infrastructure

## Message Queue

Docker run RabbitMQ:

```bash
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 -e RABBITMQ_CONFIG_FILE=/etc/rabbitmq/rabbitmq.conf -e RABBITMQ_DEFAULT_USER=msat7201 -e RABBITMQ_DEFAULT_PASS=among7201 -v /path/to/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf rabbitmq:3-management
```

## Database

Docker run SQL Server:

```powershell
# Empty server
docker run -d --name sqlserver -p 1433:1433 -e 'MSSQL_TCP_PORT=1433' -e 'MSSQL_TCP_ADDR=0.0.0.0' -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Among7201' mcr.microsoft.com/mssql/server:2022-latest

# Connection string
Server=127.0.0.1,1433;Database=richillcapital;User Id=msat7201;Password=Among7201;
```

Docker run PostgreSQL:

```bash
docker run -d -p 5432:5432 --name postgresql -e POSTGRES_PASSWORD=among7201 postgres -c 'listen_addresses=*'
```

Docker run MySQL:

```bash
docker run -d -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=among7201 mysql/mysql-server:latest --bind-address=0.0.0.0
```

### SQL

### NoSQL

## Cache
### Redis
```bash
docker run -d --name redis -p 6379:6379 redis:latest redis-server --requirepass among7201

```

### Docker Compose
```bash
docker-compose up -d
```