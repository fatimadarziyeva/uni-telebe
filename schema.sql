-- Kateqoriyalar cədvəli
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- İstifadəçilər cədvəli
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'participant' NOT NULL
);

-- Tədbirlər cədvəli
CREATE TABLE IF NOT EXISTS events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    category_id INT REFERENCES categories(id) ON DELETE CASCADE,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    location VARCHAR(200) NOT NULL,
    max_participants INT NOT NULL,
    created_by INT REFERENCES users(id) ON DELETE CASCADE
);

-- Qeydiyyatlar cədvəli
CREATE TABLE IF NOT EXISTS registrations (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    event_id INT REFERENCES events(id) ON DELETE CASCADE,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, event_id)
);

-- İlkin kateqoriyaların əlavə edilməsi (Əgər əvvəlcədən yoxdursa)
INSERT INTO categories (name) VALUES 
('Elm və Texnologiya'),
('Karyera və İnkişaf'),
('Mədəniyyət və İncəsənət'),
('İdman'),
('Digər')
ON CONFLICT (name) DO NOTHING;
