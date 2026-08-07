-- ==============================================================================
-- 2. ADVANCED MARKET CONCENTRATION ANALYSIS & GROWTH SIMULATIONS
-- Objective: Classify global markets (Big Player vs Competitive) and calculate targets
-- Requester: Dustin (Head of Retail Partnership)
-- ==============================================================================

WITH sales_by_retailer AS (
  -- Level 1: Aggregate total performance metrics per individual storefront within each Country
  SELECT
    country,
    retailer_code,
    retailer_name,
    SUM(revenue) AS retailer_revenue,
    SUM(quantity) AS retailer_quantity
  FROM `project-39934972-6d2d-4ed6-853.gooutside.sales_enriched`
  GROUP BY country, retailer_code, retailer_name
),

ranked_retailers AS (
  -- Level 2: Introduce national macro context metrics without losing record granularity via Window Functions
  SELECT
    *,
    SUM(retailer_revenue) OVER (PARTITION BY country) AS market_sales,
    SUM(retailer_quantity) OVER (PARTITION BY country) AS market_quantity,
    COUNT(*) OVER (PARTITION BY country) AS retailer_count,
    ROW_NUMBER() OVER (
      PARTITION BY country
      ORDER BY retailer_revenue DESC
    ) AS retailer_rank -- Ranks stores from highest to lowest revenue per nation
  FROM sales_by_retailer
),

market_summary AS (
  -- Level 3: Compress to country-level rows and isolate leading distributor metrics
  SELECT
    country,
    MAX(market_sales) AS market_sales,
    MAX(market_quantity) AS market_quantity,
    MAX(retailer_count) AS retailer_count,
    MAX(IF(retailer_rank = 1, retailer_name, NULL)) AS top_retailer, -- Isolates top leader name
    MAX(IF(
      retailer_rank = 1,
      SAFE_DIVIDE(retailer_revenue, market_sales),
      NULL
    )) AS top_retailer_share, -- Market share of the top leader (Top 1)
    SAFE_DIVIDE(
      SUM(IF(retailer_rank <= 3, retailer_revenue, 0)),
      MAX(market_sales)
    ) AS top_3_share -- Combined market share of the top 3 storefronts
  FROM ranked_retailers
  GROUP BY country
)

-- FINAL SELECT: Apply conditional business rules and predictive expansion modeling
SELECT
  *,
  -- Rule 1: Classify market structure category based on top 3 concentration ratio
  CASE
    WHEN top_3_share >= 0.80 THEN 'Big-player market'
    ELSE 'Competitive market'
  END AS market_type,

  -- Rule 2: Compute current average baseline sales volume per individual store
  ROUND(
    SAFE_DIVIDE(market_quantity, retailer_count),
    2
  ) AS current_volume_per_retailer,

  -- Rule 3: For Oligopolistic markets, simulate a +10% target volume push per store
  CASE
    WHEN top_3_share >= 0.80 THEN 
      ROUND(SAFE_DIVIDE(market_quantity, retailer_count) * 1.10, 2)
    ELSE NULL
  END AS target_volume_per_retailer,

  -- Rule 4: For Fragmented markets, simulate a +15% expansion in store count (rounded up via CEIL)
  CASE
    WHEN top_3_share < 0.80 THEN 
      CAST(CEIL(retailer_count * 1.15) AS INT64)
    ELSE NULL
  END AS target_retailer_count

FROM market_summary;
