# MSDS459 – Knowledge Engineering (Term Project)
## Media and Broadcasting – Consumer Services Sector  
### Checkpoint B (Week 6): Data and Schema for the Knowledge Graph

This repository contains the deliverables for the MSDS459 term project focused on constructing a knowledge base (knowledge graph) to support competitive intelligence and predictive modeling in the Media and Broadcasting sector. Checkpoint B documents the work completed through Week 5, including identified data sources, data collected to date, a proposed knowledge base schema, and plans for completing the knowledge base for the next assignment.

---

## Repository Structure

### `CheckpointA/`
Checkpoint A submission materials (topic choice and initial schema definition).

### `CheckpointB_Week6/`
Checkpoint B submission materials (Week 6).

Recommended contents:
- `Week6_Paper.pdf`  
  The formal research report (≤ 6 pages of text, double-spaced). Figures may appear in an appendix.
- `Week6_Work_Summary.md`  
  Narrative summary addressing: data sources, collected data, proposed schema, and plans.
- `Data_Sources_Description.md`  
  Narrative description of structured and unstructured sources and acquisition methods.
- `Schema_Design_Description.md`  
  Narrative schema description: nodes, relationships, attributes, and mapping of data into the graph.
- `Database_Implementation.md`  
  Narrative description of how PostgreSQL and Memgraph are used (tables/JSON/graph).
- `Knowledge_Graph_Construction_Approach.md`  
  Explanation of the knowledge base construction approach (Nickel et al., 2015).
- `schema_v2.drawio`  
  Draw.io editable schema diagram.
- `schema_v2.png` and/or `schema_v2.pdf`  
  Exported schema diagram for easy viewing.
- `sample_json_document.json`  
  Example crawled/ingested document record (representative JSON).
- `sample_sql_schema.sql`  
  PostgreSQL DDL for core tables and JSON document storage.
- `sample_cypher_schema.cypher`  
  Memgraph Cypher script to create constraints/indexes and example node/relationship patterns.

---

## Term Project Goal and Management Problem

The media and broadcasting domain evolves rapidly due to streaming adoption, regulatory shifts, and technology transitions. Decision makers must synthesize fragmented information across regulatory datasets, industry publications, and operational metadata. The management problem addressed is the lack of an integrated, queryable semantic structure for competitive intelligence.

This knowledge base is designed to consolidate structured and unstructured sources into a single graph-oriented semantic layer to support:
- competitive intelligence monitoring,
- cross-source relationship discovery,
- trend tracking across regions and time,
- and predictive modeling tasks (e.g., classification or forecasting).

---

## Databases Used

This project uses a hybrid architecture:

**PostgreSQL**
- Structured storage for curated metadata and numeric metrics.
- JSONB storage for crawled documents / API responses.
- Optional geospatial support (latitude/longitude) if location attributes become central.

**Memgraph**
- Property graph representation of entities and relationships.
- Multi-hop traversal queries for competitive intelligence.
- Graph structure suitable for downstream embedding/link prediction methods.

---

## Knowledge Base Construction Approach (Nickel et al., 2015)

The knowledge graph construction follows two primary approaches:
1. **Manual curation** (curated broadcast metadata and controlled entity labels).
2. **Information extraction from text** (entity identification and triple generation from crawled documents).

Later phases may incorporate **machine learning–based inference** for link prediction or completion once graph density increases.

---

## Submission Notes

- The Checkpoint B paper is provided as a PDF file in `CheckpointB_Week6/`.
- The GitHub repository is intended to be public and clonable by the instructor.
- The repository URL submitted in the assignment posting should include the `.git` extension.

---

## References

Nickel, M., Murphy, K., Tresp, V., & Gabrilovich, E. (2015). A Review of Relational Machine Learning for Knowledge Graphs. *Proceedings of the IEEE*, 104(1), 11–33. (arXiv:1503.00759)
