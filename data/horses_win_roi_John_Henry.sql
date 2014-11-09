-- * John Henry Mfcka Older Than You List: top 5 ROI for horses 9 yrs or older
-- * select *
-- * horses
-- * where age is 9 or greater
-- * order by ROI
-- * limit to 5


 SELECT h.horse_name,
	   ( (sum(e.win_payoff) - (2 * count(h.id))) / (2 * count(h.id) ) ) as win_roi,
	   SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   	        ELSE 0
	   	        END
	   	   ) as number_of_wins,
	   count(h.id) as number_of_races,
	   e.age
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN horses h ON (h.id = e.horse_id)
 WHERE e.age >= 9
 GROUP BY h.id, e.age
 HAVING	SUM(CASE WHEN CAST(e.official_finish as int) = 1 THEN 1
	   	        ELSE 0
	   	        END
	   	   ) > 1
 ORDER BY win_roi DESC;



