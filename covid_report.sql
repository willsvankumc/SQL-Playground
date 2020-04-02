use redcap;
drop table covid_report; 

CREATE TABLE covid_report (
	site_name VARCHAR(100), 
    site_id INT, 
	covidpend_icu_bed INT,
	covidpend_icu_bed_vent INT, 
	covidcfrm_icu_bed INT, 
	covidcfrm_icu_bed_vent INT, 
    noncovid_icu INT, 
    noncovid_icu_vent INT,
    icu_bed_num INT, 
    ventilator_num INT, 
	icu_bed_surge_num INT, 
	ventilator_surge_num INT
    
	);

INSERT INTO covid_report (site_id)
select distinct record from redcap_data where project_id='16558'
order by record;

UPDATE covid_report SET site_name = 'Other Site Menorah Medical Center' WHERE site_id = '1';
UPDATE covid_report SET site_name = 'Research Medical Center' WHERE site_id = '2';
UPDATE covid_report SET site_name = 'University of Kansas Medical Center' WHERE site_id = '3';
UPDATE covid_report SET site_name = 'St. Lukes Medical Center' WHERE site_id = '4';
UPDATE covid_report SET site_name = 'Kansas City VA Medical Center' WHERE site_id = '5';
UPDATE covid_report SET site_name = 'Lawrence Memorial' WHERE site_id = '6';
UPDATE covid_report SET site_name = 'North KC' WHERE site_id = '7';
UPDATE covid_report SET site_name = 'Other Site Liberty Hospital' WHERE site_id = '8';
UPDATE covid_report SET site_name = 'Overland Park Regional Medical Center' WHERE site_id = '9';
UPDATE covid_report SET site_name = 'Childrens Mercy' WHERE site_id = '10';
UPDATE covid_report SET site_name = 'Overland Park Regional Medical Center' WHERE site_id = '11';
UPDATE covid_report SET site_name = 'AdventHealth, Shawnee Mission' WHERE site_id = '12';
UPDATE covid_report SET site_name = 'Lees Summit Medical Center' WHERE site_id = '15';
UPDATE covid_report SET site_name = 'Kansas City VA Medical Center' WHERE site_id = '16';

select * from covid_report; 

select field_name, value from redcap_data where project_id='16558' and record='4' and field_name in (
"covidpend_icu_bed",
"covidpend_icu_bed_vent",
"covidcfrm_icu_bed",
"covidcfrm_icu_bed_vent",
"noncovid_icu",
"noncovid_icu_vent"
) 
and instance =
(select max(instance) from redcap_data where project_id='16558' and field_name='covidpend_icu_bed' and record = '4')
UNION
select field_name, value from redcap_data where project_id='16558' and record='4' and field_name in (
"icu_bed_num",
"ventilator_num",
"icu_bed_surge_num",
"ventilator_surge_num"
);


SELECT IFNULL(NULL, 0);
