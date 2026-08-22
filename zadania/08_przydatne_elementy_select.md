# Zadania 08 - przydatne elementy w SELECT

## Zadanie 1

Pokaż unikalne kraje klientów.

## Zadanie 2

Pokaż unikalne statusy zamówień.

## Zadanie 3

Pokaż unikalne kategorie produktów.

## Zadanie 4

Pokaż unikalne pary:

- `country`
- `acquisition_channel`

z tabeli `course.customers`.

## Zadanie 5

Pokaż nazwy klientów zapisane wielkimi literami.

Wynik powinien zawierać:

- `customer_name`
- `customer_name_upper`

## Zadanie 6

Pokaż emaile klientów zapisane małymi literami.

Wynik powinien zawierać:

- `email`
- `email_lower`

## Zadanie 7

Pokaż długość nazwy każdego klienta.

Wynik powinien zawierać:

- `customer_name`
- `name_length`

## Zadanie 8

Stwórz kolumnę `customer_label` w formacie:

```text
customer_name - country
```

## Zadanie 9

Pokaż zamówienia z kwotą powiększoną o VAT.

Wynik powinien zawierać:

- `order_id`
- `total_amount`
- `total_with_vat`

Kolumna `total_with_vat` ma liczyć:

```text
total_amount * 1.23
```

Wynik zaokrąglij do dwóch miejsc po przecinku.

## Zadanie 10

Policz średnią wartość zamówienia i zaokrąglij wynik do dwóch miejsc po przecinku.

Nazwa kolumny w wyniku:

```text
average_order_value
```

## Zadanie 11

Pokaż klientów z kolumną `email`, ale jeżeli email jest `NULL`, pokaż tekst:

```text
missing email
```

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `email`

## Zadanie 12

Dodaj do zamówień kolumnę `order_tier`.

Zasady:

- jeśli `total_amount >= 150`, wartość ma być `high`,
- w innym przypadku wartość ma być `standard`.

Wynik powinien zawierać:

- `order_id`
- `total_amount`
- `order_tier`

## Zadanie 13

Policz wartość pozycji zamówienia jako:

```text
quantity * unit_price
```

Wynik powinien zawierać:

- `order_item_id`
- `quantity`
- `unit_price`
- `line_value`

## Zadanie 14

Pokaż `total_amount` jako liczbę całkowitą.

Wynik powinien zawierać:

- `order_id`
- `total_amount_as_int`

## Zadanie 15

Napisz jedno zapytanie, które pokaże:

- `customer_id`
- `customer_name`
- `country` zapisane wielkimi literami jako `country_upper`
- email z wartością zastępczą `missing email`, jeśli email jest `NULL`

## Zadanie 16

Użyj `RIGHT JOIN`, żeby pokazać wszystkich klientów i ich zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 17

Użyj `FULL OUTER JOIN`, żeby połączyć klientów i zamówienia.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `order_id`
- `total_amount`

## Zadanie 18

Użyj `CROSS JOIN`, żeby pokazać wszystkie kombinacje klientów i produktów.

Wynik powinien zawierać:

- `customer_name`
- `product_name`

## Zadanie 19

Użyj `SELF JOIN`, żeby pokazać pary klientów z tego samego kraju.

Wynik powinien zawierać:

- `customer_1`
- `customer_2`
- `country`

## Zadanie 20

Użyj wzorca anti join, żeby znaleźć klientów bez zamówień.

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
