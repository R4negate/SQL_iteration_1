# Zadania 07 - joiny

## Uwaga

Przed wykonaniem tych zadań baza powinna mieć już uruchomione standardowe skrypty:

```text
SQL_iteration_1\zadania\DDL\00_create_schema.sql
SQL_iteration_1\zadania\DDL\01_create_tables.sql
SQL_iteration_1\zadania\DDL\02_insert_seed_data.sql
```

Następnie uruchom skrypt przygotowujący dane do joinów:

```text
SQL_iteration_1\zadania\DDL\04_prepare_join_demo_records.sql
```

Zadania korzystają z tych samych tabel:

- `course.customers`
- `course.orders`
- `course.products`
- `course.order_items`

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

Połącz `course.customers` z `course.orders` za pomocą `INNER JOIN`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 4

Połącz `course.customers` z `course.orders` za pomocą `LEFT JOIN`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 5

Porównaj wynik zadania 3 i zadania 4.

Zapisz jednym zdaniem, dlaczego `LEFT JOIN` może zwrócić więcej wierszy niż `INNER JOIN`.

## Zadanie 6

Użyj `RIGHT JOIN`, żeby pokazać wszystkich klientów i ich zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 7

Użyj `FULL OUTER JOIN`, żeby połączyć klientów i zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 8

Użyj `CROSS JOIN`, żeby pokazać wszystkie możliwe kombinacje klientów i produktów.

Wynik powinien zawierać:

- `customer_name`
- `product_name`

## Zadanie 9

Użyj `SELF JOIN`, żeby pokazać pary klientów z tego samego kraju.

Wynik powinien zawierać:

- `customer_1`
- `customer_2`
- `country`

Klient nie powinien być połączony sam ze sobą.

## Zadanie 10

Połącz cztery tabele:

- `course.customers`
- `course.orders`
- `course.order_items`
- `course.products`

Wynik powinien zawierać:

- `customer_name`
- `order_id`
- `product_name`
- `quantity`
- `unit_price`

## Zadanie 11

Pokaż zamówienia razem z nazwą klienta, ale tylko dla zamówień o statusie `paid`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `customer_name`
- `status`
- `total_amount`

## Zadanie 12

Pokaż klientów z Polski (`PL`) oraz ich zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `country`
- `order_id`
- `total_amount`

## Zadanie 13

Pokaż wszystkich klientów oraz ich zamówienia.

Wynik posortuj:

1. po `customer_name` rosnąco,
2. po `order_date` malejąco.

Wynik powinien zawierać:

- `customer_name`
- `order_id`
- `order_date`
- `total_amount`

## Zadanie 14

Znajdź klientów bez zamówień.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `country`

## Zadanie 15

Znajdź produkty, które nie zostały kupione.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `category`

## Zadanie 16

Pokaż unikalne kraje klientów, którzy mają przynajmniej jedno zamówienie.

Wynik powinien zawierać jedną kolumnę:

- `country`

## Zadanie 17

Policz liczbę zamówień dla każdego klienta.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `orders_count`

Klienci bez zamówień też powinni pojawić się w wyniku.

## Zadanie 18

Policz sumę sprzedaży dla każdego klienta.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `total_revenue`

Klienci bez zamówień też powinni pojawić się w wyniku.

## Zadanie 19

Policz liczbę sprzedanych sztuk dla każdego produktu.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `units_sold`

Produkty bez sprzedaży też powinny pojawić się w wyniku.

## Zadanie 20

Pokaż tylko tych klientów, którzy mają więcej niż jedno zamówienie.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `orders_count`

## Zadanie 21

Pokaż produkty, które sprzedały się łącznie w liczbie większej niż `1`.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `units_sold`

## Zadanie 22

Pokaż zamówienia z wyliczoną wartością pozycji zamówienia:

```text
quantity * unit_price
```

Wynik powinien zawierać:

- `order_id`
- `product_name`
- `quantity`
- `unit_price`
- `line_value`

## Zadanie 23

Pokaż zamówienia razem z klientem i dodaj kolumnę `order_tier`.

Zasady:

- jeśli `total_amount >= 150`, pokaż `high`,
- w innym przypadku pokaż `standard`.

Wynik powinien zawierać:

- `order_id`
- `customer_name`
- `total_amount`
- `order_tier`

## Zadanie 24

Pokaż klientów oraz ich zamówienia, ale jeśli klient nie ma zamówienia, w kolumnie `order_status` pokaż:

```text
no order
```

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `order_status`

## Zadanie 25

Pokaż sprzedaż per kraj klienta.

Wynik powinien zawierać:

- `country`
- `orders_count`
- `total_revenue`

Wynik posortuj od największej wartości `total_revenue`.

## Zadanie 26

Pokaż sprzedaż per kategoria produktu.

Wynik powinien zawierać:

- `category`
- `units_sold`
- `total_revenue`

Wynik posortuj od największej wartości `total_revenue`.

## Zadanie 27

Pokaż klientów, którzy kupili przynajmniej jeden produkt z kategorii `course`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

Klient powinien pojawić się tylko raz.

## Zadanie 28

Pokaż zamówienia, w których znajduje się produkt z nazwą zawierającą słowo:

```text
Course
```

Wynik powinien zawierać:

- `order_id`
- `customer_name`
- `product_name`

## Zadanie 29

Pokaż klientów, którzy mają zamówienia, ale nie pokazuj szczegółów zamówień.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

Klient powinien pojawić się tylko raz.

## Zadanie 30

Pokaż raport kontrolny z dwoma typami problemów:

- klienci bez zamówień,
- produkty bez sprzedaży.

Wynik powinien zawierać:

- `issue_type`
- `object_id`
- `object_name`

Przykładowe wartości `issue_type`:

- `customer_without_order`
- `product_without_sale`

## Zadanie 31

Pokaż wszystkich klientów razem z liczbą ich zamówień.

Klienci bez zamówień też mają się pojawić.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `orders_count`

Wynik posortuj od największej liczby zamówień, a przy remisie po `customer_id` rosnąco.

## Zadanie 32

Pokaż wszystkie produkty razem z łączną liczbą sprzedanych sztuk.

Produkty bez sprzedaży też mają się pojawić. Dla nich pokaż `0`.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `units_sold`

Wynik posortuj od największej liczby sprzedanych sztuk, a przy remisie po `product_id` rosnąco.

## Zadanie 33

Pokaż sprzedaż per kanał pozyskania klienta.

Wynik powinien zawierać:

- `acquisition_channel`
- `orders_count`
- `total_revenue`

Wynik posortuj od największej wartości `total_revenue`.

## Zadanie 34

Pokaż unikalne pary klient-produkt dla opłaconych zamówień.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `product_name`

Klient i produkt powinny pojawić się tylko raz dla danej pary.

Wynik posortuj po `customer_id`, a potem po `product_name`.

## Zadanie 35

Znajdź klientów, którzy kupili produkty z co najmniej dwóch różnych kategorii.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `categories_count`

Wynik posortuj po `customer_id`.

## Zadanie 36

Pokaż kontrolę wartości zamówień: porównaj `total_amount` z sumą pozycji zamówienia.

Wynik powinien zawierać:

- `order_id`
- `total_amount`
- `items_value`
- `difference`

Kolumna `difference` ma oznaczać:

```text
total_amount - items_value
```

Wynik posortuj po `order_id`.
