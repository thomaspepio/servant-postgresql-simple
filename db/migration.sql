CREATE TABLE ITEM (
  ID serial,
  NAME varchar(255) not null,
  DESCRIPTION varchar(100),
  QUANTITY int not null
);

INSERT INTO ITEM(NAME, DESCRIPTION, QUANTITY) values ('La Distinction', 'De Pierre Bourdieu', 10);
INSERT INTO ITEM(NAME, DESCRIPTION, QUANTITY) values ('La misère du monde', 'Ouvrage collectif rédigé sous la direction de Pierre Bourdieu', 20);
INSERT INTO ITEM(NAME, DESCRIPTION, QUANTITY) values ('Capitalisme et désir de servitude', 'De Frédéric Lordon', 0);