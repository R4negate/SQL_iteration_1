# Zadania 09 - zadania dodatkowe

Te zadania łączą tematy z poprzednich lekcji:

- `SELECT`
- aliasy
- `WHERE`
- `ORDER BY`
- `LIMIT`
- `IN`
- `BETWEEN`
- `LIKE`
- `IS NULL`
- agregacje
- `GROUP BY`
- `HAVING`
- `JOIN`
- `DISTINCT`
- `ROUND`
- `COALESCE`
- `CASE WHEN`

## Zadanie 1

Pokaż klientów z krajów `PL`, `DE` albo `FR`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `country`
- `email`

Jeżeli `email` jest `NULL`, pokaż tekst:

```text
missing email
```

## Zadanie 2

Pokaż 5 największych zamówień.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `status`
- `total_amount`
- `total_with_vat`

Kolumna `total_with_vat` ma być zaokrąglona do dwóch miejsc po przecinku.

## Zadanie 3

Pokaż zamówienia klientów z Polski.

Wynik powinien zawierać:

- `customer_name`
- `country`
- `order_id`
- `order_date`
- `total_amount`

Wynik posortuj od największej kwoty zamówienia.

## Zadanie 4

Policz liczbę zamówień per klient.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `orders_count`

Wynik posortuj od największej liczby zamówień.

## Zadanie 5

Policz sumę sprzedaży per kraj klienta.

Wynik powinien zawierać:

- `country`
- `total_revenue`

Wynik posortuj od największej sprzedaży.

## Zadanie 6

Policz średnią wartość zamówienia per status.

Wynik powinien zawierać:

- `status`
- `average_order_value`

Średnią zaokrąglij do dwóch miejsc po przecinku.

## Zadanie 7

Pokaż produkty, które zostały kupione więcej niż jeden raz łącznie.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `units_sold`

Użyj `GROUP BY` i `HAVING`.

## Zadanie 8

Pokaż wartość sprzedaży per produkt.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `sales_value`

Wartość sprzedaży policz jako:

```text
quantity * unit_price
```

Wynik posortuj od największej wartości sprzedaży.

## Zadanie 9

Pokaż zamówienia razem z nazwą klienta i kolumną `order_tier`.

Zasady dla `order_tier`:

- `high`, gdy `total_amount >= 150`,
- `standard`, gdy `total_amount < 150`.

Wynik powinien zawierać:

- `order_id`
- `customer_name`
- `total_amount`
- `order_tier`

## Zadanie 10

Pokaż klientów, którzy nie mają żadnego zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `country`

## Zadanie 11

Pokaż unikalne pary kraju klienta i statusu zamówienia.

Wynik powinien zawierać:

- `country`
- `status`

## Zadanie 12

Pokaż klientów, których nazwa zawiera literę `a` albo `A`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

## Zadanie 13

Pokaż klientów oraz liczbę ich zamówień, ale tylko tych klientów, którzy mają więcej niż jedno zamówienie.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `orders_count`

## Zadanie 14

Policz liczbę zamówień i sumę sprzedaży per dzień.

Wynik powinien zawierać:

- `order_date`
- `orders_count`
- `total_revenue`

Wynik posortuj po dacie rosnąco.

## Zadanie 15

Pokaż pozycje zamówień razem z nazwą produktu i nazwą klienta.

Wynik powinien zawierać:

- `order_id`
- `customer_name`
- `product_name`
- `quantity`
- `unit_price`
- `line_value`

Kolumna `line_value` ma liczyć:

```text
quantity * unit_price
```

## Zadanie 16

Pokaż klientów razem z etykietą `customer_segment`.

Zasady:

- `with_orders`, jeżeli klient ma przynajmniej jedno zamówienie,
- `without_orders`, jeżeli klient nie ma żadnego zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `customer_segment`

## Zadanie 17

Policz liczbę klientów per kanał pozyskania.

Wynik powinien zawierać:

- `acquisition_channel`
- `customers_count`

Wynik posortuj od największej liczby klientów.

## Zadanie 18

Pokaż kategorie produktów oraz łączną liczbę sprzedanych sztuk w każdej kategorii.

Wynik powinien zawierać:

- `category`
- `units_sold`

## Zadanie 19

Pokaż klientów, którzy mają email oraz złożyli zamówienie o wartości większej niż `150`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `email`
- `order_id`
- `total_amount`

## Zadanie 20

Zbuduj raport sprzedaży per klient.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `country`
- `orders_count`
- `total_revenue`
- `average_order_value`

Zaokrąglij `average_order_value` do dwóch miejsc po przecinku.

Wynik posortuj od największej wartości `total_revenue`.

