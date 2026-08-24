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
FROM course.customers
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
FROM course.orders
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
FROM course.orders
WHERE status = 'paid'
  AND total_amount > 100;
```

Wynik zawiera tylko zamówienia, które:

- mają status `paid`,
- oraz mają wartość większą niż 100.

## OR

`OR` oznacza, że wystarczy jeden spełniony warunek.

```sql
SELECT customer_id, customer_name, country
FROM course.customers
WHERE country = 'PL'
   OR country = 'DE';
```

Wynik zawiera klientów z Polski albo z Niemiec.

## Nawiasy

Nawiasy pomagają pokazać, które warunki mają być sprawdzane razem.

```sql
SELECT *
FROM course.orders
WHERE (status = 'pending' OR status = 'paid')
  AND total_amount > 100;
```

## Nazwa kolumny a wartość

To jest jedna z najważniejszych rzeczy na start:

```sql
WHERE country = 'PL'
```

- `country` bez apostrofów to nazwa kolumny,
- `'PL'` w apostrofach to wartość tekstowa.

Gdy filtrujesz po tekście, wartość wpisuj w pojedynczych apostrofach. Gdy
filtrujesz po liczbie, apostrofy zwykle nie są potrzebne:

```sql
WHERE total_amount > 100
```

## Jak działa kilka warunków

SQL sprawdza warunek osobno dla każdego wiersza. Dla jednego zamówienia pyta:

1. Czy `status = 'paid'`?
2. Czy `total_amount > 100`?
3. Czy cały warunek po `WHERE` jest prawdziwy?

Jeśli tak, wiersz trafia do wyniku. Jeśli nie, zostaje odrzucony.

## Typowa pułapka z OR i AND

Bez nawiasów zapytanie może znaczyć coś innego, niż myślisz.

```sql
WHERE country = 'PL' OR country = 'DE' AND email IS NOT NULL
```

Lepiej zapisać intencję jawnie:

```sql
WHERE (country = 'PL' OR country = 'DE')
  AND email IS NOT NULL
```

Nawiasy nie są ozdobą. One mówią bazie, które warunki mają tworzyć jedną grupę.

