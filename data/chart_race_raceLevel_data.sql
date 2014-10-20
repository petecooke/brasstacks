
-- GET RACE LEVEL DATA
SELECT rl.id, rl.race_type, rl.restriction, rl.distance, rl.dist_unit, rl.surface, rl.class_rating
  FROM race_levels rl;
  -- 75 rows


==============================================================================================

-- JOIN CHART, RACE, AND RACE LEVEL DATA
SELECT c.race_date, c.track_name,
	   r.number, r.condition,
	   rl.race_type, rl.restriction, rl.distance, rl.dist_unit, rl.surface, rl.class_rating
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (r.race_level_id = rl.id);
-- 76 rows

==============================================================================================