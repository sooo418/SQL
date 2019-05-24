문제1. Query 문장을 작성하십시오
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하시오.

select e.employee_id 사번,e.first_name 이름,department_name 부서명,m.first_name 매니저이름
from employees e join departments d
on e.manager_id = d.manager_id
join employees m
on e.employee_id = m.manager_id;

문제2. 자신의 매니저보다 연봉(salary)을 많이 받는 직원들의 성(last_name)과 연봉(salary)을 출력하시오.

select e.last_name 성,e.salary 연봉
from employees e join employees m
on e.manager_id = m.employee_id and e.salary>m.salary;

문제3. 업무명(job_title)이 ‘Sales Representative’인 직원 중에서 연봉(salary)이 9,000 이상, 10,000 이하인 
직원들의 이름(first_name), 성(last_name)과 연봉(salary)을 출력하시오.

select first_name 이름, last_name 성, salary 연봉
from employees e join jobs j
on e.job_id =(select job_id from jobs where job_title='Sales Representative')
and e.salary between 9000 and 10000;

문제4. Query 문장을 작성하십시오. 
 자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번(employee_id), 성(last_name)과 채용일(hire_date)을 조회하라.
select e.employee_id 사번,e.last_name 성,e.hire_date 채용일
from employees e join employees m
on e.employee_id=m.manager_id and e.hire_date < m.hire_date;

문제5. Query 문장을 작성하십시오. 

각 업무(job_title)가 어느 부서(department_name)에서 수행되는지 조회하는 SQL 쿼리문을 작성하세요.
(단, 수행하지 않는 업무는 표시하지 않고 중복되는 정보는 하나만 표시합니다.)
출력: JOB_TITLE | DEPARTMENT_NAME

select distinct j.job_title, d.department_name
from employees e join jobs j
on e.job_id=j.job_id 
join departments d
on e.department_id=d.department_id
order by 1;

6. 월 별 입사자 수를 조회하는 SQL 쿼리문을 작성하세요. 월 순으로 정렬하세요. 
출력: 월 | 입사자수

select to_char(hire_date,'mm') 월, to_char(count(*)) 입사자수
from employees
group by to_char(hire_date,'mm')
order by 1;

문제7. 08년도에 입사한 직원의 이름(first_name), 입사일(hire_date), 관리자사번(employee_id), 
관리자 이름(first_name)을 조회합니다. 단, 관리자가 없는 사원정보도 출력결과에 포함되어야 합니다..  

select e.first_name 직원이름, e.hire_date 입사일, m.employee_id 관리자사번, m.first_name 관리자이름
from employees e left outer join employees m
on e.manager_id = m.employee_id
where to_char(e.hire_date,'yy') = '08'
or to_char(e.hire_date,'yy') = '08' and e.manager_id is null;
order by 2;

문제8. ‘Sales’부서에 속한 직원의 이름(first_name), 급여(salary), 부서이름(department_name)을 조회하시오. 

select e.first_name 이름, e.salary 급여, d.department_name 부서이름
from employees e join departments d
on e.department_id = (select department_id from departments where department_name='Sales')
and d.department_id = (select department_id from departments where department_name='Sales');

문제9. 2004년 입사한(hire_date) 직원들의 사번(employee_id), 이름(first_name), 성(last_name), 
부서명(department_name)을 조회합니다. 이때, 부서에 배치되지 않은 직원의 경우, ‘<NOT ASSIGNED>’로 보여줍니다.
 
select e.employee_id 사번, hire_date ,e.first_name 이름, e.last_name 성, nvl(d.department_name,'<NOT ASSIGNED>') 부서명
from employees e left outer join departments d
on e.department_id=d.department_id
where to_char(e.hire_date,'yyyy')='2004'
or to_char(e.hire_date,'yyyy')='2004' and e.department_id is null;

문제10. 2005년대에 입사한 직원의 이름(first_name), 입사일(hire_date), 관리자사번(employee_id), 
관리자 이름(first_name)을 조회합니다. 단, 관리자가 없는 사원정보도 출력결과에 포함되어야 합니다.. 

select e.first_name 직원의이름, e.hire_date 입사일, m.employee_id 관리자사번, m.first_name 관리자이름
from employees e left outer join employees m 
on e.manager_id = m.employee_id
where to_char(e.hire_date,'YYYY') = '2005'
or to_char(e.hire_date,'YYYY') = '2005' and e.manager_id is null;

























