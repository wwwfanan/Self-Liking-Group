# 🌍 Collaboration and Academic Excellence – SLG Code and Data

This repository contains the data and R code used in support of our study:  
**"Collaboration Between Countries is Associated with Academic Excellence and Funding"**

---

## 📦 Dataset Description

1. `Data_AuthorEdge_GC_1980_Gap3.csv`  
   - Collaboration network: nodes represent authors; links represent co-authorships (per paper)

2. `Data_AuthorEdge_GC_1980_Gap3_Community_LouvainP_r=1.csv`  
   - Louvain-based community detection result for the author network

3. `Data_AuthorAffiliationCountry_AllYear.csv`  
   - Author's country and institutional affiliation
   - Due to its large size (~1GB), this file is hosted in the [Releases - Data]

4. `Country_Continent.csv`  
   - Country-to-continent mapping

5. `AuthorNode_CountryHomophily_Cluster_k=4new.csv`  
   - Country clustering based on homophily metrics

6. `AuthorNode_CountryHomophily_year1980_Gap3_r=1.0_LA50_p0.csv`  
   - Country-level SLG results for the year 1980

---

## 🧠 Code Description

### 1. `Country_SLG.R`  
Core script for SLG computation across countries in a scientific collaboration network.

- **Inputs**: Data 1–4  
- **Output**: SLG score per country (1980 as and example)

---

### 2. `Country_Clustering.R`  
Script to visualize clustering results on a world map based on SLG.

- **Inputs**: Data 5–6  
- **Output**: Image of clustered countries on a global map

---

### 3. `FUN_*.R`  
A collection of custom functions used across the main scripts:

- Network preprocessing  
- SLG matrix generation  
- Temporal data aggregation

---

## ⚙️ Installation & Requirements

### 💻 Operating System
- Tested on **macOS (≥ 12.0)** and **Windows 10/11**

### 🧮 R Environment
- Requires **R ≥ 4.5.0**

### 📦 Required R Packages

Run the following command in your R console to install dependencies:

```r
install.packages(c("igraph", "plyr", "dplyr", "data.table", "ggplot2"))

