-- MSDS459 - Checkpoint B (Week 6)
-- PostgreSQL schema for structured + JSON document storage

CREATE SCHEMA IF NOT EXISTS kg;

-- ------------------------------
-- Core structured entities
-- ------------------------------

CREATE TABLE IF NOT EXISTS kg.organization (
  organization_id SERIAL PRIMARY KEY,
  name            TEXT NOT NULL UNIQUE,
  org_type        TEXT,
  website         TEXT,
  country         TEXT,
  created_at      TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS kg.document (
  document_id     SERIAL PRIMARY KEY,
  doc_id          TEXT NOT NULL UNIQUE,
  title           TEXT,
  source_url      TEXT,
  published_date  DATE,
  doc_type        TEXT,
  text_hash       TEXT,
  raw_json        JSONB,               -- stores parsed doc metadata if available
  created_at      TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_document_published_date ON kg.document(published_date);
CREATE INDEX IF NOT EXISTS idx_document_source_url ON kg.document(source_url);
CREATE INDEX IF NOT EXISTS idx_document_raw_json_gin ON kg.document USING GIN (raw_json);

CREATE TABLE IF NOT EXISTS kg.dataset (
  dataset_id      SERIAL PRIMARY KEY,
  dataset_key     TEXT NOT NULL UNIQUE,  -- external id (e.g., "DS-001")
  title           TEXT,
  source_url      TEXT,
  granularity     TEXT,
  coverage_start  DATE,
  coverage_end    DATE,
  created_at      TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS kg.metric (
  metric_id     SERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE,
  unit          TEXT,
  description   TEXT
);

CREATE TABLE IF NOT EXISTS kg.service (
  service_id    SERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE,
  category      TEXT
);

CREATE TABLE IF NOT EXISTS kg.technology (
  technology_id   SERIAL PRIMARY KEY,
  name            TEXT NOT NULL UNIQUE,
  category        TEXT,
  standard_family TEXT
);

CREATE TABLE IF NOT EXISTS kg.region (
  region_id   SERIAL PRIMARY KEY,
  name        TEXT NOT NULL UNIQUE,
  iso_code    TEXT,
  latitude    DOUBLE PRECISION,
  longitude   DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS kg.time_period (
  time_period_id SERIAL PRIMARY KEY,
  label          TEXT NOT NULL UNIQUE,    -- e.g., "2025-Q4"
  start_date     DATE,
  end_date       DATE
);

CREATE TABLE IF NOT EXISTS kg.broadcast_asset (
  asset_id          BIGINT PRIMARY KEY,   -- you can use a real asset id if you have one
  title             TEXT,
  format            TEXT,
  resolution        TEXT,
  duration_seconds  INTEGER,
  air_date          DATE,
  metadata          JSONB,
  created_at        TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_asset_metadata_gin ON kg.broadcast_asset USING GIN (metadata);

-- ------------------------------
-- Bridge tables (relational representation of graph edges)
-- These make it easy to export edges to Memgraph or validate links.
-- ------------------------------

CREATE TABLE IF NOT EXISTS kg.organization_publishes_document (
  organization_id INT REFERENCES kg.organization(organization_id) ON DELETE CASCADE,
  document_id     INT REFERENCES kg.document(document_id) ON DELETE CASCADE,
  PRIMARY KEY (organization_id, document_id)
);

CREATE TABLE IF NOT EXISTS kg.document_references_dataset (
  document_id   INT REFERENCES kg.document(document_id) ON DELETE CASCADE,
  dataset_id    INT REFERENCES kg.dataset(dataset_id) ON DELETE CASCADE,
  PRIMARY KEY (document_id, dataset_id)
);

CREATE TABLE IF NOT EXISTS kg.dataset_has_metric (
  dataset_id  INT REFERENCES kg.dataset(dataset_id) ON DELETE CASCADE,
  metric_id   INT REFERENCES kg.metric(metric_id) ON DELETE CASCADE,
  PRIMARY KEY (dataset_id, metric_id)
);

CREATE TABLE IF NOT EXISTS kg.service_uses_technology (
  service_id     INT REFERENCES kg.service(service_id) ON DELETE CASCADE,
  technology_id  INT REFERENCES kg.technology(technology_id) ON DELETE CASCADE,
  PRIMARY KEY (service_id, technology_id)
);

CREATE TABLE IF NOT EXISTS kg.dataset_covers_region (
  dataset_id  INT REFERENCES kg.dataset(dataset_id) ON DELETE CASCADE,
  region_id   INT REFERENCES kg.region(region_id) ON DELETE CASCADE,
  PRIMARY KEY (dataset_id, region_id)
);

CREATE TABLE IF NOT EXISTS kg.dataset_covers_period (
  dataset_id      INT REFERENCES kg.dataset(dataset_id) ON DELETE CASCADE,
  time_period_id  INT REFERENCES kg.time_period(time_period_id) ON DELETE CASCADE,
  PRIMARY KEY (dataset_id, time_period_id)
);

CREATE TABLE IF NOT EXISTS kg.broadcast_asset_has_topic (
  asset_id    BIGINT REFERENCES kg.broadcast_asset(asset_id) ON DELETE CASCADE,
  service_id  INT REFERENCES kg.service(service_id) ON DELETE CASCADE,
  PRIMARY KEY (asset_id, service_id)
);

CREATE TABLE IF NOT EXISTS kg.broadcast_asset_references_document (
  asset_id     BIGINT REFERENCES kg.broadcast_asset(asset_id) ON DELETE CASCADE,
  document_id  INT REFERENCES kg.document(document_id) ON DELETE CASCADE,
  PRIMARY KEY (asset_id, document_id)
);
