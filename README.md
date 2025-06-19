This repository contains data and codes we used in support of our work "Collaboration Between Countries is Associated with Academic Excellence and Funding".

Structure

"Country_SLG.R": Core function implementing the SLG computation.

"FUN_....R": Some custom functions are defined separately and are required by the main script Country_SLG.R.

"....csv": A sample dataset for one year’s scientific collaboration network is included for demonstration purposes. The data represents a country-level co-authorship network, where nodes correspond to countries and edges indicate co-authorship links between them within a specific year.
Additional metadata on the countries involved in the network (e.g., region classification, income level, scientific output) is also provided in a separate file. 


Installation & Requirements

This code requires R ≥ 4.5.0 and the following packages: 

install.packages(c("igraph", "tidyverse", "data.table", "ggplot2"))

If you have any questions, please contact me at wwwwfanang@gmail.com.
