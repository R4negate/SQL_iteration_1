# Podstawowe joiny

## Po co są joiny

Dane w bazie są często podzielone na wiele tabel.

Przykład:

- tabela `customers` przechowuje klientów,
- tabela `orders` przechowuje zamówienia,
- tabela `products` przechowuje produkty.

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

## INNER JOIN

`INNER JOIN` pokazuje tylko rekordy, które mają dopasowanie w obu tabelach.

```sql
SELECT
    o.order_id,
    o.order_date,
    c.customer_name
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;
```

Znaczenie:

- `orders o` - tabela `orders` ma alias `o`,
- `customers c` - tabela `customers` ma alias `c`,
- `ON o.customer_id = c.customer_id` - warunek połączenia.

## Alias tabeli

Alias tabeli skraca zapis.

Zamiast pisać:

```sql
orders.customer_id
```

możemy pisać:

```sql
o.customer_id
```

Alias nie zmienia nazwy tabeli w bazie. Działa tylko w tym query.

## LEFT JOIN

`LEFT JOIN` bierze wszystkie rekordy z lewej tabeli i dopasowane rekordy
z prawej tabeli.

```sql
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
```

To zapytanie pokaże również klientów bez zamówień.

Dla klientów bez zamówień kolumny z tabeli `orders` będą miały `NULL`.

## INNER JOIN vs LEFT JOIN

`INNER JOIN` pokazuje tylko dopasowane rekordy.

`LEFT JOIN` zachowuje wszystkie rekordy z lewej tabeli.

Prosta intuicja:

- `INNER JOIN` - pokaż tylko tych, którzy mają parę,
- `LEFT JOIN` - pokaż wszystkich z lewej strony, nawet jeśli nie mają pary.

## Pułapka: join może zwiększyć liczbę rekordów

Jeśli jeden klient ma wiele zamówień, to po joinie klient pojawi się wiele razy.

To nie jest błąd techniczny. To wynika z relacji jeden do wielu.

Dlatego przy joinach zawsze pytamy:

- co oznacza jeden rekord w tabeli lewej?
- co oznacza jeden rekord w tabeli prawej?
- czy relacja jest 1:1, 1:N, czy N:N?
- czy po joinie liczba rekordów ma prawo wzrosnąć?

## Typowe błędy

- Brak warunku `ON`.
- Zły warunek połączenia.
- Pomylenie `INNER JOIN` i `LEFT JOIN`.
- Brak aliasów przy kolumnach o tych samych nazwach.
- Niezrozumienie, czemu po joinie jest więcej rekordów.
