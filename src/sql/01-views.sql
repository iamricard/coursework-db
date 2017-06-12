USE prescriptionsdb;


CREATE OR REPLACE VIEW bb AS
SELECT bnfcodesub
FROM chemicals
WHERE chemicalname regexp 'atenolol|bisoprolol|carvedilol|metoprolol|nebivolol|propranolol';


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
SELECT count(*) AS prescriptioncount,
       practiceid
FROM prescriptions
GROUP BY practiceid
ORDER BY prescriptioncount DESC;


CREATE OR REPLACE VIEW ppc AS
SELECT count(*) AS dispensedamount,
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
WHERE chemicalname regexp 'citalopram|dapoxetine|escitalopram|fluoxetine|fluvoxamine|paroxetine|sertraline';


CREATE OR REPLACE VIEW ssriprescriptions AS
SELECT practiceid,
       quantity,
       period,
       bnfcodesub
FROM prescriptions
INNER JOIN ssri ON prescriptions.bnfcode LIKE concat(ssri.bnfcodesub, '%');
