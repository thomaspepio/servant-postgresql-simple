CREATE TABLE ITEM (
  ID serial,
  NAME varchar(255) not null,
  DESCRIPTION varchar(100),
  QUANTITY int not null
);

INSERT INTO ITEM(NAME, DESCRIPTION, QUANTITY) values ('Nintendo Switch', 'Best console of its generation', 10);
INSERT INTO ITEM(NAME, DESCRIPTION, QUANTITY) values ('Playstation 4', 'Almost as good as the Switch', 20);