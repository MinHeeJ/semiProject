--=============================
-- semi계정 생성 @관리자
--=============================
alter session set "_oracle_script" = true;

create user semi
identified by semi
default tablespace users;

grant connect, resource to semi;

alter user semi quota unlimited on users;

--===============================
-- semi 계정
--===============================
--drop user semi cascade;
create table member (
	member_id varchar2(20),
	password varchar(500) not null,
	name varchar2(50) not null,
	phone varchar2(50) not null,
	address	varchar2(500) not null,
	gender char(1),
	member_role	char(1) default 'U',
    constraints pk_member_id primary key(member_id),
    constraints ck_member_gender check(gender in ('M', 'F')),
    constraints ck_member_role check(member_role in ('U', 'A'))
);
insert into member values ('admin', 1234, '관리자', '010-1234-5678', '서울시 역삼동', 'F', 'A');
insert into member values ('honggd', 1234, '홍지디', '010-1234-5678', '서울시 역삼동', 'M', 'U');
insert into member values ('qwerty', 1234, '쿼티', '010-1122-3344', '경기도 안산시', 'F', default);
--delete from member where member_id = 'honggd';
select * from member;
--alter table member modify member_role default 'U';
--drop table member;

create table category (
	category_no	number,
	category_name varchar2(100)	not null,
    constraints pk_category_no primary key(category_no)
);
insert into category values (1, 'main');
insert into category values (2, 'veg');
insert into category values (3, 'topping');
insert into category values (4, 'sauce');
insert into category values (5, 'drink');
select * from category;
--drop table category;

create table order_tbl (
	order_no number(20),
    member_id varchar2(20),
	order_date date default sysdate,
	state varchar(40) default '주문접수완료',
    constraints pk_order_no primary key(order_no),
    constraints fk_order_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints ck_order_state check(state in ('주문접수완료', '주문처리완료'))
);
--drop table order_tbl;
--alter table order_tbl modify state varchar2(50);
--alter table order_tbl rename column memeber_id to member_id;
--alter table order_tbl drop constraints ck_order_state;
alter table order_tbl modify state varchar2(20) default '주문처리중';
alter table order_tbl drop constraints ck_order_state;
insert into order_tbl values(1, 'honggd', default, default);
insert into order_tbl values(2, 'admin', default, default);
insert into order_tbl values(3, 'admin', '2023-06-11', default);
--update order_tbl set state = '준비완료' where order_no = 2;
select * from order_tbl;
create sequence seq_order_no;
--drop sequence seq_order_no;
--insert into order_tbl values(seq_order_no.nextval, 'honggd', default, default);
--delete from order_tbl where member_id = 'honggd';

create table cart_tbl (
    cart_no number,
	product	varchar2(1000),
	member_id varchar2(20),
	count number default 1,
	price number not null,
    constraints pk_cart_no_product primary key(cart_no, product),
    constraints fk_cart_member_id foreign key(member_id) references member(member_id) on delete cascade
);
--drop table cart_tbl;
insert into cart_tbl values(1, '양상추 닭가슴살 콜라', 'honggd', 1, 5000);
insert into cart_tbl values(2, '루꼴라 연어 콜라', 'honggd', 1, 7000);
insert into cart_tbl values(4, '양파 고기 콜라', 'admin', 1, 4000);
select * from cart_tbl;
create sequence seq_cart_no;
--drop sequence seq_cart_no;
alter table cart_tbl modify product varchar2(1000);

create table board (
	board_no number,
	writer varchar2(20),
	title varchar(200) not null,
	content	varchar(1000) not null,
	reg_date date default sysdate,
    constraints pk_board_no primary key(board_no),
    constraints fk_board_writer foreign key(writer) references member(member_id)on delete cascade
);
--drop table board;

create table board_comment (
    comment_no number,
	board_no number,
	writer	varchar2(20),
	content	varchar2(1000) not null,
	comment_level number not null,
	comment_ref	number not null,
	reg_date date default sysdate,
    constraints pk_board_comment_no primary key(comment_no),
    constraints fk_board_comment_board_no foreign key(board_no) references board(board_no) on delete cascade,
    constraints fk_board_comment_writer foreign key(writer) references member(member_id) on delete cascade
);
--drop table board_comment;

create table order_detail (
	order_serial_no number,
    order_no number,
    cart_no number,
    product varchar2(1000),
    count number,
    price number,
    constraints pk_order_detail_order_serial_no primary key(order_serial_no),
    constraints fk_order_detail_order_no foreign key(order_no) references order_tbl(order_no) on delete cascade,
    constraints fk_order_detail_cart_no_product foreign key(cart_no, product) references cart_tbl(cart_no, product) on delete cascade
);
--drop table order_detail;
insert into order_detail values(1, 1, 1, '양상추 닭가슴살 콜라', 1, 5000);
insert into order_detail values(2, 1, 2, '루꼴라 연어 콜라', 1, 7000);
insert into order_detail values(4, 3, 4, '양파 고기 콜라', 1, 4000);
select * from order_detail;
alter table order_detail modify product varchar2(1000);
create sequence seq_order_serial_no;
--drop sequence seq_order_serial_no;
--select * from (select * from order_tbl t left join order_detail d on t.order_no = d.order_no) where order_date between '2023-07-01' and '2023-07-16' order by order_date;
select * from order_detail d join order_tbl t on d.order_no = t.order_no;

create table store (
	store_no number,
	store_name varchar2(30) not null,
	address	varchar2(1000) not null,
	phone varchar2(200) not null,
    constraints pk_store_no primary key(store_no),
    constraints uq_store_name unique(store_name)
);
--drop table store;
create sequence seq_store_no;
--drop sequence seq_store_no;
insert into store values(seq_store_no.nextval, '킥킥샐러드 역삼역점', '서울 강남구 강남대로94길 66 지상1층', '02-123-4567');
insert into store values(seq_store_no.nextval, '킥킥샐러드 강남역점', '서울 강남구 강남대로84길 23 1층', '02-111-2222');
select * from store;

create table ingredient (
	ingredient_no number,
	category_no	number,
	ingredient_name	varchar2(200) not null,
	calorie	number not null,
	price number not null,
    constraints pk_ingredient_no primary key(ingredient_no),
    constraints fk_ingredient_category_no foreign key(category_no) references category(category_no) on delete cascade
);
--drop table ingredient;
create sequence seq_ingredient_no;
--drop sequence seq_ingredient_no;
insert into ingredient values(seq_ingredient_no.nextval, 1, '호밀빵', 270, 2000);
insert into ingredient values(seq_ingredient_no.nextval, 1, '샐러드볼', 0, 500);
insert into ingredient values(seq_ingredient_no.nextval, 2, '양상추', 4, 500);
insert into ingredient values(seq_ingredient_no.nextval, 2, '야채믹스', 10, 700);
insert into ingredient values(seq_ingredient_no.nextval, 2, '루꼴라', 5, 1800);
insert into ingredient values(seq_ingredient_no.nextval, 2, '양파', 12, 350);
insert into ingredient values(seq_ingredient_no.nextval, 2, '치커리', 7, 600);
insert into ingredient values(seq_ingredient_no.nextval, 2, '케일', 5, 300);
insert into ingredient values(seq_ingredient_no.nextval, 2, '로메인', 8, 400);
insert into ingredient values(seq_ingredient_no.nextval, 2, '방울토마토', 5, 400);
insert into ingredient values(seq_ingredient_no.nextval, 3, '아보카도', 150, 1000);
insert into ingredient values(seq_ingredient_no.nextval, 3, '두부', 68, 700);
insert into ingredient values(seq_ingredient_no.nextval, 3, '연어', 85, 4500);
insert into ingredient values(seq_ingredient_no.nextval, 3, '부채살', 216, 5000);
insert into ingredient values(seq_ingredient_no.nextval, 3, '계란', 72, 500);
insert into ingredient values(seq_ingredient_no.nextval, 3, '리코타치즈', 120, 3000);
insert into ingredient values(seq_ingredient_no.nextval, 4, '랜치', 136, 1200);
insert into ingredient values(seq_ingredient_no.nextval, 4, '스윗칠리', 40, 1200);
insert into ingredient values(seq_ingredient_no.nextval, 4, '홀스래디쉬', 80, 1200);
insert into ingredient values(seq_ingredient_no.nextval, 4, '참깨드레싱', 150, 1200);
insert into ingredient values(seq_ingredient_no.nextval, 4, '허니머스타드', 88, 1200);
insert into ingredient values(seq_ingredient_no.nextval, 4, '발사믹오일', 124, 1200);
insert into ingredient values(seq_ingredient_no.nextval, 5, '생수', 0, 1000);
insert into ingredient values(seq_ingredient_no.nextval, 5, '콤부차', 15, 1500);
insert into ingredient values(seq_ingredient_no.nextval, 5, '마테차', 0, 1500);
insert into ingredient values(seq_ingredient_no.nextval, 5, '녹차', 2, 1500);
insert into ingredient values(seq_ingredient_no.nextval, 5, '아메리카노', 5, 3500);
insert into ingredient values(seq_ingredient_no.nextval, 5, '제로콜라', 0, 2000);
select * from ingredient;

create table faq_board (
	board_no number,
	writer varchar2(20),
	title varchar(200) not null,
	content	varchar(1000) not null,
	reg_date date default sysdate,
    constraints pk_faq_board_board_no primary key(board_no),
    constraints fk_faq_board_writer foreign key(writer) references member(member_id) on delete cascade
);
--drop table faq_board;

create table review (
	review_no number,
	writer varchar2(20),
	title varchar2(200)	not null,
	content	varchar2(1000) not null,
	reg_date date default sysdate,
    constraints pk_review_no primary key(review_no),
    constraints fk_review_writer foreign key(writer) references member(member_id) on delete cascade
);
--drop table review;

create table attachment (
    no number, 
    board_no number not null,
    original_filename varchar2(255) not null, -- 실제파일명
    renamed_filename varchar2(255) not null, -- 저장파일명 (영문자/숫자)
    reg_date date default sysdate,
    constraints pk_attachment_no primary key(no),
    constraints fk_attachment_board_no foreign key(board_no) references board(board_no)  on delete cascade,
    constraints fk_attachment_review_no foreign key(board_no) references review(review_no) on delete cascade
    
);
select * from attachment;
--drop table attachment;



create table like_tbl (
	like_no	number,
	member_id varchar2(20),
	review_no number,
	like_count number,
    constraints pk_like_no primary key(like_no),
    constraints fk_like_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_like_review_no foreign key(review_no) references review(review_no) on delete cascade
);
--drop table like_tbl;

create table selected_option (
	serial_no number,
    member_id varchar2(20),
	ingredient_no number,
	count number null,
	calorie number null,
	price number null,
    constraints pk_selected_option_serial_no primary key(serial_no),
    constraints fk_selected_option_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_selected_option_ingredient_no foreign key(ingredient_no) references ingredient(ingredient_no)
);
--drop table selected_option;
create sequence seq_option_no;
-- drop sequence seq_option_no;
select * from selected_option;
-- delete from selected_option;
select * from ingredient;