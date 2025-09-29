-- FLEETPULSE ANALYTICS - DATABASE SETUP
-- Created by: Manikanta 
-- Business Problem: $1.2M maintenance costs (actually $14.8M!)

-- Create database
CREATE DATABASE fleetpulse;

-- Connect to fleetpulse database and create tables:

-- Master trucks table
CREATE TABLE trucks (
    truck_id VARCHAR(10) PRIMARY KEY,
    model VARCHAR(100),
    manufacturer VARCHAR(100),
    purchase_date DATE,
    truck_age_years INTEGER,
    capacity_tons INTEGER,
    status VARCHAR(20)
);

-- Maintenance records (planned and emergency)
CREATE TABLE maintenance (
    maintenance_id VARCHAR(20) PRIMARY KEY,
    truck_id VARCHAR(10),
    maintenance_date DATE,
    maintenance_type VARCHAR(100),
    cost_usd DECIMAL(10,2),
    downtime_days INTEGER,
    parts_replaced TEXT
);

-- Breakdown records (emergency failures)
CREATE TABLE breakdowns (
    breakdown_id VARCHAR(20) PRIMARY KEY,
    truck_id VARCHAR(10),
    breakdown_date DATE,
    issue_category VARCHAR(100),
    downtime_days INTEGER,
    repair_cost_usd DECIMAL(10,2)
);

-- Delivery and penalty records
CREATE TABLE deliveries (
    delivery_id VARCHAR(20) PRIMARY KEY,
    truck_id VARCHAR(10),
    delivery_date DATE,
    distance_km DECIMAL(8,2),
    was_delayed BOOLEAN,
    delay_hours INTEGER,
    penalty_fees_usd DECIMAL(10,2)
);

-- Fuel efficiency tracking
CREATE TABLE fuel (
    fuel_id VARCHAR(20) PRIMARY KEY,
    truck_id VARCHAR(10),
    date DATE,
    litres_consumed DECIMAL(8,2),
    distance_covered_km DECIMAL(8,2),
    fuel_efficiency_kmpl DECIMAL(6,2)
);