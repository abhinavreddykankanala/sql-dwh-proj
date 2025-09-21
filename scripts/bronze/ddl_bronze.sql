CREATE TABLE bronze.crm_cust_info (
	cst_id	INT,
	cst_key	NVARCHAR(50),
	cst_firstname	NVARCHAR(50),
	cst_lastname	NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr	NVARCHAR(50),
	cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info (
	prd_id	INT,
	prd_key	NVARCHAR(50),
	prd_nm	NVARCHAR(50),
	prd_cost INT,	
	prd_line	NVARCHAR(50),
	prd_start_dt DATE,	
	prd_end_dt DATE
);

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num	NVARCHAR(50),
	sls_prd_key	NVARCHAR(50),
	sls_cust_id	int,
	sls_order_dt NVARCHAR(50),
	sls_ship_dt	DATE,
	sls_due_dt	DATE,
	sls_sales	INT,
	sls_quantity INT,
	sls_price INT
);

CREATE TABLE bronze.erp_cust_az12 (
	CID	NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50)
);

CREATE TABLE bronze.erp_loc_a101 (
	CID NVARCHAR(50),
	Country NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
	id NVARCHAR(50),
	Category NVARCHAR(50),
	Subcategory NVARCHAR(50),
	Maintenance NVARCHAR(50)
);
