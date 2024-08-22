SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [commette].[generate_activation_code] (
    @email NVARCHAR(255),
    @code INT
)
AS
BEGIN
    -- Verificar si el email existe en la tabla de usuarios
    DECLARE @n INT = (SELECT COUNT(*) FROM commette.[User] WHERE email = @email);

    -- Si el email existe, insertar el código de activación
    IF @n > 0 
    BEGIN
        INSERT INTO commette.activation_codes (email, code) 
        VALUES (@email, @code);
    END;
    
    -- Devolver un valor indicando que la operación se completó
    SELECT 1 AS completed;
END;
GO
