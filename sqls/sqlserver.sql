
CREATE DATABASE test COLLATE Chinese_PRC_CI_AS;

CREATE LOGIN msat7201 WITH PASSWORD = 'Among7201';
ALTER SERVER ROLE sysadmin ADD MEMBER msat7201;
USE master;
ALTER AUTHORIZATION ON DATABASE::test TO msat7201;

USE test;

CREATE TABLE bots (
    id VARCHAR(64) PRIMARY KEY,
    side VARCHAR(8) NOT NULL,
    type VARCHAR(32) NOT NULL,
    platform VARCHAR(64) NOT NULL,
    tags VARCHAR(max),
    CONSTRAINT CK_Side CHECK (side IN ('Long', 'Short')),
    CONSTRAINT CK_BotType CHECK (type IN ('Intraday', 'Position')),
    CONSTRAINT CK_TradingPlatform CHECK (platform IN (
        'XQ', 'MultiCharts', 'TradeStation', 
        'MultiCharts.NET', 'Quantower', 'QuantConnect', 
        'CTrader', 'NinjaTrader', 'WealthLab', 
        'TradingView', 'VeighNa'))
);

