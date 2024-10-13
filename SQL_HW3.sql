CREATE DATABASE shop;

USE shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
             BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);

select *from customers;
select *from orders;
select *from sellers;


-- 1. Вывести имя продавца и сумму его заказов.
select t1.sname, t2.amt
from sellers t1
join orders t2
on t1.sell_id = t2.sell_id;

-- 2.Вывести имя клиента и сумму его заказов.
select t1.cname, t2.amt
from customers t1
join orders t2
on t1.cust_id = t2.cust_id;

-- 3.Вывести всех продавцов, включая тех, у кого нет заказов.
select t1.sname, t2.amt
from sellers t1
left join orders t2
on t1.sell_id = t2.sell_id; 

-- 4.Вывести все заказы, включая информацию о продавцах, даже если не все продавцы сделали заказы.
select t1.order_id, t2.sname
from orders t1
left join sellers t2
on t1.sell_id = t2.sell_id; 

-- 5.Вывести продавцов и их начальников.
select t1.sname as seller, t2.sname as boss
from sellers t1
join sellers t2
on t2.sell_id = t1.boss_id;

-- 6.Найти всех клиентов из города "Москва" и суммы их заказов.
select t1.cname, t2.amt
from customers t1
join orders t2
on t1.cust_id = t2.cust_id
where t1.city in ('Москва');


-- 7. Найти всех продавцов из города "Сочи" и их заказы, если таковые имеются.
select t1.sname, SUM(t2.amt)
from sellers t1
join orders t2
on t1.sell_id = t2.sell_id
where t1.city in ('Сочи')
GROUP BY t1.sname;


-- 8.Найти всех клиентов с заказами выше 5000 и информацию о продавцах, которые их обслуживали.
select t1.cname, t3.sname, t3.city, t3.comm
from customers t1
join orders t2
on t1.cust_id = t2.cust_id
join sellers t3
on t2.sell_id = t3.sell_id
where t2.amt > 5000;

-- 9.Найти всех продавцов, у которых есть начальники.
select sname
from sellers
where boss_id is not null;

-- 10.Вывести пары покупателей и обслуживших их продавцов из одного города.
select t1.cname, t2.sname
from customers t1
join sellers t2
on t1.city = t2.city;



