# Data Analysis

## Practices in a particular area

We are particularly interested in _how_ many practices —and how many registered
patients in said practices— there are in a specific area covered by the NHS —in
N17.

Getting the number of practices is an easy task to accomplish with the provided
data. From the `practices` table, we want to retrieve the rows whose `postcode`
column start with `N17`. However, we also want the patients from that area.
That's in the `gppatients` table which relates to `practices` through the
`practiceid` column. In this case, we will need a `LEFT JOIN` when combining
both tables. The reason we need it to be `LEFT` is that we might find some
`practices` which do not have any registered patients but **are** in the _N17_
postcode.

\inputminted[firstline=5,lastline=15]{sql}{src/sql/02-queries.sql}

From the result of the query we can conclude there are **7 practices in N17**
and a total of **49,358** patients are registered in that postcode.

## Beta-blockers

Taking advantage of the views created in section 3.3.1 the query to find the GP
which prescribed the most beta-blockers turns out to be a rather simple `JOIN`
from that `VIEW` to the `gppatients` table:

\inputminted[firstline=27,lastline=39]{sql}{src/sql/02-queries.sql}

The practice that has prescribed the most beta-blockers per patient registered
(in that specific practice) is **Burrswood Nursing Home**, ID **G82651**,
prescribing **161** beta-blockers per patient.

## Prescriptions per medication

The relevant `VIEW` here is `ppc`. It contains how many prescriptions there are
per chemical. Doing a simple `JOIN` with the `chemicals` table, sorting it by
the dispensed amount and `LIMIT`ing it to `1` result:

> **Disclaimer**: _The assumption is we are looking for the chemical that's
> been dispensed most often, not necessarily the one that's been dispensed the
> most as far as actual quantity goes. With the data we could gather that's a
> rather difficult task (more quantity does not equal more substance)._

\inputminted[firstline=42,lastline=53]{sql}{src/sql/02-queries.sql}

The most prescribed medication in January & February of 2016 was
**Colecalciferol**, which was prescribed **280495** times.

## Expenditure per practice

Like in every other query we also have a relevant view here, `spentpergp`. All
we need to do is join `spentpergp` with `practices` to get the name, and we are
done! `spentpergp` is the result of `SUM`ing all `prescriptions` `GROUP`ed `BY`
their `practiceid`:

\inputminted[firstline=56,lastline=80]{sql}{src/sql/02-queries.sql}

The **biggest spender** was **Midlands Medical Partnership** at
**1,638,640.13£** per patient. The **cheapest practice** was **Cri Bury
Recovery Services** at **0.17£** per patient.

## SSRI prescriptions change

There are similar `VIEW`s for [SSRI] as there were for beta-blocker. To find
the difference in the amount of times SSRIs have been prescribed between
January and February we simply `COUNT(*)` and `GROUP BY` the `period` when they
were prescribed.

To know what qualifies as SSRI we've referred to the NHS website. The relevant
excerpt:

* Types of SSRIs
    * citalopram
    * dapoxetine
    * escitalopram
    * fluoxetine
    * fluvoxamine
    * paroxetine
    * sertraline

\inputminted[firstline=92,lastline=102]{sql}{src/sql/02-queries.sql}

The difference between February and January is minimal, at only **486** fewer
SSRIs prescribed.

## Metformin per practice

You guessed it right, we are using `VIEW`s! In this case,
`metforminprescriptions` which builds on `metformin`. The latter gets all the
`bnfcodesub`s belonging to `chemicals` containing `metformin`. We use the
former to `JOIN` it with `practices` on the `practiceid = id` and `GROUP BY`
the `id`, while also `ORDER`ing `BY` the amount of `prescriptions` and finally
`LIMIT` it to `10` elements:

\inputminted[firstline=107]{sql}{src/sql/02-queries.sql}

The above comment shows a nicely formatted table of the **top 10** `practices`
per metformin prescribed.

## Wrapping up

This covers all the analysis we are doing on drug prescription by NHS practices.

[SSRI]: http://www.nhs.uk/conditions/SSRIs-(selective-serotonin-reuptake-inhibitors)/Pages/Introduction.aspx
