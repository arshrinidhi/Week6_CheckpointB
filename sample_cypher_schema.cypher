// MSDS459 - Checkpoint B (Week 6)
// Memgraph property graph "schema" setup: constraints, indexes, and exemplar patterns.

// ------------------------------
// Constraints / Indexes
// ------------------------------

// Uniqueness constraints (best effort; supported in Memgraph versions with constraints).

CREATE CONSTRAINT ON (o:Organization) ASSERT o.name IS UNIQUE;
CREATE CONSTRAINT ON (d:Document) ASSERT d.doc_id IS UNIQUE;
CREATE CONSTRAINT ON (ds:Dataset) ASSERT ds.dataset_id IS UNIQUE;
CREATE CONSTRAINT ON (t:Technology) ASSERT t.name IS UNIQUE;
CREATE CONSTRAINT ON (s:Service) ASSERT s.name IS UNIQUE;
CREATE CONSTRAINT ON (m:Metric) ASSERT m.name IS UNIQUE;
CREATE CONSTRAINT ON (r:Region) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT ON (tp:TimePeriod) ASSERT tp.label IS UNIQUE;
CREATE CONSTRAINT ON (a:BroadcastAsset) ASSERT a.asset_id IS UNIQUE;

// Indexes to speed up lookups
CREATE INDEX ON :Document(title);
CREATE INDEX ON :Document(published_date);
CREATE INDEX ON :Document(source_url);
CREATE INDEX ON :Organization(type);
CREATE INDEX ON :Technology(category);
CREATE INDEX ON :Dataset(topic);

// ------------------------------
// Node labels (conceptual)
// ------------------------------
// Organization {name, type, country, website}
// Document     {doc_id, title, source_url, published_date, doc_type, text_hash}
// Dataset      {dataset_id, title, source_url, granularity, coverage_start, coverage_end}
// Metric       {name, unit, description}
// Service      {name, category}
// Technology   {name, category, standard_family}
// Region       {name, iso_code, lat, lon}
// TimePeriod   {label, start_date, end_date}
// BroadcastAsset {asset_id, title, format, resolution, duration_seconds, air_date}

// ------------------------------
// Relationship types (conceptual)
// ------------------------------
// (Organization)-[:PUBLISHES]->(Document)
// (Document)-[:DESCRIBES]->(Service)
// (Document)-[:REFERENCES]->(Dataset)
// (Dataset)-[:HAS_METRIC]->(Metric)
// (Service)-[:USES_TECHNOLOGY]->(Technology)
// (Dataset)-[:COVERS_REGION]->(Region)
// (Dataset)-[:COVERS_PERIOD]->(TimePeriod)
// (Document)-[:MENTIONS_TECHNOLOGY]->(Technology)
// (BroadcastAsset)-[:HAS_TOPIC]->(Service)
// (BroadcastAsset)-[:REFERENCES_DOCUMENT]->(Document)

// ------------------------------
// Example: Create a minimal graph slice (illustrative only)
// ------------------------------

// Organization
MERGE (o:Organization {name: "Example Regulator"})
  ON CREATE SET o.type = "Regulator", o.website = "https://example.org";

// Document
MERGE (d:Document {doc_id: "DOC-001"})
  ON CREATE SET d.title = "Audience Trends Report",
                d.source_url = "https://example.org/reports/audience-trends",
                d.published_date = date("2026-01-15"),
                d.doc_type = "Report";

// Dataset
MERGE (ds:Dataset {dataset_id: "DS-001"})
  ON CREATE SET ds.title = "Quarterly Audience Metrics",
                ds.source_url = "https://example.org/datasets/audience",
                ds.granularity = "Quarter";

// Metric
MERGE (m:Metric {name: "Streaming Share"})
  ON CREATE SET m.unit = "percent",
                m.description = "Share of viewing attributed to streaming platforms";

// Technology
MERGE (t:Technology {name: "IP Video"})
  ON CREATE SET t.category = "Broadcast Technology",
                t.standard_family = "SMPTE";

// Service
MERGE (s:Service {name: "Streaming Services"})
  ON CREATE SET s.category = "Distribution Model";

// Region
MERGE (r:Region {name: "Qatar"})
  ON CREATE SET r.iso_code = "QA";

// Time period
MERGE (tp:TimePeriod {label: "2025-Q4"})
  ON CREATE SET tp.start_date = date("2025-10-01"),
                tp.end_date   = date("2025-12-31");

// Relationships
MERGE (o)-[:PUBLISHES]->(d);
MERGE (d)-[:REFERENCES]->(ds);
MERGE (ds)-[:HAS_METRIC]->(m);
MERGE (ds)-[:COVERS_REGION]->(r);
MERGE (ds)-[:COVERS_PERIOD]->(tp);
MERGE (d)-[:DESCRIBES]->(s);
MERGE (s)-[:USES_TECHNOLOGY]->(t);
MERGE (d)-[:MENTIONS_TECHNOLOGY]->(t);