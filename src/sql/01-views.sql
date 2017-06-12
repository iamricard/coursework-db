USE prescriptionsdb;

CREATE OR REPLACE VIEW bb AS
SELECT bnfcodesub FROM chemicals
WHERE chemicalname
REGEXP 'atenolol|bisoprolol|carvedilol|metoprolol|nebivolol|propranolol';

CREATE OR REPLACE VIEW bbprescriptions AS
SELECT practiceid, quantity
FROM prescriptions
INNER JOIN bb
ON prescriptions.bnfcode
LIKE CONCAT(bb.bnfcodesub, '%');

CREATE OR REPLACE VIEW bbpgp AS
SELECT SUM(quantity) AS total, practiceid, practices.practicename
FROM bbprescriptions
LEFT JOIN practices
ON bbprescriptions.practiceid = practices.id
GROUP BY practiceid;
