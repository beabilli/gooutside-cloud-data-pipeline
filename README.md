# 🎒 GoOutside: Cloud Data Architecture & Advanced Business Intelligence

## 🏢 Business Scenario
GoOutside is a rapidly growing global provider of camping and adventure equipment, analyzing historical data spanning from 2015 to 2018. Following the sudden departure of their previous analyst, the company was left with critical records locked in 4 raw, unorganized CSV files, rendering them completely unusable for management.

This project reconstructs the entire analytical infrastructure directly on the Cloud to eliminate manual workflows and address the strategic requirements of key stakeholders:
1. **Sarah (Finance Manager)**: Identify inefficient sales channels (such as Fax) to optimize operational costs and personnel allocation.
2. **Dustin (Head of Retail Partnership)**: Map global market concentration and generate predictive growth simulations tailored to individual country structures.

---

## 🛠️ Data Pipeline & Technology Stack
The project replicates a modern enterprise cloud production environment, leveraging the scalability of the Google Cloud ecosystem:

* **Google Cloud BigQuery**: Centralized data repository within a Cloud Data Warehouse. Utilizing advanced SQL and Many-to-One relationships via LEFT JOINs, the raw datasets were denormalized and enriched with calculated financial metrics.
* **Google Sheets**: Used as a rapid prototyping and exploratory data analysis environment to validate aggregated metrics through pivot tables before final deployment.
* **Looker Studio**: Automated Business Intelligence and Data Visualization tool connected directly to the cloud tables to deliver interactive insights for executive review.

---

## 🏗️ STEP 1: Cloud Data Engineering & SQL Transformations (BigQuery)

### 1. Data Cleaning and Enrichment (/queries/1_sales_enriched.sql)
The 4 source datasets (daily_sales, products, retailers, methods) were fully integrated into BigQuery. Row-level feature engineering was applied to generate key financial performance indicators (Revenue, Cost, Profit).

#### Enriched Cloud Base View (sales_enriched):
<img width="1453" height="601" alt="sales_enriched" src="https://github.com/user-attachments/assets/907806c9-4ddb-4b1a-a0b8-794cc2d6522b" />

### 2. Advanced Market Concentration Logic (/queries/2_market_concentration.sql)
To satisfy Dustin's strategic requests, a multi-layered query architecture was engineered within BigQuery using Nested CTEs (Common Table Expressions) and Window Functions to segment markets and automatically forecast expansion targets (+10% volume for Big Players, +15% store count for competitive markets).

#### Cloud Data Output & Target Simulations (market_concentration):
<img width="1364" height="506" alt="market_concentration" src="https://github.com/user-attachments/assets/36f250fc-463a-4c0f-9dcc-6b23db2e7ded" />

---

## 📊 STEP 2: Exploratory Data Analysis & Prototyping (Google Sheets)

### 💳 Sarah's Channel Efficiency Breakdown
Prior to building the final dashboard, the enriched cloud view was connected to Google Sheets to conduct an initial exploratory breakdown aggregated by the order_method dimension.

#### Exploratory Interface on Google Sheets:
<img width="868" height="416" alt="sheets_channel" src="https://github.com/user-attachments/assets/be08a20c-1f7c-40dd-84a4-9f1d11c7d4ab" />

### 🗺️ Dustin's Market Performance & Deep-Dive
To support international commercial scaling, cloud metrics were dissected using a Top-Down funnel approach via dual, interconnected pivot tables.

#### Macro Market Performance (Dustin_Markets):
<img width="235" height="327" alt="sheets_dustin_macro" src="https://github.com/user-attachments/assets/b5bbc1bb-64fb-4fcb-9f9c-5ce48c6c6390" />

#### Micro Retailer Deep-Dive (Dustin_Retailers):
<img width="224" height="661" alt="sheets_dustin_micro" src="https://github.com/user-attachments/assets/82526191-8774-4cc9-88b5-50e92ece4821" />

---

## 📈 STEP 3: Enterprise Business Intelligence & Dashboards (Looker Studio)

### 🔄 Automated Live-Data Architecture
*Crucial Architecture Detail:* To eliminate any manual work, Looker Studio was connected **directly and natively via live connection to the production tables in Google Cloud BigQuery**. There are no static file uploads. Whenever new sales data hits the cloud data warehouse, the executive dashboards refresh automatically in real-time. This creates a fully automated data pipeline that grants absolute operational independence to both Sarah and Dustin.

### 💳 1. Financial Optimization Dashboard (Sarah)
#### Final Interactive Dashboard (Looker Studio):
<img width="748" height="360" alt="looker_sarah" src="https://github.com/user-attachments/assets/dbd6210c-6265-49f1-8e62-89928fb13742" />

#### Executive Summary & Pitch to the CEO:
> "This is the Sales Channels Efficiency Dashboard we built for Sarah. Everything updates dynamically. At a glance, Sarah can track our macro metrics: 1.3 Billion in Total Revenue, over 500 Million in Total Profit, and a Sales Volume of nearly 20 Million items. We also created three dropdown filters here. Sarah can use them to filter by specific dates, order methods, or countries... Looking at the charts, we can instantly see that Web is our absolute champion with 910 Million in revenue. But look at the bottom: Special methods and Fax are virtually invisible. Sarah can instantly make a data-informed decision: phasing out Fax saves operational costs without hurting our business."

* **The Web channel heavily dominates the business**, accounting for 72.68% of total revenue.
* **Strategic Recommendation**: Initiate a gradual phasing out of the Fax infrastructure, migrating legacy clients to digital alternatives.

### 🗺️ 2. Global Market Segmentation Dashboard (Dustin)
#### Final Interactive Dashboard (Looker Studio):
<img width="745" height="496" alt="looker_dustin" src="https://github.com/user-attachments/assets/dd1ca27a-74f6-4707-a634-b5952be5034d" />

#### Executive Summary & Pitch to the CEO:
> "Now let’s move to Dustin's dashboard. We created a smart system that automatically classifies our global markets in our 21 countries. We added an 80% threshold line here. If the top 3 retailers control more than 80%, the system flags it as a 'Big-player market' in blue. If it's below, it turns orange as a 'Competitive market'. The best part is the map interactivity. If Dustin clicks on a specific country, like Australia here, the whole dashboard filters instantly. Regarding the 'Market Performance Details' table, Dustin doesn't need to do any math. The system automatically calculates a plus 10% target volume for Big Players, and leaves a clean 'null' for the others. For competitive markets, it automatically calculates the new target retailer count."

* **Consolidated Markets (Big-player market)**: Focus on volume-driven growth matching the automated target simulation (+10%).
* **Fragmented Markets (Competitive market)**: Onboard 15% more local boutique retailers to expand the territorial footprint.

---

## 📂 Repository Contents
* `/queries/1_sales_enriched.sql`: SQL code for data denormalization, cleaning, and financial metric feature engineering.
* `/queries/2_market_concentration.sql`: Advanced SQL script utilizing CTEs and Window Functions for automated country segmentation and target forecasting.
* `/images/`: Directory containing screenshots of the exploratory Google Sheets data layouts and the interactive Looker Studio dashboard pages.
