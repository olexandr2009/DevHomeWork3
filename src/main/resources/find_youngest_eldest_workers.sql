select concat('YOUNGEST','') "TYPE", worker_name ,birthday  from worker
where birthday = (select max(birthday) from worker)
union all
select concat('OLDEST','') "TYPE", worker_name ,birthday  from worker
where birthday = (select min(birthday) from worker);