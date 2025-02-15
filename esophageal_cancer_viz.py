#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 15 17:02:05 2025

@author: salimakoriow
"""

import pandas as pd

#Load the csv file
df = pd.read_csv('/Users/salimakoriow/Desktop/esophageal_cancer_summary.csv')

#Check the first few rows
print(df.head())

import matplotlib.pyplot as plt
import seaborn as sns

# Set style
sns.set_style("whitegrid")

# Create bar plot
plt.figure(figsize=(8, 5))
sns.barplot(data=df, x='stage', y='patient_count', palette='Blues_d')

# Labels and title
plt.xlabel("Cancer Stage")
plt.ylabel("Number of Patients")
plt.title("Distribution of Patients by Cancer Stage")

# Show plot
plt.show()
