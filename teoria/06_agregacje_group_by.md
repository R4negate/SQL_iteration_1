# Agregacje i GROUP BY

## Czym jest agregacja

Agregacja zamienia wiele wierszy w jedną wartość podsumowania.

Przykłady pytań:

- Ile jest zamówień?
- Jaka jest suma sprzedaży?
- Jaka jest średnia wartość zamówienia?
- Jaka jest największa płatność?

## Najważniejsze funkcje agregujące

```sql
COUNT(*)       -- liczba rekordów
SUM(kolumna)  -- suma
AVG(kolumna)  -- średnia
MIN(kolumna)  -- minimum
MAX(kolumna)  -- maksimum
```

## COUNT

```sql
SELECT COUNT(*) AS orders_count
FROM course.orders;
```

To zapytanie liczy wszystkie rekordy w tabeli `orders`.

## SUM

```sql
SELECT SUM(total_amount) AS total_revenue
FROM course.orders;
```

To zapytanie liczy sumę wartości zamówień.

## AVG

```sql
SELECT AVG(total_amount) AS average_order_value
FROM course.orders;
```

To zapytanie liczy średnią wartość zamówienia.

## GROUP BY

`GROUP BY` pozwala liczyć agregacje w grupach.

Przykład:

```sql
SELECT status, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

To zapytanie odpowiada na pytanie:

> Ile zamówień jest w każdym statusie?

## Przykład biznesowy

```sql
SELECT country, COUNT(*) AS customers_count
FROM course.customers
GROUP BY country
ORDER BY customers_count DESC;
```

To zapytanie pokazuje liczbę klientów per kraj.

## WHERE a GROUP BY

`WHERE` działa przed agregacją.

Przykład:

```sql
SELECT country, COUNT(*) AS customers_count
FROM course.customers
WHERE email IS NOT NULL
GROUP BY country;
```

Najpierw zostają tylko klienci z emailem, potem SQL liczy ich per kraj.

## HAVING

`HAVING` filtruje wynik po agregacji.

```sql
SELECT country, COUNT(*) AS customers_count
FROM course.customers
GROUP BY country
HAVING COUNT(*) > 10;
```

To zapytanie pokazuje tylko kraje, które mają więcej niż 10 klientów.

## Najważniejsza różnica

`WHERE` filtruje wiersze przed grupowaniem.

`HAVING` filtruje grupy po grupowaniu.

## Typowe błędy

- Użycie zwykłej kolumny w `SELECT` bez dodania jej do `GROUP BY`.
- Mylenie `WHERE` i `HAVING`.
- Brak aliasów dla metryk.

## COUNT(*) a COUNT(kolumna)

`COUNT(*)` liczy wiersze.

```sql
SELECT COUNT(*) AS rows_count
FROM course.customers;
```

`COUNT(email)` liczy tylko te wiersze, w których `email` nie jest `NULL`.

```sql
SELECT COUNT(email) AS customers_with_email
FROM course.customers;
```

To ważna różnica. Jeśli kolumna ma braki danych, `COUNT(kolumna)` może dać
mniejszy wynik niż `COUNT(*)`.

## Co musi być w GROUP BY

Jeżeli w `SELECT` pokazujesz zwykłą kolumnę oraz agregację, zwykła kolumna musi
być w `GROUP BY`.

Poprawnie:

```sql
SELECT status, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

Niepoprawnie:

```sql
SELECT status, order_date, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

Problem: `order_date` nie jest ani agregacją, ani częścią `GROUP BY`.

## Kolejność myślenia

Przy agregacjach zadawaj sobie pytania w tej kolejności:

1. Z której tabeli biorę dane?
2. Czy najpierw filtruję pojedyncze wiersze przez `WHERE`?
3. Po czym grupuję dane?
4. Jakie metryki liczę w każdej grupie?
5. Czy filtruję gotowe grupy przez `HAVING`?

Przykład:

```sql
SELECT status, SUM(total_amount) AS total_revenue
FROM course.orders
WHERE total_amount > 0
GROUP BY status
HAVING SUM(total_amount) > 200;
```

Najpierw SQL odrzuca pojedyncze wiersze przez `WHERE`, potem grupuje po
`status`, liczy sumę i dopiero na końcu filtruje grupy przez `HAVING`.
