
--PASO 1 INSERTAMOS ALGUNOS USUARIOS EN LA TABLA DE USUARIOS PARA LOS PERMISOS

INSERT INTO [User] (user_username, user_password, user_email, user_phone, user_is_admin, user_is_active)
VALUES
    ('Administrador', 'password1', 'user1@example.com', '1234567890', 1, 1),
    ('gerentejacoboR', 'password2', 'user2@example.com', '0987654321', 1, 1),
    ('GerenteAndresM', 'password3', 'user3@example.com', NULL, 1, 1),
    ('CamilaHRR', 'password4', 'user4@example.com', '1234509876', 1, 1),
    ('JosePlanningM', 'password5', 'user5@example.com', '5678901234', 1, 1),
    ('JuanR', 'password6', 'user6@example.com', NULL, 1, 1),
    ('JoseR', 'password7', 'user7@example.com', '9876543210', 1, 1),
    ('CamiloM', 'password8', 'user8@example.com', '4561237890', 1, 0),
    ('jamonM', 'password9', 'user9@example.com', '3217896540', 1, 1),
    ('vpYinaR', 'password10', 'user10@example.com', NULL, 1, 1);



-- PASO 2 INSERTAMOS LA COMBINACION DE PERMISOS PARA CADA COMPAÑIA
DECLARE @id_permi INT = 0;

-- Tabla temporal para almacenar combinaciones
CREATE TABLE #Combinations (
    id_permi INT,
    can_create BIT,
    can_read BIT,
    can_update BIT,
    can_delete BIT,
    can_import BIT,
    can_export BIT,
    name NVARCHAR(255),
    description NVARCHAR(MAX)
);


INSERT INTO #Combinations (id_permi, can_create, can_read, can_update, can_delete, can_import, can_export, name, description)
SELECT 
    ROW_NUMBER() OVER (ORDER BY a.n, b.n, c.n, d.n, e.n, f.n) AS id_permi,  -- Generar ID incremental
    a.n AS can_create,
    b.n AS can_read,
    c.n AS can_update,
    d.n AS can_delete,
    e.n AS can_import,
    f.n AS can_export,
    CONCAT(
        CASE a.n WHEN 1 THEN 'Create, ' ELSE '' END,
        CASE b.n WHEN 1 THEN 'Read, ' ELSE '' END,
        CASE c.n WHEN 1 THEN 'Update, ' ELSE '' END,
        CASE d.n WHEN 1 THEN 'Delete, ' ELSE '' END,
        CASE e.n WHEN 1 THEN 'Import, ' ELSE '' END,
        CASE f.n WHEN 1 THEN 'Export' ELSE '' END
    ) AS name,
    CONCAT(
        'Permissions: ',
        CASE a.n WHEN 1 THEN 'Create, ' ELSE '' END,
        CASE b.n WHEN 1 THEN 'Read, ' ELSE '' END,
        CASE c.n WHEN 1 THEN 'Update, ' ELSE '' END,
        CASE d.n WHEN 1 THEN 'Delete, ' ELSE '' END,
        CASE e.n WHEN 1 THEN 'Import, ' ELSE '' END,
        CASE f.n WHEN 1 THEN 'Export' ELSE '' END
    ) AS description
FROM 
    (SELECT 0 AS n UNION SELECT 1) a,  -- can_create
    (SELECT 0 AS n UNION SELECT 1) b,  -- can_read
    (SELECT 0 AS n UNION SELECT 1) c,  -- can_update
    (SELECT 0 AS n UNION SELECT 1) d,  -- can_delete
    (SELECT 0 AS n UNION SELECT 1) e,  -- can_import
    (SELECT 0 AS n UNION SELECT 1) f;  -- can_export


-- PASO 3 INSERTAR DOS COMPAÑIAS COMO EJEMPLO QUE SERAN NUESTROS CLIENTES.

INSERT INTO Company (
    compa_name, 
    compa_tradename, 
    compa_doctype, 
    compa_docnum, 
    compa_address, 
    compa_city, 
    compa_state, 
    compa_country, 
    compa_industry, 
    compa_phone, 
    compa_email, 
    compa_website, 
    compa_logo, 
    compa_active
)
VALUES
    -- Registro para Rappi
    (
        'Rappi S.A.S.', 
        'Rappi', 
        'NI', 
        '900345678', 
        'Carrera 12 # 84-55', 
        'Bogotá', 
        'Cundinamarca', 
        'Colombia', 
        'Tecnología y Logística', 
        '+57 1 1234567', 
        'contacto@rappi.com', 
        'https://www.rappi.com', 
        NULL, 
        1
    ),
    -- Registro para McDonald's
    (
        'Arcos Dorados Colombia S.A.S.', 
        'McDonald', 
        'NI', 
        '901234567', 
        'Avenida Carrera 15 # 100-41', 
        'Bogotá', 
        'Cundinamarca', 
        'Colombia', 
        'Alimentos y Bebidas', 
        '+57 1 7654321', 
        'info@mcdonalds.co', 
        'https://www.mcdonalds.co', 
        NULL, 
        1);
        --Insertar compañías
INSERT INTO Company (
    compa_name, 
    compa_tradename, 
    compa_doctype, 
    compa_docnum, 
    compa_address, 
    compa_city, 
    compa_state, 
    compa_country, 
    compa_industry, 
    compa_phone, 
    compa_email, 
    compa_website, 
    compa_logo, 
    compa_active
)
VALUES
    -- Registro para Rappi
    (
        'COMPANIA ADMINISTRADORA', 
        'STONE.COM', 
        'NI', 
        '9003456728', 
        'Carrera 12 # 84-55', 
        'Bogotá', 
        'Cundinamarca', 
        'Colombia', 
        'TecH', 
        '+57 1 1234567', 
        'contactSTONE', 
        'DDD', 
        NULL, 
        1
        );


-- PASO 4 INSERTAMOS ALGUNOS ROLES PARA LA PRIMERA COMPAÑIA--

INSERT INTO Role (company_id, role_name, role_code, role_description, role_active)
VALUES
    (1, 'CFO', 'CFO_ROLE', 'Chief Financial Officer, responsable de la estrategia financiera y la gestión de riesgos.', 1),
    (1, 'Controller Financiero', 'CONTROLLER_ROLE', 'Responsable de supervisar y controlar las operaciones contables y financieras.', 1),
    (1, 'Planeador Financiero', 'PLANNER_ROLE', 'Encargado de planificar las estrategias financieras y presupuestarias.', 1),
    (1, 'Contador', 'ACCOUNTANT_ROLE', 'Responsable de registrar y analizar las operaciones contables de la empresa.', 1),
    (1, 'Tesorero', 'TREASURER_ROLE', 'Gestiona los recursos financieros, la liquidez y los riesgos asociados.', 1),
	(2, 'CFO', 'CFO_ROLEM', 'Chief Financial Officer, responsable de la estrategia financiera y la gestión de riesgos.', 1),
    (2, 'Controller Financiero', 'CONTROLLER_ROLEM', 'Responsable de supervisar y controlar las operaciones contables y financieras.', 1),
    (2, 'Planeador Financiero', 'PLANNER_ROLEM', 'Encargado de planificar las estrategias financieras y presupuestarias.', 1),
    (2, 'Contador', 'ACCOUNTANT_ROLEM', 'Responsable de registrar y analizar las operaciones contables de la empresa.', 1),
    (2, 'Tesorero', 'TREASURER_ROLEM', 'Gestiona los recursos financieros, la liquidez y los riesgos asociados.', 1),
	(6, 'Admin', 'Admin', 'ADMINISTRADOR', 1);



-- PASO 5 Insertar sucursales para las compañías 1 y 2 Y 3
INSERT INTO BranchOffice (
    company_id, 
    broff_name, 
    broff_code, 
    broff_address, 
    broff_city, 
    broff_state, 
    broff_country, 
    broff_phone, 
    broff_email, 
    broff_active
)
VALUES
    -- Sucursales para la compañía 1 (Rappi)
    (1, 'Rappi Bogotá', 'RAPBOG', 'Calle 123, Zona T', 'Bogotá', 'Cundinamarca', 'Colombia', '+57 1 2345678', 'bogota@rappi.com', 1),
    (1, 'Rappi Medellín', 'RAPMED', 'Carrera 45, El Poblado', 'Medellín', 'Antioquia', 'Colombia', '+57 4 2345678', 'medellin@rappi.com', 1),
    (1, 'Rappi Cali', 'RAPCAL', 'Avenida Roosevelt, Tequendama', 'Cali', 'Valle del Cauca', 'Colombia', '+57 2 2345678', 'cali@rappi.com', 1),

    -- Sucursales para la compañía 2 (McDonald’s)
    (2, 'McDonald’s CDMX', 'MCDMX', 'Avenida Insurgentes Sur 123', 'Ciudad de México', 'CDMX', 'México', '+52 55 12345678', 'cdmx@mcdonalds.com', 1),
    (2, 'McDonald’s Monterrey', 'MCMON', 'Calle Hidalgo 456', 'Monterrey', 'Nuevo León', 'México', '+52 81 12345678', 'monterrey@mcdonalds.com', 1),
    (2, 'McDonald’s Guadalajara', 'MCGDL', 'Avenida Chapultepec 789', 'Guadalajara', 'Jalisco', 'México', '+52 33 12345678', 'guadalajara@mcdonalds.com', 1);

INSERT INTO BranchOffice (
    company_id, 
    broff_name, 
    broff_code, 
    broff_address, 
    broff_city, 
    broff_state, 
    broff_country, 
    broff_phone, 
    broff_email, 
    broff_active
)
VALUES
    -- Sucursales para la compañía 1 (Rappi)
    (1, 'Rappi Bogotá', 'RAPBOG', 'Calle 123, Zona T', 'Bogotá', 'Cundinamarca', 'Colombia', '+57 1 2345678', 'bogota@rappi.com', 1),
    (1, 'Rappi Medellín', 'RAPMED', 'Carrera 45, El Poblado', 'Medellín', 'Antioquia', 'Colombia', '+57 4 2345678', 'medellin@rappi.com', 1),
    (1, 'Rappi Cali', 'RAPCAL', 'Avenida Roosevelt, Tequendama', 'Cali', 'Valle del Cauca', 'Colombia', '+57 2 2345678', 'cali@rappi.com', 1),

    -- Sucursales para la compañía 2 (McDonald’s)
    (2, 'McDonald’s CDMX', 'MCDMX', 'Avenida Insurgentes Sur 123', 'Ciudad de México', 'CDMX', 'México', '+52 55 12345678', 'cdmx@mcdonalds.com', 1),
    (2, 'McDonald’s Monterrey', 'MCMON', 'Calle Hidalgo 456', 'Monterrey', 'Nuevo León', 'México', '+52 81 12345678', 'monterrey@mcdonalds.com', 1),
    (2, 'McDonald’s Guadalajara', 'MCGDL', 'Avenida Chapultepec 789', 'Guadalajara', 'Jalisco', 'México', '+52 33 12345678', 'guadalajara@mcdonalds.com', 1);


Paso

--PASO 6 ASIGNAMOS LOS USUARIOS A LAS COMPAÑIAS DONDE IRAN A TENER ACCESO 


INSERT INTO UserCompany (user_id, company_id, useco_active)
VALUES
(1, 1, 1),
(2, 1, 1),  
(4, 2, 1),  
(5, 1, 1),  
(6, 1, 1),
(7, 1, 1),
(8, 2, 1),
(9, 2, 1),
(10, 2, 1);


--PASO 7 INSERTAMOS EN ENTITY_CATALOG LAS DOS ENTIDADES PRINCIPALES DE LA COMPAÑIA QUIENES SERAN LAS LLAVES QUE ABRIRAN LOS PERMISOS DE CADA AREA DE LA COMPAÑIA

-- Insertar las entidades CostCenter y BranchOffice en la tabla EntityCatalog
INSERT INTO EntityCatalog (entit_name, entit_descrip, entit_active, entit_config)
VALUES
    ('CostCenter', 'Representa los centros de costo de la empresa, utilizados para gestionar y controlar los costos organizacionales.', 1, NULL),
    ('BranchOffice', 'Representa las sucursales de la empresa, incluyendo su ubicación y contacto.', 1, NULL);


----PASO 8 CREAMOS TABLA DE RUSER ROLE PARA HACER LAS CONEXCIONES DIRECTAS DEL ROLE AL USUARIO YA QUE EL ROL CONTIENE LAS COMPAÑIAS

CREATE TABLE UserRole (
    -- Primary Key
    id_usrol BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para la relación usuario-rol
    
    -- Foreign Keys
    user_id BIGINT NOT NULL                                   -- Usuario asociado al rol
        CONSTRAINT FK_UserRole_User 
        FOREIGN KEY REFERENCES [User](id_user),
    
    role_id BIGINT NOT NULL                                   -- Rol asociado al usuario
        CONSTRAINT FK_UserRole_Role 
        FOREIGN KEY REFERENCES Role(id_role),
    
    -- Optional: Additional Information
    usrol_start_date DATETIME NOT NULL DEFAULT GETDATE(),     -- Fecha de asignación del rol
    usrol_end_date DATETIME NULL,                             -- Fecha de finalización del rol (opcional)
    
    -- Status
    usrol_active BIT NOT NULL DEFAULT 1,                      -- Indica si la relación usuario-rol está activa
    
    -- Unique constraint to prevent duplicate role assignments
    CONSTRAINT UQ_User_Role UNIQUE (user_id, role_id)
);



 

--------------------------------------------------------------------------STORE PROCEDURE---------------------------------------------------------------------------------------
--ACTUALIZADO ULTIMO
 PROCEDURE GetUserPermissionsUpdated
    @userId BIGINT,
    @entityCatalogId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Temporary table to store permissions with user and company details
    DECLARE @Permissions TABLE (
        UserId BIGINT,
        UserName NVARCHAR(255),
        CompanyId BIGINT,
        CompanyName NVARCHAR(255),
        PermissionName NVARCHAR(255),
        CanCreate BIT DEFAULT 0,
        CanRead BIT DEFAULT 0,
        CanUpdate BIT DEFAULT 0,
        CanDelete BIT DEFAULT 0,
        CanImport BIT DEFAULT 0,
        CanExport BIT DEFAULT 0,
        RecordId BIGINT NULL,
        PermissionSource NVARCHAR(50)
    );

    -- Step 1: Check PermiUserRecord first (record-level permissions)
    INSERT INTO @Permissions (
        UserId, UserName, CompanyId, CompanyName,
        PermissionName, CanCreate, CanRead, CanUpdate, 
        CanDelete, CanImport, CanExport, RecordId, PermissionSource
    )
    SELECT 
        U.id_user,
        U.user_username,
        C.id_compa,
        C.compa_name,
        P.name,
        CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_create ELSE 0 END AS BIT),
        CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_read ELSE 0 END AS BIT),
        CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_update ELSE 0 END AS BIT),
        CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_delete ELSE 0 END AS BIT),
        CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_import ELSE 0 END AS BIT),
        CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_export ELSE 0 END AS BIT),
        PU.peusr_record,
        'PermiUserRecord'
    FROM 
        PermiUserRecord PU
    JOIN 
        UserCompany UC ON PU.usercompany_id = UC.company_id
    JOIN 
        Company C ON UC.company_id = C.id_compa
    JOIN 
        [User] U ON UC.user_id = U.id_user
    JOIN 
        Permission P ON PU.permission_id = P.id_permi
    JOIN 
        EntityCatalog E ON PU.entitycatalog_id = E.id_entit
    WHERE 
        U.id_user = @userId AND 
        E.id_entit = @entityCatalogId;

    -- Step 2: If no record-level permissions, check PermiUser (entity-level permissions)
    IF NOT EXISTS (SELECT 1 FROM @Permissions)
    BEGIN
        INSERT INTO @Permissions (
            UserId, UserName, CompanyId, CompanyName,
            PermissionName, CanCreate, CanRead, CanUpdate, 
            CanDelete, CanImport, CanExport, PermissionSource
        )
        SELECT 
           U.id_user,
        U.user_username,
        C.id_compa,
        C.compa_name,
        P.name,
            CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_create ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_read ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_update ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_delete ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_import ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.peusr_include = 1 THEN P.can_export ELSE 0 END AS BIT),
            'PermiUser'
        FROM 
            PermiUser PU
        JOIN 
            UserCompany UC ON PU.usercompany_id = UC.company_id
        JOIN 
            Company C ON UC.company_id = C.id_compa
        JOIN 
            [User] U ON UC.user_id = U.id_user
        JOIN 
            Permission P ON PU.permission_id = P.id_permi
        JOIN 
            EntityCatalog E ON PU.entitycatalog_id = E.id_entit
        WHERE 
            U.id_user = @userId AND 
            E.id_entit = @entityCatalogId;
    END;

    -- Step 3: If no user-specific permissions, check user's roles
    IF NOT EXISTS (SELECT 1 FROM @Permissions)
    BEGIN
        -- First, try PermiRoleRecord for roles
        INSERT INTO @Permissions (
            UserId, UserName, CompanyId, CompanyName,
            PermissionName, CanCreate, CanRead, CanUpdate, 
            CanDelete, CanImport, CanExport, RecordId, PermissionSource
        )
        SELECT 
           U.id_user,
        U.user_username,
        C.id_compa,
        C.compa_name,
        P.name,
            CAST(CASE WHEN PU.perrc_include = 1 THEN P.can_create ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.perrc_include = 1 THEN P.can_read ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.perrc_include = 1 THEN P.can_update ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.perrc_include = 1 THEN P.can_delete ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.perrc_include = 1 THEN P.can_import ELSE 0 END AS BIT),
            CAST(CASE WHEN PU.perrc_include = 1 THEN P.can_export ELSE 0 END AS BIT),
            PU.perrc_record,
            'PermiRoleRecord'
        FROM 
            PermiRoleRecord PU
        JOIN 
            UserRole UR ON PU.role_id = UR.role_id
        JOIN 
            UserCompany UC ON UR.user_id = UC.user_id
        JOIN 
            Company C ON UC.company_id = C.id_compa
        JOIN 
            [User] U ON UC.user_id = U.id_user
        JOIN 
            Permission P ON PU.permission_id = P.id_permi
        JOIN 
            EntityCatalog E ON PU.entitycatalog_id = E.id_entit
        WHERE 
            U.id_user = @userId AND 
            E.id_entit = @entityCatalogId;

        -- If no role record-level permissions, check PermiRole
        IF NOT EXISTS (SELECT 1 FROM @Permissions)
        BEGIN
            INSERT INTO @Permissions (
                UserId, UserName, CompanyId, CompanyName,
                PermissionName, CanCreate, CanRead, CanUpdate, 
                CanDelete, CanImport, CanExport, PermissionSource
            )
            SELECT 
                U.id_user,
        U.user_username,
        C.id_compa,
        C.compa_name,
        P.name,
                CAST(CASE WHEN PU.perol_include = 1 THEN P.can_create ELSE 0 END AS BIT),
                CAST(CASE WHEN PU.perol_include = 1 THEN P.can_read ELSE 0 END AS BIT),
                CAST(CASE WHEN PU.perol_include = 1 THEN P.can_update ELSE 0 END AS BIT),
                CAST(CASE WHEN PU.perol_include = 1 THEN P.can_delete ELSE 0 END AS BIT),
                CAST(CASE WHEN PU.perol_include = 1 THEN P.can_import ELSE 0 END AS BIT),
                CAST(CASE WHEN PU.perol_include = 1 THEN P.can_export ELSE 0 END AS BIT),
                'PermiRole'
            FROM 
                PermiRole PU
            JOIN 
                UserRole UR ON PU.role_id = UR.role_id
            JOIN 
                UserCompany UC ON UR.user_id = UC.user_id
            JOIN 
                Company C ON UC.company_id = C.id_compa
            JOIN 
                [User] U ON UC.user_id = U.id_user
            JOIN 
                Permission P ON PU.permission_id = P.id_permi
            JOIN 
                EntityCatalog E ON PU.entitycatalog_id = E.id_entit
            WHERE 
                U.id_user = @userId AND 
                E.id_entit = @entityCatalogId;
        END;
    END;

    -- Return consolidated permissions with user and company details
    SELECT 
        UserId,
        UserName,
        CompanyId,
        CompanyName,
        PermissionName,
        MAX(CAST(CanCreate AS INT)) AS CanCreate,
        MAX(CAST(CanRead AS INT)) AS CanRead,
        MAX(CAST(CanUpdate AS INT)) AS CanUpdate,
        MAX(CAST(CanDelete AS INT)) AS CanDelete,
        MAX(CAST(CanImport AS INT)) AS CanImport,
        MAX(CAST(CanExport AS INT)) AS CanExport,
        PermissionSource
    FROM @Permissions
    GROUP BY UserId, UserName, CompanyId, CompanyName, PermissionName, PermissionSource;
END;




-- Usuarios conectados a las compañias

SELECT 
  U.user_username,
  C.compa_tradename
 FROM UserCompany UC
LEFT JOIN [User] U ON U.id_user = UC.user_id
LEFT JOIN Company C ON C.id_compa = UC.company_id;
