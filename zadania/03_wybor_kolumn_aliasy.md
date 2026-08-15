# Zadania 03 - wybor kolumn i aliasy

## Zadanie 1

Z tabeli `course.customers` wyswietl tylko kolumny:

- `customer_id`
- `customer_name`
- `country`

## Zadanie 2

Z tabeli `course.products` wyswietl tylko kolumny:

- `product_id`
- `product_name`
- `base_price`

## Zadanie 3

Z tabeli `course.orders` wyswietl tylko kolumny:

- `order_id`
- `order_date`
- `total_amount`

## Zadanie 4

Z tabeli `course.customers` wyswietl `customer_name` pod aliasem `name`.

## Zadanie 5

Z tabeli `course.orders` wyswietl `total_amount` pod aliasem `order_total`.

## Zadanie 6

Z tabeli `course.products` wyswietl:

- `product_name` jako `name`
- `base_price` jako `price`

## Zadanie 7

Z tabeli `course.orders` wyswietl:

- `order_id`
- `total_amount`
- nowa kolumne `total_with_vat`, ktora liczy `total_amount * 1.23`

## Zadanie 8

Z tabeli `course.order_items` wyswietl:

- `order_item_id`
- `quantity`
- `unit_price`
- nowa kolumne `line_value`, ktora liczy `quantity * unit_price`

## Zadanie 9

Napisz zapytanie, ktore pokazuje tylko 3 kolumny z tabeli `course.customers`.

Nie uzywaj `SELECT *`.

## Zadanie 10

Odpowiedz jednym zdaniem: czy alias zmienia nazwe kolumny w tabeli, czy tylko nazwe w wyniku zapytania?

