-- Active: 1699985043656@@127.0.0.1@5432@fazzcoffeeshop@public

-- DDL
-- Create
CREATE TYPE "roles" as ENUM('Super Administrator','Staff Administrator','Customer');
CREATE TABLE "users"(
  "id" SERIAL PRIMARY KEY,
  "username" VARCHAR(80) NOT NULL,
  "email" VARCHAR(30) NOT NULL,
  "password" VARCHAR(100) NOT NULL,
  "address" TEXT NOT NULL,
  "phoneNumber" VARCHAR(20),
  "role" "roles",
  "pictures" VARCHAR(255),
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);

CREATE Table "products" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(30) NOT NULL,
  "price" INT NOT NULL,
  "description" TEXT,
  "image" VARCHAR(255),
  "isBestSeller" BOOLEAN,
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);

CREATE TYPE "pSize" AS ENUM('Reguler','Medium','Large');
CREATE TABLE "productSize"(
  "id" SERIAL PRIMARY KEY,
  "size" "pSize" NOT NULL,
  "productId" INT REFERENCES "products"("id"),
  "additionalPrice" INT NOT NULL,
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);

CREATE TYPE "pVariant" AS ENUM('Hot','Cold');
CREATE TABLE "productVariant"(
  "id" SERIAL PRIMARY KEY,
  "variant" "pVariant" NOT NULL,
  "productId" INT REFERENCES "products"("id"),
  "additionalPrice" INT NOT NULL,
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);

CREATE TABLE "promo"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL,
  "code" VARCHAR(15) NOT NULL,
  "description" TEXT,
  "percentage" FLOAT NOT NULL,
  "maxPromo" INT NOT NULL,
  "minPurchase" INT NOT NULL,
  "isExpired" BOOLEAN,
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);


CREATE TYPE "orderStatuses" AS ENUM('On-Process','Canceled','Delivered','Awaiting-Payment','Ready-to-Pick');
CREATE TABLE "orders"(
  "id" SERIAL PRIMARY KEY,
  "orderNumber" VARCHAR(30) NOT NULL,
  "userId" INT NOT NULL REFERENCES "users"("id"),
  "productId" INT NOT NULL REFERENCES "products"("id"),
  "promoId" INT REFERENCES "promo"("id"),
  "quantity" INT NOT NULL,
  "tax" FLOAT,
  "total" INT NOT NULL,
  "deliveryAddress" TEXT NOT NULL,
  "orderStatus" "orderStatuses" NOT NULL,
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);

CREATE TABLE "orderDetails"(
  "id" SERIAL PRIMARY KEY,
  "orderId" INT NOT NULL REFERENCES "orders"("id"),
  "subTotal" INT NOT NULL,
  "createdAt" TIMESTAMP DEFAULT now(),
  "updatedAt" TIMESTAMP
);

-- DML

-- users
INSERT INTO "users"("username","email","password","address","phoneNumber","role")
VALUES
('Rozalin Baudin','rbaudin0@bing.com','c4ca4238a0b923820dcc509a6f75849b','9 9th Street','62-(729)891-9538','Customer'),
('Lynnett Durno','ldurno1@bing.com','c81e728d9d4c2f636f067f89cc14862c','1 8th Circle','62-(686)944-4060','Customer'),
('Lorrie Lethbury','llethbury2@bing.com','eccbc87e4b5ce2fe28308fd9f2a7baf3','8 7th Junction','62-(546)184-0586','Customer'),
('Dorolice Tregear','dtregear3@bing.com','a87ff679a2f3e71d9181a67b7542122c','9 6th Crossing','62-(361)835-7764','Customer'),
('Kermit Baudone','kbaudone4@bing.com','e4da3b7fbbce2345d7772b0674a318d5','3 5th Trail','62-(282)171-7250','Staff Administrator'),
('Giffy Gulland','ggulland5@bing.com','1679091c5a880faf6fb5e6087eb1b2dc','4 4th Way','62-(544)884-8497','Customer'),
('Maurise Baud','mbaud6@bing.com','8f14e45fceea167a5a36dedd4bea2543','7 3rd Lane','62-(688)308-9160','Super Administrator'),
('Bartolomeo Haggerty','bhaggerty7@bing.com','c9f0f895fb98ab9159f51fd0297e236d','8 2nd Avenue','62-(366)372-4171','Staff Administrator'),
('Ricardo Baudinot','rbaudinot8@bing.com','45c48cce2e2d7fbdea1afc51c7c6ad26','5 1st Street','62-(912)771-2717','Customer'),
('Dorolice Baudains','dbaudains9@bing.com','d3d9446802a44259755d38e6d163e820','6 10th Circle','62-(671)296-5830','Customer'),
('Rozalin Baudone','rbaudonea@bing.com','6512bd43d9caa6e02c990b0a82652dca','1 9th Junction','62-(449)119-4144','Staff Admin'),
('Lynnett Baudains','lbaudainsb@bing.com','c20ad4d76fe97759aa27a0c99bff6710','2 8th Crossing','62-(378)726-5187','Customer'),
('Lorrie Baudin','lbaudinc@bing.com','c51ce410c124a10e0db5e4b97fc2af39','3 7th Trail','62-(284)429-5794','Customer'),
('Dorolice Baud','dbaudd@bing.com','aab3238922bcc25a6f606eb525ffdc56','4 6th Way','62-(336)638-4577','Staff Administrator'),
('Kermit Baudinot','kbaudinote@bing.com','9bf31c7ff062936a96d3c8bd1f8f2ff3','5 5th Lane','62-(813)387-7651','Customer'),
('Giffy Baudains','gbaudainsf@bing.com','c74d97b01eae257e44aa9d5bade97baf','6 4th Avenue','62-(547)693-8332','Customer'),
('Maurise Baudone','mbaudoneg@bing.com','70efdf2ec9b086079795c442636b55fb','7 3rd Street','62-(928)889-8942','Customer'),
('Bartolomeo Baudin','bbaudinh@bing.com','6f4922f45568161a8cdf4ad2299f6d23','8 2nd Circle','62-(362)571-6448','Customer'),
('Ricardo Baud','rbaudini@bing.com','1f0e3dad99908345f7439f8ffabdffc4','9 1st Junction','62-(897)590-6699','Customer'),
('Dorolice Baudinot','dbaudinotj@bing.com','98f13708210194c475687be6106a3b84','10 10th Crossing','62-(542)199-5068','Customer');


-- products
INSERT INTO "products" ("name","description","price","image","discount","isBestSeller")
VALUES
('Espresso','Kopi hitam pekat dengan crema di atasnya',25000,'espresso.jpg',0,TRUE),
('Cappuccino','Kopi dengan campuran susu dan busa susu',30000,'cappuccino.jpg',0.1,TRUE),
('Latte','Kopi dengan susu panas dan sedikit busa susu',30000,'latte.jpg',0,FALSE),
('Americano','Kopi dengan tambahan air panas',25000,'americano.jpg',0,FALSE),
('Mocha','Kopi dengan cokelat dan susu',35000,'mocha.jpg',0.15,TRUE),
('Macchiato','Kopi dengan tetesan susu atau busa susu',25000,'macchiato.jpg',0,FALSE),
('Frappuccino','Kopi dingin dengan es krim dan sirup',40000,'frappuccino.jpg',0.2,TRUE),
('Affogato','Kopi dengan bola es krim vanila',35000,'affogato.jpg',0,FALSE),
('Flat White','Kopi dengan susu panas tanpa busa susu',30000,'flatwhite.jpg',0,FALSE),
('Cold Brew','Kopi dingin yang diseduh dengan air dingin',30000,'coldbrew.jpg',0.1,TRUE),
('Irish Coffee','Kopi dengan tambahan krim dan wiski',40000,'irishcoffee.jpg',0,FALSE),
('Turkish Coffee','Kopi yang diseduh dengan cara khusus',35000,'turkishcoffee.jpg',0,FALSE),
('Vietnamese Coffee','Kopi dengan susu kental manis',30000,'vietnamesecoffee.jpg',0.15,TRUE),
('Cortado','Kopi dengan susu panas dengan rasio 1:1',25000,'cortado.jpg',0,FALSE),
('Lungo','Kopi dengan volume air yang lebih banyak',25000,'lungo.jpg',0,FALSE);


-- productSize
INSERT INTO "productSize" ("size", "additionalPrice")
VALUES ('Reguler', 0), ('Medium', 3000), ('Large', 4000);


-- productVariant
INSERT INTO "productVariant" ("variant", "additionalPrice")
VALUES ('Hot', 0), ('Cold', 1000);


-- promo
INSERT INTO "promo" ("name","code","description","percentage","isExpired","maxPromo","minPurchase")
VALUES
('FAZZFOOD50','FZFD50','Potongan sebesar 50% hingga maksimal 50000 untuk setiap produk minuman kopi dengan minimal pembelian sebesar 50000',0.5,FALSE,50000,50000),
('DITRAKTIR60','DTKR60','Potongan sebesar 60% hingga maksimal 30000 untuk setiap produk minuman kopi denga minimal pembelian sebesar 25000',0.6,FALSE,30000,25000);


-- orders
INSERT INTO "orders" ("orderNumber","userId","productId","quantity","total","orderStatus","deliveryAddress")
VALUES
('#01/10112023/001',1,1,1,(SELECT "price" FROM "products" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1),'On-Process','9 9th Street');

INSERT INTO "orders" ("orderNumber","userId","productId","quantity","total","orderStatus","deliveryAddress")
VALUES
('#01/10112023/002',2,2,1,(SELECT "price" FROM "products" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1),'On-Process','1 8th Circle'),
('#01/10112023/002',2,3,1,(SELECT "price" FROM "products" WHERE "id" = 3) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2),'On-Process','1 8th Circle'),
('#01/10112023/002',2,4,1,(SELECT "price" FROM "products" WHERE "id" = 4) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2),'On-Process','1 8th Circle');


INSERT INTO "orders" ("orderNumber","userId","productId","quantity","total","orderStatus","deliveryAddress")
VALUES
('#01/10112023/003',3,1,1,(SELECT "price" FROM "products" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1),'On-Process','8 7th Junction'),
('#01/10112023/003',3,4,1,(SELECT "price" FROM "products" WHERE "id" = 4) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2),'On-Process','8 7th Junction'),
('#01/10112023/003',3,6,1,(SELECT "price" FROM "products" WHERE "id" = 6) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2),'On-Process','8 7th Junction'),
('#01/10112023/003',3,8,1,(SELECT "price" FROM "products" WHERE "id" = 8) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2),'On-Process','8 7th Junction'),
('#01/10112023/003',3,9,1,(SELECT "price" FROM "products" WHERE "id" = 9) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1),'On-Process','8 7th Junction');



-- Read
SELECT * FROM "users" WHERE "username" LIKE 'B%';

('Lungo','Kopi dengan volume air yang lebih banyak',25000,'lungo.jpg',0,FALSE);
-- Update
ALTER TABLE "users" ADD COLUMN "age" INT;
UPDATE "products" SET "price" = 24000 WHERE "name" = 'Lungo';

-- Delete
ALTER TABLE "users" DROP COLUMN "age";
DELETE FROM "products" WHERE "name" = 'Lungo';

-- Join
SELECT "o"."orderNumber","u"."username", "p"."name","o"."quantity","o"."total"
FROM "users" "u"
INNER JOIN "orders" "o" ON "o"."userId" = "u"."id"
INNER JOIN "products" "p" ON "p"."id" = "o"."productId"
WHERE "o"."total" < 30000
LIMIT 3;
