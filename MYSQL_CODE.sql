
CREATE TABLE `air_quality` (
  `State Code` int NULL,
  `County Code` text,
  `Site Number` text,
  `Parameter Code` int NULL,
  `POC` int NULL,
  `Latitude` double NULL,
  `Longitude` double NULL,
  `Datum` text,
  `Parameter Name` text,
  `Duration Description` text,
  `Pollutant Standard` text,
  `Date (Local)` text,
  `Year` int NULL,
  `Day In Year (Local)` text,
  `Units of Measure` text,
  `Exceptional Data Type` text,
  `Nonreg Observation Count` text,
  `Observation Count` int NULL,
  `Observation Percent` double NULL,
  `Nonreg Arithmetic Mean` text,
  `Arithmetic Mean` double NULL,
  `Nonreg First Maximum Value` text,
  `First Maximum Value` double NULL,
  `First Maximum Hour` int NULL,
  `AQI` text,
  `Daily Criteria Indicator` text,
  `Tribe Name` text,
  `State Name` text,
  `County Name` text,
  `City Name` text,
  `Local Site Name` text,
  `Address` text,
  `MSA or CBSA Name` text,
  `Data Source` text
);
#DATA CONTENT WAS IMPORTED USING "TABLE DATA IMPORT WIZARD"

SELECT * FROM air_quality;

UPDATE air_quality
SET `count_end_date`=NULL
WHERE `count_end_date`=''; 

CREATE TABLE `traffic` (
  `FID` int  NULL,
  `RMSTRAFFIC` text  NULL,
  `ST_RT_NO` varchar(6) NULL,
  `CTY_CODE` int NULL,
  `DISTRICT_N` text  NULL,
  `JURIS` int  NULL,
  `SEG_BGN` text,
  `OFFSET_BGN` int  NULL,
  `SEG_END` text,
  `OFFSET_END` int  NULL,
  `SEG_PT_BGN` text,
  `SEG_PT_END` text,
  `SEG_LNGTH_` int  NULL,
  `SEQ_NO` int  NULL,
  `CUR_AADT` int  NULL,
  `ADTT_CUR` int  NULL,
  `TRK_PCT` int  NULL,
  `WKDY_TRK_C` int  NULL,
  `ADLR_TRK_C` int  NULL,
  `ADLF_TRK_C` int  NULL,
  `BASE_YR_CL` int  NULL,
  `BASE_ADT` int  NULL,
  `ADTT_BASE` int  NULL,
  `WKDY_TRK_B` int  NULL,
  `ADLR_TRK_B` int  NULL,
  `ADLF_TRK_B` int  NULL,
  `BASE_ADT_Y` int  NULL,
  `DLY_VMT` int  NULL,
  `DLY_TRK_VM` int  NULL,
  `K_FACTOR` int  NULL,
  `D_FACTOR` int  NULL,
  `T_FACTOR` int  NULL,
  `VOL_CNT_KE` varchar(15)  NULL,
  `VOL_CNT_DA` int  NULL,
  `RAW_CNT_HI` int  NULL,
  `TRAFF_PATT` text,
  `DUR_CLS_CN` int  NULL,
  `TYPE_OF_CN` int  NULL,
  `DIR_IND` text,
  `MSLINK` int  NULL,
  `MAPID` int  NULL,
  `NLF_ID` int  NULL,
  `SIDE_IND` int  NULL,
  `NLF_CNTL_B` int  NULL,
  `NLF_CNTL_E` int  NULL,
  `CUM_OFFSET` int  NULL,
  `CUM_OFFS_1` int  NULL,
  `RECORD_UPD` int  NULL,
  `GIS_UPDATE` text,
  `GIS_GEOMET` text,
  `GPID` int  NULL,
  `GEOMETRY_L` double  NULL
);
#DATA CONTENT WAS IMPORTED USING "TABLE DATA IMPORT WIZARD"

ALTER TABLE `final_project`.`downtown_segments` 
RENAME COLUMN `ï»¿ST_RT_NO` TO ST_RT_NO;

UPDATE `traffic`
SET `VOL_CNT_DA`=NULL
WHERE `VOL_CNT_DA`=0; 

CREATE TABLE `downtown_segments` (
  `ST_RT_NO` text,
  `CTY_CODE` text,
  `JURIS` int NULL,
  `SEG_NO` text,
  `LANE_CNT` int NULL,
  `STREET_NAME` text,
  `TRAF_RT_NO_PREFIX` text,
  `SIDE_IND` int NULL,
  `ROUTE_DIR` text,
  `SPEED_LIMIT` int NULL,
  `STREET_NAME_NO_SUF` text,
  `STREET_SUF` text,
  `RTESIGNING` int NULL,
  `OBJECTID` int NULL,
  `GEOMETRYLEN` int NULL
)
#DATA CONTENT WAS IMPORTED USING "TABLE DATA IMPORT WIZARD"

SELECT DISTINCT ST_RT_NO,STREET_NAME, VOL_CNT_DA, CUR_AADT,SEG_LNGTH_,SPEED_LIMIT, `Date (Local)`, `Parameter Name`, `Pollutant Standard`, `Duration Description`, AQI  FROM air_quality, (
SELECT DISTINCT ST_RT_NO,STREET_NAME, VOL_CNT_DA, CUR_AADT,SEG_LNGTH_,SPEED_LIMIT  FROM traffic 
NATURAL JOIN 
downtown_segments) AS downtown_traffic_count WHERE `Date (Local)`=VOL_CNT_DA;
