//테이블 생성
drop table board;
drop table users;
create table users 
(
	id 			varchar2(12) 	primary key,
	password 	varchar2(20) 	not null,
	name 		varchar2(12) 	not null, 
	role 		varchar2(12) 	default 'user'
);
//회원등록
insert into users(id,password,name) values('java01','1234','홍길동');
insert into users(id,password,name) values('java02','1234','아무개');

insert into users(id,password,name,role) 
	values('admin','1234','damin','admin');

//회원정보수정
update users set password = '0000' where id='java02' and name='아무개';

	
//로그인
select *
from users
where id = 'java01' and password = '1234';

select *
from users
where id = 'java02' and password = '0000';

select *
from users
where id = 'admin' and password = '1234';


