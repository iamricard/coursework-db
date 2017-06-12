USE prescriptionsdb;


CREATE OR REPLACE VIEW bb AS
SELECT bnfcodesub
FROM chemicals
WHERE chemicalname REGEXP 'atenolol|bisoprolol|carvedilol|metoprolol|nebivolol|propranolol';


CREATE OR REPLACE VIEW bbprescriptions AS
SELECT practiceid,
       quantity
FROM prescriptions
INNER JOIN bb ON prescriptions.bnfcode LIKE concat(bb.bnfcodesub, '%');


CREATE OR REPLACE VIEW bbpgp AS
SELECT sum(quantity) AS total,
       practiceid,
       practices.practicename
FROM bbprescriptions
LEFT JOIN practices ON bbprescriptions.practiceid = practices.id
GROUP BY practiceid;


CREATE OR REPLACE VIEW ppgp AS
SELECT COUNT(*) AS prescriptioncount,
       practiceid
FROM prescriptions
GROUP BY practiceid
ORDER BY prescriptioncount DESC;


CREATE OR REPLACE VIEW ppc AS
SELECT COUNT(*) AS dispensedamount,
       substring(bnfcode, 1, 9) AS bnfcodesub
FROM prescriptions
GROUP BY substring(bnfcode, 1, 9);


CREATE OR REPLACE VIEW spentpergp AS
SELECT sum(actualcost) AS spent,
       practiceid
FROM prescriptions
GROUP BY practiceid;


CREATE OR REPLACE VIEW ssri AS
SELECT bnfcodesub
FROM chemicals
WHERE chemicalname REGEXP 'citalopram|dapoxetine|escitalopram|fluoxetine|fluvoxamine|paroxetine|sertraline';


CREATE OR REPLACE VIEW ssriprescriptions AS
SELECT practiceid,
       quantity,
       period,
       bnfcodesub
FROM prescriptions
INNER JOIN ssri ON prescriptions.bnfcode LIKE concat(ssri.bnfcodesub, '%');


CREATE OR REPLACE VIEW metformin AS
SELECT bnfcodesub
FROM chemicals
WHERE chemicalname LIKE '%metformin%';


CREATE OR REPLACE VIEW metforminprescriptions AS
SELECT practiceid,
       quantity,
       period,
       bnfcodesub
FROM prescriptions
INNER JOIN metformin ON prescriptions.bnfcode LIKE concat(metformin.bnfcodesub, '%');
