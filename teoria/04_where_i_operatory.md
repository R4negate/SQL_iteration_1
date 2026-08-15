# WHERE i operatory

## Do czego służy WHERE

`WHERE` filtruje wiersze.

Tabela może mieć wiele rekordów, ale `WHERE` przepuszcza tylko te, które
spełniają warunek.

Prosta analogia:

> `WHERE` działa jak sito. Przez sito przechodzą tylko pasujące wiersze.

## Podstawowa składnia

```sql
SELECT kolumny
FROM tabela
WHERE warunek;
```

Przykład:

```sql
SELECT customer_id, customer_name, country
FROM customers
WHERE country = 'PL';
```

To zapytanie pokazuje tylko klientów z kraju `PL`.

## Warunki tekstowe

Tekst w SQL zapisujemy w pojedynczych apostrofach.

```sql
WHERE country = 'PL'
```

Ważne:

- `country` to nazwa kolumny,
- `'PL'` to wartość tekstowa.

## Warunki liczbowe

Przykład:

```sql
SELECT order_id, total_amount
FROM orders
WHERE total_amount > 100;
```

To zapytanie pokazuje zamówienia o wartości większej niż 100.

## Najczęstsze operatory

```sql
=    równe
<>   różne
>    większe niż
<    mniejsze niż
>=   większe lub równe
<=   mniejsze lub równe
```

## AND

`AND` oznacza, że wszystkie warunki muszą być prawdziwe.

```sql
SELECT order_id, status, total_amount
FROM orders
WHERE status = 'shipped'
  AND total_amount > 100;
```

Wynik zawiera tylko zamówienia, które:

- mają status `shipped`,
- oraz mają wartość większą niż 100.

## OR

`OR` oznacza, że wystarczy jeden spełniony warunek.

```sql
SELECT customer_id, customer_name, country
FROM customers
WHERE country = 'PL'
   OR country = 'DE';
```

Wynik zawiera klientów z Polski albo z Niemiec.

## Nawiasy

Nawiasy pomagają pokazać, które warunki mają być sprawdzane razem.

```sql
SELECT *
FROM orders
WHERE (status = 'shipped' OR status = 'paid')
  AND total_amount > 100;
```

Bez nawiasów zapytanie może znaczyć coś innego, niż uczestnik zakłada.

