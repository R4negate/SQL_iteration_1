# Wybór kolumn i aliasy

## Dlaczego nie zawsze używamy SELECT *

`SELECT *` pokazuje wszystkie kolumny.

To jest dobre do szybkiego podglądu, ale często nie jest najlepsze w pracy.

Powody:

- wynik może być nieczytelny,
- tabela może mieć dużo kolumn,
- pobieramy dane, których nie potrzebujemy,
- trudniej zobaczyć, które kolumny są naprawdę ważne.

## Wybór konkretnych kolumn

```sql
SELECT customer_id, customer_name, country
FROM customers;
```

To zapytanie pokazuje tylko trzy kolumny:

- `customer_id`,
- `customer_name`,
- `country`.

## Przecinki między kolumnami

Kolumny w `SELECT` oddzielamy przecinkami.

Poprawnie:

```sql
SELECT customer_id, customer_name, country
FROM customers;
```

Niepoprawnie:

```sql
SELECT customer_id customer_name country
FROM customers;
```

## Alias AS

Alias to tymczasowa nazwa kolumny w wyniku zapytania.

```sql
SELECT customer_name AS name
FROM customers;
```

Wynik będzie miał kolumnę `name`, ale tabela w bazie nadal ma kolumnę
`customer_name`.

Alias nie zmienia danych w bazie.

## Kiedy alias jest przydatny

Alias pomaga, gdy:

- nazwa kolumny jest długa,
- tworzymy kolumnę wyliczaną,
- wynik ma być czytelny dla człowieka,
- przygotowujemy raport.

Przykład:

```sql
SELECT
    order_id,
    total_amount,
    total_amount * 1.23 AS total_with_vat
FROM orders;
```

`total_with_vat` to nowa kolumna w wyniku zapytania.

