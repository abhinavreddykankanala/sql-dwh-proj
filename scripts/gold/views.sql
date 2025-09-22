CREATE VIEW gold.dim_customers AS
SELECT 
		ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
		ci.cst_id AS Customer_id,
		ci.cst_key AS Customer_number,
		ci.cst_firstname AS First_name,
		ci.cst_lastname AS Last_name,
		ci.cst_marital_status AS Marital_status,
		ca.bdate AS Birthdate,
		la.country AS Country,
		CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr --CRM is the Master for gender Info
			 ELSE COALESCE(ca.gen, 'n/a')
		END AS Gender,
		ci.cst_create_date AS Create_date
FROM [silver].[crm_cust_info] ci
LEFT JOIN [silver].[erp_cust_az12] ca
ON		  ci.cst_key = ca.cid
LEFT JOIN [silver].[erp_loc_a101] la
ON		  ci.cst_key = la.cid

CREATE VIEW gold.dim_products AS
SELECT
		ROW_NUMBER() OVER (ORDER BY prd_start_dt, pn.prd_key) AS product_key,
		pn.prd_id AS Product_id,
		pn.prd_key AS Product_number,
		pn.prd_nm AS Product_Name,
		pn.cat_id AS Category_id,
		pc.category AS Category,
		pc.subcategory AS SubCategory,
		pc.maintenance AS Maintenance,
		pn.prd_cost AS Cost,
		pn.prd_line AS Product_Line,
		pn.prd_start_dt AS Start_Date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL

CREATE VIEW gold.fact_sales AS
SELECT 
	    sd.sls_ord_num AS order_number,
		pr.product_key,  --surrogate key
		cu.customer_key, --surrogate key = used to connect the fact table with dimension tables
		sd.sls_order_dt AS order_date,
		sd.sls_ship_dt AS shipping_date,
		sd.sls_due_dt AS due_date,
		sd.sls_sales AS sales_amount,
		sd.sls_quantity AS quantity,
		sd.sls_price price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr 
ON sd.sls_prd_key  = pr.Product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.Customer_id
