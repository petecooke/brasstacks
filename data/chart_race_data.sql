-- GET CHART DATA
SELECT c.id, c.race_date, c.track_name
  FROM charts c;
-- 8 rows

-- GET RACE DATA
SELECT r.id, r.number, r.condition, r.chart_id, r.race_level_id
  FROM races r;
-- 76 rows  

==============================================

-- JOIN CHART AND RACE DATA
SELECT c.race_date, c.track_name,
	   r.number, r.condition
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id);
-- 76 rows

===============================================