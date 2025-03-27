CREATE USER phytoplankton identified by "null"
DEFAULT TABLESPACE "APPDATA"
TEMPORARY TABLESPACE "TEMP";

ALTER USER phytoplankton QUOTA UNLIMITED ON "APPDATA";

CREATE ROLE cc_user;

SET DEFINE OFF;

CREATE TABLE phytoplankton.t_Lakes
(
    LakeID number not null,
    Lake varchar2(255),
    VannforekomstID varchar2(255),
    River_Basin_code varchar2(255),
    Lake_number varchar2(255),
    Altitude number,
    Mean_depth number,
    Max_depth number,
    Surface_area number,
    Lake_type varchar2(255),
    ICtypeID varchar2(255),
    Lake_type_code varchar2(255),
    Comments varchar2(255),
    SMWF varchar2(255),
    Country varchar2(255),
    CONSTRAINT t_lakes_pk PRIMARY KEY (LakeID)
);
COMMENT ON COLUMN phytoplankton.t_Lakes.LakeID IS 'Lake ID, unique';
COMMENT ON COLUMN phytoplankton.t_Lakes.Lake IS 'Name of the waterbody';
COMMENT ON COLUMN phytoplankton.t_Lakes.VannforekomstID IS 'Lake code from NVE, e.g. 014-314-L';
COMMENT ON COLUMN phytoplankton.t_Lakes.River_basin_code IS 'Code of the watershed';
COMMENT ON COLUMN phytoplankton.t_Lakes.Lake_number IS 'Lake number, norwegian system';
COMMENT ON COLUMN phytoplankton.t_Lakes.Altitude IS 'Hight above sea level';
COMMENT ON COLUMN phytoplankton.t_Lakes.Mean_depth IS 'Mean depth of waterbody';
COMMENT ON COLUMN phytoplankton.t_Lakes.Max_depth IS 'Max depth of waterbody';
COMMENT ON COLUMN phytoplankton.t_Lakes.Surface_area IS 'Surface area of waterbody';
COMMENT ON COLUMN phytoplankton.t_Lakes.Lake_type IS 'Lake type, New Norwegian system';
COMMENT ON COLUMN phytoplankton.t_Lakes.ICtypeID IS 'Intercalibrated lake type, e.g. L-N1';
COMMENT ON COLUMN phytoplankton.t_Lakes.Lake_type_code IS 'Lake type, Norwegian system, e.g. LEL23212';
COMMENT ON COLUMN phytoplankton.t_Lakes.SMWF IS 'Modified waterbody';
COMMENT ON COLUMN phytoplankton.t_Lakes.Country IS 'NO is Norwegian lake';

GRANT SELECT,INSERT,UPDATE,DELETE ON phytoplankton.t_lakes TO cc_user;

CREATE TABLE phytoplankton.t_Taxon_information
(
    Rubin_code varchar2(255) not null,
    Taxon_name varchar2(255),
    Taxon_volume_SingleCells number,
    Taxon_volume_Colony number,
    Cells_in_colony number,
    Colony_structure varchar2(255),
    Person varchar2(255),
    Date_registry date,
    CONSTRAINT t_taxon_information_pk PRIMARY KEY (Rubin_code)
);
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Rubin_code IS 'Valid rubin code';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Taxon_name IS 'Taxon name for rubin code';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Taxon_volume_SingleCells IS 'Volume of taxon';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Taxon_volume_Colony IS 'Volume of taxon';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Cells_in_colony IS 'Average number of cells in colonies';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Colony_structure IS 'Structure of colony, trichome, cells in cluster, etc';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Person IS 'Person that added taxon';
COMMENT ON COLUMN phytoplankton.t_Taxon_information.Date_registry IS 'Date taxon added';

GRANT SELECT,INSERT,UPDATE,DELETE ON phytoplankton.t_Taxon_information TO cc_user;

CREATE TABLE phytoplankton.t_Stations
(
    StationID number not null,
    LakeID number,
    Station varchar2(255),
    Stasjonskode varchar2(255),
    St_code varchar2(255),
    St_code_fag varchar2(10),
    Longitude number,
    Latitude number,
    Comments varchar2(255),
    CONSTRAINT t_stations_pk PRIMARY KEY (StationID),
    CONSTRAINT t_stations_fk1 FOREIGN KEY (LakeID) REFERENCES phytoplankton.t_Lakes (LakeID)
);

COMMENT ON COLUMN phytoplankton.t_Stations.StationID IS 'ID_Station  from t_Stations';
COMMENT ON COLUMN phytoplankton.t_Stations.LakeID IS 'Lake ID, unique';
COMMENT ON COLUMN phytoplankton.t_Stations.Station IS 'Code of the station in the waterbody, from current database';
COMMENT ON COLUMN phytoplankton.t_Stations.Stasjonskode IS 'Combination of Station & St_code & Station & St_code_fag';
COMMENT ON COLUMN phytoplankton.t_Stations.St_code IS 'ID of the station in the waterbody, from current database';
COMMENT ON COLUMN phytoplankton.t_Stations.St_code_fag IS 'Name of the station in the waterbody, from EUREGI, example: VESIAKE';
COMMENT ON COLUMN phytoplankton.t_Stations.Longitude IS 'Longitude, decimal degree';
COMMENT ON COLUMN phytoplankton.t_Stations.Latitude IS 'Latitude, decimal degree';

GRANT SELECT,INSERT,UPDATE,DELETE ON phytoplankton.t_Stations TO cc_user;

CREATE TABLE phytoplankton.t_Sample
(
    SampleID number not null,
    StationID number not null,
    SampleDate date,
    Depths varchar2(255),
    Depth_1 number,
    Depth_2 number,
    Person varchar2(3),
    Comments varchar2(255),
    CONSTRAINT t_sample_pk PRIMARY KEY (SampleID),
    CONSTRAINT t_sample_fk1 FOREIGN KEY (StationID) REFERENCES phytoplankton.t_Stations (StationID)
);

COMMENT ON COLUMN phytoplankton.t_Sample.SampleID IS 'Sample ID, unique';
COMMENT ON COLUMN phytoplankton.t_Sample.StationID IS 'ID_Station  from t_Stations';
COMMENT ON COLUMN phytoplankton.t_Sample.SampleDate IS 'Sample date';
COMMENT ON COLUMN phytoplankton.t_Sample.Depths IS 'Sample depth';
COMMENT ON COLUMN phytoplankton.t_Sample.Depth_1 IS 'Upper sample depth, for integrated samples commonly 0 m';
COMMENT ON COLUMN phytoplankton.t_Sample.Depth_2 IS 'Lower sample depth';
COMMENT ON COLUMN phytoplankton.t_Sample.Person IS 'Initials of the person counting the sample';
COMMENT ON COLUMN phytoplankton.t_Sample.Comments IS 'Comments';

GRANT SELECT,INSERT,UPDATE,DELETE ON phytoplankton.t_Sample TO cc_user;

CREATE TABLE phytoplankton.t_Phytoplankton
(
    PlanktonID number not null,
    SampleID number not null,
    Rubin_code varchar2(255) not null,
    Taxon varchar2(255),
    Confer number,
    Single_species number,
    Value number,
    Factor number,
    Taxon_volume number,
    Bio_volume number,
    Counting_date date,
    Counting_level varchar2(55),
    Number_of_units number,
    Sample_type varchar2(255),
    Project_type varchar2(255),
    CONSTRAINT t_phytoplankton_pk PRIMARY KEY (PlanktonID),
    CONSTRAINT t_phytoplankton_uk1 UNIQUE (SampleID, Rubin_code),
    CONSTRAINT t_phytoplankton_fk1 FOREIGN KEY (SampleID) REFERENCES phytoplankton.t_Sample (SampleID),
    CONSTRAINT t_phytoplankton_fk2 FOREIGN KEY (Rubin_code) REFERENCES phytoplankton.t_Taxon_information (Rubin_code)
);

COMMENT ON COLUMN phytoplankton.t_Phytoplankton.PlanktonID IS 'ID';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.SampleID IS 'SampleID from t_Samples';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Rubin_code IS 'Rubin code for each taxon';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Taxon IS 'Current name of each taxon';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Confer IS 'Cf';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Single_species IS 'Sp = 1 or Spp = 2';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Value IS 'Number of counted units, e.g. cells, filaments, coenobia, colonies';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Factor IS 'Factor for calulating taxon per liter';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Taxon_volume IS 'Volume for each counting unit';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Bio_volume IS 'Volume for each taxon in the sample';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Counting_date IS 'Date for counting';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Counting_level IS 'Level of counting units, e.g. cells, coenobia, filaments, colonies';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Number_of_units IS 'Number of colonies';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Sample_type IS 'Quick analysis (R), Cyanobacteria (C), normal analysis (tom)';
COMMENT ON COLUMN phytoplankton.t_Phytoplankton.Project_type IS 'Project type, surveillance monitoring, research project etc.';

GRANT SELECT,INSERT,UPDATE,DELETE ON phytoplankton.t_Phytoplankton TO cc_user;
SET DEFINE ON;

CALL niva_db_tools.pkg_db_tools.create_audits_table('PHYTOPLANKTON');
CALL niva_db_tools.pkg_db_tools.create_sequence_and_triggers('PHYTOPLANKTON', 'T_LAKES');
CALL niva_db_tools.pkg_db_tools.create_sequence_and_triggers('PHYTOPLANKTON', 'T_PHYTOPLANKTON');
CALL niva_db_tools.pkg_db_tools.create_sequence_and_triggers('PHYTOPLANKTON', 'T_SAMPLE');
CALL niva_db_tools.pkg_db_tools.create_sequence_and_triggers('PHYTOPLANKTON', 'T_STATIONS');
CALL niva_db_tools.pkg_db_tools.create_bir_trigger('PHYTOPLANKTON', 'T_TAXON_INFORMATION');
CALL niva_db_tools.pkg_db_tools.create_adur_trigger('PHYTOPLANKTON', 'T_TAXON_INFORMATION');
