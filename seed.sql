INSERT INTO users (full_name, email, password_hash, role, job_role) VALUES
('Kasun Perera', 'kasun@beyonddestiny.com', 'hashed_pw_1', 'Staff', 'Photo Editor'),
('Nethmi Silva', 'nethmi@beyonddestiny.com', 'hashed_pw_2', 'Staff', 'Album Designer'),
('Anjana Gamage', 'anjana@beyonddestiny.com', 'hashed_pw_3', 'Staff', 'Photo Editor'),
('Admin User', 'admin@beyonddestiny.com', 'hashed_pw_4', 'Administrator', NULL)


INSERT INTO clients (primary_contact_name, phone, email, address) VALUES
('Inami & Dimuth', '+94 77 123 4567', 'inamid@gmail.com', 'Kalubowila, Dehiwala, Colombo 00500, Sri Lanka')

INSERT INTO projects (client_id, event_type, event_date, deadline, is_completed) VALUES
(1, 'Wedding', '2026-06-12', '2026-07-30', false)

INSERT INTO tasks (project_id, assigned_to_user_id, title, status) VALUES
(1, 1, 'Culling', 'Completed'),
(1, 1, 'Photo Selection', 'Completed'),
(1, 1, 'Editing', 'In Progress'),
(1, 3, 'Retouch', 'Not Started'),
(1, 2, 'Album Design', 'Not Started')