SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [commette].[delete_product_and_inventory]
    @id_product INT
AS
BEGIN
    -- Inicia una transacción para asegurarte de que ambas operaciones se completen exitosamente o se deshagan
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Elimina primero el inventario asociado al producto
        DELETE FROM commette.Inventory
        WHERE id_product = @id_product;

        -- Luego elimina el producto
        DELETE FROM commette.Product
        WHERE id_product = @id_product;

        -- Si ambas eliminaciones fueron exitosas, confirma la transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revierte la transacción
        ROLLBACK TRANSACTION;
        
        -- Lanza el error para manejo posterior
        THROW;
    END CATCH
END;
GO
