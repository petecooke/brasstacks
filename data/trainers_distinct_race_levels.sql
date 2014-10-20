-- TRAINER DISTINCT TRACKS and RACE LEVELS

 SELECT c.track_name, rl.id as race_level_id, rl.*, count(t.id)
  FROM charts c
 INNER JOIN races r ON (r.chart_id = c.id)
 INNER JOIN race_levels rl ON (rl.id = r.race_level_id)
 INNER JOIN entries e ON (e.race_id = r.id)
 INNER JOIN trainers t ON (t.id = e.trainer_id)
 --WHERE t.last_name = 'Clement'
 GROUP BY c.track_name, rl.id;