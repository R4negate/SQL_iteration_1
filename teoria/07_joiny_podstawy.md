# Joiny

## Uwaga przed rozpoczęciem lekcji

Przed przerabianiem tej lekcji wykonaj w bazie skrypt:

```text
SQL_iteration_1\zadania\DDL\04_prepare_join_demo_records.sql
```

Ten skrypt dodaje i usuwa kilka rekordów w istniejących tabelach `course.*`, żeby było widać różnice między joinami.

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

`PRIMARY KEY`, czyli klucz główny, to kolumna albo zestaw kolumn, który jednoznacznie identyfikuje rekord w tabeli.

Przykład:

```sql
course.customers.customer_id
```

Jeśli `customer_id = 10`, to powinien oznaczać jednego konkretnego klienta.

To znaczy, że w tabeli `customers` nie mogą istnieć dwaj różni klienci z takim samym `customer_id`.

Przykład poprawny:

```text
customer_id | customer_name
1           | Anna Kowalska
2           | Jan Nowak
3           | Maria Schmidt
```

Przykład niepoprawny:

```text
customer_id | customer_name
1           | Anna Kowalska
1           | Jan Nowak
```

Tutaj baza nie powinna pozwolić wstawić drugiego rekordu z `customer_id = 1`, bo `customer_id` jest kluczem głównym.

Klucz główny ma dwie bardzo ważne cechy:

- nie może się powtarzać,
- nie może być `NULL`.

`NULL` oznacza brak wartości. Gdyby klucz główny mógł być `NULL`, to rekord nie miałby pewnego identyfikatora.

Dlatego taki rekord nie ma sensu:

```text
customer_id | customer_name
NULL        | Anna Kowalska
```

W naszych tabelach kluczami głównymi są między innymi:

- `course.customers.customer_id`,
- `course.orders.order_id`,
- `course.products.product_id`,
- `course.order_items.order_item_id`.

Można o tym myśleć tak:

- `customer_id` identyfikuje klienta,
- `order_id` identyfikuje zamówienie,
- `product_id` identyfikuje produkt,
- `order_item_id` identyfikuje jedną pozycję zamówienia.

Klucz główny odpowiada na pytanie:

> Jak jednoznacznie wskazać jeden konkretny rekord w tej tabeli?

## Foreign key

`FOREIGN KEY`, czyli klucz obcy, to kolumna w jednej tabeli, która wskazuje rekord w innej tabeli.

Przykład:

```sql
course.orders.customer_id
```

Ta kolumna mówi, który klient złożył dane zamówienie.

W tabeli `orders` mamy kolumnę `customer_id`.

Ta kolumna nie jest nazwą klienta. To jest identyfikator klienta z tabeli `customers`.

Przykład:

```text
course.customers

customer_id | customer_name
1           | Anna Kowalska
2           | Jan Nowak
```

```text
course.orders

order_id | customer_id | total_amount
1001     | 1           | 169.99
1002     | 2           | 120.00
```

Z tego wynika:

- zamówienie `1001` należy do klienta `1`, czyli do Anny,
- zamówienie `1002` należy do klienta `2`, czyli do Jana.

Klucz obcy pilnuje spójności danych.

Jeżeli `course.orders.customer_id` wskazuje na `course.customers.customer_id`, to baza nie powinna pozwolić dodać zamówienia dla klienta, który nie istnieje.

Czyli taki rekord powinien być zablokowany:

```text
order_id | customer_id | total_amount
9999     | 123456      | 50.00
```

Jeżeli nie ma klienta z `customer_id = 123456`, to takie zamówienie byłoby "oderwane" od klienta.

W naszych tabelach mamy takie relacje:

```text
course.orders.customer_id
    -> course.customers.customer_id
```

czyli:

> Zamówienie wskazuje klienta.

```text
course.order_items.order_id
    -> course.orders.order_id
```

czyli:

> Pozycja zamówienia wskazuje zamówienie.

```text
course.order_items.product_id
    -> course.products.product_id
```

czyli:

> Pozycja zamówienia wskazuje produkt.

Klucz obcy odpowiada na pytanie:

> Do którego rekordu w innej tabeli odnosi się ten rekord?

Ważne: klucz obcy może się powtarzać.

Przykład:

```text
order_id | customer_id
1001     | 1
1004     | 1
1012     | 1
```

To jest poprawne, bo jeden klient może mieć wiele zamówień.

Czy klucz obcy może być `NULL`?

To zależy od definicji tabeli.

W naszych tabelach `course.orders.customer_id` ma `NOT NULL`, więc każde zamówienie musi mieć klienta.

Fragment definicji tabeli:

```sql
customer_id INT NOT NULL
```

To znaczy:

> Nie wolno dodać zamówienia bez wartości `customer_id`.

Gdyby kolumna nie miała `NOT NULL`, technicznie mogłaby przyjmować `NULL`, ale wtedy rekord nie wskazywałby żadnego klienta.

## Primary key vs foreign key

Najprostsza różnica:

```text
PRIMARY KEY  = kim jestem?
FOREIGN KEY  = na kogo wskazuję?
```

Dla tabeli `customers`:

```text
customer_id
```

to klucz główny, bo identyfikuje klienta.

Dla tabeli `orders`:

```text
customer_id
```

to klucz obcy, bo wskazuje klienta.

Ta sama nazwa kolumny może występować w różnych tabelach, ale jej rola może być inna.

W tabeli `customers`:

```sql
customer_id
```

oznacza:

> identyfikator tego klienta.

W tabeli `orders`:

```sql
customer_id
```

oznacza:

> identyfikator klienta, który złożył to zamówienie.

To właśnie dzięki temu możemy wykonać join:

```sql
ON o.customer_id = c.customer_id
```

## Relacje między tabelami

Joiny są łatwiejsze, gdy rozumiemy relacje między tabelami.

Najczęstsze typy relacji:

- jeden do jednego,
- jeden do wielu,
- wiele do wielu.

## Relacja jeden do wielu

W naszych danych najważniejsza jest relacja jeden do wielu.

Przykład:

```text
jeden klient -> wiele zamówień
```

Jeden klient może mieć zero, jedno albo wiele zamówień.

Ale jedno zamówienie należy do jednego klienta.

Przykład:

```text
course.customers

customer_id | customer_name
1           | Anna Kowalska
```

```text
course.orders

order_id | customer_id
1001     | 1
1004     | 1
1012     | 1
```

Po joinie Anna pojawi się trzy razy, bo ma trzy zamówienia.

To nie jest duplikat w sensie błędu.

To jest wynik relacji jeden do wielu.

## Grain, czyli co oznacza jeden wiersz

Przed joinem warto zadać pytanie:

> Co oznacza jeden wiersz w tej tabeli?

To pytanie jest bardzo ważne w data engineeringu.

Przykłady:

- jeden wiersz w `course.customers` oznacza jednego klienta,
- jeden wiersz w `course.orders` oznacza jedno zamówienie,
- jeden wiersz w `course.order_items` oznacza jedną pozycję zamówienia,
- jeden wiersz w `course.products` oznacza jeden produkt.

Jeśli łączymy `customers` z `orders`, to przechodzimy z poziomu klienta na poziom zamówienia.

Dlatego liczba wierszy może wzrosnąć.

Przykład:

```text
customers: 1 wiersz dla Anny
orders: 3 wiersze dla Anny
wynik joina: 3 wiersze dla Anny
```

Przy joinach zawsze pytamy:

- która tabela jest tabelą bazową?
- czy chcemy zachować rekordy bez dopasowania?
- czy relacja jest jeden do jednego, czy jeden do wielu?
- czy po joinie liczba wierszy może wzrosnąć?

## ON

`ON` mówi, jak połączyć rekordy z dwóch tabel.

Przykład:

```sql
ON o.customer_id = c.customer_id
```

Znaczenie:

> Połącz zamówienie z klientem, który ma ten sam `customer_id`.

W tym przykładzie:

- `o.customer_id` pochodzi z tabeli `orders`,
- `c.customer_id` pochodzi z tabeli `customers`.

Czyli mówimy:

> Weź zamówienie i znajdź klienta, którego identyfikator pasuje do `customer_id` zapisanego w zamówieniu.

`ON` nie musi zawsze używać kolumn o tej samej nazwie, ale bardzo często tak będzie.

Najważniejsze jest to, żeby warunek opisywał prawdziwą relację między tabelami.

Dobry warunek:

```sql
ON o.customer_id = c.customer_id
```

Błędny warunek:

```sql
ON o.order_id = c.customer_id
```

Ten drugi warunek technicznie może się wykonać, ale biznesowo nie ma sensu, bo numer zamówienia nie jest identyfikatorem klienta.

## ON a WHERE

`ON` i `WHERE` robią różne rzeczy.

`ON` mówi:

> Jak połączyć tabele?

`WHERE` mówi:

> Które rekordy zostawić w wyniku?

Przykład:

```sql
SELECT
    o.order_id,
    c.customer_name,
    o.status
FROM course.orders o
INNER JOIN course.customers c
    ON o.customer_id = c.customer_id
WHERE o.status = 'paid';
```

Tutaj:

- `ON o.customer_id = c.customer_id` łączy zamówienie z klientem,
- `WHERE o.status = 'paid'` zostawia tylko opłacone zamówienia.

Nie mieszamy tych dwóch pojęć.

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
- klientów bez zamówień.

W naszych tabelach `course.orders` ma klucz obcy do `course.customers`, więc nie dodajemy zamówień bez klienta.

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

## Najważniejsze rzeczy do zapamiętania

- `PRIMARY KEY` jednoznacznie identyfikuje rekord w tabeli.
- `PRIMARY KEY` nie może się powtarzać.
- `PRIMARY KEY` nie może być `NULL`.
- `FOREIGN KEY` wskazuje rekord w innej tabeli.
- `FOREIGN KEY` może się powtarzać, np. wiele zamówień może wskazywać tego samego klienta.
- `FOREIGN KEY` pomaga pilnować spójności danych.
- `JOIN` łączy tabele.
- `ON` definiuje warunek połączenia.
- `ON` mówi, jak rekordy z dwóch tabel mają się dopasować.
- `WHERE` mówi, które rekordy zostawić w wyniku.
- `INNER JOIN` pokazuje tylko dopasowania.
- `LEFT JOIN` zachowuje wszystkie rekordy z lewej tabeli.
- `RIGHT JOIN` zachowuje wszystkie rekordy z prawej tabeli.
- `FULL OUTER JOIN` zachowuje rekordy z obu tabel.
- `CROSS JOIN` tworzy wszystkie kombinacje rekordów.
- `SELF JOIN` łączy tabelę z samą sobą.
- Anti join pozwala znaleźć rekordy bez dopasowania.
