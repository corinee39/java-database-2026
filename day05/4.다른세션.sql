SELECT * FROM dept_tcl;

update dept_tcl
   set loc = 'SEOUL'
 where deptno = 50;

 insert into dept_tcl (deptno, dname, loc)
 values (90, 'TEST', 'TEST');