USE prescriptionsdb;

-- a) How many practices and registered patients are there in the N17 postcode
--    Area?

SELECT
  COUNT(*) AS 'practices in n17',
  SUM(patientcount) AS 'patients in n17'
FROM
  practices
LEFT JOIN
  gppatients
ON
  gppatients.practiceid = practices.id
WHERE
  postcode
LIKE
  'N17%';
-- There are 8 practices in the N17 postcode.
-- There are 58118391 registered patients in the N17 postcode.

-- b) Which practice prescribed the most beta blockers per registered patients
--    in total over the two month period?

-- Common beta-blockers include:
-- atenolol
-- bisoprolol
-- carvedilol
-- metoprolol
-- nebivolol
-- propranolol

SELECT
  bbpgp.practiceid AS 'practice id',
  bbpgp.total / gppatients.patientcount AS 'betablockers per patient',
  bbpgp.practicename AS 'practice name'
FROM
  bbpgp
INNER JOIN
  gppatients
ON
  gppatients.practiceid = bbpgp.practiceid
ORDER BY
  'Betablockers per patient'
LIMIT 1;

-- c) Which was the most prescribed medication across all practices?

-- d) Which practice spent the most and the least per patient?

-- e) What was the difference in selective serotonin reuptake inhibitor
--    prescriptions between January and February?

-- f) Visualise the top 10 practices by number of metformin prescriptions
--    throughout the entire period.
