Best way for finding second max salary:
***************************************
SELECT EMPNO,SAL,DEPTNO FROM (SELECT EMPNO,SAL,DEPTNO,dense_rank() over ( ORDER BY SAL ASC) r FROM EMP ) WHERE r=1

Best way for finding second max salary IN EACH Department:
**********************************************************

SELECT EMPNO,SAL,DEPTNO FROM (SELECT EMPNO,SAL,DEPTNO,dense_rank() over ( PARTITION BY deptno ORDER BY SAL ASC) r FROM EMP ) WHERE r=1


Alternate ways : But not efficient.
***********************************

SELECT * FROM EMP e WHERE 5 = (SELECT COUNT(DISTINCT(sal)) FROM EMP WHERE e.sal >= sal)


SELECT * FROM(SELECT ROWNUM AS r,sal FROM(SELECT ROWNUM,sal FROM EMP ORDER BY sal DESC))WHERE r=3
 

SELECT LEVEL, MAX(sal) FROM EMP WHERE LEVEL=5 CONNECT BY PRIOR sal > sal GROUP BY LEVEL