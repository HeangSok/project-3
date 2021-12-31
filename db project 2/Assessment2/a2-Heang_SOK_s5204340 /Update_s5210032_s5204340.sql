-- Task 4:
-- Insert additional data in the tables appropriately


-- Select a database

USE BigM_s5210032_s5204340;

-- Insert into CUSTOMER Table

INSERT INTO CUSTOMER VALUES 
	(NULL, 'Daniel', 'Ortega', '0431xxx668');

-- Insert into CUSTOMERORDER Table

INSERT INTO CUSTOMERORDER VALUES 
    (NULL, '2018-09-06', 11, 2);

-- Insert into ORDERLINE Table

INSERT INTO ORDERLINE VALUES 
    (26, 8,'2018-09-08', '2018-09-10', 2);

-- Insert into INVENTORY Table

UPDATE INVENTORY SET
    Inv_QntyOnHand = 13,
    Inv_QtyOrdered = 2
    WHERE ProductNum = 8 AND Str_Num = 2;
    