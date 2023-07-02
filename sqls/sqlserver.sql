CREATE DATABASE test;
ALTER DATABASE test SET TIMEZONE = 'UTC';
CREATE LOGIN msat7201 WITH PASSWORD = 'Among7201', CHECK_POLICY = OFF;
CREATE USER msat7201 FOR LOGIN msat7201;
ALTER LOGIN mast7201 ENABLE;
ALTER SERVER ROLE sysadmin ADD MEMBER msat7201;
USE test;
ALTER ROLE db_owner ADD MEMBER mast7201;


-- CREATE TABLE instruments ();
-- CREATE TABLE ticks ();
-- CREATE TABLE bars ();
-- CREATE TABLE market_depth ();

-- CREATE TABLE news ();

-- CREATE TABLE accounts;
-- CREATE TABLE executions;
-- CREATE TABLE orders;
-- CREATE TABLE positions;
-- CREATE TABLE trades;

-- CREATE TABLE bots;

CREATE TABLE bots (
    id VARCHAR(64) PRIMARY KEY,
    side VARCHAR(8),
    type VARCHAR(16),
    platform VARCHAR(32),
    tags VARCHAR(256)
);
