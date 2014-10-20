-- TRAINER DISTINCT TRACKS

  SELECT t.id, c.track_name--, count(t.id) as count
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN trainers t ON (t.id = e.trainer_id)
 --WHERE t.last_name = 'Clement'
 GROUP BY c.track_name, t.id;
 -- ORDER BY t.last_name, t.first_name, win_roi DESC, rl.class_rating DESC;











   SELECT t.last_name, t.suffix, t.first_name, t.middle_name,
	   ( sum(e.win_payoff) - (2 * count(t.id)) / (2 * count(t.id) ) ) as win_roi, 
	   c.track_name, 
	   rl.race_type, rl.restriction, rl.distance, rl.dist_unit, rl.surface, count(t.id) as count

 SELECT DISTINCT c.track_name	   
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN trainers t ON (t.id = e.trainer_id)
 --WHERE t.last_name = 'Clement'
 GROUP BY c.track_name, rl.id, t.id
 HAVING ( sum(e.win_payoff) - (2 * count(t.id)) / (2 * count(t.id) ) ) >= 5;


 ORDER BY t.last_name, t.first_name, win_roi DESC, rl.class_rating DESC;



 SELECT DISTINCT c.track_name
   FROM charts c;
