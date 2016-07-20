print("*****************************************************************")
print("Running load_kyc.r")
print(paste("Script start time:", Sys.time()))
print("*****************************************************************")

Sys.setenv(HIVE_HOME='/usr/lib/hive')
Sys.setenv(HADOOP_HOME='/usr/lib/hadoop')
#setwd("/user/aml_project/temp")
library(RHive)

print("Accessing HIVE table.....")
# Initialize Hive connection
rhive.init()
rhive.connect()
rm(kyc)
kyc = rhive.query(query = "select 
                  customerid,
                  primaryaccountnumber,
                  balance,
                  firstname,
                  lastname,
                  middlename,
                  alias,
                  fatherlastname,
                  fatherfirstname,
                  fathermiddlename,
                  spouselastname,
                  spousefirstname,
                  spousemiddlename,
                  dateofbirth,
                  marital_status,
                  addressline1,
                  addressline2,
                  addresscity,
                  addresszipcode,
                  addressstate,
                  addresscountry,
                  primaryphone,
                  secondaryphone,
                  landlinephone,
                  primaryemailid,
                  secondaryemailid,
                  primaryoccupation,
                  primaryoccupationemployername,
                  primaryoccupationaddressline1,
                  primaryoccupationaddressline2,
                  primaryoccupationaddresscity,
                  primaryoccupationaddresszipcode,
                  primaryoccupationaddressstate,
                  primaryoccupationaddresscountry,
                  primaryoccupationprimaryphone,
                  primaryoccupationsecondaryphone,
                  debitcardno,
                  primarybranchcode,
                  accounttype,
                  passport_no,
                  namematches,
                  aliasmatches,
                  addressmatches,
                  passportmatches,
                  overallscore
                  from syne_aml.aml_customerdetails")

rhive.close()

kyc$balance <- as.numeric(kyc$balance)

print(paste("Count of kyc records:",nrow(kyc)))
print("Sample kyc records")
print(head(kyc)[,1:5])
print(tail(kyc)[,1:5])

print(paste("Script end time:", Sys.time()))
print("*****************************************************************")