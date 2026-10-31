-- 1. Create Enums
CREATE TYPE user_role_enum AS ENUM ('Owner', 'Manager', 'Staff', 'Administrator');
CREATE TYPE staff_job_enum AS ENUM ('Photo Editor', 'Video Editor', 'Album Designer', 'QC Staff', 'General Staff');
CREATE TYPE task_priority_enum AS ENUM ('Low', 'Medium', 'High', 'Urgent');
CREATE TYPE task_status_enum AS ENUM ('Not Started', 'In Progress', 'Blocked', 'Completed');

-- 2. Create Users Table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role user_role_enum NOT NULL,
    job_role staff_job_enum,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create Clients Table
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    primary_contact_name VARCHAR(120) NOT NULL,
    partner_name VARCHAR(120),
    phone VARCHAR(25) NOT NULL,
    email VARCHAR(120),
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create Projects Table
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES clients(client_id) ON DELETE RESTRICT,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) DEFAULT 'Wedding',
    current_stage VARCHAR(50) DEFAULT 'Filtering',
    deadline DATE,
    notes TEXT,
    is_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Create Tasks Table
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES projects(project_id) ON DELETE CASCADE,
    assigned_to_user_id INT REFERENCES users(user_id) ON DELETE SET NULL,
    title VARCHAR(150) NOT NULL,
    job_type staff_job_enum,
    priority task_priority_enum DEFAULT 'Medium',
    status task_status_enum DEFAULT 'Not Started',
    deadline TIMESTAMP WITH TIME ZONE,
    is_urgent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);