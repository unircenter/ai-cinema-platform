-- PostgreSQL Schema для AI-Cinema
CREATE SCHEMA IF NOT EXISTS ai_cinema;

-- Таблица пользователей и MLM-структуры
CREATE TABLE ai_cinema.users (
    user_id BIGINT PRIMARY KEY,                 -- Telegram ID пользователя
    username VARCHAR(100),                      -- Юзернейм
    referrer_id BIGINT REFERENCES ai_cinema.users(user_id), -- Спонсор (Уровень 1)
    is_premium BOOLEAN DEFAULT FALSE,           -- Активна ли подписка
    status_legal VARCHAR(20) DEFAULT 'fiz',     -- fiz, npd (самозанятый), ip
    balance_rub DECIMAL(10, 2) DEFAULT 0.00,    -- Баланс для вывода
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица ИИ-видеоконтента
CREATE TABLE ai_cinema.videos (
    video_id SERIAL PRIMARY KEY,
    author_id BIGINT REFERENCES ai_cinema.users(user_id),
    title VARCHAR(255) NOT NULL,
    ai_tools VARCHAR(255),                      -- Теги: Runway, Kling, Midjourney
    video_url VARCHAR(512) NOT NULL,            -- Ссылка в CDN
    status VARCHAR(20) DEFAULT 'sandbox',       -- sandbox или main
    watch_time_total INT DEFAULT 0              -- Время просмотра в секундах
);

-- История транзакций
CREATE TABLE ai_cinema.transactions (
    id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES ai_cinema.users(user_id),
    amount DECIMAL(10, 2),
    level_source INT,                           -- Уровень (1, 2 или 3)
    type VARCHAR(50),                           -- 'referral' или 'author_reward'
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
