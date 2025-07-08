use India_Election_Result;

-- Total Seats
SELECT 
distinct count('Parliament Constituency') as Total_Seats
from india_election_result.constituencywise_results ;

-- What are the total number of Seats Available for election in each State
SELECT 
    s.State AS State_name,
    COUNT(DISTINCT cr.`Parliament Constituency`) AS Total_seats
FROM india_election_result.constituencywise_results cr
INNER JOIN india_election_result.statewise_result sr 
    ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
INNER JOIN india_election_result.states s 
    ON s.`State ID` = sr.`State ID`
GROUP BY s.State;

-- Total Seats Won By NDA Alliance
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN `Won`
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    india_election_result.partywise_results;
    
-- -- Total Seats Won By NDA Alliance   parties With Name 
SELECT 
    party AS Party_Name,
    won AS Seats_Won
FROM 
    india_election_result.partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY 
    Seats_Won DESC;

-- Seats Won by I.N.D.I.A. Allianz Parties

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN `Won`
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    india_election_result.partywise_results;

-- Seats Won By the I.N.D.I.A Alliance Party

SELECT 
    party AS Party_Name,
    won AS Seats_Won
FROM 
    india_election_result.partywise_results
WHERE 
    party IN (
        'Indian National Congress - INC',
        'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Jharkhand Mukti Morcha - JMM',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP',
        'Samajwadi Party - SP',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY 
    Seats_Won DESC;
/*
Add new column field in table partywise_results to get 
the Party Allianz as NDA, I.N.D.I.A and OTHER
*/

-- Step 1: Add new column
ALTER TABLE india_election_result.partywise_results
ADD party_alliance VARCHAR(50);

-- Step 2: Update I.N.D.I.A. alliance parties
UPDATE india_election_result.partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

-- Step 3: Update NDA alliance parties
UPDATE india_election_result.partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

-- Step 4: Mark remaining parties as OTHER
UPDATE india_election_result.partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select 
party_alliance, sum(won) as Total_seats
from india_election_result.`partywise_results`
group by party_alliance
order by Total_seats desc;

-- for single party short query
select
party,
won
from india_election_result.`partywise_results`
where party_alliance = 'I.N.D.I.A'
order by won desc;
 
SELECT     
    p.`party_alliance`,     
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM     
    india_election_result.`constituencywise_results` cr
JOIN     
    india_election_result.`partywise_results` p     
    ON cr.`Party ID` = p.`Party ID`
WHERE     
    p.`party_alliance` IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY     
    p.`party_alliance`
ORDER BY     
    Seats_Won DESC;




-- Winning candidate's name, their party name, total votes, and 
-- the margin of victory for a specific state and constituency?

select
cr.`Winning Candidate` ,
pr.Party, pr.party_alliance,
cr.`Total votes`, 
cr.Margin, s.state , 
cr.`Constituency Name`
From 
`india_election_result`.`constituencywise_results` cr
inner join
`india_election_result`.`partywise_results` pr
on cr.`party Id` = pr .`Party id`
inner join 
`india_election_result`.`statewise_result` sr 
on cr.`Parliament Constituency`  = sr .`Parliament Constituency`
inner join
india_election_result.states s 
on sr.`state id` = s.`state id`
where cr.`Constituency Name` = "BARAMATI";


-- What is the distribution of EVM votes versus postal votes for
-- candidates in a specific constituency?

SHOW COLUMNS FROM india_election_result.constituencywise_details;

SELECT 
    cd.Candidate,
    cd.`EVM Votes`,
    cd.`Postal Votes`,
    cd.`Total Votes`,
    cr.`Constituency Name`
FROM 
    india_election_result.constituencywise_details cd
JOIN 
    india_election_result.constituencywise_results cr 
    ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE 
    cr.`Constituency Name` = 'BUXAR'
ORDER BY 
    cd.`Total Votes` DESC;



SELECT DISTINCT `Constituency Name` 
FROM india_election_result.constituencywise_results;

SELECT * 
FROM india_election_result.constituencywise_results 
WHERE `Constituency Name` LIKE '%AMETHI%';

SELECT *
FROM india_election_result.constituencywise_details
WHERE TRIM(`Constituency ID`) ='S2437';

SELECT * 
FROM india_election_result.constituencywise_details
LIMIT 10;

-- Which parties won the most seats in s State, 
-- and how many seats did each party win?

SELECT 
    p.Party,
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM 
    india_election_result.constituencywise_results cr
JOIN 
    india_election_result.partywise_results p 
    ON cr.`Party ID` = p.`Party ID`
JOIN 
    india_election_result.statewise_result sr 
    ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN 
    india_election_result.states s 
    ON sr.`State ID` = s.`State ID`
WHERE 
    s.State = 'Madhya Pradesh'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;
    
-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each 
-- state for the India Elections 2024

SELECT 
s.State AS State_Name,
SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
    india_election_result.constituencywise_results cr
JOIN 
    india_election_result.partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN 
    india_election_result.statewise_result sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN 
    india_election_result.states s ON sr.`State ID` = s.`State ID`
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    s.State
ORDER BY 
    s.State;

-- Which candidate received the highest number of 
-- EVM votes in each constituency (Top 10)?

SELECT 
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.Candidate,
    cd.`EVM Votes`
FROM 
    india_election_result.constituencywise_details cd
JOIN 
    india_election_result.constituencywise_results cr 
    ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE 
    cd.`EVM Votes` = (
        SELECT MAX(cd1.`EVM Votes`)
        FROM india_election_result.constituencywise_details cd1
        WHERE cd1.`Constituency ID` = cd.`Constituency ID`
    )
ORDER BY 
    cd.`EVM Votes` DESC
LIMIT 10;

-- Which candidate won and which candidate was the runner-up in each 
-- constituency of State for the 2024 elections?

WITH RankedCandidates AS (
    SELECT 
        cd.`Constituency ID`,
        cd.Candidate,
        cd.Party,
        cd.`EVM Votes`,
        cd.`Postal Votes`,
        cd.`EVM Votes` + cd.`Postal Votes` AS Total_Votes,
        ROW_NUMBER() OVER (
            PARTITION BY cd.`Constituency ID`
            ORDER BY cd.`EVM Votes` + cd.`Postal Votes` DESC
        ) AS VoteRank
    FROM 
        india_election_result.constituencywise_details cd
    JOIN 
        india_election_result.constituencywise_results cr 
        ON cd.`Constituency ID` = cr.`Constituency ID`
    JOIN 
        india_election_result.statewise_result sr 
        ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
    JOIN 
        india_election_result.states s 
        ON sr.`State ID` = s.`State ID`
    WHERE 
        s.State = 'Maharashtra'
)

SELECT 
    cr.`Constituency Name`,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    india_election_result.constituencywise_results cr 
    ON rc.`Constituency ID` = cr.`Constituency ID`
GROUP BY 
    cr.`Constituency Name`
ORDER BY 
    cr.`Constituency Name`
LIMIT 10;
    
-- For the state of Maharashtra, what are the total number of seats,
-- total number of candidates, total number of parties, 
-- total votes (including EVM and postal), and the breakdown of 
-- EVM and postal votes? 

SELECT 
    COUNT(DISTINCT cr.`Constituency ID`) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.`EVM Votes` + cd.`Postal Votes`) AS Total_Votes,
    SUM(cd.`EVM Votes`) AS Total_EVM_Votes,
    SUM(cd.`Postal Votes`) AS Total_Postal_Votes
FROM 
    india_election_result.constituencywise_results cr
JOIN 
    india_election_result.constituencywise_details cd 
    ON cr.`Constituency ID` = cd.`Constituency ID`
JOIN 
    india_election_result.statewise_result sr 
    ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN 
    india_election_result.states s 
    ON sr.`State ID` = s.`State ID`
JOIN 
    india_election_result.partywise_results p 
    ON cr.`Party ID` = p.`Party ID`
WHERE 
    s.State = 'Maharashtra';
    










