% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DBI-connection.R
\docType{methods}
\name{DBI-connection}
\alias{DBI-connection}
\alias{dbSendQuery,Pool-method}
\alias{dbGetQuery,Pool,character-method}
\alias{dbExecute,Pool,character-method}
\alias{dbListResults,Pool-method}
\alias{dbListFields,Pool,character-method}
\alias{dbListTables,Pool-method}
\alias{dbReadTable,Pool,character-method}
\alias{dbWriteTable,Pool-method}
\alias{dbExistsTable,Pool-method}
\alias{dbRemoveTable,Pool-method}
\title{DBIConnection methods.}
\usage{
\S4method{dbSendQuery}{Pool}(conn, statement, ...)

\S4method{dbGetQuery}{Pool,character}(conn, statement, ...)

\S4method{dbExecute}{Pool,character}(conn, statement, ...)

\S4method{dbListResults}{Pool}(conn, ...)

\S4method{dbListFields}{Pool,character}(conn, name, ...)

\S4method{dbListTables}{Pool}(conn, ...)

\S4method{dbReadTable}{Pool,character}(conn, name, ...)

\S4method{dbWriteTable}{Pool}(conn, name, value, ...)

\S4method{dbExistsTable}{Pool}(conn, name, ...)

\S4method{dbRemoveTable}{Pool}(conn, name, ...)
}
\arguments{
\item{conn, statement, ...}{See \code{\link[DBI]{dbSendQuery}}.}

\item{name, value}{See \code{\link[DBI]{dbWriteTable}}.}
}
\description{
Pool object wrappers around DBIConnection methods. For the original
documentation, see:
\itemize{
 \item \code{\link[DBI]{dbSendQuery}}
 \item \code{\link[DBI]{dbGetQuery}}
 \item \code{\link[DBI]{dbExecute}}
 \item \code{\link[DBI]{dbListResults}}
 \item \code{\link[DBI]{dbListFields}}
 \item \code{\link[DBI]{dbListTables}}
 \item \code{\link[DBI]{dbReadTable}}
 \item \code{\link[DBI]{dbWriteTable}}
 \item \code{\link[DBI]{dbExistsTable}}
 \item \code{\link[DBI]{dbRemoveTable}}
}
}
\examples{
if (requireNamespace("RSQLite", quietly = TRUE)) {
  mtcars1 <- mtcars[ c(1:16), ] # first half of the mtcars dataset
  mtcars2 <- mtcars[-c(1:16), ] # second half of the mtcars dataset

  pool <- dbPool(RSQLite::SQLite(), dbname = ":memory:")

  # write the mtcars1 table into the database
  dbWriteTable(pool, "mtcars", mtcars1, row.names = TRUE)

  # list the current tables in the database
  dbListTables(pool)

  # read the "mtcars" table from the database (only 16 rows)
  dbReadTable(pool, "mtcars")

  # append mtcars2 to the "mtcars" table already in the database
  dbWriteTable(pool, "mtcars", mtcars2, row.names = TRUE, append = TRUE)

  # read the "mtcars" table from the database (all 32 rows)
  dbReadTable(pool, "mtcars")

  # get the names of the columns in the databases's table
  dbListFields(pool, "mtcars")

  # use dbExecute to change the "mpg" and "cyl" values of the 1st row
  dbExecute(pool,
    paste(
      "UPDATE mtcars",
      "SET mpg = '22.0', cyl = '10'",
      "WHERE row_names = 'Mazda RX4'"
    )
  )

  # read the 1st row of "mtcars" table to confirm the previous change
  dbGetQuery(pool, "SELECT * FROM mtcars WHERE row_names = 'Mazda RX4'")

  # drop the "mtcars" table from the database
  dbRemoveTable(pool, "mtcars")

  # list the current tables in the database
  dbListTables(pool)

  poolClose(pool)

} else {
  message("Please install the 'RSQLite' package to run this example")
}
}
