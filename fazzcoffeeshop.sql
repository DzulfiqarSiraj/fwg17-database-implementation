-- DDL
-- Create

-- (T1 - users)
CREATE TYPE "roles" as ENUM('Super Administrator','Staff Administrator','Customer');
CREATE TABLE "users"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "fullName"          VARCHAR(80) NOT NULL,
  "email"             VARCHAR(30) NOT NULL,
  "password"          VARCHAR(255) NOT NULL,
  "address"           TEXT NOT NULL,
  "phoneNumber"       VARCHAR(20),
  "role"              "roles",
  "pictures"          VARCHAR(255),
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T2 - products)
CREATE Table "products" (
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "name"              VARCHAR(50) NOT NULL,
  "basePrice"         INT NOT NULL,
  "description"       TEXT,
  "image"             VARCHAR(255),
  "discount"          NUMERIC(3,2),
  "isBestSeller"      BOOLEAN,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T3 - productSize)
CREATE TYPE "itemSize" AS ENUM('Regular','Medium','Large');
CREATE TABLE "productSize"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "size"              "itemSize",
  "productId"         INT REFERENCES "products"("id"),
  "additionalPrice"   INT,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T4 - productVariant)
CREATE TABLE "productVariant"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "name"              VARCHAR(50) NOT NULL,  
  "productId"         INT REFERENCES "products"("id"),
  "additionalPrice"   INT,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T5 - tags)
CREATE TABLE "tags"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "name"              VARCHAR(50) NOT NULL,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T6 - productTags)
CREATE TABLE "productTags"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "tagId"             INT REFERENCES "tags"("id"),
  "productId"         INT REFERENCES "products"("id"),
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP  
);

-- (T7 - productRatings)
CREATE TABLE "productRatings"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "productId"         INT REFERENCES "products"("id"),
  "rate"              INT NOT NULL,
  "reviewMessage"     TEXT,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T8 - categories)
CREATE TABLE "categories"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "name"              VARCHAR(50) NOT NULL,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
)

-- (T9 - productCategories)
CREATE TABLE "productCategories"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "productId"         INT REFERENCES "products"("id"),
  "categoryId"        INT,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T10 - promo)
CREATE TABLE "promo"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "name"              VARCHAR(50) NOT NULL,
  "code"              VARCHAR(15) NOT NULL,
  "description"       TEXT,
  "percentage"        NUMERIC(3,2) NOT NULL,
  "maxPromo"          INT,
  "minPurchase"       INT,
  "isExpired"         BOOLEAN,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T11 - orders)
CREATE TYPE "orderStatuses" AS ENUM('On Process','Canceled','Delivered','Awaiting Payment','Ready to Pick');
CREATE TABLE "orders"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "userId"            INT REFERENCES "users"("id"),
  "orderNumber"       VARCHAR(30) NOT NULL,
  "fullName"          VARCHAR(80) NOT NULL,
  "email"             VARCHAR(50) NOT NULL,
  "promoId"           INT REFERENCES "promo"("id"),
  "tax"               NUMERIC(3,2),
  "total"             INT,
  "deliveryAddress"   TEXT,
  "status"            "orderStatuses",
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T12 - orderDetails)
CREATE TABLE "orderDetails"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "productId"         INT REFERENCES "products"("id"),
  "productSizeId"     INT REFERENCES "productSize"("id"),
  "productVariantId"  INT REFERENCES "productVariant"("id"),
  "quantity"          INT,
  "orderId"           INT REFERENCES "orders"("id"),
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);

-- (T13 - messages)
CREATE TABLE "messages"(
  "id"                SERIAL PRIMARY KEY NOT NULL,
  "recipientId"       INT,
  "senderId"          INT,
  "text"              TEXT,
  "createdAt"         TIMESTAMP DEFAULT now(),
  "updatedAt"         TIMESTAMP
);



-- DML

-- users
INSERT INTO "users"("fullName","email","password","address","phoneNumber","role")
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
('Rozalin Baudone','rbaudonea@bing.com','6512bd43d9caa6e02c990b0a82652dca','1 9th Junction','62-(449)119-4144','Staff Administrator'),
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
INSERT INTO "products" ("name","description","basePrice","image","discount","isBestSeller")
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
('Lungo','Kopi dengan volume air yang lebih banyak',25000,'lungo.jpg',0,FALSE),
('Jus Apel',5000,'Jus segar dari buah apel pilihan','jus_apel.jpg',0.10,TRUE),
('Es Lemon',4500,'Es lemon yang menyegarkan dengan tambahan daun mint','es_lemon.jpg',0.05,FALSE),
('Smoothie Mangga',6000,'Smoothie lembut dengan rasa mangga yang lezat','smoothie_mangga.jpg',0.15,TRUE),
('Teh Hijau Matcha',7000,'Teh hijau matcha berkualitas tinggi','teh_matcha.jpg',0.20,FALSE),
('Sirup Jeruk',5500,'Sirup jeruk segar untuk minuman yang menyegarkan','sirup_jeruk.jpg',0.10,FALSE),
('Es Leci', 6500,'Es leci dengan potongan buah leci segar','es_leci.jpg',0.15,TRUE),
('Minuman Cranberry',6000,'Minuman segar dengan rasa cranberry yang khas','cranberry_drink.jpg',0.10,FALSE),
('Es Semangka',7500,'Es semangka untuk menyegarkan di hari panas','es_semangka.jpg',0.25,TRUE),
('Smoothie Blueberry',7000,'Smoothie dengan rasa blueberry yang kaya antioksidan','smoothie_blueberry.jpg',0.20,FALSE),
('Sirup Delima',8000,'Sirup delima eksotis untuk pengalaman rasa yang unik','sirup_delima.jpg',0.15,TRUE);


-- productSize
INSERT INTO "productSize" ("size", "additionalPrice")
VALUES
('Regular', 0),
('Medium', 3000),
('Large', 4000);
SELECT * FROM "productSize";


-- productVariant
INSERT INTO "productVariant" ("name","additionalPrice")
VALUES
('Hot', 0),
('Ice', 1000);
SELECT * FROM "productVariant";


-- tags
INSERT INTO "tags" ("name")
VALUES ('Flash Sale');


-- productTags
INSERT INTO "productTags" ("tagId","productId")
VALUES
(1,3),
(1,7),
(1,8),
(1,15),
(1,17),
(1,22),
(1,23);


-- productRatings
INSERT INTO "productRatings" ("productId", "rate", "reviewMessage")
VALUES 
(1, 4, 'Espresso-nya mantap banget, kerasa banget kopinya!'),
(2, 5, 'Cappuccino-nya enak banget, susunya lembut kayak bantal.'),
(3, 4, 'Latte-nya oke juga, susu panasnya pas.'),
(4, 3, 'Americano-nya biasa aja sih, kopi kuat.'),
(5, 5, 'Mocha-nya lezat parah, cokelatnya dapet!'),
(6, 4, 'Macchiato-nya unik, tetesan susunya jadi istimewa.'),
(7, 5, 'Frappuccino-nya enak banget, es krimnya bikin nagih!'),
(8, 4, 'Affogato-nya selalu jadi favorit, es krim vanila makin nikmat.'),
(9, 3, 'Flat White-nya lumayan sih, susunya pas.'),
(10, 5, 'Cold Brew-nya dingin seger, pas buat cuaca panas.'),
(11, 4, 'Irish Coffee-nya hangat dan enak, krimnya lembut.'),
(12, 3, 'Turkish Coffee-nya berbeda rasanya, agak pahit.'),
(13, 5, 'Vietnamese Coffee-nya manis banget, kental dan lezat!'),
(14, 4, 'Cortado-nya pas banget, rasio susunya oke.'),
(15, 3, 'Lungo-nya intens, cocok buat yang suka kopi strong.'),
(16, 5, 'Espresso-nya juara, bener-bener berasa khas!'),
(17, 4, 'Cappuccino-nya dapet banget, busa susunya lembut.'),
(18, 3, 'Latte-nya oke lah, rasa kopinya cukup kuat.'),
(19, 4, 'Americano-nya simpel aja, tapi enak kok.'),
(20, 5, 'Mocha-nya selalu bikin puas, cokelatnya bikin nagih!');


-- categories
INSERT INTO "categories" ("name")
VALUES
('Food'),
('Beverage'),
('Coffee'),
('Non-Coffee');


-- productCategories
INSERT INTO "productCategories" ("productId","categoryId")
VALUES
(1,2),
(2,2),
(3,2),
(4,2),
(5,2),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2),
(13,2),
(14,2),
(15,2),
(16,2),
(17,2),
(18,2),
(19,2),
(20,2),
(21,2),
(22,2),
(23,2),
(24,2),
(25,2);


-- promo
INSERT INTO "promo" ("name","code","description","percentage","isExpired","maxPromo","minPurchase")
VALUES
('FAZZFOOD50','FZFD50','Potongan sebesar 50% hingga maksimal 50000 untuk setiap produk minuman kopi dengan minimal pembelian sebesar 50000',0.5,FALSE,50000,50000),
('DITRAKTIR60','DTKR60','Potongan sebesar 60% hingga maksimal 30000 untuk setiap produk minuman kopi denga minimal pembelian sebesar 25000',0.6,FALSE,30000,25000);


-- orders
-- cust1
INSERT INTO "orders" ("userId","orderNumber","fullName","email","promoId","tax","total","deliveryAddress","status")
VALUES
(1,'#01/10112023/001',(SELECT "fullName" FROM "users" WHERE "id"=1),(SELECT "email" FROM "users" WHERE "id"=1),1,0.1,
(SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1),
(SELECT "address" FROM "users" WHERE "id"=1),'On Process');
-- cust2
INSERT INTO "orders" ("userId","orderNumber","fullName","email","promoId","tax","total","deliveryAddress","status")
VALUES
(2,'#01/10112023/002',(SELECT "fullName" FROM "users" WHERE "id"=2),(SELECT "email" FROM "users" WHERE "id"=2),1,0.1,
(SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1) +
(SELECT "basePrice" FROM "products" WHERE "id" = 3) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1) +
(SELECT "basePrice" FROM "products" WHERE "id" = 7) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2),
(SELECT "address" FROM "users" WHERE "id"=2),'Awaiting Payment');
-- cust3
INSERT INTO "orders" ("userId","orderNumber","fullName","email","promoId","tax","total","deliveryAddress","status")
VALUES
(3,'#01/10112023/002',(SELECT "fullName" FROM "users" WHERE "id"=3),(SELECT "email" FROM "users" WHERE "id"=3),1,0.1,
(SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1) +
(SELECT "basePrice" FROM "products" WHERE "id" = 4) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2) +
(SELECT "basePrice" FROM "products" WHERE "id" = 6) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2) +
(SELECT "basePrice" FROM "products" WHERE "id" = 8) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 2) +
(SELECT "basePrice" FROM "products" WHERE "id" = 9) + (SELECT "additionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "additionalPrice" FROM "productVariant" WHERE "id" = 1),
(SELECT "address" FROM "users" WHERE "id"=2),'Ready to Pick');


-- orderDetails
INSERT INTO "orderDetails" ("productId","productSizeId","productVariantId","quantity","orderId")
VALUES
(1,1,1,1,1),
(1,1,1,1,2),
(3,1,1,1,2),
(7,2,2,1,2),
(1,1,1,1,3),
(4,2,2,1,3),
(6,2,2,1,3),
(8,2,2,1,3),
(9,1,1,1,3);


-- Read
SELECT * FROM "users" WHERE "username" LIKE 'B%';


-- Update
ALTER TABLE "users" ADD COLUMN "age" INT;
UPDATE "products" SET "price" = 24000 WHERE "name" = 'Lungo';


-- Delete
ALTER TABLE "users" DROP COLUMN "age";
DELETE FROM "products" WHERE "name" = 'Lungo';


-- Join
-- INNER
SELECT "o"."orderNumber","u"."username", "p"."name","o"."quantity","o"."total"
FROM "users" "u"
INNER JOIN "orders" "o" ON "o"."userId" = "u"."id"
INNER JOIN "products" "p" ON "p"."id" = "o"."productId"
WHERE "o"."total" < 30000
LIMIT 3;

-- LEFT
SELECT "p"."name", "t"."name" "tags"
FROM "products" "p"
LEFT JOIN "productTags" "pt" ON "p"."id"="pt"."productId"
LEFT JOIN "tags" "t" ON "t"."id"="pt"."tagId"
LIMIT 10;

-- RIGHT
SELECT "p"."name","c"."name" "category"
FROM "products" "p"
RIGHT JOIN "productCategories" "pc" ON "p"."id"="pc"."productId"
RIGHT JOIN "categories" "c" ON "c"."id"="pc"."categoryId";