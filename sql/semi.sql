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
	member_role	char(1)	not null,
    constraints pk_member_id primary key(member_id),
    constraints ck_member_gender check(gender in ('M', 'F')),
    constraints ck_member_role check(member_role in ('U', 'A'))
);

create table category (
	category_no	number,
	category_name varchar2(100)	not null,
    constraints pk_category_no primary key(category_no)
);

create table order_tbl (
	order_no number(20),
    serial_no number(20),
	count number default 1,
	order_date date default sysdate,
	state varchar(20) default 0,
    constraints pk_order_no primary key(order_no),
    constraints fk_order_serial_no foreign key(serial_no) references order_detail(serial_no) on delete cascade,
    constraints ck_order_state check(state in (0, 1, 2))
);

create table cart_tbl (
	product	varchar2(100),
	member_id varchar2(20),
	count number default 1,
	price number not null,
    constraints pk_cart_no_product primary key(product, member_id),
    constraints fk_cart_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create table board (
	board_no number,
	writer varchar2(20),
	title varchar(200) not null,
	content	varchar(1000) not null,
	reg_date date default sysdate,
    constraints pk_board_no primary key(board_no),
    constraints fk_board_writer foreign key(writer) references member(member_id)on delete cascade
);

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

create table order_detail (
	serial_no number,
	member_id varchar(20),
	product	varchar2(100),
    price number,
    constraints pk_order_detail_serial_no primary key(serial_no),
    constraints fk_order_detail_member_id foreign key(member_id, product) references cart_tbl(member_id, product) on delete cascade
);

create table store (
	store_no number,
	store_name varchar2(30) not null,
	address	varchar2(1000) not null,
	phone number not null,
    constraints pk_store_no primary key(store_no)
);

create table ingredient (
	ingredient_no number,
	category_no	number,
	ingredient_name	varchar2(200) not null,
	calorie	number not null,
	price number not null,
    constraints pk_ingredient_no primary key(ingredient_no),
    constraints fk_ingredient_category_no foreign key(category_no) references category(category_no) on delete cascade
);

create table faq_board (
	board_no number,
	writer varchar2(20),
	title varchar(200) not null,
	content	varchar(1000) not null,
	reg_date date default sysdate,
    constraints pk_faq_board_board_no primary key(board_no),
    constraints fk_faq_board_writer foreign key(writer) references member(member_id) on delete cascade
);

create table review (
	review_no number,
	writer varchar2(20),
	title varchar2(200)	not null,
	content	varchar2(1000) not null,
	reg_date date default sysdate,
    constraints pk_review_no primary key(review_no),
    constraints fk_review_writer foreign key(writer) references member(member_id) on delete cascade
);

create table like_tbl (
	like_no	number,
	member_id varchar2(20),
	review_no number,
	like_count number,
    constraints pk_like_no primary key(like_no),
    constraints fk_like_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_like_review_no foreign key(review_no) references review(review_no) on delete cascade
);

create table cart_detail (
	serial_no number,
	ingredient_no number,
	count number null,
	calorie number null,
	price number null,
    constraints pk_cart_detail_serial_no primary key(serial_no),
    constraints fk_cart_detail_product_ingredient_no foreign key(ingredient_no) references ingredient(ingredient_no)
);