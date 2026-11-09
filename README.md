
# Blinkin' Park — Database Design & PostgreSQL

**Individual University Project | Database Systems Laboratory | University of Turin | 2025/2026**

## Overview

Blinkin' Park is a university project focused on the design and implementation of a relational database for a parking management system in Turin, Italy.

The database models parking facilities, vehicles, customers, parking sessions, tickets, subscriptions, employees, working shifts, customer reviews, and discounts.

The project covers the complete database design process, from requirements analysis and conceptual modeling to logical design and SQL implementation using PostgreSQL.

## Project Objectives

- Analyze and organize system requirements.
- Design an Entity-Relationship (E-R) model.
- Define entities, relationships, cardinalities, and integrity constraints.
- Transform the conceptual model into a relational database schema.
- Optimize database design through redundancy analysis.
- Implement the relational database using PostgreSQL.
- Populate the database with sample data and define integrity tests.

## Database Design

### 1. Requirements Analysis

Identified the main system requirements, defined a terminology glossary, and established business rules and integrity constraints.

### 2. Conceptual Design

Developed an Entity-Relationship (E-R) model representing the parking management system, including its entities, relationships, attributes, and cardinalities.

### 3. Logical Design

Transformed and restructured the conceptual model into a relational schema.

This phase included:
- Data volume and operation frequency estimates.
- Redundancy analysis.
- Entity and relationship restructuring.
- Primary key selection.
- Relational schema definition.

### 4. Performance Analysis

Evaluated whether to store the number of available parking spaces or calculate it dynamically from parking records.

Based on the project's workload assumptions:

| Approach | Estimated Daily Accesses |
|---|---:|
| With stored availability | 7,566 |
| Without stored availability | 917,066 |

The analysis supported maintaining the availability attribute, requiring approximately 2.8 KB of additional storage.

These results are analytical estimates, not measured performance benchmarks.

### 5. SQL Implementation

Implemented the relational database using PostgreSQL.

The implementation includes:
- 17 relational tables.
- Primary and foreign keys.
- Referential integrity constraints.
- CHECK constraints.
- Sample data insertion.
- Integrity test statements.

## Technologies and Skills

- PostgreSQL
- SQL
- Relational Database Design
- Entity-Relationship Modeling
- Conceptual and Logical Data Modeling
- Database Integrity Constraints
- Database Performance Analysis

## Repository Structure

```text
blinking-park-database/
│
├── README.md
│
├── documentation/
│   └── Blinkin_Park_Project_Report.pdf
│
└── sql/
    ├── 01_schema.sql
    ├── 02_sample_data.sql
    └── 03_integrity_tests.sql
```

## How to Run

1. Install PostgreSQL.
2. Create a new empty database.
3. Execute `sql/01_schema.sql` to create the database structure.
4. Execute `sql/02_sample_data.sql` to populate the tables.
5. Run the statements in `sql/03_integrity_tests.sql` individually to examine integrity constraints. Some tests intentionally produce errors.

**Note:** The SQL scripts were extracted from the academic report and have not been independently tested for this portfolio version.

## Documentation

The complete academic report is available in:

`documentation/Blinkin_Park_Project_Report.pdf`

It includes requirements analysis, E-R diagrams, logical database design, performance considerations, relational schema, and SQL implementation.

## Author

**Giulia Zenoni**

Bachelor's Degree in Computer Science  
University of Turin — Academic Year 2025/2026

Individual university project developed for the Database Systems Laboratory.

## Project Status

Completed academic project.

This repository presents the database design and SQL implementation developed for educational purposes. It is not a deployed parking management application.
