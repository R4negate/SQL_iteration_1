# Zadania 07 - podstawowe joiny

## Zadanie 1

Polacz `course.orders` z `course.customers`.

Wynik powinien zawierac:

- `order_id`
- `order_date`
- `total_amount`
- `customer_name`
- `country`

## Zadanie 2

Polacz `course.order_items` z `course.products`.

Wynik powinien zawierac:

- `order_item_id`
- `order_id`
- `product_name`
- `category`
- `quantity`
- `unit_price`

## Zadanie 3

Polacz `course.orders`, `course.order_items` i `course.products`.

Wynik powinien zawierac:

- `order_id`
- `order_date`
- `product_name`
- `quantity`
- `unit_price`

## Zadanie 4

Polacz `course.customers` z `course.orders` za pomoca `INNER JOIN`.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 5

Polacz `course.customers` z `course.orders` za pomoca `LEFT JOIN`.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 6

Porownaj liczbe wierszy z zadania 4 i zadania 5.

Zapisz jednym zdaniem, z czego moze wynikac roznica.

## Zadanie 7

Pokaz zamowienia razem z nazwa klienta, ale tylko dla zamowien o statusie `paid`.

## Zadanie 8

Pokaz pozycje zamowien razem z nazwa produktu, ale tylko dla produktow z kategorii `course`.

## Zadanie 9

Policz liczbe zamowien per klient.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- liczbe zamowien

## Zadanie 10

Policz sume sprzedazy per klient.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- sume `total_amount`

## Zadanie 11

Policz liczbe sprzedanych sztuk per produkt.

Wynik powinien zawierac:

- `product_id`
- `product_name`
- sume `quantity`

## Zadanie 12

Pokaz klientow, ktorzy nie maja zadnego zamowienia.

Uzyj `LEFT JOIN` oraz warunku sprawdzajacego `NULL` po stronie zamowien.

