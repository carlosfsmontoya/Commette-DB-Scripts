SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [commette].[create_user]
    @username NVARCHAR(50),
    @firstname NVARCHAR(50),
    @lastname NVARCHAR(50),
    @email NVARCHAR(50),
    @is_seller BIT,
    @company_name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @new_user_id INT;

    -- Insertar en la tabla User
    INSERT INTO commette.[User] (first_name, last_name, username, email, role, registration_date, active)
    VALUES (@firstname, @lastname, @username, @email, 
            CASE WHEN @is_seller = 1 THEN 'Seller' ELSE 'Buyer' END, 
            GETDATE(), 1);

    -- Obtener el ID del usuario recién insertado
    SET @new_user_id = SCOPE_IDENTITY();

    -- Si es vendedor, insertar en la tabla Seller
    IF @is_seller = 1
    BEGIN
        INSERT INTO commette.Seller (id_user, rating_average, rating_count, company_name)
        VALUES (@new_user_id, 0, 0, @company_name);
    END

    -- Devolver el ID del usuario recién insertado
    SELECT @new_user_id AS id_user;
END;
GO
