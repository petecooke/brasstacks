SELECT c.race_date, c.track_name,
	   r.number, r.condition,
	   rl.race_type, rl.restriction, rl.distance, rl.dist_unit, rl.surface, rl.class_rating,
	   e.program_num, e.meds, e.equip, e.odds, e.official_finish, e.speed_rating, 
	   e.comment, e.win_payoff, e.place_payoff, e.show_payoff, e.show_payoff2,
	   e.race_id, e.program_num, e.meds, e.equip, e.odds, e.official_finish, e.speed_rating, 
	   e.comment, e.win_payoff, e.place_payoff, e.show_payoff, e.show_payoff2,
	   h.horse_name

SELECT h.horse_name, e.win_payoff, e.place_payoff, e.show_payoff, e.show_payoff2
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id)
 WHERE h.horse_name = 'Perfect Stormy';


=================================================================================

-- GET WIN ROI ($2 investment)
-- ROI = (payoff - initial investment) / initial investment
SELECT h.horse_name,
	   ( sum(e.win_payoff) - (2 * count(h.id)) / (2 * count(h.id) ) ) as win_roi
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id)
 --WHERE h.horse_name = 'Back Forty'
 GROUP BY h.id
 ORDER BY win_roi DESC;

 =================================================================================


-- THIS WORKS
SELECT h.horse_name,
	   ( (sum(e.win_payoff) - (2 * count(h.id))) / (2 * count(h.id) ) ) as win_roi,
	   SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   	        ELSE 0
	   	        END
	   	   ) as number_of_wins,
	   -- sum(e.win_payoff) / (SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   -- 	        ELSE 0
	   -- 	        END
	   -- 	   )) as avg_win_payoff,
	   -- sum(e.win_payoff) as win_payoff,
	   count(h.id) as number_of_races
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id)
 WHERE h.horse_name = 'Raglin River'
 GROUP BY h.id
 -- HAVING	SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	--    	        ELSE 0
	--    	        END
	--    	   ) > 0
 ORDER BY win_roi DESC;

 -- comments removed from above
 SELECT h.horse_name,
	   ( (sum(e.win_payoff) - (2 * count(h.id))) / (2 * count(h.id) ) ) as win_roi,
	   SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   	        ELSE 0
	   	        END
	   	   ) as number_of_wins,
	   count(h.id) as number_of_races
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id)
 GROUP BY h.id
 HAVING	SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   	        ELSE 0
	   	        END
	   	   ) > 1
 ORDER BY win_roi DESC;


SELECT h.horse_name, CAST(e.official_finish as INT), e.win_payoff
	   --( sum(e.win_payoff) - (2 * count(h.id)) / (2 * count(h.id) ) ) as win_roi,
	   -- SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   -- 	        ELSE 0
	   -- 	        END
	   -- 	   ) as number_of_wins
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id)
 WHERE h.horse_name = 'Raglin River';
 --GROUP BY h.id;
-- HAVING	count(e.official_finish) > 2
 --ORDER BY win_roi DESC;


 
 