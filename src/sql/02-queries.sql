USE prescriptionsdb;

-- a) How many practices and registered patients are there in the N17 postcode
--    Area?

SELECT COUNT(*) AS 'practices in n17',
       SUM(patientcount) AS 'patients in n17'
FROM practices
LEFT JOIN gppatients ON gppatients.practiceid = practices.id
WHERE postcode LIKE 'N17%';

-- +------------------+-----------------+
-- | practices in n17 | patients in n17 |
-- +------------------+-----------------+
-- |                7 | 49358           |
-- +------------------+-----------------+
-- b) Which practice prescribed the most beta blockers per registered patients
--    in total over the two month period?
-- Common beta-blockers include:
-- atenolol
-- bisoprolol
-- carvedilol
-- metoprolol
-- nebivolol
-- propranolol

SELECT bbpgp.practiceid AS 'practice id',
       bbpgp.total / gppatients.patientcount AS betablockersperpatient,
       bbpgp.practicename AS 'practice name'
FROM bbpgp
INNER JOIN gppatients ON gppatients.practiceid = bbpgp.practiceid
ORDER BY betablockersperpatient DESC
LIMIT 1;

-- +-------------+------------------------+------------------------+
-- | practice id | betablockersperpatient | practice name          |
-- +-------------+------------------------+------------------------+
-- | G82651      | 161.0000               | BURRSWOOD NURSING HOME |
-- +-------------+------------------------+------------------------+
-- c) Which was the most prescribed medication across all practices?

SELECT chemicalname,
       dispensedamount
FROM chemicals
INNER JOIN ppc ON ppc.bnfcodesub = chemicals.bnfcodesub
ORDER BY dispensedamount DESC
LIMIT 1;

-- +----------------+-----------------+
-- | chemicalname   | dispensedamount |
-- +----------------+-----------------+
-- | Colecalciferol |          280495 |
-- +----------------+-----------------+
-- d) Which practice spent the most and the least per patient?

SELECT practicename,
       spent
FROM spentpergp
INNER JOIN practices ON id = practiceid
ORDER BY spent DESC
LIMIT 1;


SELECT practicename,
       spent
FROM spentpergp
INNER JOIN practices ON id = practiceid
ORDER BY spent ASC
LIMIT 1;

-- BIGGEST SPENDER
-- +------------------------------+--------------------+
-- | practicename                 | spent              |
-- +------------------------------+--------------------+
-- | MIDLANDS MEDICAL PARTNERSHIP | 1638640.1302093118 |
-- +------------------------------+--------------------+
-- CHEAPEST PEOPLE
-- +------------------------------+---------------------+
-- | practicename                 | spent               |
-- +------------------------------+---------------------+
-- | CRI BURY RECOVERY SERVICES   | 0.17000000178813934 |
-- +------------------------------+---------------------+

-- e) What was the difference in selective serotonin reuptake inhibitor
--    prescriptions between January and February?
-- There are currently seven SSRIs prescribed in the UK:
-- citalopram (Cipramil)
-- dapoxetine (Priligy)
-- escitalopram (Cipralex)
-- fluoxetine (Prozac or Oxactin)
-- fluvoxamine (Faverin)
-- paroxetine (Seroxat)
-- sertraline (Lustral)

SELECT period,
       count(*)
FROM ssriprescriptions
GROUP BY period;

-- f) Visualise the top 10 practices by number of metformin prescriptions
--    throughout the entire period.
