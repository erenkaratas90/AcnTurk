CREATE OR REPLACE FUNCTION TNSWIN.gettarifftosbmKPS (
  citizenshipNumber varchar2,
  plateCityCode varchar2,
  plateNo varchar2,
  registrationSerialCode varchar2,
  registrationSerialNo varchar2,
  chassisNo varchar2,
  clobXML Clob,
  operationType varchar2, -- TRF - KSK
  registryDate varchar2,
  firstRegistrationDate varchar2,
  modelYear varchar2,
  vehicleUsageCode varchar2,
  refCorporationCode varchar2,
  refAgencyCode varchar2,
  refPolicyNo varchar2,
  refRenewalNo varchar2,
  sbmTeklifIslemId varchar2,
  clientBirthDate varchar2
)
RETURN CLOB AS
LANGUAGE JAVA NAME 'TARIFFGETWSKPS.getResponse(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.sql.Clob, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String) return java.sql.Clob';
