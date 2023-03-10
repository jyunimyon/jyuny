create table enter(
    회사명 varchar2(30) primary key,
    대표명 varchar2(20),
    회사전화 varchar2(20)
);
create table singer(
    가수번호 number(4) primary key,
    가수명 varchar2(30) not null,
    대표곡 varchar2(30) not null,
    장르 varchar(30) not null,
    회사명 varchar2(30),
    foreign key (회사명) references enter(회사명)
);
create table song(
    음원번호 number(4) primary key,
    제목 varchar2(30) not null,
    프로듀서 varchar2(30),
    순위 number(3) check(순위>=1 and 순위<=100),
    가수번호 number(4),
    발매일자 varchar2(10),
    foreign key (가수번호) references singer(가수번호)
);
create table streaming_pass(
    이용권 varchar2(30) primary key,
    결제주기 number(2),
    가격 number(10) 
);
create table customer(
    고객아이디 varchar2(30) primary key,
    고객명 varchar2(30),
    연령대 number(4),
    선호음악장르 varchar2(30),
    이용권 varchar2(30),
    구매일자 varchar2(10),
    구매방식 varchar2(30),
    foreign key(이용권) REFERENCES streaming_pass(이용권)
);
create table listen(
    음원번호 number(4),
    고객아이디 varchar2(30),
    감상횟수 number(4) check(감상횟수>=0 and 감상횟수<=1000),
    감상시간대 varchar(20),
    foreign key(음원번호) references song(음원번호),
    foreign key(고객아이디) references customer(고객아이디),
    constraint listen_pk primary key(음원번호,고객아이디)
);