

-- GET HORSE DATA
SELECT h.horse_name
  FROM horses h;   
  -- 595 rows 


============================================================================================

-- JOIN CHART, RACE, RACE LEVEL, ENTRIES, AND HORSE DATA
SELECT c.race_date, c.track_name,
	   r.number, r.condition,
	   rl.race_type, rl.restriction, rl.distance, rl.dist_unit, rl.surface, rl.class_rating,
	   e.program_num, e.meds, e.equip, e.odds, e.official_finish, e.speed_rating, 
	   e.comment, e.win_payoff, e.place_payoff, e.show_payoff, e.show_payoff2,
	   e.race_id, e.program_num, e.meds, e.equip, e.odds, e.official_finish, e.speed_rating, 
	   e.comment, e.win_payoff, e.place_payoff, e.show_payoff, e.show_payoff2,
	   h.horse_name
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id);
-- 601 rows

============================================================================================







