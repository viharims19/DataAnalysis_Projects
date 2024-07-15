-- Removing Empty Blanks in orders table
UPDATE `retail corporation_sales`.`orders` 
SET
   order_id = NULLIF(order_id,''),
   customer_id = NULLIF(customer_id,''),
   order_status = NULLIF(order_status,''),
   order_purchase_timestamp = NULLIF(order_purchase_timestamp,''),
   order_approved_at = NULLIF(order_approved_at,''),
   order_delivered_carrier_date = NULLIF(order_delivered_carrier_date,''),
   order_delivered_customer_date = NULLIF(order_delivered_customer_date,''),
   order_estimated_delivery_date = NULLIF(order_estimated_delivery_date,'');
   
-- Renaming Column Name in Payments table
ALTER TABLE `retail corporation_sales`.`products` 
CHANGE COLUMN `product category` `product_category` TEXT NULL DEFAULT NULL ;

-- 

-- Changing Datatype of columns in orders table
ALTER TABLE `retail corporation_sales`.`orders`
MODIFY COLUMN `order_id` CHAR(32) NOT NULL,
MODIFY COLUMN `customer_id` CHAR(32) NOT NULL,
MODIFY COLUMN `order_purchase_timestamp` DATETIME NULL,
MODIFY COLUMN `order_approved_at` DATETIME NULL,
MODIFY COLUMN `order_delivered_carrier_date` DATETIME NULL,
MODIFY COLUMN `order_delivered_customer_date` DATETIME NULL,
MODIFY COLUMN `order_estimated_delivery_date` DATETIME NULL;

-- Setting order_id column as primary key in orders table
ALTER TABLE `retail corporation_sales`.`orders` 
ADD PRIMARY KEY (`order_id`);

-- Setting customer_id as foreign key in orders table
ALTER TABLE `retail corporation_sales`.`orders` 
ADD CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`)
REFERENCES `retail corporation_sales`.`customers` (`customer_id`);

-- Changing Datatypes of columns in order_items table
ALTER TABLE `retail corporation_sales`.`order_items`
MODIFY COLUMN `seller_id` CHAR(32) DEFAULT NULL;

ALTER TABLE `retail corporation_sales`.`order_items` 
MODIFY COLUMN `order_id` CHAR(32) DEFAULT NULL;

-- Setting seller_id as foreign key in order_items table
ALTER TABLE `retail corporation_sales`.`order_items` 
ADD CONSTRAINT `seller_id` FOREIGN KEY (`seller_id`)
REFERENCES `retail corporation_sales`.`sellers` (`seller_id`);

-- Setting order_id as foreign key in order_items table
ALTER TABLE `retail corporation_sales`.`order_items` 
ADD CONSTRAINT `order_id_oi` FOREIGN KEY (`order_id`)
REFERENCES `retail corporation_sales`.`orders` (`order_id`);

-- Changing Datatypes of columns in payments table
ALTER TABLE `retail corporation_sales`.`payments` 
MODIFY COLUMN `order_id` CHAR(32) DEFAULT NULL;

-- Setting order_id as foreign key in payments table
ALTER TABLE `retail corporation_sales`.`payments` 
ADD CONSTRAINT `order_id` FOREIGN KEY (`order_id`) 
REFERENCES `retail corporation_sales`.`orders` (`order_id`);

-- Changing datatypes of columns in sellers table
ALTER TABLE `retail corporation_sales`.`sellers`
MODIFY COLUMN `seller_id` CHAR(32) NOT NULL,
MODIFY COLUMN `seller_zip_code_prefix` CHAR(5)  DEFAULT NULL ;

-- Setting seller_id column as primary key in sellers table
ALTER TABLE `retail corporation_sales`.`sellers`
ADD PRIMARY KEY (`seller_id`);

-- Changing datatypes of columns in customers table
ALTER TABLE `retail corporation_sales`.`customers` 
MODIFY COLUMN `customer_id`  CHAR(32) NOT NULL;

-- Setting customer_id column as primary key in customers table
ALTER TABLE `retail corporation_sales`.`customers` 
ADD PRIMARY KEY (`customer_id`);

-- Changing datatypes of columns in geolocation table
ALTER TABLE `retail corporation_sales`.`geolocation` 
MODIFY COLUMN  `geolocation_zip_code_prefix` CHAR(5) DEFAULT NULL ;

-- Setting customer_id column as primary key in geolocation table
ALTER TABLE `retail corporation_sales`.`geolocation` 
ADD PRIMARY KEY (`customer_id`);


CREATE UNIQUE INDEX seller_zip_code_prefix_idx ON sellers (seller_zip_code_prefix);

ALTER TABLE geolocation
ADD CONSTRAINT geolocation_zip_code_prefix
FOREIGN KEY (geolocation_zip_code_prefix) REFERENCES sellers (seller_zip_code_prefix);



