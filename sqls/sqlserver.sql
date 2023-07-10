
CREATE DATABASE test COLLATE Chinese_PRC_CI_AS;

CREATE LOGIN msat7201 WITH PASSWORD = 'Among7201';
ALTER SERVER ROLE sysadmin ADD MEMBER msat7201;
USE master;
ALTER AUTHORIZATION ON DATABASE::test TO msat7201;

USE test;

-- Instruments 
CREATE TABLE instruments (
    symbol VARCHAR(64) PRIMARY KEY,
    ticker VARCHAR(64),
    description VARCHAR(MAX),
    type VARCHAR(16) CHECK (type IN ('EQUITY', 'FUTURE', 'OPTION', 'CRYPTO_CURRENCY', 'WARRANT', 'CFD', 'ETF')),
    exchange VARCHAR(16)
);

-- Accounts
CREATE TABLE accounts (
    id VARCHAR(256) PRIMARY KEY,
    name VARCHAR(32),
    settlement_currency VARCHAR(16) CHECK (settlement_currency IN ('TWD', 'USDT', 'USD')),
    brokerage VARCHAR(32)  
);

-- Balances
CREATE TABLE balances (
    account_id VARCHAR(256) NOT NULL,
    amount DECIMAL(18, 2),
    currency VARCHAR(16) CHECK (currency IN ('TWD', 'USDT', 'USD')),

    FOREIGN KEY (account_id) REFERENCES accounts (id)
);

-- Orders
CREATE TABLE orders (
    id VARCHAR(256) PRIMARY KEY,
    account_id VARCHAR(256),
    symbol VARCHAR(64), 
    trade_type VARCHAR(16) CHECK (trade_type IN ('BUY', 'SELL')),
    type VARCHAR(16) CHECK (type IN ('MARKET')),
    quantity DECIMAL(18, 2),
    price DECIMAL(18, 2),
    time_in_force VARCHAR(8) CHECK (time_in_force IN ('IOC')),
    status VARCHAR(16) CHECK (status IN ('PENDING', 'REJECTED', 'CANCELLED', 'FILLED'))
    FOREIGN KEY (account_id) REFERENCES accounts (id), 
    FOREIGN KEY (symbol) REFERENCES instruments (symbol) 
);

-- Executions 
CREATE TABLE executions (
    id VARCHAR(256) PRIMARY KEY,
    account_id VARCHAR(256),
    symbol VARCHAR(64), 
    trade_type VARCHAR(16) CHECK (trade_type IN ('BUY', 'SELL')),
    executed_quantity DECIMAL(18, 2),
    executed_price DECIMAL(18, 2),
    executed_time DATETIME2,
    commission DECIMAL(18, 2),
    tax DECIMAL(18, 2),
    FOREIGN KEY (account_id) REFERENCES accounts (id), 
    FOREIGN KEY (symbol) REFERENCES instruments (symbol) 
);

-- Positions
CREATE TABLE positions (
    id VARCHAR(256) PRIMARY KEY,
    account_id VARCHAR(256),
    symbol VARCHAR(64),
    side VARCHAR(8) CHECK (side in ('LONG', 'SHORT')),
    quantity DECIMAL(18, 2),
    average_price DECIMAL(18, 2),
    open_time DATETIME2,
    unrealized_pnl DECIMAL(18, 2),
    commission DECIMAL(18, 2),
    tax DECIMAL(18, 2),
    unrealized_net_pnl DECIMAL(18, 2),
    FOREIGN KEY (account_id) REFERENCES accounts (id), 
    FOREIGN KEY (symbol) REFERENCES instruments (symbol) 
);

-- Trades 
CREATE TABLE trades (
    id VARCHAR(256) PRIMARY KEY,
    account_id VARCHAR(256),
    symbol VARCHAR(64),
    side VARCHAR(8) CHECK (side in ('LONG', 'SHORT')),
    open_quantity DECIMAL(18, 2),
    open_price DECIMAL(18, 2),
    open_time DATETIME2,
    close_quantity DECIMAL(18, 2),
    close_price DECIMAL(18, 2),
    close_time DATETIME2,
    pnl DECIMAL(18, 2),
    commission DECIMAL(18, 2),
    tax DECIMAL (18, 2),
    net_pnl DECIMAL (18, 2),
    FOREIGN KEY (account_id) REFERENCES accounts (id), 
    FOREIGN KEY (symbol) REFERENCES instruments (symbol) 
);