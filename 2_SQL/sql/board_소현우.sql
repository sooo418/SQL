//테이블 생성
create table board
(
	seq				number(5) 	 	primary key,
	title 			varchar2(20) 	not null,
	content 		varchar2(800) 	not null,
	regdate 		date 			default sysdate,
	cnt 			number(5),
	id 				varchar2(12)	references users
);

//게시판 글등록
insert into board(seq,title,content,regdate,cnt,id) 
values((select nvl(max(seq),0)+1 from board), '공지사항', '~~~',default,default,'admin');
insert into board(seq,title,content,id) 
values((select nvl(max(seq),0)+1 from board), '공지사항', '~~~','admin');
insert into board(seq,title,content,id) 
values((select nvl(max(seq),0)+1 from board), '연습용1', '~~~','java01');
insert into board(seq,title,content,id) 
values((select nvl(max(seq),0)+1 from board), '연습용2', '~~~','java01');
insert into board(seq,title,content,regdate,cnt,id) 
values((select nvl(max(seq),0)+1 from board), '공지사항', '~~~','19/04/04',default,'admin');

//글 수정
update board set title = '연습용' where seq=5 and id='admin';

//게시판 글삭제
delete from board where seq=5; 

//데이터검색
select * from board;

select * from board where seq=1;
//전체 등록글 수
select count(content)
from board;
//사용자별 등록글수 
select id,count(content)
from board
group by id
order by 1;
//월별개시글수
select to_char(regdate,'mm'),count(content)
from board
group by to_char(regdate,'mm')
order by 1;
//사용자별 게시글 검색
select id, seq, title, regdate
from board
where id = 'java01';
//제목으로 게시글 검색
select id, seq, title, regdate
from board
where title like '%공지사항%';

select id, seq, title, regdate
from board
where title like '%연습용%';
























