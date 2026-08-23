# Zadania 07 - joiny

## Zadanie 1

Połącz `course.orders` z `course.customers`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `total_amount`
- `customer_name`
- `country`

## Zadanie 2

Połącz `course.order_items` z `course.products`.

Wynik powinien zawierać:

- `order_item_id`
- `order_id`
- `product_name`
- `category`
- `quantity`
- `unit_price`

## Zadanie 3

Połącz `course.orders`, `course.order_items` i `course.products`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `product_name`
- `quantity`
- `unit_price`

## Zadanie 4

Połącz `course.customers` z `course.orders` za pomocą `INNER JOIN`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 5

Połącz `course.customers` z `course.orders` za pomocą `LEFT JOIN`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 6

Porównaj liczbę wierszy z zadania 4 i zadania 5.

Zapisz jednym zdaniem, z czego może wynikać różnica.

## Zadanie 7

Użyj `RIGHT JOIN`, żeby pokazać wszystkich klientów i ich zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 8

Użyj `FULL OUTER JOIN`, żeby połączyć klientów i zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 9

Użyj `CROSS JOIN`, żeby pokazać wszystkie kombinacje klientów i produktów.

Wynik powinien zawierać:

- `customer_name`
- `product_name`

## Zadanie 10

Użyj `SELF JOIN`, żeby pokazać pary klientów z tego samego kraju.

Wynik powinien zawierać:

- `customer_1`
- `customer_2`
- `country`

## Zadanie 11

Użyj wzorca anti join, żeby znaleźć klientów bez zamówień.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

## Zadanie 12

Użyj wzorca semi join, żeby znaleźć klientów, którzy mają przynajmniej jedno zamówienie.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

Klient powinien pojawić się tylko raz, nawet jeśli ma wiele zamówień.

## Zadanie 13

Pokaż zamówienia razem z nazwą klienta, ale tylko dla zamówień o statusie `paid`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `customer_name`
- `total_amount`

## Zadanie 14

Pokaż pozycje zamówień razem z nazwą produktu, ale tylko dla produktów z kategorii `course`.

Wynik powinien zawierać:

- `order_id`
- `product_name`
- `category`
- `quantity`

## Zadanie 15

Policz liczbę zamówień per klient.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `orders_count`

## Zadanie 16

Policz sumę sprzedaży per klient.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `total_revenue`

## Zadanie 17

Policz liczbę sprzedanych sztuk per produkt.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `units_sold`

## Zadanie 18

Pokaż przykład joinu wielu tabel: klient, zamówienie, pozycja zamówienia, produkt.

Wynik powinien zawierać:

- `customer_name`
- `order_id`
- `product_name`
- `quantity`
- `unit_price`

## Zadanie 19

Pokaż produkty, które nie zostały kupione.

Wynik powinien zawierać:

- `product_id`
- `product_name`

## Zadanie 20

Pokaż klientów, którzy kupili przynajmniej jeden produkt z kategorii `course`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

Klient powinien pojawić się tylko raz.

