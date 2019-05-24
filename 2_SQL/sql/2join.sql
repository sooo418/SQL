select
from
where
order by
단일 SQL문 실행 순서
from -> where -> group by -> having -> order by -> select(projection)

select * from emp;
select ename,hiredate,to_char(hiredate,'yy') 
from emp;
select ename,hiredate,substr(hiredate,1,2) 
from emp;
select lower(ename),hiredate,substr(hiredate,1,2) 
from emp;

select round(55.55),trunc(55.55)
from dual;

select round(sal), trunc(sal) from emp;

select * from emp order by deptno;

select ename,deptno,sal,sal*1.1	
from emp 
where deptno=10;

select ename,deptno,sal,sal*1.2	
from emp 
where deptno=20;

select ename,deptno,sal,sal*1.3	
from emp 
where deptno=30;

select ename,deptno,sal,decode(deptno,10,sal*1.1,
										20,sal*1.2,
											sal) as 수당
from emp;

select ename,nvl(to_char(mgr),'X')   
from emp;
		//nvl메소드는 자동 형 변환이 안되서 명시해줘야함.

select ename,nvl2(mgr,'O', 'X') 
from emp;
		//nvl메소드는 자동 형 변환이 되기 때문에 명시하지 않아도 됨.
		
select * from dept;
select * from emp;

select * 
from dept,emp
where emp.deptno = dept.deptno;

select ename,job,deptno,dname,loc
from dept,emp
where emp.deptno = dept.deptno;

select ename,job,emp.deptno,dname,loc
from dept,emp
where emp.deptno = dept.deptno;

select ename,job,d.deptno,dname,loc
from dept d,emp e
where e.deptno = d.deptno;

안시 표준  :  ,  =>  join 	 where => on

select ename,job,d.deptno,dname,loc
from emp e join dept d
on e.deptno = d.deptno;

select ename,job,d.deptno,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno;

select ename,job,dname,sal
from emp e inner join dept d
on e.deptno = d.deptno
where sal>2000;

select ename,job,dname,sal
from emp e inner join dept d
on e.deptno = d.deptno and sal>2000;

select ename,job,d.deptno,dname,loc
from dept d,emp e
where e.deptno(+) = d.deptno;
		//오라클 전용방식으로 아우터 조인이 연산됨.
		
select ename,job,d.deptno,dname,loc
from emp e right outer join dept d
on e.deptno=d.deptno;
		//아우터 조인의 안씨 표준
		
select * from SALGRADE;

select ename,sal,grade
from emp,SALGRADE
where sal between losal and hisal;

select ename,sal,grade
from emp e join SALGRADE s
on sal between losal and hisal;
//non_equi_join

select e.ename 사원이름,m.ename 상사이름
from emp e,emp m
where e.mgr=m.empno;
//equi_join

select e.ename 사원이름,nvl(m.ename,'<<CEO>>') 상사이름
from emp e left outer join emp m
on e.mgr=m.empno;

상사보다 입사일자가 빠른사원 alter
select e.ename 사원이름,e.hiredate,m.ename 상사이름,m.hiredate
from emp e left outer join emp m
on e.mgr=m.empno 
where e.hiredate<m.hiredate;

상사보다 급여가 많은 사원 목록
select e.ename 사원이름,e.sal,m.ename 상사이름,m.sal
from emp e left outer join emp m
on e.mgr=m.empno
where e.sal>m.sal;

select e.ename 사원이름,e.sal,m.ename 상사이름,m.sal
from emp e , emp m
where e.mgr=m.empno and e.sal>m.sal;

집계함수
select ename,round(sal) from emp;
select avg(sal)	from emp;
select ename,avg(sal)	from emp;                 x
//avg(sal)은 하나의 개체만 있는데 ename은 개체가12개 이기에 오류 발생.
select count(sal), count(comm),count(*),count(mgr) from emp;
//count는 행의 개수를 출력.

select count(job) from emp;
select count(distinct job) from emp;

select sum(sal), count(*),round(sum(sal)/count(*),2) 평균, 
										round(avg(sal),2) "평균  2"
from emp
where deptno=40;

select sum(sal), count(*),round(sum(sal)/count(*),2) 평균, 
										round(avg(sal),2) "평균  2"
from emp;

select deptno,sum(sal),count(*),round(sum(sal)/count(*),2) 평균
from emp
group by deptno;
//group by에 기술된 속성외에는 모두 집계함수가 적용되어야 한다.

select deptno,max(sal),min(sal),count(*),round(sum(sal)/count(*),2) 평균
from emp
group by deptno;

select e.deptno,dname,avg(sal)
from emp e,dept d
where e.deptno(+)=d.deptno
group by dname,e.deptno
order by 3;

select e.deptno,dname,avg(sal) 평균
from emp e,dept d
where e.deptno(+)=d.deptno
group by dname,e.deptno
order by 평균;

select e.deptno,dname,count(*),avg(sal) 평균
from emp e,dept d
where e.deptno(+)=d.deptno
group by dname,e.deptno
order by 평균;

select e.deptno,dname,count(*),avg(sal) 평균
from emp e,dept d
where e.deptno(+)=d.deptno and sal>2000
group by dname,e.deptno
order by 평균;

평균 급여가 2000 이상인 부서정보 출력
select e.deptno,dname,count(*),avg(sal) 평균
from emp e,dept d
where e.deptno(+)=d.deptno 
having avg(sal)>2000
group by dname,e.deptno
order by 평균;
//having절은 그룹의 조건에 집계함수를 사용할 때 사용

select ename,dname,sal,grade
from emp e,dept d,SALGRADE s
where e.deptno=d.deptno and sal between losal and hisal
order by 3;

select ename,dname,sal,grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join SALGRADE s
on sal between losal and hisal
order by 3;

select deptno, avg(sal)
from emp
group by deptno
having avg(sal)>2000;


서브쿼리
FORD 급여
select sal from emp where ename = 'FORD';
select * from emp where sal>3000;

select * 
from emp
where sal>(select sal
from emp
where ename = 'FORD');

select *
from emp
where sal < (select round(avg(sal)) from emp);

select *
from emp
where sal > (select avg(sal) from emp);

select *
from emp
where sal = (select min(sal) from emp);

select min(sal) 
from emp
group by deptno;

select *
from emp
where sal = (select min(sal) from emp group by deptno);
//조건이 =일 때 값이 하나여야만 하는데 위에 문은 값이 3개라서 오류

select *
from emp
where sal in (select max(sal) from emp group by deptno);

자신이 속한 부서의 평균보다 급여가 적은 사람 리스트
select *
from emp outer
where sal<(select avg(sal) from emp where deptno=outer.deptno);

select dept.deptno,avg(sal) from emp,dept where emp.deptno=dept.deptno group by dept.deptno;

select ename,job,sal
from emp;

select rownum,ename,job,sal
from emp
order by sal;


select rownum,ename,job,sal
from (select * from emp order by sal desc)
where rownum<4;

select rownum,ename,job,sal
from (select * from emp order by sal desc)
where rownum between 1 and 4;

select row#,ename,job,sal
from
(
	select rownum row#,ename,job,sal
	from (select * from emp order by sal desc)
)	where row# between 4 and 7;

81년도에 입사한 사람중 월급 상위 3명
select rownum,ename, job,sal
from
(
	(select *from emp where hiredate like '%81%' order by sal desc)
)	
where rownum <4;



select row#,ename,job,sal
from(
	select rownum row#, ename, job, sal
	from ( select * from emp order by sal desc)
)	where row# between 5 and 12;

select *
from emp
order by deptno,sal;

각 부서별 최고 급여를 받는 사람 리스트
select *
from emp
where (deptno, sal)
in(select deptno,max(sal) from emp group by deptno);
 //조건-> 각 부서에서 가장 급여가 높은 사람의 부서와 급여가 같은 사람의 정보를 출력
 in안에 있는 검색값 해당부서번호와 가장높은 급여가 출력되고 그 출력값을 where절 deptno와 sal값을 비교해 맞는 사람의 정보만 출력

select *
from emp
where (deptno, sal)
in(select deptno,min(sal) from emp group by deptno);

select deptno,min(sal) from emp group by deptno;







