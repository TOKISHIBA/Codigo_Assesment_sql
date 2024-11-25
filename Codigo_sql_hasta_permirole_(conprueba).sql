
/*

PASO 1 INSERTAMOS ALGUNOS USUARIOS EN LA TABLA DE USUARIOS PARA LOS PERMISOS

INSERT INTO [User] (user_username, user_password, user_email, user_phone, user_is_admin, user_is_active)
VALUES
    ('user1', 'password1', 'user1@example.com', '1234567890', 0, 1),
    ('user2', 'password2', 'user2@example.com', '0987654321', 1, 1),
    ('user3', 'password3', 'user3@example.com', NULL, 0, 1),
    ('user4', 'password4', 'user4@example.com', '1234509876', 0, 0),
    ('user5', 'password5', 'user5@example.com', '5678901234', 1, 1),
    ('user6', 'password6', 'user6@example.com', NULL, 0, 1),
    ('user7', 'password7', 'user7@example.com', '9876543210', 0, 1),
    ('user8', 'password8', 'user8@example.com', '4561237890', 1, 0),
    ('user9', 'password9', 'user9@example.com', '3217896540', 0, 1),
    ('user10', 'password10', 'user10@example.com', NULL, 1, 1);

-- Verificar los registros insertados
SELECT * FROM [User];

*/





/*

-- Generar todas las combinaciones posibles para la tabla Permission
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

-- PASO 2 INSERTAMOS LA COMBINACION DE PERMISOS PARA CADA COMPAÑIA
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

-- Insertar los datos generados en la tabla Permission
INSERT INTO Permission (name, description, can_create, can_read, can_update, can_delete, can_import, can_export)
SELECT name, description, can_create, can_read, can_update, can_delete, can_import, can_export
FROM #Combinations;

-- Limpiar la tabla temporal
DROP TABLE #Combinations;

-- Verificar el resultado
SELECT * FROM Permission;

*/



/*
-- PASO 3 INSERTAR DOS COMPAÑIAS COMO EJEMPLO QUE SERAN NUESTROS CLIENTES.
-- Insertar compañías
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
        1
    );

*/




 /*
-- PASO 4 INSERTAMOS ALGUNOS ROLES PARA LA PRIMERA COMPAÑIA--

INSERT INTO Role (company_id, role_name, role_code, role_description, role_active)
VALUES
    (1, 'CFO', 'CFO_ROLE', 'Chief Financial Officer, responsable de la estrategia financiera y la gestión de riesgos.', 1),
    (1, 'Controller Financiero', 'CONTROLLER_ROLE', 'Responsable de supervisar y controlar las operaciones contables y financieras.', 1),
    (1, 'Planeador Financiero', 'PLANNER_ROLE', 'Encargado de planificar las estrategias financieras y presupuestarias.', 1),
    (1, 'Contador', 'ACCOUNTANT_ROLE', 'Responsable de registrar y analizar las operaciones contables de la empresa.', 1),
    (1, 'Tesorero', 'TREASURER_ROLE', 'Gestiona los recursos financieros, la liquidez y los riesgos asociados.', 1);

*/





/*

--PASO 5 CREAREMOS ALGUNOS CENTRO DE COSTO PARA LA TABLA Y HACER PRUBEBAS: 

-- Insertar centros de costo demo
INSERT INTO CostCenter (
    company_id, 
    cosce_parent_id, 
    cosce_code, 
    cosce_name, 
    cosce_description, 
    cosce_budget, 
    cosce_level, 
    cosce_active
)
VALUES
    -- Nivel superior: Dirección General
    (1, NULL, 'CC001', 'Dirección General', 'Centro de costos de la dirección general de la empresa.', 1000000, 1, 1),

    -- Nivel 2: Finanzas
    (1, 1, 'CC002', 'Finanzas', 'Centro de costos para el departamento financiero.', 500000, 2, 1),

    -- Nivel 2: Tecnología
    (1, 1, 'CC003', 'Tecnología', 'Centro de costos para el departamento de tecnología e innovación.', 700000, 2, 1),

    -- Nivel 3: Contabilidad (hijo de Finanzas)
    (1, 2, 'CC004', 'Contabilidad', 'Centro de costos para la gestión contable.', 200000, 3, 1),

    -- Nivel 3: Desarrollo (hijo de Tecnología)
    (1, 3, 'CC005', 'Administrativo', 'Centro de costos para el equipo de gastos administrativos.', 300000, 3, 1);



PASO 6 CREAMOS ALGUNAS BRANCHES PARA LAS COMPAÑIAS

-- Insertar sucursales para las compañías 1 y 2
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

--PASO 7 INSERTAMOS ALGUNOS USUARIOS CON RELACION MUCHOS A MUCHOS 


-- Insertar roles para usuarios en compañías
INSERT INTO UserCompany (user_id, company_id, useco_active)
VALUES
(1, 1, 1),
(2, 1, 1),  
(4, 2, 1),  
(5, 1, 1),  
(6, 1, 1),
(7, 1, 1),
(8, 2, 1);






--PASO 8 INSERTAMOS EN ENTITY_CATALOG LAS DOS ENTIDADES PRINCIPALES DE LA COMPAÑIA

-- Insertar las entidades CostCenter y BranchOffice en la tabla EntityCatalog
INSERT INTO EntityCatalog (entit_name, entit_descrip, entit_active, entit_config)
VALUES
    ('CostCenter', 'Representa los centros de costo de la empresa, utilizados para gestionar y controlar los costos organizacionales.', 1, NULL),
    ('BranchOffice', 'Representa las sucursales de la empresa, incluyendo su ubicación y contacto.', 1, NULL);



    --PASO 9 INSERTAMOS EN PERMIROLE LOS PERMISOS POR ROLE 
INSERT INTO PermiRole (role_id,permission_id,entitycatalog_id,perol_include,perol_record)
VALUES
(7,405,2,1,1);

*/


select * FROM Permirole as a

left JOIN [Role] as b on a.role_id = b.id_role
left JOIN Permission as c on a.permission_id =c.id_permi;














