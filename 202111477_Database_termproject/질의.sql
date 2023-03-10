select distinct 가수명,장르 from singer si, song so where si.가수번호=so.가수번호 and 프로듀서 in 'E';

select 가수명, 장르, 대표곡 from singer si, (select 가수번호 from song s,
(select distinct su.음원번호 from (select 음원번호, sum(감상횟수) su from listen group by 음원번호having sum(감상횟수)>=100) su, (select 음원번호, count(고객아이디) co from listen group by 음원번호 having count(고객아이디)<=4) co where su.음원번호=co.음원번호) d where s.음원번호=d.음원번호) di where di.가수번호=si.가수번호;

select 프로듀서,
sum(decode(substr(so.발매일자,1,3),'198',1,0 )) in_1980,
sum(decode(substr(so.발매일자,1,3),'199',1,0 )) in_1990,
sum(decode(substr(so.발매일자,1,3),'200',1,0 )) in_2000,
sum(decode(substr(so.발매일자,1,3),'201',1,0 )) in_2010,
sum(decode(substr(so.발매일자,1,3),'202',1,0 )) in_2020 
from song so group by 프로듀서 order by 프로듀서;

select distinct 음원번호,제목 from song where 음원번호 in (select 음원번호 from listen,customer where listen.고객아이디=customer.고객아이디 and 선호음악장르='힙합');

select jo1.장르,제목,가수명,jo2.전체_감상횟수 from (select sum(감상횟수) 총_감상횟수,제목,장르,가수명 from( select 가수명,제목,장르,고객아이디,감상횟수 from
singer si,song so,listen li where si.가수번호=so.가수번호 and so.음원번호=li.음원번호 order by 고객아이디) group by 제목,장르,가수명) jo1,
(select max(총_감상횟수) 전체_감상횟수,장르 from( select sum(감상횟수) 총_감상횟수,제목,장르,가수명 from( select 가수명,제목,장르,고객아이디,감상횟수 from
singer si,song so,listen li where si.가수번호=so.가수번호 and so.음원번호=li.음원번호 order by 고객아이디) group by 제목,장르,가수명) 
group by 장르) jo2 where jo2.전체_감상횟수=jo1.총_감상횟수 and jo1.장르=jo2.장르 order by jo2.전체_감상횟수 desc;

select 프로듀서, count(제목) from ( SELECT 가수번호,제목,순위,프로듀서 FROM song s where s.순위 in ( select min(순위) from song group by 가수번호) order by 순위) group by 프로듀서 order by 2;

SELECT 고객아이디, 총_스트리밍_수,
    CASE
        WHEN 총_스트리밍_수 >=500 THEN 'MVIP'
        WHEN 총_스트리밍_수 >=400 THEN 'VIP'
        WHEN 총_스트리밍_수 >=300 THEN 'GOLD'
        WHEN 총_스트리밍_수 >=200 THEN 'SILVER'
        ELSE 'USER'
    END AS 등급,
    CASE
        WHEN 총_스트리밍_수 >=500 THEN '이용권_업그레이드'
        WHEN 총_스트리밍_수 >=400 THEN '이용권_무료연장_2개월'
        WHEN 총_스트리밍_수 >=300 THEN 'MP3_이용_20회'
        WHEN 총_스트리밍_수 >=200 THEN 'MP3_이용_10회'
        ELSE '없음'
    END AS 보상내용
FROM (select 고객아이디,sum(감상횟수) 총_스트리밍_수 from listen group by 고객아이디)
WHERE 총_스트리밍_수>=100 ORDER BY 총_스트리밍_수;

select sum(DECODE(l.감상시간대,'오전',1,0)) 오전, sum(DECODE(l.감상시간대,'오후',1,0)) 오후, sum(DECODE(l.감상시간대,'저녁',1,0)) 저녁, sum(DECODE(l.감상시간대,'새벽',1,0)) 새벽, count(*) 총합 FROM LISTEN l;

select round(sum(DECODE(l.감상시간대,'오전',1,0))/count(*)*100,1) 오전, round(sum(DECODE(l.감상시간대,'오후',1,0))/count(*)*100,1) 오후, round(sum(DECODE(l.감상시간대,'저녁',1,0))/count(*)*100,1) 저녁, round(sum(DECODE(l.감상시간대,'새벽',1,0))/count(*)*100,1) 새벽, 100 전체_퍼센트 FROM LISTEN l;

select 고객명,st.이용권,가격, case when cu.이용권 like '%클럽' and 구매방식!='카카오페이' then 가격*1.2 when cu.이용권 like '%클럽' and 구매방식='카카오페이' then 가격*1.1 else 가격 end as 인상from streaming_pass st,customer cu where st.이용권=cu.이용권 order by 인상;