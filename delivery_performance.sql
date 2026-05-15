
--1. On-time rate by route — top 3 and bottom 3

WITH route_counts AS (SELECT r.route_id,
        r.origin_city,
        r.destination_city,
        COUNT(event_id) AS total_count,
        COUNT(*) FILTER (WHERE on_time_flag = true)  AS on_time_count,
        COUNT(*) FILTER (WHERE on_time_flag = false) AS late_count
FROM delivery_events de JOIN loads l ON de.load_id = l.load_id JOIN routes r ON l.route_id = r.route_id
GROUP BY r.route_id, r.origin_city, r.destination_city)


SELECT route_id,
        origin_city,
        destination_city,
        on_time_count,
        late_count,
       ROUND((on_time_count ::numeric /total_count * 100), 2) AS on_time_pctg
FROM route_counts
ORDER BY on_time_pctg DESC



        