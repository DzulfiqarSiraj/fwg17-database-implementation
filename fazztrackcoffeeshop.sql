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







