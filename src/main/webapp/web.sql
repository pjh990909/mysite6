create table users(
no int auto_increment 		primary key,
id varchar(20) unique       not null, 
password varchar(20)  not null,
name varchar(20),
gender varchar(10)
);

INSERT INTO users
VALUES (null,'pjh990909', 'qwer', '박종희','남');

select *
from users;

select no,
	   name
from users
where id = 'pjh'
and password='123d';

update users
set password = '1199' ,
	name = '종희',
    gender = 'male'
where no = 1 ;

select id,
	   password,
       name,
       gender
from users
where no = '1';

drop table users;

create table member(
no int auto_increment primary key,
name varchar(80),
password varchar(20),
content varchar(2000),
reg_date datetime
);

INSERT INTO member
VALUES (null,'박종희', '12345', '집가고 싶다 학원오기 싫다 공부하기 싫다',now());


select *
from member;


select no,
	   name,
       password,
       content,
       reg_date
from member;

delete from member 
where no = '5';

drop table member;

create  table rboard(
   no integer auto_increment primary key,
    title varchar(500) not null,
    content varchar(4000),
    hit integer,
    reg_date date not null,
    user_no INTEGER not null,
    group_no integer,
    order_no integer,
    depth integer,
    CONSTRAINT num FOREIGN KEY (user_no)
   REFERENCES users(no)
);
INSERT INTO rboard
VALUES (null,'제에목', '내용물',111,now(),2,4,1,0);

select *
from rboard;

drop table rboard;

select b.no,
	   u.name,
       b.group_no,
       b.order_no,
       b.title,
       b.depth
from rboard b,users u
where b.user_no = u.no
order by group_no DESC, order_no ASC;

update rboard
set order_no = order_no+1
where group_no = 2
and depth = 1;

create  table board(
    no integer auto_increment primary key,
    title varchar(500) not null,
    content varchar(4000),
    hit integer,
    reg_date date not null,
    user_no INTEGER not null,
    CONSTRAINT user_no FOREIGN KEY (user_no)
   REFERENCES users(no)
);

INSERT INTO board
VALUES (null,'제목', '내용물',1119,now(),2);

select *
from board;

drop table board;

select u.name,
       b.hit,
       b.reg_date,
       b.title,
       b.content
from board b,users u
where b.user_no = u.no
and b.no = 1;

create  table gallery(
    no integer auto_increment primary key,
    user_no INTEGER,
    content varchar(1000) ,
    filePath varchar(500),
    orgName varchar(200),
    saveName varchar(500),
    fileSize integer,
    CONSTRAINT no FOREIGN KEY (user_no)
   REFERENCES users(no)
);

INSERT INTO gallery
VALUES (null,1, '내용물','111','312ad','2',4);

select *
from gallery;

drop table gallery;

select u.name,
       g.filePath,
       g.orgName,
       g.saveName,
       g.fileSize
from gallery g,users u
where g.user_no = u.no;
