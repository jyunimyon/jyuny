select distinct ������,�帣 from singer si, song so where si.������ȣ=so.������ȣ and ���ε༭ in 'E';

select ������, �帣, ��ǥ�� from singer si, (select ������ȣ from song s,
(select distinct su.������ȣ from (select ������ȣ, sum(����Ƚ��) su from listen group by ������ȣhaving sum(����Ƚ��)>=100) su, (select ������ȣ, count(�����̵�) co from listen group by ������ȣ having count(�����̵�)<=4) co where su.������ȣ=co.������ȣ) d where s.������ȣ=d.������ȣ) di where di.������ȣ=si.������ȣ;

select ���ε༭,
sum(decode(substr(so.�߸�����,1,3),'198',1,0 )) in_1980,
sum(decode(substr(so.�߸�����,1,3),'199',1,0 )) in_1990,
sum(decode(substr(so.�߸�����,1,3),'200',1,0 )) in_2000,
sum(decode(substr(so.�߸�����,1,3),'201',1,0 )) in_2010,
sum(decode(substr(so.�߸�����,1,3),'202',1,0 )) in_2020 
from song so group by ���ε༭ order by ���ε༭;

select distinct ������ȣ,���� from song where ������ȣ in (select ������ȣ from listen,customer where listen.�����̵�=customer.�����̵� and ��ȣ�����帣='����');

select jo1.�帣,����,������,jo2.��ü_����Ƚ�� from (select sum(����Ƚ��) ��_����Ƚ��,����,�帣,������ from( select ������,����,�帣,�����̵�,����Ƚ�� from
singer si,song so,listen li where si.������ȣ=so.������ȣ and so.������ȣ=li.������ȣ order by �����̵�) group by ����,�帣,������) jo1,
(select max(��_����Ƚ��) ��ü_����Ƚ��,�帣 from( select sum(����Ƚ��) ��_����Ƚ��,����,�帣,������ from( select ������,����,�帣,�����̵�,����Ƚ�� from
singer si,song so,listen li where si.������ȣ=so.������ȣ and so.������ȣ=li.������ȣ order by �����̵�) group by ����,�帣,������) 
group by �帣) jo2 where jo2.��ü_����Ƚ��=jo1.��_����Ƚ�� and jo1.�帣=jo2.�帣 order by jo2.��ü_����Ƚ�� desc;

select ���ε༭, count(����) from ( SELECT ������ȣ,����,����,���ε༭ FROM song s where s.���� in ( select min(����) from song group by ������ȣ) order by ����) group by ���ε༭ order by 2;

SELECT �����̵�, ��_��Ʈ����_��,
    CASE
        WHEN ��_��Ʈ����_�� >=500 THEN 'MVIP'
        WHEN ��_��Ʈ����_�� >=400 THEN 'VIP'
        WHEN ��_��Ʈ����_�� >=300 THEN 'GOLD'
        WHEN ��_��Ʈ����_�� >=200 THEN 'SILVER'
        ELSE 'USER'
    END AS ���,
    CASE
        WHEN ��_��Ʈ����_�� >=500 THEN '�̿��_���׷��̵�'
        WHEN ��_��Ʈ����_�� >=400 THEN '�̿��_���Ῥ��_2����'
        WHEN ��_��Ʈ����_�� >=300 THEN 'MP3_�̿�_20ȸ'
        WHEN ��_��Ʈ����_�� >=200 THEN 'MP3_�̿�_10ȸ'
        ELSE '����'
    END AS ���󳻿�
FROM (select �����̵�,sum(����Ƚ��) ��_��Ʈ����_�� from listen group by �����̵�)
WHERE ��_��Ʈ����_��>=100 ORDER BY ��_��Ʈ����_��;

select sum(DECODE(l.����ð���,'����',1,0)) ����, sum(DECODE(l.����ð���,'����',1,0)) ����, sum(DECODE(l.����ð���,'����',1,0)) ����, sum(DECODE(l.����ð���,'����',1,0)) ����, count(*) ���� FROM LISTEN l;

select round(sum(DECODE(l.����ð���,'����',1,0))/count(*)*100,1) ����, round(sum(DECODE(l.����ð���,'����',1,0))/count(*)*100,1) ����, round(sum(DECODE(l.����ð���,'����',1,0))/count(*)*100,1) ����, round(sum(DECODE(l.����ð���,'����',1,0))/count(*)*100,1) ����, 100 ��ü_�ۼ�Ʈ FROM LISTEN l;

select ����,st.�̿��,����, case when cu.�̿�� like '%Ŭ��' and ���Ź��!='īī������' then ����*1.2 when cu.�̿�� like '%Ŭ��' and ���Ź��='īī������' then ����*1.1 else ���� end as �λ�from streaming_pass st,customer cu where st.�̿��=cu.�̿�� order by �λ�;