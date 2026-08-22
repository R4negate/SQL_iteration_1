# Typy danych i praca z datami

## Po co ta lekcja

Kolumny w tabelach mają typy danych.

Typ danych mówi bazie, jakiego rodzaju wartość znajduje się w kolumnie.

To ważne, bo inaczej pracuje się z:

- liczbą,
- tekstem,
- datą,
- kwotą,
- wartością `NULL`.

## Dlaczego typy danych są ważne

Zobacz trzy wartości:

```text
'100'
100
100.00
```

Dla człowieka wyglądają podobnie.

Dla bazy danych to mogą być trzy różne typy:

- tekst,
- liczba całkowita,
- liczba z miejscami po przecinku.

## INT

`INT` przechowuje liczby całkowite.

Przykłady:

- `customer_id`
- `order_id`
- `quantity`

## VARCHAR

`VARCHAR` przechowuje tekst.

Przykłady:

- `customer_name`
- `email`
- `country`
- `status`

Tekst w SQL zapisujemy w apostrofach:

```sql
WHERE country = 'PL'
```

## NUMERIC

`NUMERIC` przechowuje dokładne liczby z miejscami po przecinku.

Przykłady:

- `total_amount`
- `base_price`
- `unit_price`

Do kwot pieniężnych często używa się właśnie `NUMERIC`.

## DATE

`DATE` przechowuje datę bez godziny.

Przykłady:

- `signup_date`
- `order_date`

Przykład wartości:

```text
2026-05-01
```

## TIMESTAMP

`TIMESTAMP` przechowuje datę i godzinę.

Przykład wartości:

```text
2026-05-01 14:30:00
```

W naszej bazie ćwiczeniowej mamy głównie `DATE`, ale w prawdziwych systemach `TIMESTAMP` jest bardzo częsty.

## BOOLEAN

`BOOLEAN` przechowuje prawdę albo fałsz.

Przykładowe wartości:

```text
true
false
```

## Sprawdzanie typów kolumn

Typy kolumn można sprawdzić w `information_schema.columns`.

```sql
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'course'
ORDER BY table_name, ordinal_position;
```

## CAST

`CAST` zmienia typ wartości w wyniku zapytania.

```sql
SELECT
    order_id,
    CAST(total_amount AS INT) AS total_as_int
FROM course.orders;
```

To nie zmienia danych w tabeli.

Zmienia tylko wynik zapytania.

## Filtrowanie po datach

Daty zapisujemy w apostrofach.

```sql
SELECT
    order_id,
    order_date,
    total_amount
FROM course.orders
WHERE order_date >= '2026-05-10';
```

## BETWEEN na datach

```sql
SELECT
    order_id,
    order_date,
    total_amount
FROM course.orders
WHERE order_date BETWEEN '2026-05-01' AND '2026-05-10';
```

`BETWEEN` obejmuje początek i koniec zakresu.

## CURRENT_DATE

`CURRENT_DATE` zwraca aktualną datę.

```sql
SELECT CURRENT_DATE AS today;
```

## CURRENT_TIMESTAMP

`CURRENT_TIMESTAMP` zwraca aktualną datę i godzinę.

```sql
SELECT CURRENT_TIMESTAMP AS now;
```

## EXTRACT

`EXTRACT` wyciąga część daty.

```sql
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    EXTRACT(DAY FROM order_date) AS order_day
FROM course.orders;
```

## DATE_TRUNC

`DATE_TRUNC` ucina datę do wybranego poziomu.

Przykład: miesiąc sprzedaży.

```sql
SELECT
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(total_amount) AS total_revenue
FROM course.orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;
```

## INTERVAL

`INTERVAL` oznacza odstęp czasu.

```sql
SELECT CURRENT_DATE - INTERVAL '7 days' AS seven_days_ago;
```

## TO_CHAR

`TO_CHAR` formatuje datę jako tekst.

```sql
SELECT
    order_id,
    TO_CHAR(order_date, 'YYYY-MM') AS order_month
FROM course.orders;
```

## Najważniejsze rzeczy do zapamiętania

- Każda kolumna ma typ danych.
- `INT` to liczby całkowite.
- `VARCHAR` to tekst.
- `NUMERIC` jest dobry do kwot.
- `DATE` to data bez godziny.
- `TIMESTAMP` to data z godziną.
- `CAST` zmienia typ w wyniku zapytania.
- `EXTRACT` wyciąga część daty.
- `DATE_TRUNC` pomaga grupować dane po czasie.
- `INTERVAL` oznacza odstęp czasu.

