/* ОПИСАНИЕ БД
Даочай.
Интернет-магазин китайского чая. 
Основан в 2013. 
Рейтинг 4,97 на Яндексе.
Покупательская база - более 10 тысяч пользователей (в этом проекте чуть поменьше).
Расположены три точки в Москве, доступна доставка по России.
Бизнес-логику упростил для экономии своего времени:
Уверен, в реальном проекте категории и подкатегории разделены на отдельные таблицы 
(к примеру, пуэр, который также делится на (шен, шу, белый пуэр), а дальше по партиям или локациям произрастания, и т.д.);
я же построил несложную иерархию из 2-3 уровней.
Ассортимент, в целом, описан, но в учебных целях: таблицы заполнены на 0-20 записей, не больше, а
некоторые столбцы с большим заполнением закомментировал (см. description таблицы products, например).

Требования к курсовому проекту:
1. Составить общее текстовое описание БД и решаемых ею задач (+);
2. минимум 10 таблиц (+);
3. скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами) (+);
5. скрипты наполнения БД данными (+);
6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы); представления (минимум 2)  (+);
7. хранимые процедуры / триггеры (+) ; 
8. создать ERDiagram (+) */

-- ------------------------------------------------------------------
DROP DATABASE IF EXISTS daochai;
CREATE DATABASE daochai;
USE daochai;

--------------------------------------------------------------------------
# МАГАЗИНЫ
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  address VARCHAR(255) COMMENT 'Адрес магазина',
  phone VARCHAR(255) COMMENT 'Номер телефона'
) COMMENT = 'Магазины' ;
  
INSERT INTO stores VALUES
  (1, 'м. Пролетарская', '1-я Дубровская 1а, вход со двора', '8 (495) 580-40-41'),
  (2, 'м. Филевский парк', 'ул Олеко Дундича д 19/15', '8(967) 075-62-17'),
  (3, 'м. Беломорская', 'Беломорская 23 к3', '8(977) 446-40-41')  ;
  
-------------------------------------------------------------------------------
# КАТЕГОРИИ
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (DEFAULT, 'Чай'),
  (DEFAULT, 'Аксессуары для чая'),
  (DEFAULT, 'ЗИП (Запасные части)'),
  (DEFAULT, 'Подарочная упаковка'),
  (DEFAULT, 'Наборы чаев'),
  (DEFAULT, 'Околочайное'),
  (DEFAULT, 'Посуда'),
  (DEFAULT, 'Подарочные сертификаты') ;
  
---------------------------------------------------------------------------
# ПОДКАТЕГОРИИ
DROP TABLE IF EXISTS subcatalogs;
CREATE TABLE subcatalogs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название раздела',
  catalog_id INT,
  FOREIGN KEY (catalog_id) REFERENCES catalogs (id)
) COMMENT = 'Подразделы';

INSERT INTO subcatalogs VALUES
  (1, 'Пуэр', 1), (2, 'Улунский чай', 1), (3, 'Красный чай', 1), (4, 'Зеленый чай', 1), (5, 'Белый чай', 1),
  (6, 'Желтый чай', 1), (7, 'Хэй Ча (Черный чай)', 1), (8, 'Чайные добавки', 1),
  (9, 'Чайницы и хранение чая', 2), (10, 'Чайные фигурки', 2), (11, 'Инструменты, кисточки, шила', 2), 
  (12, 'Подставки и чато', 2), (13, 'Чахэ', 2), (14, 'Полотенца и чайный текстиль', 2),
  (15, 'Хранение и транспортировка', 2), (16, 'Чай на природе', 2), (17, 'Чайная электроника', 2),
  (18, 'Благовония', 6), (19, ' Курильницы и подставки под благовония', 6), (20, 'Инструменты сяндао', 6),
  (21, 'Браслеты и четки', 6), (22, 'Декор пространства', 6), (23, ' Изделия из камня', 6), 
  (24, 'Фигурки из дерева', 6), (25, 'Литература', 6),
  (26, 'Чайники из исинской глины', 7), (27, 'Чайники из Цзяньшуй', 7), (28, 'Чайники из Гуанси', 7),
  (29, 'Чайники (керамика, фарфор)', 7), (30, 'Посуда из Цзиндэчжень', 7), (31, 'Пиалы', 7), 
  (32, 'Гайвани', 7), (33, 'Чахай «гун дао бэй»', 7), (34, 'Чабани (чайные доски)', 7), (35, 'Чайные прудики', 7) ;

-----------------------------------------------------------------------------
# ТОВАРЫ
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название',
  -- desсription TEXT COMMENT 'Описание',
  price DECIMAL (10,2) COMMENT 'Цена',
  weight FLOAT DEFAULT NULL COMMENT 'Вес в граммах',
  subcatalog_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- ---------------------------------
  store1 BIT,
  store2 BIT, -- НАЛИЧИЕ В МАГАЗИНАХ
  store3 BIT,
  -- ---------------------------------
  FOREIGN KEY (subcatalog_id) REFERENCES subcatalogs (id)
) COMMENT = 'Товарные позиции';

INSERT INTO products VALUES
  (DEFAULT, 'Да Хун Пао "Большой красный халат", средний огонь, 2022 весна', 489.00, 50.0, 2, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Шу "Тэцзи Шубин - шу высшего разряда", Пувэнь, 2019', 2991.66, 357.0, 1, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Тунму Цзинь Цзюнь Мэй «Золотые брови из деревни Тунму», 2022', 1372.00, 50.0, 3, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Хуаншань Маофен «Ворсистые пики с Желтых гор», 2022 первый сбор', 1660.00, 50.0, 4, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Лао Гун Мэй "Цзинь Цзян", золотая награда, 2014', 2947.00, 50.0, 5, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Мэндин Хуан Я "Желтая почка с Мэндин", 2020', 1977.00, 50.0, 6, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Тяньфу хэйча "Небесные острия", 2014', 3470.00, 100.0, 7, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Е Шен Цзинь Инь Хуа "Дикорастущая японская жимолость", 2022', 576.00, 50.0, 8, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чайница "Цветы", фарфор из Цзиндэчжэнь', 6418.00, DEFAULT, 9, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Фигурка "Филин", керамика ', 410.00, DEFAULT, 10, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Шило для колки пуэра, палисандр', 398.00, DEFAULT, 11, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Набор подставок под пиалы, дерево, смола', 3367.00, DEFAULT, 12, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чахэ, фарфор', 408.00, DEFAULT, 13, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Полотенце 28х15см "Белый лотос"', 362.00, DEFAULT, 14, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Мешок для переноски посуды, 2 1 секции', 732.00, DEFAULT, 15, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Походная газовая горелка, 3500Вт', 1720.00, DEFAULT, 16, DEFAULT, DEFAULT, 1, 0, 1),
  (DEFAULT, 'Адаптер-переходник под евро-розетку', 194.00, DEFAULT, 17, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чайник 90мл "Нефритовое колечко", исинская глина', 6580.00, DEFAULT, 26, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чайник 200мл, цзяньшуйская керамика', 19188.00, DEFAULT, 27, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чайник 120мл "Крабы", циньчжоуская керамика', 10080.00, DEFAULT, 28, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чайник 130мл "Пейзаж", циньчжоуская керамика', 8960.00, DEFAULT, 29, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Гайвань 200мл "Пейзаж", фангу цинхуа', 32026.00, DEFAULT, 30, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Пиала 120мл "Тигр Лаоху", фаньхун', 16020.00, DEFAULT, 31, DEFAULT, DEFAULT, 0, 1, 1),
  (DEFAULT, 'Гайвань 175мл "Орхидея", коралловая глазурь', 2710.00, DEFAULT, 32, DEFAULT, DEFAULT, 0, 0, 1),
  (DEFAULT, 'Чахай 205мл, стекло', 1367.00, DEFAULT, 33, DEFAULT, DEFAULT, 0, 0, 0),
  (DEFAULT, 'Чабань (Венге, 39×27см)', 9200.00, DEFAULT, 34, DEFAULT, DEFAULT, 1, 1, 1),
  (DEFAULT, 'Чайный пруд 15см "Вулканический камень"', 4294.00, DEFAULT, 35, DEFAULT, DEFAULT, 1, 1, 1) ;
 
------------------------------------------------------------------------------------
# ПОКУПАТЕЛИ
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(255) NOT NULL COMMENT 'Имя покупателя',
  lastname VARCHAR(255) NOT NULL COMMENT 'Фамилия',
  patronym VARCHAR(255) DEFAULT ' ' COMMENT 'Отчество',
  login VARCHAR(255) UNIQUE NOT NULL COMMENT 'Логин',
  emeil VARCHAR(255) UNIQUE NOT NULL COMMENT 'Адрес электронной почты',
  phone BIGINT UNSIGNED UNIQUE,
  scores BIGINT(8) DEFAULT 0 COMMENT 'Бонусные баллы',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users VALUES
  (DEFAULT, 'Геннадий', 'Смирнов', DEFAULT, 'gensmirn', 'gensmir@mail.ru', 89222112313, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 'Арсений', 'Петрушкин', DEFAULT, 'ars1991', 'ars1991@mail.ru', 89212112313, 243, DEFAULT, DEFAULT),
  (DEFAULT, 'Алиса', 'Вяткова', 'Юрьевна', 'alvyat', 'alvyat@mail.ru', 89232112313, 99990, DEFAULT, DEFAULT),
  (DEFAULT, 'Алексей', 'Валериев', DEFAULT, 'alekse', 'alekse@mail.ru', 89277112313, 197, DEFAULT, DEFAULT),
  (DEFAULT, 'Валерия', 'Абсурдова', DEFAULT, 'trueeeee', 'trueee@mail.ru', 89222902313, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 'Александр', 'Андреев', DEFAULT, 'alexandr1992', 'alexandr1992@mail.ru', 89852119913, 600, DEFAULT, DEFAULT),
  (DEFAULT, 'Дилара', 'Алиева', DEFAULT, 'dilara', 'dilara@mail.ru', 89773020047, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 'Данила', 'Жужа', DEFAULT, 'dani89', 'dani89@mail.ru', 89228812313, 1, DEFAULT, DEFAULT),
  (DEFAULT, 'Иван', 'Городецкий', DEFAULT, 'gorodetz', 'gorodetz@mail.ru', 89222666313, 22, DEFAULT, DEFAULT),
  (DEFAULT, 'Юлия', 'Иванова', DEFAULT, 'oiwwaazz tzchii', 'oiwwaazztzchii@mail.ru', 89243112313, DEFAULT, DEFAULT, DEFAULT) ;

----------------------------------------------------------------------------
# ПРОФИЛИ; у одного пользователя может быть несколько адресов для доставки
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  profile_name VARCHAR(255) NOT NULL,
  firstname VARCHAR(255) NOT NULL COMMENT 'Имя',
  lastname VARCHAR(255) NOT NULL COMMENT 'Фамилия',
  patronym VARCHAR(255) DEFAULT ' ' COMMENT 'Отчество',
  country VARCHAR(255) NOT NULL DEFAULT 'Россия' COMMENT 'Страна', 
  city VARCHAR(255) NOT NULL DEFAULT 'Москва' COMMENT 'Город',
  address VARCHAR(255) DEFAULT ' ' COMMENT 'Адрес',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users (id)
) ;

INSERT INTO profiles VALUES
  (DEFAULT, 1, 'Основной', 'Геннадий', 'Смирнов', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 2, 'Основной', 'Арсений', 'Петрушкин', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 3, 'Основной', 'Алиса', 'Вяткова', 'Юрьевна', DEFAULT, DEFAULT, DEFAULT,DEFAULT),
  (DEFAULT, 3, 'Работа', 'Алиса', 'Вяткова', 'Юрьевна', 'Россия', 'Москва', 'Комсомольский проспект, 24', DEFAULT),
  (DEFAULT, 4, 'Основной', 'Алексей', 'Валериев', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 5, 'Основной', 'Валерия', 'Абсурдова', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 6, 'Основной', 'Александр', 'Андреев', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 7, 'Основной', 'Дилара', 'Алиева', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 8, 'Основной', 'Данила', 'Жужа', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 9, 'Основной', 'Иван', 'Городецкий', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 10, 'Основной', 'Юлия', 'Иванова', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT) ;


------------------------------------------------------------------------------
# СООБЩЕНИЯ 
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  from_user_id BIGINT UNSIGNED NOT NULL,
  content TEXT COLLATE utf8_unicode_ci DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
  UNIQUE KEY id (id),
  KEY from_user_id (from_user_id),
  FOREIGN KEY (from_user_id) REFERENCES users (id)
) COMMENT 'Сообщения для Daochai.ru';

INSERT INTO messages VALUES 
(DEFAULT, 1, 'Привет!','2021-08-19 10:43:28'),
(DEFAULT, 10, 'Здравствуйте, можно ли в скором времени ожидать новых поставок зеленого чая?', '2022-03-25 13:49:08');


--------------------------------------------------------------------------------
#  КОММЕНТАРИИ
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id BIGINT(12) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
  user_id BIGINT(12) UNSIGNED NOT NULL,
  product_id BIGINT,
  rating ENUM('1', '2', '3', '4', '5') COMMENT 'Оценка товара',
  comment TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (product_id) REFERENCES products (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
) COMMENT 'Комментарии к товарам' ;

INSERT INTO comments VALUES
  (DEFAULT, 1, 1, 5, 'Отлично! снова чувствую себя молодым!' , DEFAULT),
  (DEFAULT, 1, 23, 4, 'Как все изменилось...',  DEFAULT), 
  (DEFAULT, 4, 1, 5, 'Был пробник, понравился! Надо взять еще чтобы получше распробовать!', DEFAULT) ,
  (DEFAULT, 1, 12, 4, 'У меня утюг дома не выключен.. ', DEFAULT),
  (DEFAULT, 3, 22, 3, 'Красивая, качественная и не дорогая гайвань. В живую красный цвет менее насыщенный больше в бордовый и серые линии на синем практически не видны. Доволен покупкой', DEFAULT),
  (DEFAULT, 5, 2, 5, 'Очень нежный и ароматный Уишанец. После знакомства с сухим листом решил, что будет сильный и крепкий классический вкус, но оказалось не совсем так. 
  Чай довольно деликатный во вкусе и очень ароматный, особенно шлейф в гундаобэе. ', DEFAULT),
  (DEFAULT, 2, 15, 5, 'Прекрасная вещь. Спасибо даочай, снова в дУшу', DEFAULT),
  (DEFAULT, 3, 4, 5, 'Свежий зелёный чай. Не требователен к перезавариванию, запах зелёного горошка и травянистые оттенки. Долгое послевкусие с кислинкой.', DEFAULT),
  (DEFAULT, 9, 4, 4, 'Шик! Заваривать зеленые люблю просто в кружке, ~3 г и 70°, подождать ... Готово! Овощной,цитрусовый, вкус просто шикарен! Как только попадает в рот, чувствуешь овощи гриль,но подождать,оно уже переходит в лайм или лимон,со своей шикарной кислинкой!!!', DEFAULT),
  (DEFAULT, 9, 1, 5, 'Мощный менхайский профиль. На любителя. Выраженная горчинка, кофе, дерево. При варке получается заметно мягче и сбалансированней', DEFAULT) ;

---------------------------------------------------------------------------------
# ЗАКАЗЫ
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id BIGINT(12) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
  user_profile_id BIGINT(12) UNSIGNED NOT NULL,
  product_id BIGINT,
  address_id BIGINT UNSIGNED NOT NULL COMMENT 'Адрес доставки (id магазина)',
  order_status ENUM('Размещен', 'Обработан', 'Оплачен') COLLATE utf8_unicode_ci DEFAULT 'Размещен' COMMENT 'Статус заказа',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (product_id) REFERENCES products (id),
  FOREIGN KEY (user_profile_id) REFERENCES profiles (id),
  FOREIGN KEY (address_id) REFERENCES stores (id)
) COMMENT 'Журнал заказов всех пользователей' ;

INSERT INTO orders VALUES
  (DEFAULT, 3, 1, 2, 'Обработан', DEFAULT),
  (DEFAULT, 3, 2, 2, 'Обработан', DEFAULT),
  (DEFAULT, 1, 3, 2, 'Обработан', DEFAULT),
  (DEFAULT, 10, 3, 3, 'Размещен', DEFAULT),
  (DEFAULT, 5, 2, 1, 'Оплачен', DEFAULT),
  (DEFAULT, 2, 1, 1, 'Обработан', DEFAULT),
  (DEFAULT, 9, 1, 2, 'Обработан', DEFAULT),
  (DEFAULT, 6, 3, 3, 'Обработан', DEFAULT),
  (DEFAULT, 9, 3, 2, 'Обработан', DEFAULT),
  (DEFAULT, 4, 2, 1, 'Обработан', DEFAULT) ;

-- ---------------------------------------------------------------------------------------
# СТАТЬИ
DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
  id BIGINT UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) UNIQUE NOT NULL,
  -- content TEXT, 
  author VARCHAR(255) DEFAULT 'Daochai',
  created_at DATE,
  subcategory_related INT,
  FOREIGN KEY (subcategory_related) REFERENCES subcatalogs (id)
) COMMENT 'Статьи' ;


INSERT INTO articles VALUES
(1, 'Шесть причин пить чай пуэр', DEFAULT, '2022-04-27', 1),
(2, 'Классификация зеленого чая: от чаоцина к чжэнцину', DEFAULT, '2022-05-29', 4),
(3, 'Тай Пин Хоу Куй или "Обезьяний главарь из Хоу Кэн"', DEFAULT, '2013-06-09', 4),
(4, 'Глина Циншуйни', DEFAULT, '2017-08-28', 26),
(5, 'НеобыЧАЙные ощущения от обычных чаепитий на природе', DEFAULT, '2013-06-05', 16),
(6, 'Почему блин пуэра весит 357 грамм?', DEFAULT, '2012-02-09', 1),
(7, '4 компонента уишаньского улуна: аромат, чистота, сладость, жизненность', DEFAULT, '2019-03-25', 2)
;

-- -------------------------------------------------------------------
# КОНСУЛЬТАНТЫ
DROP TABLE IF EXISTS consultants;
CREATE TABLE consultants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL COMMENT 'Имя и фамилия',
  workplace BIGINT UNSIGNED,
  -- description TEXT COMMENT 'Описание',
  created_at DATE,
  FOREIGN KEY (workplace) REFERENCES stores (id)
) COMMENT = 'Консультанты';

INSERT INTO consultants VALUES
(DEFAULT, 'Денис Костылев', 2, '2019-10-01'),
(DEFAULT, 'Виктор Кучеров', 1, '2017-11-01'),
(DEFAULT, 'Александра Боброва', 3, '2020-02-01') ;

# ОТЗЫВЫ К КОНСУЛЬТАНТАМ
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  cons_id BIGINT UNSIGNED NOT NULL COMMENT 'Имя и фамилия',
  from_id BIGINT UNSIGNED COMMENT 'Пользователь' ,
  rating ENUM('1', '2', '3', '4', '5') COMMENT 'Оценка' ,
  -- comment TEXT COMMENT 'Описание',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cons_id) REFERENCES consultants (id),
  FOREIGN KEY (from_id) REFERENCES users (id)
) COMMENT = 'Отзывы о консультантах';

INSERT INTO reviews VALUES
(DEFAULT, 1, 1, '5', DEFAULT), (DEFAULT, 1, 2, '5', DEFAULT), (DEFAULT, 1, 3, '5', DEFAULT),
(DEFAULT, 2, 9, '5', DEFAULT), (DEFAULT, 2, 2, '5', DEFAULT), (DEFAULT, 2, 4, '3', DEFAULT),
(DEFAULT, 3, 5, '5', DEFAULT), (DEFAULT, 3, 5, '4', DEFAULT), (DEFAULT, 3, 1, '5', DEFAULT) ;

-- -------------------------------------------------------------------
-- ПРЕДСТАВЛЕНИЯ 
/* Представления, процедуры и триггеры создал не самые изысканные. Под пивко сойдет. Для галочки.   */

CREATE OR REPLACE VIEW most_valuable_consultants AS
SELECT c.name,
ROUND(SUM(r.rating) / COUNT(r.rating), 2) AS average_rating,
COUNT(r.rating) AS number_of_reviews FROM reviews r
JOIN consultants c ON c.id = r.cons_id
GROUP BY c.name ;

SELECT * FROM most_valuable_consultants;
-- ------------------------

CREATE OR REPLACE VIEW 10_valuable_products AS
SELECT c.name AS catalog, p.name AS product, p.price,
CASE 
	WHEN p.weight IS NOT NULL THEN 100 * p.price / p.weight
	ELSE p.price
END AS comparable_price
FROM products p
JOIN subcatalogs s ON s.id = p.subcatalog_id
JOIN catalogs c ON c.id = s.catalog_id
ORDER BY comparable_price DESC LIMIT 10;

SELECT * FROM 10_valuable_products;

-- ----------
CREATE OR REPLACE VIEW show_assortment AS
SELECT
	c.name AS 'Категория',
	s.name AS 'Подкатегория',
	p.name AS 'Товар',
	CASE 
		WHEN p.weight IS NOT NULL THEN 100 * p.price / p.weight
		ELSE p.price
	END AS 'Цена'
    FROM products p	JOIN subcatalogs s ON s.id = p.subcatalog_id
    JOIN catalogs c ON c.id = s.catalog_id;

-- ------------------------------
-- ТРИГГЕР
DROP TRIGGER IF EXISTS product_insert;
DELIMITER \\
CREATE TRIGGER product_insert BEFORE INSERT ON products FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name)) OR (ISNULL(NEW.name)) OR (ISNULL(NEW.price)) OR (ISNULL(NEW.price))  THEN
    SIGNAL SQLSTATE '45000' SET message_text = 'Отсутствующие значения в некоторых столбцах';
	END IF;
END \\

DELIMITER ;

-- ------------------------------