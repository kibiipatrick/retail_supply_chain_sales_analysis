"""
Retail Supply Chain Sales Analysis

Author: Patrick Kibii
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats


# Load dataset
df = pd.read_csv('/Users/kibii/Documents/GitHub/retail_supply_chain_sales_analysis/python files/retail_supply_chain_sales_dataset.csv')

print("Dataset Shape:", df.shape)


# Data preparation and feature engineering

# Convert date columns
df["Order Date"] = pd.to_datetime(df["Order Date"], dayfirst=True)
df["Ship Date"] = pd.to_datetime(df["Ship Date"], dayfirst=True)


# Create shipping duration metric
df["Shipping Duration"] = (df["Ship Date"] - df["Order Date"]).dt.days

# Time-based features
df["Order Year"] = df["Order Date"].dt.year
df["Order Month"] = df["Order Date"].dt.month
df["Order Quarter"] = df["Order Date"].dt.quarter

# Profit margin calculation
df["Profit Margin"] = df["Profit"] / df["Sales"]
df["Profit Margin"].replace([np.inf, -np.inf], np.nan, inplace=True)

# Remove rows missing critical numerical data
df.dropna(subset=["Sales", "Profit", "Shipping Duration"], inplace=True)


# Key Performance Indicators

total_sales = df["Sales"].sum()
total_profit = df["Profit"].sum()
avg_profit_margin = df["Profit Margin"].mean()
total_orders = df["Order ID"].nunique()
total_customers = df["Customer ID"].nunique()

print("\nKPI Summary")
print(f"Total Sales: ${total_sales:,.2f}")
print(f"Total Profit: ${total_profit:,.2f}")
print(f"Average Profit Margin: {avg_profit_margin:.2%}")
print(f"Total Orders: {total_orders}")
print(f"Total Customers: {total_customers}")


# Outlier removal using IQR method

def remove_outliers(data, column):
    Q1 = data[column].quantile(0.25)
    Q3 = data[column].quantile(0.75)
    IQR = Q3 - Q1
    lower = Q1 - 1.5 * IQR
    upper = Q3 + 1.5 * IQR
    return data[(data[column] >= lower) & (data[column] <= upper)]

df_clean = remove_outliers(df, "Sales")


# Customer RFM-style analysis

latest_date = df["Order Date"].max()

rfm = df.groupby("Customer ID").agg({
    "Order Date": lambda x: (latest_date - x.max()).days,
    "Order ID": "nunique",
    "Sales": "sum"
})

rfm.columns = ["Recency", "Frequency", "Monetary"]


# Product performance

category_performance = df.groupby("Category")[["Sales", "Profit"]].sum()
subcategory_profit = df.groupby("Sub-Category")["Profit"].sum().sort_values(ascending=False)


# Discount impact analysis

discount_profit_corr = df["Discount"].corr(df["Profit"])

median_discount = df["Discount"].median()
high_discount_profit = df[df["Discount"] > median_discount]["Profit"]
low_discount_profit = df[df["Discount"] <= median_discount]["Profit"]

t_stat, p_value = stats.ttest_ind(high_discount_profit, low_discount_profit)

print("\nDiscount vs Profit Analysis")
print(f"Correlation: {discount_profit_corr:.3f}")
print(f"T-Test P-Value: {p_value:.5f}")


# Shipping performance analysis

shipping_by_mode = df.groupby("Ship Mode")["Shipping Duration"].mean()
shipping_by_region = df.groupby("Region")["Shipping Duration"].mean()


# Time series analysis

monthly_sales = df.groupby(
    pd.Grouper(key="Order Date", freq="M")
)["Sales"].sum()

rolling_sales = monthly_sales.rolling(window=3).mean()

plt.figure(figsize=(10, 5))
monthly_sales.plot(label="Monthly Sales")
rolling_sales.plot(label="3-Month Rolling Avg")
plt.title("Monthly Sales Trend")
plt.legend()
plt.tight_layout()
plt.show()


# Correlation matrix

numeric_cols = df.select_dtypes(include="number")
correlation_matrix = numeric_cols.corr()

plt.figure(figsize=(10, 8))
sns.heatmap(correlation_matrix, annot=True, cmap="coolwarm", fmt=".2f")
plt.title("Correlation Matrix")
plt.tight_layout()
plt.show()


# Return impact analysis

return_profit_comparison = df.groupby("Returned")["Profit"].mean()


# Export processed dataset

df.to_csv("retail_supply_chain_processed.csv", index=False)

