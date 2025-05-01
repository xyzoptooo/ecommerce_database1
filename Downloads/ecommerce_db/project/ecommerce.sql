
-- Create the ecommerce database and select it for use
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Table to store brand information
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    logo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table for product categories with hierarchical parent-child relationships
CREATE TABLE product_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(id)
);

-- Table defining size categories (e.g., clothing, footwear)
CREATE TABLE size_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for specific size options linked to size categories
CREATE TABLE size_option (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES size_category(id)
);

-- Table storing color options with names and hex codes
CREATE TABLE color (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table grouping attribute categories
CREATE TABLE attribute_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table defining attribute types with data types and category association
CREATE TABLE attribute_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    data_type ENUM('text', 'number', 'boolean', 'date') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES attribute_category(id)
);

-- Table storing product details with brand and category references
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- Table managing product images with primary image flag
CREATE TABLE product_image (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

-- Table linking products to their attributes and values
CREATE TABLE product_attribute (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);

-- Table representing purchasable product variations (SKUs)
CREATE TABLE product_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

-- Table linking product items to specific variations like color and size
CREATE TABLE product_variation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    product_item_id INT NOT NULL,
    color_id INT,
    size_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_id) REFERENCES size_option(id)
);

-- Junction table tracking available colors for each product
CREATE TABLE product_color (
    product_id INT NOT NULL,
    color_id INT NOT NULL,
    PRIMARY KEY (product_id, color_id),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES color(id)
);

-- Insert data into brand table
INSERT INTO brand (name, description, logo_url) VALUES
('Acme Corp', 'Leading manufacturer of quality products.', 'https://xyzopto/logos/acme.png'),
('Global Goods', 'Worldwide distributor of consumer goods.', 'https://xyzopto/logos/globalgoods.png');

-- Insert  data into product_category table
INSERT INTO product_category (name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and gadgets', NULL),
('Computers', 'Desktops and laptops', 1),
('Smartphones', 'Mobile phones and accessories', 1),
('Clothing', 'Apparel for men and women', NULL),
('Men', 'Men clothing', 4),
('Women', 'Women clothing', 4);

-- Insert  data into size_category table
INSERT INTO size_category (name, description) VALUES
('Clothing Sizes', 'Sizes for clothing items'),
('Shoe Sizes', 'Sizes for footwear');

-- Insert data into size_option table
INSERT INTO size_option (category_id, name, description) VALUES
(1, 'Small', 'Small size'),
(1, 'Medium', 'Medium size'),
(1, 'Large', 'Large size'),
(2, '7', 'Size 7 shoe'),
(2, '8', 'Size 8 shoe'),
(2, '9', 'Size 9 shoe');

-- Insert  data into color table
INSERT INTO color (name, hex_code) VALUES
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Green', '#00FF00'),
('Black', '#000000'),
('White', '#FFFFFF');

-- Insert data into attribute_category table
INSERT INTO attribute_category (name) VALUES
('Physical Attributes'),
('Technical Specifications');

-- Insert  data into attribute_type table
INSERT INTO attribute_type (category_id, name, data_type) VALUES
(1, 'Weight', 'number'),
(1, 'Dimensions', 'text'),
(2, 'Battery Life', 'text'),
(2, 'Processor', 'text');

-- Insert  data into product table
INSERT INTO product (brand_id, category_id, name, description, base_price) VALUES
(1, 2, 'Acme Laptop', 'High performance laptop for professionals.', 1200.00),
(1, 3, 'Acme Smartphone', 'Latest model smartphone with advanced features.', 800.00),
(2, 5, 'Men\'s T-Shirt', 'Comfortable cotton t-shirt for men.', 20.00),
(2, 6, 'Women\'s Dress', 'Elegant evening dress for women.', 150.00);

-- Insert  data into product_image table
INSERT INTO product_image (product_id, image_url, is_primary) VALUES
(1, 'https://xyzoptooo/images/laptop1.jpg', TRUE),
(1, 'https://xyzoptooo/images/laptop2.jpg', FALSE),
(2, 'https://xyzoptooo/images/smartphone1.jpg', TRUE),
(3, 'https://xyzoptooo/images/tshirt1.jpg', TRUE),
(4, 'https://xyzoptoooimages/dress1.jpg', TRUE);

-- Insert  data into product_attribute table
INSERT INTO product_attribute (product_id, attribute_type_id, value) VALUES
(1, 1, '2.5 kg'),
(1, 2, '15 x 10 x 1 inches'),
(2, 3, '10 hours'),
(2, 4, 'Octa-core 2.8 GHz'),
(3, 1, '0.2 kg'),
(4, 1, '0.3 kg');

-- Insert  data into product_item table
INSERT INTO product_item (product_id, sku, price, quantity) VALUES
(1, 'ACME-LAP-001', 1200.00, 10),
(2, 'ACME-PHN-001', 800.00, 25),
(3, 'GG-MTS-001', 20.00, 100),
(4, 'GG-WDR-001', 150.00, 50);

-- Insert data into product_variation table
INSERT INTO product_variation (product_id, product_item_id, color_id, size_id) VALUES
(1, 1, 4, NULL),
(2, 2, 5, NULL),
(3, 3, 1, 1),
(3, 3, 2, 2),
(4, 4, 3, NULL);

-- Insert data into product_color table
INSERT INTO product_color (product_id, color_id) VALUES
(1, 4),
(2, 5),
(3, 1),
(3, 2),
(4, 3);
