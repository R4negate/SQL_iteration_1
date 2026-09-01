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
FROM course.customers;
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
FROM course.customers;
```

Niepoprawnie:

```sql
SELECT customer_id customer_name country
FROM course.customers;
```

## Alias AS

Alias to tymczasowa nazwa kolumny w wyniku zapytania.

```sql
SELECT customer_name AS name
FROM course.customers;
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
FROM course.orders;
```

`total_with_vat` to nowa kolumna w wyniku zapytania.

## Kolejność kolumn ma znaczenie

Kolumny w wyniku pojawiają się w takiej kolejności, w jakiej wpiszesz je po
`SELECT`.

Te dwa zapytania zwracają te same dane, ale w innej kolejności kolumn:

```sql
SELECT customer_id, customer_name
FROM course.customers;
```

```sql
SELECT customer_name, customer_id
FROM course.customers;
```

Przy zwykłym podglądzie danych to często drobiazg. Przy raportach, eksporcie do
pliku albo automatycznym sprawdzaniu zadań kolejność kolumn może być ważna.

## Alias dla wyrażenia

Alias jest szczególnie ważny, gdy kolumna jest wyliczana:

```sql
SELECT
    order_id,
    total_amount * 1.23 AS total_with_vat
FROM course.orders;
```

Bez aliasu baza sama nada nazwę kolumnie, często mało czytelną, np. `?column?`
albo całe wyrażenie matematyczne.

## Alias i ORDER BY

Aliasu z `SELECT` można użyć w `ORDER BY`.

Przykład:

```sql
SELECT
    order_id,
    total_amount * 1.23 AS total_with_vat
FROM course.orders
ORDER BY total_with_vat DESC;
```

To jest wygodne, bo nie trzeba drugi raz przepisywać całego wyrażenia:

```sql
total_amount * 1.23
```

Warto jednak pamiętać, że alias działa tylko w wyniku tego jednego zapytania.
Nie tworzy nowej kolumny w tabeli.

## Alias tabeli a alias kolumny

W SQL spotkasz dwa rodzaje aliasów:

- alias kolumny,
- alias tabeli.

Alias kolumny zmienia nazwę kolumny w wyniku:

```sql
SELECT customer_name AS name
FROM course.customers;
```

Alias tabeli skraca nazwę tabeli w zapytaniu:

```sql
SELECT c.customer_name
FROM course.customers c;
```

Tutaj `c` oznacza tabelę `course.customers`, ale tylko w tym zapytaniu.

To jest szczególnie przydatne przy joinach, gdy w jednym zapytaniu używamy
kilku tabel.

## Najważniejsze rzeczy do zapamiętania

- Alias kolumny zmienia nazwę kolumny w wyniku.
- Alias tabeli skraca nazwę tabeli w zapytaniu.
- Alias nie zmienia danych ani struktury tabeli.
- Aliasu z `SELECT` można użyć w `ORDER BY`.
