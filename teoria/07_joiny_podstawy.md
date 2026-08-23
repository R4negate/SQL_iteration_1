# Joiny

## Po co są joiny

Dane w bazie są często podzielone na wiele tabel.

Przykład:

- `customers` przechowuje klientów,
- `orders` przechowuje zamówienia,
- `products` przechowuje produkty,
- `order_items` przechowuje produkty w zamówieniach.

Jeśli chcemy zobaczyć zamówienia razem z nazwą klienta, musimy połączyć tabele.

Do tego służy `JOIN`.

## Primary key

Primary key to kolumna, która jednoznacznie identyfikuje rekord w tabeli.

Przykład:

```sql
customers.customer_id
```

Jeśli `customer_id = 10`, to powinien oznaczać jednego konkretnego klienta.

## Foreign key

Foreign key to kolumna, która wskazuje rekord w innej tabeli.

Przykład:

```sql
orders.customer_id
```

Ta kolumna mówi, który klient złożył dane zamówienie.

## ON

`ON` mówi, jak połączyć rekordy z dwóch tabel.

Przykład:

```sql
ON o.customer_id = c.customer_id
```

Znaczenie:

> Połącz zamówienie z klientem, który ma ten sam `customer_id`.

## Alias tabeli

Alias tabeli skraca zapis.

Zamiast pisać:

```sql
course.orders.customer_id
```

możemy pisać:

```sql
o.customer_id
```

Przykład:

```sql
FROM course.orders o
INNER JOIN course.customers c
    ON o.customer_id = c.customer_id;
```

Alias nie zmienia nazwy tabeli w bazie. Działa tylko w tym zapytaniu.

## INNER JOIN

`INNER JOIN` pokazuje tylko rekordy, które mają dopasowanie w obu tabelach.

```sql
SELECT
    o.order_id,
    o.order_date,
    c.customer_name
FROM course.orders o
INNER JOIN course.customers c
    ON o.customer_id = c.customer_id;
```

Prosta intuicja:

> Pokaż tylko te rekordy, które mają parę.

Jeśli klient nie ma zamówienia, nie pojawi się w wyniku tego zapytania.

## LEFT JOIN

`LEFT JOIN` zachowuje wszystkie rekordy z lewej tabeli i dopasowane rekordy z prawej tabeli.

```sql
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM course.customers c
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id;
```

To zapytanie pokaże wszystkich klientów.

Jeśli klient nie ma zamówienia, kolumny z tabeli `orders` będą miały `NULL`.

## LEFT OUTER JOIN

`LEFT OUTER JOIN` oznacza to samo co `LEFT JOIN`.

Słowo `OUTER` jest opcjonalne.

```sql
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM course.customers c
LEFT OUTER JOIN course.orders o
    ON c.customer_id = o.customer_id;
```

## RIGHT JOIN

`RIGHT JOIN` zachowuje wszystkie rekordy z prawej tabeli i dopasowane rekordy z lewej tabeli.

```sql
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM course.orders o
RIGHT JOIN course.customers c
    ON o.customer_id = c.customer_id;
```

To zapytanie pokaże wszystkich klientów, nawet jeśli nie mają zamówień.

W praktyce `RIGHT JOIN` często można przepisać jako `LEFT JOIN`, zamieniając kolejność tabel.

## RIGHT OUTER JOIN

`RIGHT OUTER JOIN` oznacza to samo co `RIGHT JOIN`.

Słowo `OUTER` jest opcjonalne.

## FULL OUTER JOIN

`FULL OUTER JOIN` zachowuje rekordy z obu tabel.

```sql
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM course.customers c
FULL OUTER JOIN course.orders o
    ON c.customer_id = o.customer_id;
```

Wynik może zawierać:

- klientów z zamówieniami,
- klientów bez zamówień,
- zamówienia bez klienta, jeśli takie dane istnieją.

## CROSS JOIN

`CROSS JOIN` tworzy wszystkie możliwe kombinacje rekordów z dwóch tabel.

```sql
SELECT
    c.customer_name,
    p.product_name
FROM course.customers c
CROSS JOIN course.products p;
```

Jeśli mamy 8 klientów i 8 produktów, wynik będzie miał 64 wiersze.

Przy `CROSS JOIN` trzeba uważać, bo wynik może bardzo szybko urosnąć.

## SELF JOIN

`SELF JOIN` oznacza połączenie tabeli samej ze sobą.

Przykład: pokaż pary klientów z tego samego kraju.

```sql
SELECT
    c1.customer_name AS customer_1,
    c2.customer_name AS customer_2,
    c1.country
FROM course.customers c1
INNER JOIN course.customers c2
    ON c1.country = c2.country
   AND c1.customer_id < c2.customer_id;
```

Używamy dwóch aliasów tej samej tabeli:

- `c1`
- `c2`

## Anti join

Anti join to wzorzec, który pozwala znaleźć rekordy bez dopasowania.

Przykład: klienci bez zamówień.

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM course.customers c
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

Ten wzorzec jest bardzo przydatny, gdy chcemy znaleźć brakujące dane.

## Semi join

Semi join pokazuje rekordy z lewej tabeli, jeśli istnieje dopasowanie po prawej stronie, ale nie powiela rekordów z lewej tabeli.

Przykład: klienci, którzy mają przynajmniej jedno zamówienie.

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

To zapytanie pokaże klienta tylko raz, nawet jeśli ma wiele zamówień.

## NATURAL JOIN

`NATURAL JOIN` automatycznie łączy tabele po kolumnach o takich samych nazwach.

Przykład składni:

```sql
SELECT *
FROM table_a
NATURAL JOIN table_b;
```

W praktyce lepiej go unikać.

Lepiej pisać jawnie:

```sql
JOIN ... ON ...
```

Wtedy dokładnie widać, po jakim warunku łączymy tabele.

## Join wielu tabel

W jednym zapytaniu można połączyć więcej niż dwie tabele.

Przykład:

```sql
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM course.orders o
INNER JOIN course.customers c
    ON o.customer_id = c.customer_id
INNER JOIN course.order_items oi
    ON o.order_id = oi.order_id
INNER JOIN course.products p
    ON oi.product_id = p.product_id;
```

To zapytanie łączy:

```text
customers -> orders -> order_items -> products
```

## INNER JOIN vs LEFT JOIN

`INNER JOIN` pokazuje tylko dopasowane rekordy.

`LEFT JOIN` zachowuje wszystkie rekordy z lewej tabeli.

Prosta intuicja:

- `INNER JOIN` - pokaż tylko tych, którzy mają parę,
- `LEFT JOIN` - pokaż wszystkich z lewej strony, nawet jeśli nie mają pary.

## Pułapka: join może zwiększyć liczbę rekordów

Jeśli jeden klient ma wiele zamówień, to po joinie klient pojawi się wiele razy.

To nie jest błąd techniczny.

To wynika z relacji jeden do wielu.

Dlatego przy joinach zawsze pytamy:

- co oznacza jeden rekord w tabeli lewej?
- co oznacza jeden rekord w tabeli prawej?
- czy relacja jest 1:1, 1:N, czy N:N?
- czy po joinie liczba rekordów ma prawo wzrosnąć?

## Typowe błędy

- Brak warunku `ON`.
- Zły warunek połączenia.
- Pomylenie `INNER JOIN` i `LEFT JOIN`.
- Użycie `CROSS JOIN` przez przypadek.
- Brak aliasów przy kolumnach o tych samych nazwach.
- Niezrozumienie, czemu po joinie jest więcej rekordów.
- Używanie `NATURAL JOIN`, gdy warunek połączenia powinien być jawny.

## Najważniejsze rzeczy do zapamiętania

- `JOIN` łączy tabele.
- `ON` definiuje warunek połączenia.
- `INNER JOIN` pokazuje tylko dopasowania.
- `LEFT JOIN` zachowuje wszystkie rekordy z lewej tabeli.
- `RIGHT JOIN` zachowuje wszystkie rekordy z prawej tabeli.
- `FULL OUTER JOIN` zachowuje rekordy z obu tabel.
- `CROSS JOIN` tworzy wszystkie kombinacje rekordów.
- `SELF JOIN` łączy tabelę z samą sobą.
- Anti join pozwala znaleźć rekordy bez dopasowania.
- Semi join pozwala znaleźć rekordy, dla których istnieje dopasowanie.
- `NATURAL JOIN` istnieje, ale zwykle lepiej go unikać.
- Po joinie liczba wierszy może wzrosnąć.

