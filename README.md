# RichillCapital Infrastructure

Docker compose for infrastructure.

### Message Queue (RabbitMQ)

Docker run RabbitMQ:

```bash
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 -e RABBITMQ_CONFIG_FILE=/etc/rabbitmq/rabbitmq.conf -e RABBITMQ_DEFAULT_USER=msat7201 -e RABBITMQ_DEFAULT_PASS=among7201 -v /path/to/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf rabbitmq:3-management
```

### SQL Database

Docker run SQL Server:

```powershell
# Empty server
docker run -d --name mssql -p 1433:1433 -e 'MSSQL_TCP_PORT=1433' -e 'MSSQL_TCP_ADDR=0.0.0.0' -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_USER=SA' -e 'SA_PASSWORD=Pa55w0rd!' mcr.microsoft.com/mssql/server:2022-latest 

# Connection string
"Server=dev-127.0.0.1,1433;Database=test;User Id=SA;Password=Among7201;TrustServerCertificate=true;"
```

### NoSQL Database

Docker run MongoDB

```powershell
```

### Cache (Redis)

Docker run Redis

```bash
docker run -d --name redis -p 6379:6379 redis:latest redis-server --requirepass among7201
```

## All together

```bash
docker-compose up -d
```
