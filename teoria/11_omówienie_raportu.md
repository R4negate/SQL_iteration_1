# 013 - Jak tworzyć raporty

## Polecenie

Przygotuj raport zawierający kolumny:

- `issue_type`
- `object_id`
- `object_name`
- `details`

Raport ma skladac sie z 3 czesci polaczonych przez `UNION ALL`.

W raporcie pokaz:

1. Klientow bez zamowien.
   - `issue_type`: `customer_without_order`,
   - `object_id`: `customer_id`,
   - `object_name`: `customer_name`,
   - `details`: {krótki opis problemu}.

2. Zamowienia anulowane.
   - `issue_type`: `cancelled_order`,
   - `object_id`: `order_id`,
   - `object_name`: tekst w formacie `Order <order_id>`,
   - `details`: {krótki opis problemu}.

3. Produkty z cena bazowa wieksza niz `200`.
   - `issue_type`: `expensive_product`,
   - `object_id`: `product_id`,
   - `object_name`: `product_name`,
   - `details`: {krótki opis problemu}.

Kolumna `details` ma zawierac krotki opis problemu dla kazdego typu rekordu.

Wynik posortuj po:

- `issue_type`,
- `object_id`.

Pamietaj:

- kazdy `SELECT` w `UNION ALL` musi zwracac te sama liczbe kolumn,
- kolumny musza byc w tej samej kolejnosci,
- typy danych powinny byc ze soba zgodne.

## Po co jest taki raport

Normalnie kazdy problem mozna byloby sprawdzac osobnym query:

- osobno klienci bez zamowien,
- osobno anulowane zamowienia,
- osobno drogie produkty.

Ale w pracy data engineera czesto wygodniej jest zbudowac jeden raport, ktory laczy kilka problemów w jeden wspolny format.

Wtedy kazdy wiersz odpowiada jednemu problemowi, a kolumna `issue_type` mowi, jaki to typ problemu.

## UNION i UNION ALL

`UNION` oraz `UNION ALL` sluza do laczenia wynikow kilku zapytan jedno pod drugim.

To jest inny mechanizm niz `JOIN`.

`JOIN` laczy tabele poziomo, czyli dokleja kolumny:

```sql
customers + orders = kolumny klienta + kolumny zamowienia
```

`UNION ALL` laczy wyniki pionowo, czyli dokleja wiersze:

```sql
wynik 1
+ wynik 2
+ wynik 3
```

Przyklad:

```sql
SELECT 'customer_without_order' AS issue_type

UNION ALL

SELECT 'cancelled_order' AS issue_type;
```

Wynik:

```text
issue_type
------------------------
customer_without_order
cancelled_order
```

## Różnica miedzy UNION a UNION ALL

`UNION ALL` zostawia wszystkie wiersze, rowniez duplikaty.

```sql
SELECT 'PL' AS country

UNION ALL

SELECT 'PL' AS country;
```

Wynik:

```text
country
-------
PL
PL
```

`UNION` usuwa duplikaty.

```sql
SELECT 'PL' AS country

UNION

SELECT 'PL' AS country;
```

Wynik:

```text
country
-------
PL
```

W raportach kontrolnych zwykle lepszy jest `UNION ALL`, bo nie chcemy, aby baza po cichu usuwala podobne rekordy.

## Warunek konieczny przy UNION ALL

Kazdy `SELECT` musi zwracac taka sama strukture (liczba kolumn + typy kolumn zwracanych musza byc takie same).

To jest poprawne:

```sql
SELECT
    'customer_without_order' AS issue_type,
    10 AS object_id,
    'Anna' AS object_name,
    'Customer has no orders' AS details

UNION ALL

SELECT
    'cancelled_order' AS issue_type,
    100 AS object_id,
    'Order 100' AS object_name,
    'Order is cancelled' AS details;
```

Oba `SELECT`-y zwracaja:

```text
tekst, liczba, tekst, tekst
```

To jest niepoprawne:

```sql
SELECT
    customer_id,
    customer_name
FROM course.customers

UNION ALL

SELECT
    order_id,
    status,
    total_amount
FROM course.orders;
```

Pierwszy `SELECT` ma 2 kolumny, drugi ma 3 kolumny, wiec PostgreSQL nie wie, jak skleic takie wyniki.

## Krok 1 - ustalamy wspolny format raportu

Najpierw ustalamy, ze kazdy fragment raportu ma zwracac te same 4 kolumny:

```sql
SELECT
    issue_type,
    object_id,
    object_name,
    details
```

Znaczenie kolumn:

- `issue_type` - typ problemu, np. `customer_without_order`,
- `object_id` - identyfikator obiektu, ktorego dotyczy problem,
- `object_name` - czytelna nazwa obiektu,
- `details` - krotki opis problemu.

## Krok 2 - klienci bez zamowien

Pierwsza czesc raportu ma pokazac klientow bez zamowien.

To jest klasyczny anti join.

Najpierw bierzemy wszystkich klientow:

```sql
FROM course.customers c
```

Potem probujemy dokleic zamowienia:

```sql
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id
```

`LEFT JOIN` zostawia wszystkich klientow, nawet jezeli nie maja zamowienia.

Dla klienta bez zamowienia kolumny z tabeli `orders` beda mialy `NULL`.

Dlatego filtrujemy:

```sql
WHERE o.order_id IS NULL
```

Cala pierwsza czesc:

```sql
SELECT
    'customer_without_order' AS issue_type,
    c.customer_id AS object_id,
    c.customer_name AS object_name,
    'Customer has no orders' AS details
FROM course.customers c
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
```

Zauwaz, ze `issue_type` i `details` to stale tekstowe. One nie pochodza z tabeli. Dodajemy je po to, zeby wynik byl czytelnym raportem.

## Krok 3 - zamowienia anulowane

Druga czesc raportu ma pokazac zamowienia o statusie `cancelled`.

Tutaj nie potrzebujemy joina, bo wszystkie potrzebne dane sa w tabeli `course.orders`.

```sql
SELECT
    'cancelled_order' AS issue_type,
    o.order_id AS object_id,
    CONCAT('Order ', o.order_id) AS object_name,
    'Order has cancelled status' AS details
FROM course.orders o
WHERE o.status = 'cancelled'
```
!!! Uwaga nowa funkcja: `CONCAT('Order ', o.order_id)` tworzy tekst, np.:

```text
Order 100
```

Robimy tak dlatego, ze raport wymaga kolumny `object_name`, a zamowienie nie ma naturalnej nazwy tak jak klient albo produkt.

## Krok 4 - produkty drozsze niz 200

Trzecia czesc raportu ma pokazac produkty z cena bazowa wieksza niz `200`.

Tutaj tez nie potrzebujemy joina, bo wszystko jest w tabeli `course.products`.

```sql
SELECT
    'expensive_product' AS issue_type,
    p.product_id AS object_id,
    p.product_name AS object_name,
    'Product base price is greater than 200' AS details
FROM course.products p
WHERE p.base_price > 200
```

To jest zwykly filtr przez `WHERE`.

## Krok 5 - laczymy fragmenty przez UNION ALL

Kiedy kazda czesc dziala osobno, laczymy je przez `UNION ALL`.

```sql
SELECT
    'customer_without_order' AS issue_type,
    c.customer_id AS object_id,
    c.customer_name AS object_name,
    'Customer has no orders' AS details
FROM course.customers c
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL

UNION ALL

SELECT
    'cancelled_order' AS issue_type,
    o.order_id AS object_id,
    CONCAT('Order ', o.order_id) AS object_name,
    'Order has cancelled status' AS details
FROM course.orders o
WHERE o.status = 'cancelled'

UNION ALL

SELECT
    'expensive_product' AS issue_type,
    p.product_id AS object_id,
    p.product_name AS object_name,
    'Product base price is greater than 200' AS details
FROM course.products p
WHERE p.base_price > 200;
```

Na tym etapie raport juz dziala, ale nie jest jeszcze posortowany.

## Krok 6 - dodajemy sortowanie

`ORDER BY` przy `UNION ALL` dajemy na samym koncu calego zapytania.

Nie piszemy osobnego `ORDER BY` po kazdym fragmencie.

Poprawnie:

```sql
SELECT ...

UNION ALL

SELECT ...

UNION ALL

SELECT ...

ORDER BY issue_type, object_id;
```

Niepoprawnie:

```sql
SELECT ...
ORDER BY issue_type

UNION ALL

SELECT ...
ORDER BY issue_type;
```

## Finalne rozwiazanie

```sql
SELECT
    'customer_without_order' AS issue_type,
    c.customer_id AS object_id,
    c.customer_name AS object_name,
    'Customer has no orders' AS details
FROM course.customers c
LEFT JOIN course.orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL

UNION ALL

SELECT
    'cancelled_order' AS issue_type,
    o.order_id AS object_id,
    CONCAT('Order ', o.order_id) AS object_name,
    'Order has cancelled status' AS details
FROM course.orders o
WHERE o.status = 'cancelled'

UNION ALL

SELECT
    'expensive_product' AS issue_type,
    p.product_id AS object_id,
    p.product_name AS object_name,
    'Product base price is greater than 200' AS details
FROM course.products p
WHERE p.base_price > 200

ORDER BY issue_type, object_id;
```


