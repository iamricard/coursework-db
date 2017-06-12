# databases coursework

Full report can be found on the `report.pdf` file.

## setup

Assuming you are in a UNIX-like system, and have cURL and MariaDB installed the
script `setup` will:

1. fetch the necessary CSV files
1. load them onto the database (`src/sql/00-setup.sql`)
1. create the necessary views (`src/sql/01-views.sql`)

## predefined queries

There's a set of predefined queries (`src/sql/02-queries.sql`). The script
`run-queries` will run them and output the result to the CLI.

## assumptions

Your default user is `root`, and the `mysql` command is available in your path.
