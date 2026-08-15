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
FROM orders;
```

To zapytanie liczy wszystkie rekordy w tabeli `orders`.

## SUM

```sql
SELECT SUM(total_amount) AS total_revenue
FROM orders;
```

To zapytanie liczy sumę wartości zamówień.

## AVG

```sql
SELECT AVG(total_amount) AS average_order_value
FROM orders;
```

To zapytanie liczy średnią wartość zamówienia.

## GROUP BY

`GROUP BY` pozwala liczyć agregacje w grupach.

Przykład:

```sql
SELECT status, COUNT(*) AS orders_count
FROM orders
GROUP BY status;
```

To zapytanie odpowiada na pytanie:

> Ile zamówień jest w każdym statusie?

## Przykład biznesowy

```sql
SELECT country, COUNT(*) AS customers_count
FROM customers
GROUP BY country
ORDER BY customers_count DESC;
```

To zapytanie pokazuje liczbę klientów per kraj.

## WHERE a GROUP BY

`WHERE` działa przed agregacją.

Przykład:

```sql
SELECT country, COUNT(*) AS customers_count
FROM customers
WHERE email IS NOT NULL
GROUP BY country;
```

Najpierw zostają tylko klienci z emailem, potem SQL liczy ich per kraj.

## HAVING

`HAVING` filtruje wynik po agregacji.

```sql
SELECT country, COUNT(*) AS customers_count
FROM customers
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
