CREATE TABLE ITEM (
  ID serial,
  NAME varchar(255) not null,
  DESCRIPTION varchar(100)
);

CREATE TABLE STOCK (
    ID serial,
    ITEM_ID int not null,
    QUANTITY int not null
);

INSERT INTO ITEM(NAME, DESCRIPTION) values ('Nintendo Switch', 'Best console of its generation');
INSERT INTO ITEM(NAME, DESCRIPTION) values ('Playstation 4', 'Almost as good as the Switch');

INSERT INTO STOCK(ITEM_ID, QUANTITY) values((SELECT ID FROM ITEM WHERE NAME='Nintendo Switch'), 10);
INSERT INTO STOCK(ITEM_ID, QUANTITY) values((SELECT ID FROM ITEM WHERE NAME='Playstation 4'), 20);