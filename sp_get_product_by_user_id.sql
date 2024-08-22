SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [commette].[get_products_by_user_id]
    @UserID INT
AS
BEGIN
    SELECT 
        p.id_product AS ProductID,  -- Incluir el ID del producto en los resultados
        p.product_name AS ProductName,
        b.brand_name AS BrandName,
        c.category_name AS CategoryName,
        i.price AS Price,
        i.stock AS QuantityAvailable,
        s.company_name AS SellerCompany,
        p.product_description AS ProductDescription
    FROM commette.Product p
    INNER JOIN commette.Brand b ON p.id_brand = b.id_brand
    INNER JOIN commette.Category c ON p.id_category = c.id_category
    INNER JOIN commette.Inventory i ON p.id_product = i.id_product
    INNER JOIN commette.Seller s ON i.id_seller = s.id_seller
    WHERE s.id_user = @UserID;
END;
GO
