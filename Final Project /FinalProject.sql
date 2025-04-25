-- Members
CREATE TABLE Members (
	username VARCHAR(50) UNIQUE NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
    member_id BIGSERIAL PRIMARY KEY,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

--Categories 
CREATE TABLE Categories (
    category_id SMALLSERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Courses 
CREATE TABLE Courses (
    course_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    instructor VARCHAR(100),
    category_id SMALLINT,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Enrollments
CREATE TABLE Enrollments (
    enrollment_id BIGSERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_member FOREIGN KEY (member_id) REFERENCES Members(member_id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    CONSTRAINT uq_member_course UNIQUE (member_id, course_id) -- A student shouldn't attend a course more than once.
);

-- Certificates
CREATE TABLE Certificates (
    certificate_id BIGSERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE DEFAULT CURRENT_DATE
);

-- Certificate Assignments
CREATE TABLE CertificateAssignments (
    assignment_id BIGSERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    certificate_id BIGINT NOT NULL,
    assignment_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_member_certificate FOREIGN KEY (member_id) REFERENCES Members(member_id),
    CONSTRAINT fk_certificate FOREIGN KEY (certificate_id) REFERENCES Certificates(certificate_id),
    CONSTRAINT uq_member_certificate UNIQUE (member_id, certificate_id) 
);

-- Blog
CREATE TABLE BlogPosts (
    post_id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id BIGINT NOT NULL,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES Members(member_id)
);
