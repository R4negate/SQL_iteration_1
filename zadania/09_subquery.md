# Zadania 09 - subquery

## Zadanie 1

Pokaż zamówienia większe niż średnia wartość zamówienia.

Wynik powinien zawierać:

- `order_id`
- `total_amount`

## Zadanie 2

Pokaż klientów, którzy mają zamówienia.

Użyj subquery z `IN`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

## Zadanie 3

Pokaż klientów bez zamówień.

Użyj subquery z `NOT IN`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

## Zadanie 4

Pokaż produkty, które występują w tabeli `course.order_items`.

Użyj subquery z `IN`.

Wynik powinien zawierać:

- `product_id`
- `product_name`

## Zadanie 5

Pokaż zamówienia, których wartość jest większa niż największa wartość zamówienia o statusie `cancelled`.

Wynik powinien zawierać:

- `order_id`
- `status`
- `total_amount`

## Zadanie 6

Użyj subquery w `FROM`, żeby najpierw policzyć sprzedaż per klient.

Następnie z tego wyniku pokaż tylko klientów, których sprzedaż jest większa niż `200`.

Wynik powinien zawierać:

- `customer_id`
- `total_revenue`

## Zadanie 7

Użyj subquery w `SELECT`, żeby pokazać przy każdym zamówieniu średnią wartość wszystkich zamówień.

Wynik powinien zawierać:

- `order_id`
- `total_amount`
- `average_order_value`

## Zadanie 8

Pokaż klientów, którzy mają przynajmniej jedno zamówienie.

Użyj `EXISTS`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

## Zadanie 9

Pokaż klientów bez zamówień.

Użyj `NOT EXISTS`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

## Zadanie 10

Pokaż statusy zamówień, dla których suma sprzedaży jest większa niż średnia wartość zamówienia ze wszystkich zamówień.

Wynik powinien zawierać:

- `status`
- `total_revenue`

## Zadanie 11

Pokaż zamówienia o najwyższej wartości `total_amount`.

Użyj subquery, które znajdzie największą wartość zamówienia.

Wynik powinien zawierać:

- `order_id`
- `customer_id`
- `total_amount`

Wynik posortuj po `order_id`.

## Zadanie 12

Pokaż produkty, których cena jest większa niż średnia cena w ich kategorii.

Użyj subquery skorelowanego.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `category`
- `base_price`
- `category_avg_price`

Wynik posortuj po `category`, a potem po `base_price` malejąco.

## Zadanie 13

Pokaż klientów, którzy mają przynajmniej jedno opłacone zamówienie.

Użyj `EXISTS`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

Wynik posortuj po `customer_id`.

## Zadanie 14

Pokaż klientów, którzy mają zamówienia, ale nie mają żadnego anulowanego zamówienia.

Użyj `EXISTS` oraz `NOT EXISTS`.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`

Wynik posortuj po `customer_id`.

## Zadanie 15

Pokaż produkty, które nigdy nie zostały sprzedane.

Użyj `NOT EXISTS`.

Wynik powinien zawierać:

- `product_id`
- `product_name`

Wynik posortuj po `product_id`.
