1. джойны (не только перечислить виды, но и сказать, например, как пишутся запросы с джойнами)
	inner join
	left/right/full outer join
	cross join
2. связи (привести примеры, как они реализуются)
	1:n
	n:1
	m:n
	

--	1:n
--	n:1

sID | 	Sex
1		m
2		f

hID | 	sID
mp1		1
mp2		1
mp3 	2

3. ключи (для чего используются)
http://www.postgresql.org/docs/9.3/static/ddl-constraints.html
	primary key
	unique keys
	check constraint
	not null/null
	foreign keys - integrity constraint

4. индексы (что это такое и для чего используются)
	clustered index - сортирует данные
	non-clustered index
 indices may slow performance!

5. null

1*null = null
 sum(null)=null
sum(1,2,null)=3 sql ignores null
http://stackoverflow.com/questions/17511567/why-sumnull-is-not-0-in-oracle

 6. удаление дубликатов (как искать дубликаты?)
почитать про аналитические функции (какие есть, как пишутся в запросах)

num, num2
1
2
2
3

count(num) vs count(distinct num)
select num from t1 group by num having count(num)>1 
select num, num2, 
count(*) over (partition by num) duplicates, 
count(*) over (partition by num2) from t1


select 
"item", "total", "month", "year", 
sum("total") over (partition by "month"),
sum("total") over (partition by "year") 
from t1

select "item", "total", "month", sum_total from t1 inner join 
	(select sum("total") as sum_total, "month" from t1) t2 on t1.month=t2.month
	inner join 
	(select sum("total") as sum_total, "year" from t1) t3 on t1.year=t3.year

http://www.postgresql.org/docs/9.2/static/functions-window.html

rank(total) over (partition by month)
lag(total) 
row_number() over (partition by month order by total desc)



7. view  (что это такое и для чего используются)

	a. simplify query
	b. restrict access

https://en.wikipedia.org/wiki/View_(SQL):
	Views can represent a subset of the data contained in a table. Consequently, a view can limit the degree of exposure of the underlying tables to the outer world: a given user may have permission to query the view, while denied access to the rest of the base table.
	Views can join and simplify multiple tables into a single virtual table.
	Views can act as aggregated tables, where the database engine aggregates data (sum, average, etc.) and presents the calculated results as part of the data.
	Views can hide the complexity of data. For example, a view could appear as Sales2000 or Sales2001, transparently partitioning the actual underlying table.
	Views take very little space to store; the database contains only the definition of a view, not a copy of all the data that it presents.
	Depending on the SQL engine used, views can provide extra security.

	create or replace view "Students_BSEU" as 
		select * from students where university='BSEU';

	grant select on Students_BSEU to Shmarla;

	select * from Students_BSEU === select * from students where university='BSEU'

	!if we define view as join, and DELETE from view, data will NOT be deleted from both tables!
	create or replace view "Students_BSEU_apply" as 
		select * from students s1 
						inner join apply a1 
						on s1.sID=a1.sID where university='BSEU';

		delete from Students_BSEU_apply where a1.job='Assurance'; ==> ERROR

	materialised view: a way to increase performance 
	materialised view = usual view + indices => constraints! cannot update without rebuilding index


8. нормализация
https://en.wikipedia.org/wiki/Database_normalization
reduce data redundancy (избыточность)

9. модели организации данных
http://smiroleg.h12.ru/kurs/access_modeli.html

10. выражения SQL, их порядок в запросах (select from where group by having order by - syntax)
FROM
ON
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY - execution

11. курсор
кинуть пример по курсору

12. триггеры (когда вызываются?)
http://blog.sqlauthority.com/2008/01/15/sql-server-what-is-dml-ddl-dcl-and-tcl-introduction-and-examples/

13. подзапрос  - что это такое и как пишется
select * from (select * from ) as 


14. что такое хранимая процедура?
 набор инструкций к базе данных, которые скомпилированы заранее (т.е. проверены на выполняемость единожды)
 которые позволяют программировать определенные действия

 http://stackoverflow.com/questions/1179758/function-vs-stored-procedure-in-sql-server