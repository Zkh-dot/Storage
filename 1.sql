select
  "��� ��������",
  "CALC_ID",
  "���� ��������",
  "���",
  "���",
  "������������ �������",
  "ID �������",
  sum("������������� �����") AS "������������� �����",
  sum("������ ����� ����") AS "������ ����� ����",
  sum("������ ����� CONSO") AS "������ ����� CONSO",
  sum("������ ����� ����") AS "������ ����� ����",
  sum("������ ����� PPA") AS "������ ����� PPA",
  (
    CASE 
      WHEN sum("������������� �����") = 0 
        THEN 0 
        ELSE
    sum("������ ����� ����") / sum("������������� �����")
  ) END AS "������ ����",
  (
    CASE WHEN sum("������������� �����") = 0 THEN 0 ELSE
    sum("������ ����� CONSO") / sum("������������� �����")
  ) END AS "������ CONSO",
  (
    CASE WHEN sum("������������� �����") = 0 THEN 0 ELSE
    sum("������ ����� ����") / sum("������������� �����")
  ) END AS "������ ����",
  (
    CASE WHEN sum("������������� �����") = 0 THEN 0 ELSE
    sum("������ ����� PPA") / sum("������������� �����")
  ) END AS "������ PPA"
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
    "��� ��������",
    "CALC_ID",
    "���� ��������",
    "���",
    "���",
    "������������ �������",
    "ID �������"
  )
