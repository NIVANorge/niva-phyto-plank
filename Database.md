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

Used to find taxon group. We will use Nivadatabase bio_groups instead. Need a web interface to maintain this.

### 13a_q_PTI

Used to look up computed PTI. We must do the computation elsewhere.
