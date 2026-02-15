# MSDS459 – Knowledge Engineering  
## Week 6 – Checkpoint B: Data and Schema for the Knowledge Graph  
### Media and Broadcasting – Consumer Services Sector  

This repository contains the deliverables for Checkpoint B (Week 6) of the MSDS459 term project. The objective of this stage is to summarize work completed through Week 5, formalize the data sources and schema design, and demonstrate partial implementation of a hybrid relational–graph knowledge base to support competitive intelligence and predictive modeling in the media and broadcasting domain.

---

## Repository Contents

All files are located in the root directory of this repository.

### 1. Research Paper (PDF)

- `Shrinidhi-Aarudra_MSDS459_Data_and_Schema.pdf`  

This document contains the formal research report structured as:

- Abstract  
- Introduction  
- Literature Review  
- Methods  
- Results  
- Conclusions (including management recommendations)

The paper addresses:
- Identified structured and unstructured data sources  
- Description of collected data  
- Detailed schema definition  
- Database storage strategy (PostgreSQL + Memgraph)  
- Plans for completing the knowledge base  

---

### 2. Database Schema Files

- `sample_sql_schema.sql`  
  PostgreSQL schema defining relational tables, JSONB storage, and link tables representing graph relationships.

- `sample_cypher_schema.cypher`  
  Memgraph Cypher script defining node types, constraints, indexes, and example relationships for the property graph implementation.

These files demonstrate implementation and programming components required for the assignment.

---

### 3. Schema Diagrams

- `schema_v2.drawio`  
- `schema_v2.drawio.png`  
- `schema__Graph_v2.drawio`  
- `schema__Graph_v2.png`  

These diagrams illustrate the proposed knowledge graph structure, including:

Core entities:
- Organization  
- Document  
- Dataset  
- Service  
- Technology  
- Metric  
- Region  
- TimePeriod  
- BroadcastAsset  

Key relationships:
- PUBLISHES  
- REFERENCES  
- DESCRIBES  
- USES_TECHNOLOGY  
- HAS_METRIC  
- COVERS_REGION  
- COVERS_PERIOD  
- HAS_TOPIC  
- REFERENCES_DOCUMENT  

The schema represents a property graph model suitable for Memgraph while remaining compatible with relational storage in PostgreSQL.

---

## Knowledge Graph Construction Approach

Following Nickel et al. (2015), this project combines:

1. Manual curation (structured broadcast metadata and controlled entity definitions)
2. Information extraction from unstructured text (focused crawler outputs stored as JSON/JSON Lines)

Future phases may incorporate machine learning–based inference and link prediction once graph density increases.

---

## Database Architecture

This project uses a hybrid architecture:

**PostgreSQL**
- Stores structured broadcast metadata
- Stores JSONB document data
- Supports potential geospatial attributes (latitude/longitude)
- Maintains relational integrity

**Memgraph**
- Stores semantic relationships
- Enables multi-hop traversal queries
- Supports competitive intelligence analysis and predictive modeling

---

## Management Objective

The knowledge base addresses the fragmentation of media and broadcasting intelligence across regulatory reports, datasets, and technical publications. By consolidating structured and unstructured information into a unified graph structure, the system enables improved discoverability, trend analysis, and data-driven decision-making for strategic planning.

---

## Repository URL for Cloning
https://github.com/arshrinidhi/Week6_CheckpointB.git
