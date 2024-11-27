/*
Usuario.

Un usuario representa una persona que interactúa con el sistema,
con sus credenciales y datos básicos de acceso.

¿Para qué sirve?:

1. Gestión de acceso y autenticación en el sistema.

2. Almacenamiento de información básica de los usuarios.

3. Control de estados y permisos de usuarios.

4. Seguimiento de actividad y auditoría de usuarios.

5. Base para la personalización de la experiencia de usuario.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create User Table
CREATE TABLE [User] (
    -- Primary Key
    id_user BIGINT IDENTITY(1,1) PRIMARY KEY,                 -- Identificador único para el usuario
    
    -- Authentication Information
    user_username NVARCHAR(255) NOT NULL,                     -- Nombre de usuario para iniciar sesión
    user_password NVARCHAR(255) NOT NULL,                     -- Contraseña encriptada del usuario
    
    -- Contact Information
    user_email NVARCHAR(255) NOT NULL,                        -- Dirección de correo electrónico del usuario
    user_phone NVARCHAR(255) NULL,                            -- Número de teléfono del usuario
    
    -- Access Control
    user_is_admin BIT NOT NULL DEFAULT 0,                     -- Indica si el usuario es Administrador (1) o normal (0)
    user_is_active BIT NOT NULL DEFAULT 1,                    -- Indica si el usuario está activo (1) o inactivo (0)
    
    -- Unique Constraints
    CONSTRAINT UQ_User_Username UNIQUE (user_username),
    CONSTRAINT UQ_User_Email UNIQUE (user_email)
);




--Creamos valores para la tabla de users

INSERT INTO [User] (user_username, user_password, user_email, user_phone, user_is_admin, user_is_active)
VALUES
    ('John_Smith', 'password1', 'user1@example.com', '1234567890', 0, 1),
    ('Emily_Rodriguez', 'password2', 'user2@example.com', '0987654321', 1, 1),
    ('Michael_Chen', 'password3', 'user3@example.com', NULL, 0, 1),
    ('Sarah_Williams', 'password4', 'user4@example.com', '1234509876', 0, 0),
    ('David_Garcia', 'password5', 'user5@example.com', '5678901234', 1, 1),
    ('Jessica_Kim', 'password6', 'user6@example.com', NULL, 0, 1),
    ('Ryan_Murphy', 'password7', 'user7@example.com', '9876543210', 0, 1),
    ('Emma_Patel', 'password8', 'user8@example.com', '4561237890', 1, 0),
    ('Alexander_Brown', 'password9', 'user9@example.com', '3217896540', 0, 1),
    ('Olivia_Martinez', 'password10', 'user10@example.com', NULL, 1, 1);

-- Verify the inserted records
SELECT * FROM [User];