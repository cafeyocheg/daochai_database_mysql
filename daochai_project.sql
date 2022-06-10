DROP DATABASE IF EXISTS daochai;
CREATE DATABASE daochai;
USE daochai;

--------------------------------------------------------------------------

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

DROP TABLE IF EXISTS subcatalogs;
CREATE TABLE subcatalogs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название раздела',
  catalog_id INT,
  FOREIGN KEY (catalog_id) REFERENCES catalogs (id)
) COMMENT = 'Подразделы';

INSERT INTO subcatalogs VALUES
  (DEFAULT, 'Пуэр', 1), (DEFAULT, 'Улунский чай', 1), (DEFAULT, 'Красный чай', 1), (DEFAULT, 'Зеленый чай', 1), (DEFAULT, 'Белый чай', 1),
  (DEFAULT, 'Желтый чай', 1), (DEFAULT, 'Хэй Ча (Черный чай)', 1), (DEFAULT, 'Чайные добавки', 1),
  (DEFAULT, 'Чайницы и хранение чая', 2), (DEFAULT, 'Чайные фигурки', 2), (DEFAULT, 'Инструменты, кисточки, шила', 2), 
  (DEFAULT, 'Подставки и чато', 2), (DEFAULT, 'Чахэ', 2), (DEFAULT, 'Полотенца и чайный текстиль', 2),
  (DEFAULT, 'Хранение и транспортировка', 2), (DEFAULT, 'Чай на природе', 2), (DEFAULT, 'Чайная электроника', 2),
  (DEFAULT, 'Благовония', 6), (DEFAULT, ' Курильницы и подставки под благовония', 6), (DEFAULT, 'Инструменты сяндао', 6),
  (DEFAULT, 'Браслеты и четки', 6), (DEFAULT, 'Декор пространства', 6), (DEFAULT, ' Изделия из камня', 6), 
  (DEFAULT, 'Фигурки из дерева', 6), (DEFAULT, 'Литература', 6),
  (DEFAULT, 'Чайники из исинской глины', 7), (DEFAULT, 'Чайники из Цзяньшуй', 7), (DEFAULT, 'Чайники из Гуанси', 7),
  (DEFAULT, 'Чайники (керамика, фарфор)', 7), (DEFAULT, 'Посуда из Цзиндэчжень', 7), (DEFAULT, 'Пиалы', 7), 
  (DEFAULT, 'Гайвани', 7), (DEFAULT, 'Чахай «гун дао бэй»', 7), (DEFAULT, 'Чабани (чайные доски)', 7), (DEFAULT, 'Чайные прудики', 7) ;

-----------------------------------------------------------------------------
  
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desсription TEXT COMMENT 'Описание',
  price DECIMAL (10,2) COMMENT 'Цена',
  catalog_id INT,
  subcatalog_id INT,
  location SMALLINT COMMENT 'Номер склада',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id),
  FOREIGN KEY (catalog_id) REFERENCES catalogs (id),
  FOREIGN KEY (subcatalog_id) REFERENCES subcatalogs (id)
  -- FOREIGN KEY (location) REFERENCES stores (id)
) COMMENT = 'Товарные позиции';

INSERT INTO products VALUES
  (DEFAULT, 'Да Хун Пао "Большой красный халат", средний огонь, 2022 весна', 
  'Да Хун Пао прошел первичный интенсивный прогрев в начале мая 2022 года. 
  В сухом листе такие чаи не обладают особыми специфическими проявлениями. 
  Тут много огня, пряности из перца и корицы, корочка сильно жаренного хлеба. 
  В прогретой посуде доминанты такие же - жареные фундук, шелуха арахиса и подсолнечное семечко. 
  Но все меняется после пробуждения чая кипятком. Аромат претерпевает кардинальные изменения. 
  Он чуть минеральный и освежающе эвкалиптовый, пульсируют весенние первоцветы и мякоть ягод черешни. 
  К третьему проливу раскрывает максимальный обертоновый окрас, смягчает жаренные оттенки, уступает место цветам с тяжелыми ароматами 
  и свежим фруктовым нотам. Первоначальная эвкалиптовость вырождается в нежный аромат белых цветов лилии, магнолии. 
  Настой искристый, наполняющий букетом нёбо, динамичный, со специфической непередаваемой рифмой в послевкусиии. 
  В шлейфе на первых проливах жареный фундук и пряный цитрон, трансформируется во фруктовые свежие абрикосы и сладкое яблоко. 
  Стимулирует желудок, поэтому осторожно.' 489.00, 1, 2, 1, DEFAULT, DEFAULT),
  (DEFAULT, 'Аксессуары для чая'),
  (DEFAULT, 'ЗИП (Запасные части)'),
  (DEFAULT, 'Подарочная упаковка'),
  (DEFAULT, 'Наборы чаев'),
  (DEFAULT, 'Околочайное'),
  (DEFAULT, 'Посуда'),
  (DEFAULT, 'Подарочные сертификаты') ;

------------------------------------------------------------------------------------

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(255) COMMENT 'Имя покупателя',
  lastname VARCHAR(255) DEFAULT ' ' COMMENT 'Фамилия покупателя',
  login VARCHAR(255) UNIQUE NOT NULL COMMENT 'Логин',
  address VARCHAR(255) DEFAULT ' ' COMMENT 'Адрес доставки',
  emeil VARCHAR(255) UNIQUE NOT NULL COMMENT 'Адрес электронной почты',
  scores BIGINT(8) DEFAULT 0 COMMENT 'Бонусные баллы',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users VALUES
  (DEFAULT, 'Геннадий', 'Смирнов', 'gensmirn', DEFAULT, 'gensmir@mail.ru', DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 'Арсений', DEFAULT, 'ars1991', DEFAULT, 'ars1991@mail.ru', 243, DEFAULT, DEFAULT),
  (DEFAULT, 'Алиса', 'Вяткова', 'alvyat', 'Москва, Комсомольский проспект, 24', 'alvyat@mail.ru', 99990, DEFAULT, DEFAULT),
  (DEFAULT, 'Алексей', DEFAULT, 'alekse', DEFAULT, 'alekse@mail.ru', 197, DEFAULT, DEFAULT),
  (DEFAULT, 'Валерия', 'Абсурдова', 'trueeeee', DEFAULT, 'trueee@mail.ru', DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 'Александр', 'Андреев', 'alexandr1992', DEFAULT, 'alexandr1992@mail.ru', 600, DEFAULT, DEFAULT),
  (DEFAULT, 'Дилара', 'Алиева', 'dilara', DEFAULT, 'dilara@mail.ru', DEFAULT, DEFAULT, DEFAULT),
  (DEFAULT, 'Данила', DEFAULT, 'dani89', DEFAULT, 'dani89@mail.ru', 1, DEFAULT, DEFAULT),
  (DEFAULT, 'Иван', 'Городецкий', 'gorodetz', DEFAULT, 'gorodetz@mail.ru', 22, DEFAULT, DEFAULT),
  (DEFAULT, 'Юлия', DEFAULT, 'oiwwaazz tzchii', DEFAULT, 'oiwwaazztzchii@mail.ru', DEFAULT, DEFAULT, DEFAULT) ;

--------------------------------------------------------------------------------

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
  (3, 'м. Беломорская', 'Беломорская 23 к3', '8(977) 446-40-41');
  
-------------------------------------------------------------------------------
  
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id BIGINT(12) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
  user_id BIGINT(12) UNSIGNED NOT NULL,
  product_id BIGINT(12) UNSIGNED NOT NULL,
  rating ENUM('1', '2', '3', '4', '5') COMMENT 'Оценка товара',
  comment TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (product_id) REFERENCES products (id)
) COMMENT 'Комментарии к продуктам' ;

INSERT INTO comments VALUES
  (DEFAULT, 1, 14, 5, 'Отлично! снова чувствую себя молодым!' , DEFAULT),
  (DEFAULT, 1, 2, 4, 'Как все изменилось...',  DEFAULT), 
  (DEFAULT, 4, 22, 5, 'Был пробник, понравился! Надо взять еще чтобы получше распробовать!', DEFAULT) ,
  (DEFAULT, 1, 20, 4, 'Ох, у меня ж утюг дома не выключен... ' DEFAULT),
  (DEFAULT, 3, 29, 4, 'Красивая, качественная и не дорогая гайвань. В живую красный цвет менее насыщенный больше
  в бордовый и серые линии на синем практически не видны. Доволен покупкой', DEFAULT),
  (DEFAULT, 5, 1, 'Очень нежный и ароматный Уишанец. После знакомства с сухим листом решил, что будет сильный и крепкий классический вкус, но оказалось не совсем так. 
  Чай довольно деликатный во вкусе и очень ароматный, особенно шлейф в гундаобэе. Вкус хоть и деликатный, но долгий в послевкусии и чувствуется лёгкая минеральная мелодия утёса. 
  Действительно, на удивление цветочный и даже слегка хлебный, также присутствует карамель брюле и...что-то ещё ягодное или цитрусовое, возможно это ягодная пастила. 
  Хорошему чаю хорошую оценку.', DEFAULT),
  (DEFAULT, 2, 1, 5, 'Прекрасная вещь. Спасибо даочай, снова в дУшу', DEFAULT),
  (DEFAULT, 3, 13, 4, 'Свежий зелёный чай. Не требователен к перезавариванию, запах зелёного горошка и травянистые оттенки. Долгое послевкусие с кислинкой.', DEFAULT),
  (DEFAULT, 9, 16, 4, 'Шик! Заваривать зеленые люблю просто в кружке, ~3 г и 70°, подождать ... Готово! Овощной,цитрусовый, вкус просто шикарен! Как только попадает в рот, чувствуешь овощи гриль,но подождать,оно уже переходит в лайм или лимон,со своей шикарной кислинкой!!!', DEFAULT),
  (DEFAULT, 9, 21, 4, 'Мощный менхайский профиль. На любителя. Выраженная горчинка, кофе, дерево. При варке получается заметно мягче и сбалансированней', DEFAULT) ;

---------------------------------------------------------------------------------

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id BIGINT(12) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
  user_id BIGINT(12) UNSIGNED NOT NULL,
  product_id INT,
  address ENUM('Свой адрес', 'м. Пролетарская', 'м. Филевский парк', 'м. Беломорская') DEFAULT 'м. Пролетарская' COMMENT 'Адрес доставки',
  order_status ENUM('Размещен', 'Обработан', 'Оплачен') COLLATE utf8_unicode_ci DEFAULT 'Размещен' COMMENT 'Статус заказа',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (product_id) REFERENCES products (id),
  FOREIGN KEY (address) REFERENCES stores (id)
) COMMENT 'Журнал заказов всех пользователей' ;

INSERT INTO orders VALUES
  (DEFAULT, 3, 'Свой адрес', 'Обработан', DEFAULT),
  (DEFAULT, 3, 'Свой адрес', 'Обработан', DEFAULT),
  (DEFAULT, 1, 'м. Беломорская', 'Обработан', DEFAULT),
  (DEFAULT, 10, DEFAULT, 'alekse', DEFAULT, DEFAULT),
  (DEFAULT, 5, 'м. Беломорская', 'Оплачен', DEFAULT),
  (DEFAULT, 2, 'м. Пролетарская', 'Обработан', DEFAULT),
  (DEFAULT, 9, 'м. Филевский парк', 'Обработан', DEFAULT),
  (DEFAULT, 6, DEFAULT, 'dani89', 'Обработан', DEFAULT),
  (DEFAULT, 9, 'м. Филевский парк', 'Обработан', DEFAULT),
  (DEFAULT, 4, DEFAULT, 'Обработан', DEFAULT) ;

-----------------------------------------------------------------------------------------

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
  id BIGINT(12) UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
  user_id BIGINT(12) UNSIGNED NOT NULL,
  product_id BIGINT(12) UNSIGNED UNIQUE NOT NULL,
  weight ENUM('10', '20', '25', '50', '100', '200', '357') COMMENT 'Вес в граммах',
  quantity SMALLINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Количество',
  CONSTRAINT cart_to_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT cart_to_product_id_fk FOREIGN KEY (product_id) REFERENCES products (id)
) COMMENT 'Корзина пользователей M x M' ;

INSERT INTO cart VALUES
  (DEFAULT, 1, 'Свой адрес', 'Обработан', DEFAULT),
  (DEFAULT, 2, 'Свой адрес', 'Обработан', DEFAULT),
  (DEFAULT, 3, 'м. Беломорская', 'Обработан', DEFAULT),
  (DEFAULT, 4, DEFAULT, 'alekse', DEFAULT, DEFAULT),
  (DEFAULT, 5, 'м. Беломорская', 'Оплачен', DEFAULT),
  (DEFAULT, 7, 'м. Пролетарская', 'Обработан', DEFAULT),
  (DEFAULT, 8, 'м. Филевский парк', 'Обработан', DEFAULT),
  (DEFAULT, 9, DEFAULT, 'dani89', 'Обработан', DEFAULT),
  (DEFAULT, 10, 'м. Филевский парк', 'Обработан', DEFAULT) ;

------------------------------------------------------------------------

