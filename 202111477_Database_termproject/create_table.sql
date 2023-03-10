create table enter(
    ȸ��� varchar2(30) primary key,
    ��ǥ�� varchar2(20),
    ȸ����ȭ varchar2(20)
);
create table singer(
    ������ȣ number(4) primary key,
    ������ varchar2(30) not null,
    ��ǥ�� varchar2(30) not null,
    �帣 varchar(30) not null,
    ȸ��� varchar2(30),
    foreign key (ȸ���) references enter(ȸ���)
);
create table song(
    ������ȣ number(4) primary key,
    ���� varchar2(30) not null,
    ���ε༭ varchar2(30),
    ���� number(3) check(����>=1 and ����<=100),
    ������ȣ number(4),
    �߸����� varchar2(10),
    foreign key (������ȣ) references singer(������ȣ)
);
create table streaming_pass(
    �̿�� varchar2(30) primary key,
    �����ֱ� number(2),
    ���� number(10) 
);
create table customer(
    �����̵� varchar2(30) primary key,
    ���� varchar2(30),
    ���ɴ� number(4),
    ��ȣ�����帣 varchar2(30),
    �̿�� varchar2(30),
    �������� varchar2(10),
    ���Ź�� varchar2(30),
    foreign key(�̿��) REFERENCES streaming_pass(�̿��)
);
create table listen(
    ������ȣ number(4),
    �����̵� varchar2(30),
    ����Ƚ�� number(4) check(����Ƚ��>=0 and ����Ƚ��<=1000),
    ����ð��� varchar(20),
    foreign key(������ȣ) references song(������ȣ),
    foreign key(�����̵�) references customer(�����̵�),
    constraint listen_pk primary key(������ȣ,�����̵�)
);