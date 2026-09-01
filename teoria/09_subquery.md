# Subquery

## Po co ta lekcja

Subquery to zapytanie wewnętrzne.

Oznacza to, że jedno zapytanie SQL znajduje się wewnątrz drugiego zapytania SQL.

Można myśleć o tym tak:

> Najpierw znajdź albo policz coś w środku, a potem użyj tego wyniku na zewnątrz.

## Najprostszy przykład

Pokaż zamówienia większe niż średnia wartość zamówienia.

```sql
SELECT
    order_id,
    total_amount
FROM course.orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM course.orders
);
```

Zapytanie wewnętrzne:

```sql
SELECT AVG(total_amount)
FROM course.orders
```

liczy średnią wartość zamówienia.

Zapytanie zewnętrzne pokazuje tylko zamówienia większe niż ta średnia.

To jest przykład subquery, które zwraca jedną wartość. Taki typ nazywa się
czasem subquery skalarne.

W tym przypadku zapytanie wewnętrzne:

```sql
SELECT AVG(total_amount)
FROM course.orders
```

zwraca jedną liczbę, więc można jej użyć tak, jakby była zwykłą wartością w
warunku:

```sql
WHERE total_amount > jedna_liczba
```

## Subquery nieskorelowane i skorelowane

Subquery może być:

- nieskorelowane,
- skorelowane.

Subquery nieskorelowane nie potrzebuje danych z zapytania zewnętrznego.

Przykład:

```sql
SELECT
    order_id,
    total_amount
FROM course.orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM course.orders
);
```

Zapytanie wewnętrzne liczy jedną średnią dla całej tabeli.

Subquery skorelowane używa kolumny z zapytania zewnętrznego.

Przykład:

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM course.customers c
WHERE EXISTS (
    SELECT 1
    FROM course.orders o
    WHERE o.customer_id = c.customer_id
);
```

Wewnętrzne zapytanie używa `c.customer_id`, czyli wartości z aktualnie
sprawdzanego klienta.

Można to czytać tak:

> Dla każdego klienta sprawdź, czy istnieje przynajmniej jedno jego zamówienie.

## Subquery w WHERE z IN

Subquery może przygotować listę wartości.

Przykład: pokaż klientów, którzy mają zamówienia.

```sql
SELECT
    customer_id,
    customer_name
FROM course.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM course.orders
);
```

Zapytanie wewnętrzne zwraca listę identyfikatorów klientów z zamówieniami.

Zapytanie zewnętrzne pokazuje klientów z tej listy.

## Subquery w WHERE z NOT IN

Przykład: pokaż klientów bez zamówień.

```sql
SELECT
    customer_id,
    customer_name
FROM course.customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM course.orders
);
```

`NOT IN` wygląda prosto, ale ma ważną pułapkę z `NULL`.

Jeżeli zapytanie wewnętrzne zwróci chociaż jednego `NULL`, wynik `NOT IN` może
być pusty, nawet jeżeli intuicyjnie spodziewasz się rekordów.

Dlatego przy szukaniu braku dopasowania bezpieczniejszym wzorcem jest często
`NOT EXISTS`.

## Subquery w FROM

Subquery może działać jak tymczasowa tabela.

Przykład:

```sql
SELECT
    customer_id,
    total_revenue
FROM (
    SELECT
        customer_id,
        SUM(total_amount) AS total_revenue
    FROM course.orders
    GROUP BY customer_id
) customer_revenue
WHERE total_revenue > 200;
```

Subquery w `FROM` musi mieć alias.

W tym przykładzie alias to:

```text
customer_revenue
```

## Subquery w SELECT

Subquery może pojawić się w `SELECT`, jeśli zwraca jedną wartość.

```sql
SELECT
    order_id,
    total_amount,
    (
        SELECT ROUND(AVG(total_amount), 2)
        FROM course.orders
    ) AS average_order_value
FROM course.orders;
```

Ta sama średnia pojawi się przy każdym zamówieniu.

## EXISTS

`EXISTS` sprawdza, czy zapytanie wewnętrzne zwraca jakikolwiek rekord.

Przykład:

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM course.customers c
WHERE EXISTS (
    SELECT 1
    FROM course.orders o
    WHERE o.customer_id = c.customer_id
);
```

To zapytanie pokazuje klientów, którzy mają przynajmniej jedno zamówienie.

W `EXISTS` często piszemy:

```sql
SELECT 1
```

Nie chodzi o to, że chcemy zobaczyć liczbę `1`. `EXISTS` nie interesuje się
wartościami zwróconych kolumn. Interesuje się tylko tym, czy zapytanie
wewnętrzne zwróciło jakikolwiek wiersz.

Dlatego `SELECT 1` znaczy tutaj:

> Nie pobieraj konkretnych danych, tylko sprawdź, czy istnieje pasujący rekord.

To jest przykład subquery skorelowanego. Zapytanie wewnętrzne używa kolumny
z zapytania zewnętrznego:

```sql
o.customer_id = c.customer_id
```

Można to czytać tak: dla każdego klienta `c` sprawdź, czy istnieje przynajmniej
jedno zamówienie `o` tego klienta.

## NOT EXISTS

`NOT EXISTS` sprawdza brak dopasowania.

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM course.customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM course.orders o
    WHERE o.customer_id = c.customer_id
);
```

To zapytanie pokazuje klientów bez zamówień.

Ten sam problem można zapisać joinem:

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM course.customers c
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

Oba zapytania odpowiadają na podobne pytanie:

> Pokaż klientów, dla których nie ma pasującego zamówienia.

Na początku możesz używać wersji, którą łatwiej rozumiesz. W praktyce
`NOT EXISTS` jest bardzo dobrym wyborem do sprawdzania braku relacji, bo dobrze
radzi sobie z `NULL` i jasno pokazuje intencję.

## Najważniejsze rzeczy do zapamiętania

- Subquery to zapytanie w zapytaniu.
- Subquery może być w `WHERE`, `FROM` albo `SELECT`.
- Subquery w `FROM` musi mieć alias.
- Subquery skalarne zwraca jedną wartość.
- Subquery skorelowane używa kolumny z zapytania zewnętrznego.
- `IN` działa z listą wartości.
- `EXISTS` sprawdza, czy istnieje dopasowany rekord.
- `NOT EXISTS` sprawdza, czy dopasowany rekord nie istnieje.

## Uwaga na NOT IN i NULL

`NOT IN` bywa zdradliwe, jeśli zapytanie wewnętrzne może zwrócić `NULL`.
Wtedy wynik może być inny, niż intuicyjnie oczekujesz.

Jeżeli szukasz rekordów bez dopasowania, często bezpieczniej użyć
`NOT EXISTS`:

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM course.customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM course.orders o
    WHERE o.customer_id = c.customer_id
);
```

Na początku zapamiętaj prostą zasadę:

- `IN` jest wygodne do listy wartości,
- `EXISTS` i `NOT EXISTS` są bardzo dobre do sprawdzania istnienia relacji
  między tabelami.
