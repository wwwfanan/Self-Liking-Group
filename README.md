# 🌍 Collaboration and Academic Excellence – SLG Code and Data

This repository contains the data and R code used in support of our study:  
**"Collaboration Between Countries is Associated with Academic Excellence and Funding"**

---

## 📁 Structure

- 🔹 **`Country_SLG.R`**  
  Core script implementing the SLG (Self-Liking Group) computation for country-level scientific collaboration networks.

- 🔹 **`FUN_*.R`**  
  A set of custom functions required by the main script. These include routines for network preprocessing, SLG matrix generation, and temporal aggregation.

- 🔹 **`.csv` files**  
  - A sample dataset for one year’s country-level co-authorship network. Nodes represent countries, and edges indicate co-authorship links within that year.  
  - An additional metadata file provides country-level attributes, such as:
    - Region classification  
    - Continent 

---

## ⚙️ Installation & Requirements

This code was developed and tested in **R ≥ 4.5.0**. Please install the following packages before running:

```r
install.packages(c("igraph", "tidyverse", "data.table", "ggplot2"))

**

## ✉️ Contact

If you have any questions or need support, feel free to contact:  
📧 **wwwwfanang@gmail.com**
