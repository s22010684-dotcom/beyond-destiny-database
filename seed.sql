-- 1. Insert Users
INSERT INTO users (role_id, user_name, user_email, password_hash) VALUES
(1, 'Mahesh Kaushalya', 'owner@beyonddestiny.com', 'password123'),
(2, 'Saman Kumara', 'manager@beyonddestiny.com', 'password123'),
(4, 'Ananya Pathumi', 'ananya@beyonddestiny.com', 'password123'),
(4, 'Kasun Perera', 'kasun@beyonddestiny.com', 'password123');

-- 2. Insert Staff Profiles
INSERT INTO staff (user_id, job_role, phone) VALUES
(3, 'Retoucher', '+94771112233'),
(4, 'Album Designer', '+94774445566');

-- 3. Insert Client (Bride & Groom)
INSERT INTO clients (bride_full_name, groom_full_name, primary_contact, email, address) VALUES
('Inami Perera', 'Dimuth Fernando', '+94712789870', 'inami@gmail.com', 'Havelock Residence, Colombo 05');

-- 4. Insert Project (PROJECT #18)
INSERT INTO projects (client_id, project_code, project_name, event_date, current_stage, deadline) VALUES
(1, 'PROJECT #18', 'Inami & Dimuth Wedding', '2026-06-15', 'Retouching', '2026-08-20');

-- 5. Insert Task
INSERT INTO tasks (project_id, task_type_id, title, description, is_urgent, status, deadline) VALUES
(1, 4, 'Ceremony Retouching', 'Retouch 150 main ceremony images', TRUE, 'In Progress', '2026-08-10 18:00:00+00');

-- 6. Assign Task to Staff (Ananya - staff_id = 1)
INSERT INTO task_assignments (task_id, staff_id, assignment_status) VALUES
(1, 1, 'Assigned');