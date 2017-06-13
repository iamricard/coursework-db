# Starting up

For consistency with the lectures the RDMS used is [MariaDB], a fork of
[MySQL]. The OS is Apple's [OSX], and the package manager to install MariaDB we
used for this exercise is [homebrew]. I chose MariaDB over MySQL because I'll be
working at Google and that seems to be their fork.

## Installing MariaDB

Using the `brew` command, in our terminal:

```sh
brew --version
Homebrew 1.2.2
Homebrew/homebrew-core (git revision 73a8655; last commit 2017-06-12)

brew install mariadb
```

We might be prompted to _secure_ the `MySQL/MariaDB` (we will use both names
interchangeably from now on), this is accomplished by following the steps asked
in this command:

```sh
mysql_secure_installation
```

## Creating the database

With some really simple steps we'll be able to create a database. Fortunately,
I've create a bash script that will automate the setup on a UNIX system. Here,
however, we'll describe it step by step.

```sh
mysql -uroot -p
```
```
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 78
Server version: 10.2.6-MariaDB Homebrew

Copyright (c) 2000, 2017, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE DATABASE prescriptionsdb;
Query OK, 1 row affected (0.01 sec)
```

## Modeling the data

Upon inspection of the data, there are **four** CSV files. Three of them found
[here](https://goo.gl/zC3afI) and the last one [here](https://goo.gl/n8XbX7).
This maps to also four tables in our database. `practices` —containing the
address, names and postcodes of GPs—, `prescriptions` —actual prescribed
medicine, cost, GP, and quantity—, `gppatients` —the number oh patients, per
age, per GP—, and `chemicals` —extended information on medicaments that are
registered by the NHS.

Everything builds on the `practices` table: both `prescriptions` and
`gppatients` have a `practiceid` field which will be a `FOREIGN KEY` reference
to the `practices` table.

### Create practices table

\inputminted[firstline=10,lastline=19]{sql}{src/sql/00-setup.sql}

### Create prescriptions table

\inputminted[firstline=21,lastline=34]{sql}{src/sql/00-setup.sql}

#### Add FOREIGN KEY reference

\inputminted[firstline=36,lastline=36]{sql}{src/sql/00-setup.sql}

### Create gppatients table

\inputminted[firstline=43,lastline=46]{sql}{src/sql/00-setup.sql}

#### Add FOREIGN KEY reference

\inputminted[firstline=48,lastline=48]{sql}{src/sql/00-setup.sql}

### Create chemicals table

\inputminted[firstline=38,lastline=41]{sql}{src/sql/00-setup.sql}

## Wrapping up

This does it for scaffolding our database and tables. In the next chapter we'll
load the CSV files, and create some useful views for future queries.

[MariaDB]: https://mariadb.org/
[MySQL]: https://mysql.com
[OSX]: https://www.wikiwand.com/en/MacOS
[homebrew]: https://brew.sh
[FAQ]: http://content.digital.nhs.uk/media/10048/FAQs-Practice-Level-Prescribingpdf/pdf/PLP_FAQs_April_2015.pdf
