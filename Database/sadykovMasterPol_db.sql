-- ============================================================
-- База данных: sadykovmasterfloor (Мастер пол)
-- Схема: app
-- Автор: Sadykov
-- Проект: sadykovMasterPol
-- Описание: Подсистема работы с партнёрами
-- ============================================================

-- 1. Роль для подключения приложения
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'app') THEN
        CREATE ROLE app WITH LOGIN PASSWORD '123456789';
    END IF;
END
$$;

-- 2. База данных создаётся отдельно командой:
-- CREATE DATABASE masterfloor OWNER app;

-- 3. Схема app
CREATE SCHEMA IF NOT EXISTS app AUTHORIZATION app;

-- Устанавливаем search_path
SET search_path TO app;

-- ============================================================
-- Таблица типов партнёров
-- ============================================================
CREATE TABLE IF NOT EXISTS app.partner_types (
    id          SERIAL          PRIMARY KEY,
    type_name   VARCHAR(100)    NOT NULL UNIQUE
);

-- ============================================================
-- Таблица партнёров
-- ============================================================
CREATE TABLE IF NOT EXISTS app.partners (
    id              SERIAL          PRIMARY KEY,
    type_id         INTEGER         NOT NULL REFERENCES app.partner_types(id) ON DELETE RESTRICT,
    company_name    VARCHAR(255)    NOT NULL,
    legal_address   VARCHAR(500)    NOT NULL,
    inn             VARCHAR(12)     NOT NULL UNIQUE,
    director_name   VARCHAR(255)    NOT NULL,
    phone           VARCHAR(20)     NOT NULL,
    email           VARCHAR(255)    NOT NULL,
    rating          INTEGER         NOT NULL DEFAULT 0 CHECK (rating >= 0),
    logo_path       VARCHAR(500)    NULL
);

-- ============================================================
-- Таблица продукции
-- ============================================================
CREATE TABLE IF NOT EXISTS app.products (
    id              SERIAL          PRIMARY KEY,
    article         VARCHAR(50)     NOT NULL UNIQUE,
    product_name    VARCHAR(255)    NOT NULL,
    product_type    VARCHAR(100)    NOT NULL,
    min_price       NUMERIC(12,2)   NOT NULL CHECK (min_price >= 0)
);

-- ============================================================
-- Таблица истории реализации продукции партнёром
-- (один партнёр -> много записей о продажах)
-- ============================================================
CREATE TABLE IF NOT EXISTS app.partner_sales (
    id              SERIAL          PRIMARY KEY,
    partner_id      INTEGER         NOT NULL REFERENCES app.partners(id) ON DELETE CASCADE,
    product_id      INTEGER         NOT NULL REFERENCES app.products(id) ON DELETE RESTRICT,
    quantity        INTEGER         NOT NULL CHECK (quantity > 0),
    sale_date       DATE            NOT NULL DEFAULT CURRENT_DATE
);

-- ============================================================
-- Права доступа для роли app
-- ============================================================
GRANT USAGE ON SCHEMA app TO app;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA app TO app;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA app TO app;

-- ============================================================
-- Тестовые данные
-- ============================================================

-- Типы партнёров
INSERT INTO app.partner_types (type_name) VALUES
    ('ЗАО'),
    ('ООО'),
    ('ПАО'),
    ('ОАО')
ON CONFLICT (type_name) DO NOTHING;

-- Продукция
INSERT INTO app.products (article, product_name, product_type, min_price) VALUES
    ('ART-001', 'Ламинат дуб светлый 33 класс', 'Ламинат',    850.00),
    ('ART-002', 'Ламинат венге 32 класс',        'Ламинат',    720.00),
    ('ART-003', 'Паркетная доска ясень',          'Паркет',   1200.00),
    ('ART-004', 'Виниловый ПВХ плинтус',          'Плинтус',   180.00),
    ('ART-005', 'Кварцвиниловая плитка серая',    'Плитка',    950.00)
ON CONFLICT (article) DO NOTHING;

-- Партнёры
INSERT INTO app.partners (type_id, company_name, legal_address, inn, director_name, phone, email, rating)
VALUES
    (2, 'СтройМаркет',       'г. Москва, ул. Строителей, 15',     '7712345678',  'Иванов Иван Иванович',    '+7 495 123 45 67', 'info@stroymarket.ru',   8),
    (1, 'ПолДом',            'г. Санкт-Петербург, пр. Невский, 3','7801234567',  'Петров Пётр Петрович',    '+7 812 234 56 78', 'contact@poldom.ru',     5),
    (3, 'ФлорТрейд',         'г. Екатеринбург, ул. Ленина, 42',   '6612345678',  'Сидоров Алексей Николаевич','+7 343 345 67 89','floor@floortrade.ru',  10),
    (2, 'МегаПол',           'г. Казань, ул. Баумана, 7',         '1651234567',  'Козлов Дмитрий Сергеевич','+7 843 456 78 90', 'mega@megapol.ru',       3),
    (4, 'ЭлитФлоринг',       'г. Краснодар, ул. Красная, 112',    '2312345678',  'Новиков Виктор Андреевич','+7 861 567 89 01', 'elite@eliteflooring.ru',7)
ON CONFLICT (inn) DO NOTHING;

-- История продаж
INSERT INTO app.partner_sales (partner_id, product_id, quantity, sale_date) VALUES
    (1, 1, 5000,  '2024-01-15'),
    (1, 2, 8000,  '2024-03-20'),
    (1, 3, 12000, '2024-06-10'),
    (2, 1, 3000,  '2024-02-14'),
    (2, 4, 1500,  '2024-04-05'),
    (3, 1, 50000, '2023-11-01'),
    (3, 2, 30000, '2024-01-20'),
    (3, 5, 80000, '2024-07-18'),
    (4, 3, 2000,  '2024-05-22'),
    (5, 1, 15000, '2024-03-30'),
    (5, 2, 20000, '2024-08-11');
