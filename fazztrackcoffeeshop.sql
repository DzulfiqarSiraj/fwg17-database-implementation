create type "role" as enum('admin','staff','customer');
create table "users" (
	"userId" serial primary key not null,
	"fullName" varchar(50) not null,
	"email" varchar(30) not null,
	"password" varchar(255) not null,
	"address" text not null,
	"picture" varchar(255),
	"phoneNumber" varchar(15),
	"role" role,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);


create table "products" (
	"productId" serial primary key not null,
	"name" varchar(50) not null,
	"description" text not null,
	"basePrice" numeric(10, 2) not null,
	"image" varchar(255),
	"discount" float,
	"isRecommended" boolean,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);


create type "size" as enum('small','medium','large');
create table "productSize" (
	"productSizeId" serial primary key not null,
	"size" size not null,
	"additionalPrice" numeric(10,2) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productVariant" (
	"variantId" serial primary key not null,
	"name" varchar(15) not null,
	"additionalPrice" numeric(10,2) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "tags" (
	"tagId" serial primary key not null,
	"name" varchar(15) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productTags" (
	"productTagId" serial primary key not null,
	"productId" int not null references "products" ("productId"),
	"tagId" int not null references "tags" ("tagId"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productRatings" (
	"productRatingId" serial primary key not null,
	"productId" int not null references "products" ("productId"),
	"rate" smallint not null,
	"reviewMessage" text,
	"userId" int not null references "users" ("userId"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "categories" (
	"categoryId" serial primary key not null,
	"name" varchar(50) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productCategories" (
	"productCategoryId" serial primary key not null,
	"productId" int not null references "products" ("productId"),
	"categoryId" int not null references "categories" ("categoryId"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "promo" (
	"promoId" serial primary key not null,
	"name" varchar(15) not null,
	"code" varchar(15) not null,
	"description" text not null,
	"percentage" float not null,
	"isExpired" boolean not null,
	"maximumPromo" numeric(10,2) not null,
	"minimumAmount" numeric(10,2) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);


create type "status" as enum('on-progress','delivered','canceled','ready-to-pick');
create table "orders" (
	"orderId" serial primary key not null,
	"userId" int not null references "users" ("userId"),
	"orderNumber" varchar(20) not null,
	"promoId" int not null references "promo" ("promoId"),
	"total" int not null,
	"taxAmount" float not null,
	"status" status not null,
	"deliveryAddress" text not null,
	"fullName" varchar(50) not null,
	"email" varchar(30) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "orderDetails" (
	"orderDetailsId" serial primary key not null,
	"productId" int not null references "products" ("productId"),
	"productSizeId" int not null references "productSize" ("productSizeId"),
	"productVariantId" int not null references "productVariant" ("variantId"),
	"quantity" int not null,
	"orderId" int not null references "orders" ("orderId"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "message" (
	"messageId" serial primary key not null,
	"recipientId" int not null references "users" ("userId"),
	"senderId" int not null references "users" ("userId"),
	"text" text not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

alter table "users" alter column "role" set not null;
alter table "users" alter column "phoneNumber" set data type varchar(20);

insert into "users" ("fullName","email","password","address","picture","phoneNumber","role")
values ('Rozalin Baudin', 'rbaudin0@bing.com', 'c4ca4238a0b923820dcc509a6f75849b', '9 9th Street', 'http://dummyimage.com/100x100.png/ff4444/ffffff', '62-(729)891-9538', 'customer'),
('Lynnett Durno', 'ldurno1@bing.com', 'c81e728d9d4c2f636f067f89cc14862c', '1 8th Circle', 'http://dummyimage.com/100x100.png/5fa2dd/ffffff', '62-(686)944-4060', 'staff'),
('Lorrie Lethbury', 'llethbury2@bing.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', '8 7th Junction', 'http://dummyimage.com/100x100.png/dddddd/000000', '62-(546)184-0586', 'customer'),
('Dorolice Tregear', 'dtregear3@bing.com', 'a87ff679a2f3e71d9181a67b7542122c', '9 6th Crossing', 'http://dummyimage.com/100x100.png/cc0000/ffffff', '62-(361)835-7764', 'customer'),
('Kermit Baudone', 'kbaudone4@bing.com', 'e4da3b7fbbce2345d7772b0674a318d5', '3 5th Trail', 'http://dummyimage.com/100x100.png/ff4444/ffffff', '62-(282)171-7250', 'staff'),
('Giffy Gulland', 'ggulland5@bing.com', '1679091c5a880faf6fb5e6087eb1b2dc', '4 4th Way', 'http://dummyimage.com/100x100.png/5fa2dd/ffffff', '62-(544)884-8497', 'customer'),
('Maurise Baud', 'mbaud6@bing.com', '8f14e45fceea167a5a36dedd4bea2543', '7 3rd Lane', 'http://dummyimage.com/100x100.png/dddddd/000000', '62-(688)308-9160', 'admin'),
('Bartolomeo Haggerty', 'bhaggerty7@bing.com', 'c9f0f895fb98ab9159f51fd0297e236d', '8 2nd Avenue', 'http://dummyimage.com/100x100.png/cc0000/ffffff', '62-(366)372-4171', 'staff'),
('Ricardo Baudinot', 'rbaudinot8@bing.com', '45c48cce2e2d7fbdea1afc51c7c6ad26', '5 1st Street', 'http://dummyimage.com/100x100.png/ff4444/ffffff', '62-(912)771-2717', 'customer'),
('Dorolice Baudains', 'dbaudains9@bing.com', 'd3d9446802a44259755d38e6d163e820', '6 10th Circle', 'http://dummyimage.com/100x100.png/5fa2dd/ffffff', '62-(671)296-5830', 'customer'),
('Rozalin Baudone', 'rbaudonea@bing.com', '6512bd43d9caa6e02c990b0a82652dca', '1 9th Junction', 'http://dummyimage.com/100x100.png/dddddd/000000', '62-(449)119-4144', 'staff'),
('Lynnett Baudains', 'lbaudainsb@bing.com', 'c20ad4d76fe97759aa27a0c99bff6710', '2 8th Crossing', 'http://dummyimage.com/100x100.png/cc0000/ffffff', '62-(378)726-5187', 'customer'),
('Lorrie Baudin', 'lbaudinc@bing.com', 'c51ce410c124a10e0db5e4b97fc2af39', '3 7th Trail', 'http://dummyimage.com/100x100.png/ff4444/ffffff', '62-(284)429-5794', 'customer'),
('Dorolice Baud', 'dbaudd@bing.com', 'aab3238922bcc25a6f606eb525ffdc56', '4 6th Way', 'http://dummyimage.com/100x100.png/5fa2dd/ffffff', '62-(336)638-4577', 'staff'),
('Kermit Baudinot', 'kbaudinote@bing.com', '9bf31c7ff062936a96d3c8bd1f8f2ff3', '5 5th Lane', 'http://dummyimage.com/100x100.png/dddddd/000000', '62-(813)387-7651', 'customer'),
('Giffy Baudains', 'gbaudainsf@bing.com', 'c74d97b01eae257e44aa9d5bade97baf', '6 4th Avenue', 'http://dummyimage.com/100x100.png/cc0000/ffffff', '62-(547)693-8332', 'admin'),
('Maurise Baudone', 'mbaudoneg@bing.com', '70efdf2ec9b086079795c442636b55fb', '7 3rd Street', 'http://dummyimage.com/100x100.png/ff4444/ffffff', '62-(928)889-8942', 'customer'),
('Bartolomeo Baudin', 'bbaudinh@bing.com', '6f4922f45568161a8cdf4ad2299f6d23', '8 2nd Circle', 'http://dummyimage.com/100x100.png/5fa2dd/ffffff', '62-(362)571-6448', 'customer'),
('Ricardo Baud', 'rbaudini@bing.com', '1f0e3dad99908345f7439f8ffabdffc4', '9 1st Junction', 'http://dummyimage.com/100x100.png/dddddd/000000', '62-(897)590-6699', 'customer'),
('Dorolice Baudinot', 'dbaudinotj@bing.com', '98f13708210194c475687be6106a3b84', '10 10th Crossing', 'http://dummyimage.com/100x100.png/cc0000/ffffff', '62-(542)199-5068', 'customer');


insert into "products" ("name","description","basePrice","image","discount","isRecommended")
values ('Espresso', 'Kopi hitam pekat dengan crema di atasnya', 25000, 'espresso.jpg', 0, TRUE),
('Cappuccino', 'Kopi dengan campuran susu dan busa susu', 30000, 'cappuccino.jpg', 0.1, TRUE),
('Latte', 'Kopi dengan susu panas dan sedikit busa susu', 30000, 'latte.jpg', 0, FALSE),
('Americano', 'Kopi dengan tambahan air panas', 25000, 'americano.jpg', 0, FALSE),
('Mocha', 'Kopi dengan cokelat dan susu', 35000, 'mocha.jpg', 0.15, TRUE),
('Macchiato', 'Kopi dengan tetesan susu atau busa susu', 25000, 'macchiato.jpg', 0, FALSE),
('Frappuccino', 'Kopi dingin dengan es krim dan sirup', 40000, 'frappuccino.jpg', 0.2, TRUE),
('Affogato', 'Kopi dengan bola es krim vanila', 35000, 'affogato.jpg', 0, FALSE),
('Flat White', 'Kopi dengan susu panas tanpa busa susu', 30000, 'flatwhite.jpg', 0, FALSE),
('Cold Brew', 'Kopi dingin yang diseduh dengan air dingin', 30000, 'coldbrew.jpg', 0.1, TRUE),
('Irish Coffee', 'Kopi dengan tambahan krim dan wiski', 40000, 'irishcoffee.jpg', 0, FALSE),
('Turkish Coffee', 'Kopi yang diseduh dengan cara khusus', 35000, 'turkishcoffee.jpg', 0, FALSE),
('Vietnamese Coffee', 'Kopi dengan susu kental manis', 30000, 'vietnamesecoffee.jpg', 0.15, TRUE),
('Cortado', 'Kopi dengan susu panas dengan rasio 1:1', 25000, 'cortado.jpg', 0, FALSE),
('Lungo', 'Kopi dengan volume air yang lebih banyak', 25000, 'lungo.jpg', 0, FALSE);




