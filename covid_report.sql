select distinct site.value as site_id, icu_bed.value as icu_bed, vent_num.value as vent_num, bed_surge_num.value as bed_surge_num, vent_surge_num.value as vent_surge_num, covid_icu_bed_pen.record as covid_icu_bed_pen, covid_icu_bed_vent_pen.record as covid_icu_bed_vent_pen, covid_icu_bed_cfrm.record as covid_icu_bed_cfrm, covid_icu_bed_vent_cfrm.record as covid_icu_bed_vent_cfrm, non_covid_icu.record as non_covid_icu, non_covid_icu_vent.record as non_covid_icu_vent
from (select field_name, record, value 
from redcap_data where project_id='16558' and field_name='site') as site
left join (select MAX(instance) as max_instance, record from redcap_data WHERE project_id='16558' group by record) as max_instance 
On site.record = max_instance.max_instance
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'icu_bed_num')) as icu_bed
On site.record = icu_bed.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'ventilator_num')) as vent_num
On site.record = vent_num.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'icu_bed_surge_num')) as bed_surge_num
On site.record = bed_surge_num.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'ventilator_surge_num')) as vent_surge_num
On site.record = vent_surge_num.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'covidpend_icu_bed')) as covid_icu_bed_pen
On site.record = covid_icu_bed_pen.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'covidpend_icu_bed_vent')) as covid_icu_bed_vent_pen
On site.record = covid_icu_bed_vent_pen.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'covidcfrm_icu_bed')) as covid_icu_bed_cfrm
On site.record = covid_icu_bed_cfrm.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'covidcfrm_icu_bed_vent')) as covid_icu_bed_vent_cfrm
On site.record = covid_icu_bed_vent_cfrm.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'noncovid_icu')) as non_covid_icu
On site.record = non_covid_icu.record
left join (select record, field_name, value FROM redcap.redcap_data WHERE project_id='16558' AND field_name IN (
  'noncovid_icu_vent')) as non_covid_icu_vent
On site.record = non_covid_icu_vent.record
order by site_id;
