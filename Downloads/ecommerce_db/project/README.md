# E-commerce Database Design

This repository contains the design and initial data setup for an e-commerce database. It is structured to handle product information, brand details, category hierarchies, product attributes, and variations essential for an online retail system.

## Schema Description

The database schema includes these core tables:

- **brand**: Holds details about various product brands.
- **product_category**: Organizes products into categories with support for nested subcategories.
- **size_category**: Classifies different size groups such as apparel or footwear.
- **size_option**: Lists specific size values applicable to products.
- **color**: Contains color names and their corresponding hex color codes.
- **attribute_category**: Groups product attributes into meaningful categories like physical or technical.
- **attribute_type**: Defines individual product attributes such as weight or dimensions.
- **product**: Stores comprehensive product information including brand and category links.
- **product_image**: Manages images associated with products, including primary and additional images.
- **product_attribute**: Connects products with their specific attribute values.
- **product_item**: Represents distinct purchasable units of a product, such as different SKUs.
- **product_variation**: Links product items to their variations like color and size.
- **product_color**: Tracks the available colors for each product.

## Features Overview

- **Category Hierarchy**: Supports multi-level product categories for detailed classification.
- **Variation Management**: Handles product variations including sizes and colors at the item level.
- **Custom Attributes**: Enables flexible attribute definitions grouped by category.
- **Image Support**: Allows multiple images per product with a primary image designation.
- **Seed Data Included**: Provides example data for brands, categories, products, and variations to jumpstart development.

## Requirements

- A MySQL-compatible database server.
- Basic familiarity with SQL commands and database management.

## Setup Instructions

1. Initialize the database and tables by executing the provided SQL script:

   ```sql
   CREATE DATABASE ecommerce;
   USE ecommerce;
   SOURCE ecommerce.sql;
   ```

2. Confirm that the schema and sample data have been successfully created.

## How to Use

- Utilize this schema as a foundation for developing an e-commerce platform.
- Customize and expand the schema to meet specific business needs.
- Integrate with backend applications to manage product data and variations dynamically.
