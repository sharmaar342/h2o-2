######################################################################
# Test for HEX-1794
# UUID
# Issue: is.na on a UUID column was not giving correct results
######################################################################

setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
options(echo=TRUE)
source('../findNSourceUtils.R')

test.uuid <- function(conn) {
  Log.info('Importing test_uuid.csv to H2O...')
  df <- h2o.importFile(conn, normalizePath(locate('smalldata/test/test_uuid_na.csv')))
  colnames(df) = c("AA", "UUID", "CC")
  
  Log.info("Slice a subset of columns 1")
  df.nona <- df[!is.na(df$UUID),]  # this is the line appearing in the jira


  Log.info("How many rows dows the filter take out??")
    
  Log.info("Before dim(df)")
  print(dim(df))
  
  Log.info("After !is.na")
  print(dim(df.nona))

  expect_that(dim(df.nona)[1], is_less_than(dim(df)[1]))

  testEnd()
}

doTest("HEX-1789 Test: UUID", test.uuid)
