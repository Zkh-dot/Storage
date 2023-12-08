select
  "Тип портфеля",
  "CALC_ID",
  "Дата портфеля",
  "ГСЗ",
  "ИНН",
  "Наименование клиента",
  "ID клиента",
  sum("Задолженность Итого") AS "Задолженность Итого",
  sum("Резерв Итого МСФО") AS "Резерв Итого МСФО",
  sum("Резерв Итого CONSO") AS "Резерв Итого CONSO",
  sum("Резерв Итого РСБУ") AS "Резерв Итого РСБУ",
  sum("Резерв Итого PPA") AS "Резерв Итого PPA",
  (
    CASE 
      WHEN sum("Задолженность Итого") = 0 
        THEN 0 
        ELSE
    sum("Резерв Итого МСФО") / sum("Задолженность Итого")
  ) END AS "Ставка МСФО",
  (
    CASE WHEN sum("Задолженность Итого") = 0 THEN 0 ELSE
    sum("Резерв Итого CONSO") / sum("Задолженность Итого")
  ) END AS "Ставка CONSO",
  (
    CASE WHEN sum("Задолженность Итого") = 0 THEN 0 ELSE
    sum("Резерв Итого РСБУ") / sum("Задолженность Итого")
  ) END AS "Ставка РСБУ",
  (
    CASE WHEN sum("Задолженность Итого") = 0 THEN 0 ELSE
    sum("Резерв Итого PPA") / sum("Задолженность Итого")
  ) END AS "Ставка PPA"
from
  pxu_dirm_upa.comparison_rates_table
WHERE
  "CALC_ID" = (
    SELECT
      MAX("CALC_ID")
    from
      pxu_dirm_upa.comparison_rates_table
  )
GROUP BY
  (
    "Тип портфеля",
    "CALC_ID",
    "Дата портфеля",
    "ГСЗ",
    "ИНН",
    "Наименование клиента",
    "ID клиента"
  )
