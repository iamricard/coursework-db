# Setting up our data

As described in the previous chapter we'll detail step by step how to load the
data from the CSV to our `MariaDB` instance, and into `prescriptionsdb`.

## Fetching the data

The data we'll be working with is from 2016, January and February. It is
provided by the government. The easiest way to fetch it is to `cURL` it from the
terminal:

\inputminted[lastline=114]{bash}{setup}

## How to load a CSV file

MariaDB provides an instruction, `LOAD DATA [LOCAL] INFILE`, which lets us dump
a file into a table. You can find more information on how that command works on
the MariaDB documentation website for
[`LOAD DATA`](https://mariadb.com/kb/en/mariadb/load-data-infile/).

### Usage

\inputminted[firstline=55,lastline=97]{sql}{src/sql/00-setup.sql}

## Creating views

Before moving on to actually querying our data, I found it useful to look at the
specified tasks and possibly create views that would aid said queries. From
Wikipedia:

> _“In database theory, a view is the result set of a stored query on the data,
> which the database users can query just as they would in a persistent database
> collection object. This pre-established query command is kept in the database
> dictionary.”_

You can find more information on what views are on the MariaDB documentation
website [about views], or on [Wikipedia].

### Beta-blockers

One of the first things asked is to identify [beta-blocker] prescriptions. The
NHS Provides with some information in what some common beta-blockers are. I
found it particularly useful to create a view of what prescriptions actually
match the chemicals commonly identified as beta-blockers.

\inputminted[firstline=4,lastline=23]{sql}{src/sql/01-views.sql}

### Prescriptions-per-x

Other tasks ask for common patterns such as prescriptions per gp, and
prescriptions per chemical.

\inputminted[firstline=26,lastline=38]{sql}{src/sql/01-views.sql}

### Other views

There are some other views that proved to be necessary/useful as queries were
being constructed. These will be discussed further with their corresponding
queries.

\inputminted[firstline=41]{sql}{src/sql/01-views.sql}

## Wrapping up

That's all there is to model our data. To recap we have:

* Downloaded the CSV files into a data folder using `cURL`.
* Loaded the CSV files using `LOAD DATA`
* Created some `VIEW`s that we'll be using later to abstract complexity from
  our queries.

[Wikipedia]: https://www.wikiwand.com/en/View_(SQL)
[about views]: https://mariadb.com/kb/en/mariadb/views/
[beta-blocker]: http://bit.ly/2reDxBL
