DROP DATABASE IF EXISTS prescriptionsdb;
CREATE DATABASE IF NOT EXISTS prescriptionsdb;
USE prescriptionsdb;

DROP TABLE IF EXISTS prescriptions;
DROP TABLE IF EXISTS gppatients;
DROP TABLE IF EXISTS chemicals;
DROP TABLE IF EXISTS practices;

CREATE TABLE IF NOT EXISTS practices(
  period INT,
  id VARCHAR(6) NOT NULL PRIMARY KEY,
  practicename TEXT,
  address1 TEXT,
  address2 TEXT,
  city TEXT,
  state TEXT,
  postcode TEXT
);

CREATE TABLE IF NOT EXISTS prescriptions(
  id BIGINT NOT NULL AUTO_INCREMENT,
  sha TEXT,
  pct TEXT,
  practiceid VARCHAR(6),
  bnfcode VARCHAR(15),
  bnfname TEXT,
  items INT,
  ingredientcost FLOAT,
  actualcost FLOAT,
  quantity INT,
  period INT,
  PRIMARY KEY (id)
);

ALTER TABLE prescriptions ADD FOREIGN KEY (practiceid) REFERENCES practices(id);

CREATE TABLE IF NOT EXISTS chemicals(
  bnfcodesub VARCHAR(9) PRIMARY KEY,
  chemicalname TEXT
);

CREATE TABLE IF NOT EXISTS gppatients(
  practiceid VARCHAR(6),
  patientcount INT
);

ALTER TABLE gppatients ADD FOREIGN KEY (practiceid) REFERENCES practices(id);

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE practices;
SET FOREIGN_KEY_CHECKS = 1;
TRUNCATE prescriptions;

LOAD DATA LOCAL INFILE './data/practices.csv'
INTO TABLE practices
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
(@period, @id, @name, @address1, @address2, @city, @state, @postcode)
SET
  period = @period,
  id = @id,
  practicename = @name,
  address1 = @address1,
  address2 = @address2,
  city = @city,
  state = @state,
  postcode = @postcode
;

LOAD DATA LOCAL INFILE './data/prescriptions.csv'
INTO TABLE prescriptions
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES
(@id, @sha, @pct, @practice, @bnfc, @bnfn, @items, @nic, @actcost, @qty, @period)
SET
  id = @id, pct = @pct, sha = @sha, practiceid = @practice,
  bnfcode = @bnfc, bnfname = @bnfn, items = @items,
  ingredientcost = @nic, actualcost = @actcost, quantity = @qty,
  period = @period
;

LOAD DATA LOCAL INFILE './data/chemicals.csv'
INTO TABLE chemicals
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES
(@bnf, @name)
SET
  bnfcodesub = @bnf,
  chemicalname = @name
;

LOAD DATA LOCAL INFILE './data/gppatients.csv'
INTO TABLE gppatients
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES
(@practiceid, @i1, @i2, @i3, @i4, @i5, @i6, @i7, @totalpatients)
SET
  practiceid = @practiceid,
  patientcount = @totalpatients
;
