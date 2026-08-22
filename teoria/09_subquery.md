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

## Najważniejsze rzeczy do zapamiętania

- Subquery to zapytanie w zapytaniu.
- Subquery może być w `WHERE`, `FROM` albo `SELECT`.
- Subquery w `FROM` musi mieć alias.
- `IN` działa z listą wartości.
- `EXISTS` sprawdza, czy istnieje dopasowany rekord.
- `NOT EXISTS` sprawdza, czy dopasowany rekord nie istnieje.

