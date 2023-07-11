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
    memeber_id varchar2(20),
	order_date date default sysdate,
	state varchar(20) default 0,
    constraints pk_order_no primary key(order_no),
    constraints fk_order_memeber_id foreign key(memeber_id) references member(member_id) on delete cascade,
    constraints ck_order_state check(state in (0, 1, 2))
);
--drop table order_tbl;
create table cart_tbl (
    cart_no number,
	product	varchar2(100),
	member_id varchar2(20),
	count number default 1,
	price number not null,
    constraints pk_cart_no_product primary key(cart_no, product),
    constraints fk_cart_member_id foreign key(member_id) references member(member_id) on delete cascade
);
--drop table cart_tbl;
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
	order_serial_no number,
    order_no number,
    cart_no number,
    product varchar2(100),
    count number,
    price number,
    constraints pk_order_detail_order_serial_no primary key(order_serial_no),
    constraints fk_order_detail_order_no foreign key(order_no) references order_tbl(order_no) on delete cascade,
    constraints fk_order_detail_cart_no_product foreign key(cart_no, product) references cart_tbl(cart_no, product) on delete cascade
);
--drop table order_detail;
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
--drop table cart_detail;