# Database schema

Referring to those used in CatCounter code.

## Tables

- t_Lakes
- t_Taxon_information
- t_Stations
- t_Samples
- t_Phytoplankton
- q_RubinCode_Group
- 13a_q_PTI (database PTI_v2b)

### t_Lakes

Covering metadata about the lakes, used for index computation. In the long run should be taken from Nivagis.

### t_Taxon_information

Taxon information in addition to volume and colony / structure information. There is an anology to Nivadatabase Taxonomy, but should be kept for now.

### t_Stations

Station information with code and link to t_Lakes. In addition the longitude and latitude. Should be aligned with Nivadatabase stations.

### t_Samples

Sample information much the same as Nivadatabase water samples, but in addition a person field. Should be aligned with Nivadatabase samples.

### t_Phytoplankton

Count information. Keep it for now.

### q_RubinCode_Group

Used to find taxon group. We will use Nivadatabase bio_groups instead.

### 13a_q_PTI

Used to look up computed PTI. We must do the computation elsewhere.


## Clean up taxon names

Taxon names are not consistent and should be cleaned up. Either in NIVADATABASE.TAXONOMY_CODES or in the Access database before the import to Oracle.


```
SELECT a.taxonomy_code_id, a.code, a.name AS NIVADATABASE_NAME, b.taxon_name AS ACCESS_NAME, (SELECT count(*) FROM nivadatabase.plankton_sampled_values c WHERE c.taxonomy_code_id = a.taxonomy_code_id) AS ANTALL
FROM nivadatabase.taxonomy_codes a, phytoplankton.t_taxon_information b 
WHERE a.taxonomy_domain_id = 2 AND a.code = b.rubin_code AND NOT a.name = b.taxon_name;
```

## Clean up taxon groups

The groups in t_groups_output should be represented in NIVADATABASE.BIO_GROUPS. And a new field in t_taxon_information should point to the group in NIVADATABASE.BIO_GROUPS.

Some clean up af the groups in Nivadatabase is needed.

```
UPDATE nivadatabase.bio_groups SET sort_code = '0'||sort_code WHERE group_type_id = 201 AND LENGTH(sort_code)=1;

UPDATE nivadatabase.bio_groups SET sort_code='22' WHERE group_id = 12092;

UPDATE nivadatabase.bio_groups SET group_name='Cyanobacteria (Blågrønnbakterier)' WHERE group_id = 12014;

```

We have some duplicates in the bio_groups_codes table.

```
SELECT a.code, b.groups_codes_id, d.group_name, c.groups_codes_id, e.group_name 
FROM nivadatabase.taxonomy_codes a, nivadatabase.bio_groups_codes b, nivadatabase.bio_groups_codes c, nivadatabase.bio_groups d, nivadatabase.bio_groups e
WHERE a.taxonomy_domain_id = 2 AND a.taxonomy_code_id = b.taxonomy_code_id AND a.taxonomy_code_id = c.taxonomy_code_id AND b.group_id < c.GROUP_ID
AND b.group_id = d.group_id AND d.group_type_id = 201 AND c.group_id = e.group_id AND e.group_type_id = 201
ORDER BY a.code;

DELETE FROM nivadatabase.bio_groups_codes WHERE groups_codes_id = 38385;
```

