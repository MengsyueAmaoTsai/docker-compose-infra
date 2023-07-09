
CREATE DATABASE test COLLATE Chinese_PRC_CI_AS;

CREATE LOGIN msat7201 WITH PASSWORD = 'Among7201';
ALTER SERVER ROLE sysadmin ADD MEMBER msat7201;
USE master;
ALTER AUTHORIZATION ON DATABASE::test TO msat7201;

USE test;

CREATE TABLE instruments (
    symbol VARCHAR(64) PRIMARY KEY,
    ticker VARCHAR(16),
    description VARCHAR(256),
    type VARCHAR(16) CHECK (type IN ('Equity', 'Future', 'Cryptocurrency')), 
    exchange VARCHAR(16)
);

CREATE TABLE accounts (
    id VARCHAR(128) PRIMARY KEY UNIQUE,
    name VARCHAR(64) UNIQUE,
    primary_currency VARCHAR(8) CHECK (currency IN ('TWD', 'USDT', 'USD', 'EUR')),

    created_at DATETIME2(7) NOT NULL DEFAULT SYSUTCDATEIME() 
);

CREATE TABLE balances (
    account_id VARCHAR(128),
    amount DECIMAL(18, 2),
    currency VARCHAR(8) CHECK (currency IN ('TWD', 'USDT', 'USD', 'EUR')),

    FOREIGN KEY (account_id) REFERENCES accounts (id)
);

CREATE TABLE orders (
    account_id VARCHAR(128),
    id VARCHAR(128) PRIMARY KEY,
    symbol VARCHAR(64),
    trade_type VARCHAR(8) CHECK (trade_type IN ('Buy', 'Sell')),
    quantity DECIMAL(18, 2),
    price DECIMAL(18, 2),
    status VARCHAR(16) CHECK (status IN ('Pending', 'Cancelled', 'Rejected', 'Filled')),
    time_in_force VARCHAR(8) CHECK (time_in_force IN ('IOC')),
    created_at DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),

    FOREIGN KEY (account_id) REFERENCES accounts (id),
    FOREIGN KEY (symbol) REFERENCES instruments (symbol)
);

CREATE TABLE executions (
    account_id VARCHAR(128),
    order_id VARCHAR(128),
    symbol VARCHAR(64),
    trade_type VARCHAR(8) CHECK (trade_type IN ('Buy', 'Sell')),
    executed_quantity DECIMAL(18, 2),
    executed_price DECIMAL(18, 2),
    executed_time DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    
    FOREIGN KEY (account_id) REFERENCES accounts (id),
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (symbol) REFERENCES instruments (symbol)
);

CREATE TABLE positions (
    account_id VARCHAR(128),
    symbol VARCHAR(64),
    side VARCHAR(8) CHECK (trade_type IN ('Long', 'Short')),

    open_time DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    avg_price DECIMAL(18, 2),    
    unrealized_pnl DECIMAL(18, 2),    
    
    FOREIGN KEY (account_id) REFERENCES accounts (id),
    FOREIGN KEY (symbol) REFERENCES instruments (symbol)
);

CREATE TABLE trades (
    account_id VARCHAR(128),
    symbol VARCHAR(64),
    side VARCHAR(8) CHECK (trade_type IN ('Long', 'Short')),

    open_time DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    open_avg_price DECIMAL(18, 2),    
    close_time DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(),
    close_avg_price DECIMAL(18, 2),    

    pnl DECIMAL(18, 2),
    fees DECIMAL(18, 2),
    net_profit DECIMAL(18, 2),
    
    FOREIGN KEY (account_id) REFERENCES accounts (id),
    FOREIGN KEY (symbol) REFERENCES instruments (symbol)
);

CREATE TABLE bots (
    id VARCHAR(64) PRIMARY KEY,
    description VARCHAR(MAX),
    type VARCHAR(16) CHECK (type IN ('Intraday', 'Position')),
    tags VARCHAR(MAX),
    account_id VARCHAR(128),

    FOREIGN KEY (account_id) REFERENCES accounts (id)
);