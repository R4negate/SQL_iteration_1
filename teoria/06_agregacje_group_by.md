# Agregacje i GROUP BY

## Czym jest agregacja

Agregacja zamienia wiele wierszy w jedną wartość podsumowania.

Przykłady pytań:

- Ile jest zamówień?
- Jaka jest suma sprzedaży?
- Jaka jest średnia wartość zamówienia?
- Jaka jest największa płatność?

W data engineeringu agregacje są podstawą raportowania. Surowe dane często są
zapisane bardzo szczegółowo, np. jedno zamówienie albo jedna pozycja zamówienia
w jednym wierszu. Raport zwykle potrzebuje innego poziomu:

- sprzedaż per kraj,
- sprzedaż per miesiąc,
- liczba zamówień per status,
- średnia wartość zamówienia per kanał sprzedaży.

Agregacja zmienia więc poziom szczegółowości wyniku.

## Grain przy agregacjach

`Grain` oznacza, co reprezentuje jeden wiersz.

Przed agregacją pytamy:

> Co oznacza jeden wiersz w tabeli źródłowej?

Po agregacji pytamy:

> Co oznacza jeden wiersz w wyniku?

Przykład:

```sql
SELECT status, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

Tabela `course.orders` ma grain:

```text
jeden wiersz = jedno zamówienie
```

Wynik po `GROUP BY status` ma grain:

```text
jeden wiersz = jeden status zamówienia
```

To jest bardzo ważne, bo po agregacji nie patrzymy już na pojedyncze
zamówienia, tylko na grupy zamówień.

## Najważniejsze funkcje agregujące

```sql
COUNT(*)       -- liczba rekordów
COUNT(kolumna) -- liczba rekordów, gdzie kolumna nie jest NULL
COUNT(DISTINCT kolumna) -- liczba unikalnych wartości
SUM(kolumna)  -- suma
AVG(kolumna)  -- średnia
MIN(kolumna)  -- minimum
MAX(kolumna)  -- maksimum
```

## COUNT

```sql
SELECT COUNT(*) AS orders_count
FROM course.orders;
```

To zapytanie liczy wszystkie rekordy w tabeli `orders`.

## COUNT DISTINCT

`COUNT(DISTINCT kolumna)` liczy unikalne wartości.

Przykład:

```sql
SELECT COUNT(DISTINCT customer_id) AS customers_with_orders
FROM course.orders;
```

To zapytanie odpowiada na pytanie:

> Ilu różnych klientów złożyło zamówienie?

Gdy jeden klient ma trzy zamówienia, `COUNT(*)` policzy trzy wiersze, ale
`COUNT(DISTINCT customer_id)` policzy tego klienta tylko raz.

## SUM

```sql
SELECT SUM(total_amount) AS total_revenue
FROM course.orders;
```

To zapytanie liczy sumę wartości zamówień.

## AVG

```sql
SELECT AVG(total_amount) AS average_order_value
FROM course.orders;
```

To zapytanie liczy średnią wartość zamówienia.

## GROUP BY

`GROUP BY` pozwala liczyć agregacje w grupach.

Przykład:

```sql
SELECT status, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

To zapytanie odpowiada na pytanie:

> Ile zamówień jest w każdym statusie?

## Przykład biznesowy

```sql
SELECT country, COUNT(*) AS customers_count
FROM course.customers
GROUP BY country
ORDER BY customers_count DESC;
```

To zapytanie pokazuje liczbę klientów per kraj.

## WHERE a GROUP BY

`WHERE` działa przed agregacją.

Przykład:

```sql
SELECT country, COUNT(*) AS customers_count
FROM course.customers
WHERE email IS NOT NULL
GROUP BY country;
```

Najpierw zostają tylko klienci z emailem, potem SQL liczy ich per kraj.

## HAVING

`HAVING` filtruje wynik po agregacji.

```sql
SELECT country, COUNT(*) AS customers_count
FROM course.customers
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

## COUNT(*) a COUNT(kolumna)

`COUNT(*)` liczy wiersze.

```sql
SELECT COUNT(*) AS rows_count
FROM course.customers;
```

`COUNT(email)` liczy tylko te wiersze, w których `email` nie jest `NULL`.

```sql
SELECT COUNT(email) AS customers_with_email
FROM course.customers;
```

To ważna różnica. Jeśli kolumna ma braki danych, `COUNT(kolumna)` może dać
mniejszy wynik niż `COUNT(*)`.

## Co musi być w GROUP BY

Jeżeli w `SELECT` pokazujesz zwykłą kolumnę oraz agregację, zwykła kolumna musi
być w `GROUP BY`.

Poprawnie:

```sql
SELECT status, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

Niepoprawnie:

```sql
SELECT status, order_date, COUNT(*) AS orders_count
FROM course.orders
GROUP BY status;
```

Problem: `order_date` nie jest ani agregacją, ani częścią `GROUP BY`.

## Kolejność myślenia

Przy agregacjach zadawaj sobie pytania w tej kolejności:

1. Z której tabeli biorę dane?
2. Czy najpierw filtruję pojedyncze wiersze przez `WHERE`?
3. Po czym grupuję dane?
4. Jakie metryki liczę w każdej grupie?
5. Czy filtruję gotowe grupy przez `HAVING`?

Przykład:

```sql
SELECT status, SUM(total_amount) AS total_revenue
FROM course.orders
WHERE total_amount > 0
GROUP BY status
HAVING SUM(total_amount) > 200;
```

Najpierw SQL odrzuca pojedyncze wiersze przez `WHERE`, potem grupuje po
`status`, liczy sumę i dopiero na końcu filtruje grupy przez `HAVING`.

## Agregacja warunkowa z CASE

Czasami chcemy policzyć kilka metryk w jednym zapytaniu.

Przykład: liczba wszystkich zamówień oraz liczba zamówień w konkretnych
statusach.

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'paid' THEN 1 ELSE 0 END) AS paid_orders,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders
FROM course.orders;
```

Jak to czytać:

- `CASE WHEN status = 'paid' THEN 1 ELSE 0 END` tworzy tymczasowo wartości
  `1` albo `0`,
- `SUM(...)` dodaje te jedynki,
- wynik mówi, ile wierszy spełniło warunek.

To jest częsty wzorzec analityczny. Pozwala zbudować kilka liczników bez
pisania kilku osobnych zapytań.

Ten sam wzorzec można połączyć z `GROUP BY`:

```sql
SELECT
    country,
    COUNT(*) AS customers_count,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS customers_without_email
FROM course.customers
GROUP BY country;
```

Wynik ma jeden wiersz per kraj i dwie metryki dla każdego kraju.

## Agregacje po joinach

Przy agregacjach po joinach trzeba uważać na zmianę liczby wierszy.

Przykład:

```sql
SELECT COUNT(*) AS rows_after_join
FROM course.orders o
INNER JOIN course.order_items oi
    ON o.order_id = oi.order_id;
```

To nie liczy zamówień. To liczy pozycje zamówień po połączeniu tabel.

Jeżeli jedno zamówienie ma trzy produkty, po joinie pojawi się trzy razy.

Jeśli naprawdę chcesz policzyć zamówienia po takim joinie, użyj:

```sql
SELECT COUNT(DISTINCT o.order_id) AS orders_count
FROM course.orders o
INNER JOIN course.order_items oi
    ON o.order_id = oi.order_id;
```

Prosta zasada:

> Po każdym joinie upewnij się, co oznacza jeden wiersz wyniku.

## Typowy schemat zapytania analitycznego

Wiele zapytań analitycznych ma podobny kształt:

1. wybierz tabelę startową,
2. dołącz potrzebne tabele,
3. odfiltruj niepotrzebne wiersze,
4. policz metryki,
5. pogrupuj wynik,
6. posortuj wynik.

Przykład:

```sql
SELECT
    c.country,
    SUM(o.total_amount) AS total_revenue
FROM course.orders o
INNER JOIN course.customers c
    ON o.customer_id = c.customer_id
WHERE o.status = 'paid'
GROUP BY c.country
ORDER BY total_revenue DESC;
```

To zapytanie odpowiada na pytanie:

> Jaka jest suma opłaconych zamówień per kraj klienta?
