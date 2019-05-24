select * from tab;
//table 목록 확인

drop table book;
create table book(
	bookno number(5),
	title  varchar2(12),
	author varchar2(12),
	pubdate date
);
//DDL은 autocommit

commit;
rollback;
//rollback은 이전 commit까지 복구해줌
select * from book;

insert into book values(1,'java','kim',sysdate);
insert into book values(1,'java','kim',sysdate);
insert into book values(2,null,null,'19/05/15');


insert into book (bookno,title,author,pubdate)
			values(3,'sql','lee',null);
			
insert into book (bookno,title,author)
			values(4,'db','java01');



DML은 commit을 해줘야함.
commit;
rollback;

delete from book;
delete from book where title is null;
delete from book where author='kim';

alter table book add(price number(7));

insert into book values( 5, default,default,default,default);

update book set price=null;
update book set price=10,title = 'jsp' where bookno = 3;

alter table book modify(price number(7,2));

alter table book drop column price;

rename book to book2;
rename book2 to book;

delete from book;

truncate table book;
//truncate은 잘라내는 기능을 하며 롤백의 여지가 없음.

drop table book;


select * from emp;
select * from dept;

create table emp2
as select * from emp;

create table emp3
as select * from emp where deptno=10;

create table dept2
as select * from dept;

insert into dept values(50, null,null);
insert into dept2 values(50,null,null);

update dept set dname = 'EDU',loc = 'SEOUL' where deptno=50;

insert into dept values(10,'EDU', 'SEOUL');
insert into dept2 values(10,'EDU', 'SEOUL');

update dept2 set dname = 'EDU',loc = 'SEOUL' where deptno=50;

drop table book;
create table book(
	bookno number(5) CONSTRAINT scott_book_pk primary key, 
	title  varchar2(12) CONSTRAINT book_title_unique unique,
	author varchar2(12) CONSTRAINT book_author_notnull not null,
	price number(5) CONSTRAINT book_price_check check(price>0),
	pubdate date default sysdate
);

commit;
rollback;
select * from book;

insert into book  values(1,'c','mil',9000,'08,10,11');
insert into book  values(2,'c++','fefe',9000,'08,10,11');
insert into book  values(3,'c#','fefe',9000,'08,10,11');
insert into book  values(4,'java','mil',9100,'08,10,11');
insert into book(bookno,title,author,price)  values(5,'jsp','jimmy',9500);

select CONSTRAINT_name from user_cons_columns;
//제약조건 출력

select CONSTRAINT_name
from user_cons_columns
where table_name='BOOK';

drop table book;
purge recyclebin;
//휴지통 비우기
drop table book cascade CONSTRAINT;
//book테이블을 다른 계정에서 사용중일 때 강제로 삭제 시키는 명령어.

drop table book;
create table book(
	bookno number(5) primary key, 
	title  varchar2(12) unique,
	author varchar2(12) not null,
	price number(5) check(price>0),
	pubdate date default sysdate
);

insert into book(bookno,title,author,price) values(5,'java 5','mil',7000);
select * from book;

drop table book;
create table book(
	bookno number(5) , 
	title  varchar2(12) unique,
	author varchar2(12) ,
	price number(5) check(price>0),
	pubdate date default sysdate
);

alter table book add CONSTRAINT book_bookno_pk primary key(bookno);
alter table book drop CONSTRAINT book_bookno_pk;

drop table dept2;

create table dept2
	as select * from dept;

	//dept2 테이블에 deptno컬럼에 pk설정
	//emp2 테이블에 empno컬럽에 pk설정
	
alter table dept2 add CONSTRAINT dept2_deptno_pk primary key(deptno);
alter table emp2 add CONSTRAINT emp2_empno_pk primary key(empno);

	//emp2 테이블에  mgr 컬럼에 fk설정
alter table emp2 add CONSTRAINT emp2_mgr_fk foreign key(deptno) references dept2;
alter table emp2 add foreign key(deptno) references dept2;

select ename,dname,sal,grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join SALGRADE s
on sal between losal and hisal;

create or replace view emp_detail
as select ename,dname,sal,grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join SALGRADE s
on sal between losal and hisal;

select * from emp_detail;

update emp set sal = sal*1.1 where deptno=10;


create sequence bookno;

drop sequence bookno;

insert into book(bookno, title, price) 
values(bookno.nextval,'SQL3',7000);

select bookno.currval from dual;

insert into book(bookno, title, price) 
values((select nvl(max(bookno),0)+1 from book),'spring',7000);

delete from book;

set autotrace on;

create index book_title on book(title);
drop index book_title;







