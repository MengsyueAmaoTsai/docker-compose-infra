
CREATE DATABASE test COLLATE Chinese_PRC_CI_AS;

CREATE LOGIN msat7201 WITH PASSWORD = 'Among7201';
ALTER SERVER ROLE sysadmin ADD MEMBER msat7201;
USE master;
ALTER AUTHORIZATION ON DATABASE::test TO msat7201;

USE test;


-- Accounts
CREATE TABLE accounts (
    id VARCHAR(256) PRIMARY KEY,
    name VARCHAR(32),
    primary_currency VARCHAR(16) CHECK (primary_currency IN ('TWD', 'USDT', 'USD')),
    brokerage VARCHAR(32)  
);

-- Balances
CREATE TABLE balances (
    account_id VARCHAR(256) NOT NULL,
    amount DECIMAL(18, 2),
    currency VARCHAR(16) CHECK (currency IN ('TWD', 'USDT', 'USD')),

    FOREIGN KEY (account_id) REFERENCES accounts (id)
);


