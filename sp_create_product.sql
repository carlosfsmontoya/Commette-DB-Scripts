SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [commette].[create_product]
    @id_user INT,  -- Cambiado a id_user
    @id_brand INT,
    @id_category INT,
    @product_name VARCHAR(50),
    @product_image VARCHAR(255),
    @product_description VARCHAR(255),
    @price DECIMAL(10,2),
    @stock INT
AS
BEGIN
    -- Declarar una variable para el id_seller
    DECLARE @id_seller INT;

    -- Obtener el id_seller correspondiente al id_user
    SELECT @id_seller = id_seller
    FROM commette.Seller
    WHERE id_user = @id_user;

    -- Verificar si se encontró un id_seller
    IF @id_seller IS NULL
    BEGIN
        RAISERROR('No seller found for the given user ID.', 16, 1);
        RETURN;
    END

    -- Insertar en la tabla Product
    INSERT INTO commette.Product (id_brand, id_category, product_name, product_image, product_description)
    VALUES (@id_brand, @id_category, @product_name, @product_image, @product_description);

    -- Obtener el ID del producto insertado
    DECLARE @new_product_id INT;
    SET @new_product_id = SCOPE_IDENTITY();

    -- Insertar en la tabla Inventory
    INSERT INTO commette.Inventory (id_seller, price, stock, inventory_entry_date, id_product)
    VALUES (@id_seller, @price, @stock, GETDATE(), @new_product_id);
END;
GO
