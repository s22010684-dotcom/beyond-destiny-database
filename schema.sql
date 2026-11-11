-- Clean up existing tables
DROP TABLE IF EXISTS task_status_history CASCADE;
DROP TABLE IF EXISTS task_assignments CASCADE;
DROP TABLE IF EXISTS tasks CASCADE;
DROP TABLE IF EXISTS task_types CASCADE;
DROP TABLE IF EXISTS client_feedback CASCADE;
DROP TABLE IF EXISTS deliverables CASCADE;
DROP TABLE IF EXISTS deliverable_types CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TYPE IF EXISTS staff_job_enum CASCADE;

-- 1. Roles Table
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL -- 'Owner', 'Manager', 'Administrator', 'Staff'
);

-- 2. Users Table (Authentication)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES roles(role_id) ON DELETE RESTRICT,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Staff Table
CREATE TYPE staff_job_enum AS ENUM (
    'Filter', 
    'Selector', 
    'Editor', 
    'Retoucher', 
    'Album Designer', 
    'Full Video Editor', 
    'Trailer Editor'
);

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    job_role staff_job_enum NOT NULL,
    phone VARCHAR(25),
    is_active BOOLEAN DEFAULT TRUE
);

-- 4. Clients Table
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    bride_full_name VARCHAR(120) NOT NULL,
    groom_full_name VARCHAR(120) NOT NULL,
    primary_contact VARCHAR(25) NOT NULL,
    email VARCHAR(120),
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Projects Table
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES clients(client_id) ON DELETE RESTRICT,
    project_code VARCHAR(30) UNIQUE NOT NULL, -- e.g. 'PROJECT #18'
    project_name VARCHAR(150) NOT NULL,
    event_date DATE NOT NULL,
    current_stage VARCHAR(50) DEFAULT 'Filtering',
    deadline DATE,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. Task Types Table
CREATE TABLE task_types (
    task_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL
);

-- 7. Tasks Table
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES projects(project_id) ON DELETE CASCADE,
    task_type_id INT REFERENCES task_types(task_type_id) ON DELETE SET NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    is_urgent BOOLEAN DEFAULT FALSE,
    status VARCHAR(50) DEFAULT 'Not Started',
    deadline TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 8. Task Assignments Table
CREATE TABLE task_assignments (
    assignment_id SERIAL PRIMARY KEY,
    task_id INT NOT NULL REFERENCES tasks(task_id) ON DELETE CASCADE,
    staff_id INT NOT NULL REFERENCES staff(staff_id) ON DELETE CASCADE,
    start_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP WITH TIME ZONE,
    assignment_status VARCHAR(50) DEFAULT 'Assigned',
    reassigned_reason TEXT
);

-- 9. Task Status History Table
CREATE TABLE task_status_history (
    history_id SERIAL PRIMARY KEY,
    task_id INT NOT NULL REFERENCES tasks(task_id) ON DELETE CASCADE,
    previous_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    changed_by_user_id INT REFERENCES users(user_id) ON DELETE SET NULL,
    change_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    note TEXT
);

-- Insert Default System Roles
INSERT INTO roles (role_name) VALUES 
('Owner'), ('Manager'), ('Administrator'), ('Staff');

-- Insert Default Task Types
INSERT INTO task_types (type_name) VALUES 
('Photo Filtering'), ('Photo Selection'), ('Editing'), 
('Retouching'), ('Album Designing'), ('Full Video Editing'), ('Trailer Editing');