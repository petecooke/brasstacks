
-- HORSES WITH WINS
SELECT h.id, 
	   h.horse_name, 
	   count(e.official_finish) as count
  FROM horses h 
  LEFT OUTER JOIN entries e ON (    h.id = e.horse_id
    	                        AND e.official_finish = '1'
    	                        )
 GROUP BY h.id
 ORDER BY count DESC, h.horse_name;



================================================================

-- HORSES WITH WINS
SELECT h.id, h.horse_name, count(e.official_finish) as count
  FROM horses h
 INNER JOIN entries e ON (e.horse_id = h.id)
 WHERE e.official_finish = '1'
 GROUP BY h.id
 ORDER BY count DESC, h.horse_name;
-- 76 rows 

================================================================




