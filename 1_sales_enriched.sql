-- ==============================================================================
-- 1. DATA DENORMALIZATION & ENRICHMENT (ETL PIPELINE)
-- Objective: Integrate the 4 raw datasets and calculate key financial metrics
-- ==============================================================================

SELECT
  s.Date AS sale_date,
  s.`Retailer code` AS retailer_code,
  r.`Retailer name` AS retailer_name,
  r.Type AS retailer_type,
  r.Country AS country,

  s.`Product number` AS product_number,
  p.`Product line` AS product_line,
  p.`Product type` AS product_type,
  p.Product AS product,
  p.`Product brand` AS product_brand,

  s.`Order method code` AS order_method_code,
  m.`Order method type` AS order_method,

  s.Quantity AS quantity,
  s.`Unit sale price` AS unit_sale_price,
  p.`Unit cost` AS unit_cost,

  -- Calculated Financial Metrics (Feature Engineering)
  s.Quantity * s.`Unit sale price` AS revenue,
  s.Quantity * p.`Unit cost` AS cost,
  s.Quantity * (s.`Unit sale price` - p.`Unit cost`) AS profit

FROM `gooutside_beatrice.daily_sales` AS s

LEFT JOIN `gooutside_beatrice.retailers` AS r
  ON s.`Retailer code` = r.`Retailer code`

LEFT JOIN `gooutside_beatrice.products` AS p
  ON s.`Product number` = p.`Product number`

LEFT JOIN `gooutside_beatrice.methods` AS m
  ON s.`Order method code` = m.`Order method code`;
