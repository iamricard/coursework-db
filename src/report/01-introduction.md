# Introduction

## Goal

The goal of this analysis is to get a better grasp on drug prescriptions per
NHS practices and expenditure per practice over the months of January and
February of the year 2016.

## Tasks

We will download and load CSV files containing data for registered chemicals,
practices, prescriptions, and patients over the specified time periods.

The analysis will cover:

* The amount of practices in a specific area, along with its registered
  patients.
* Prescription amounts for some specific medicines/chemicals.
* Estimated expenditure per practice in prescriptions.

## Further materials and remarks

The entire source code for this report in markdown and latex format and the SQL
queries to load data, create views and analyze the data that used in the report
are publicly published on [Github] under the [MIT License].

### Running

I provided a utility script in the Github repository to `setup` and`run-queries`
on your local machine:

> **Disclaimer:** _Assumes bash CLI, MariaDB w/ password and a working internet
> connection._

```sh
./setup && ./run-queries
```

[Github]: https://github.com/rcsole/coursework-db
[MIT License]: https://choosealicense.com/licenses/mit/
