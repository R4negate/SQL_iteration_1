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

Stwórz etykietę klienta w formacie:

```text
customer_id - customer_name
```

Wynik powinien zawierać:

- `customer_id`
- `customer_label`

Wynik posortuj po `customer_id`.

## Zadanie 17

Pokaż email klienta, a jeśli email jest `NULL`, pokaż tekst:

```text
brak emaila
```

Wynik powinien zawierać:

- `customer_id`
- `customer_name`
- `email_or_placeholder`

Wynik posortuj po `customer_id`.

## Zadanie 18

Dodaj do produktów kolumnę `price_bucket`.

Zasady:

- jeśli `base_price < 50`, pokaż `budget`,
- jeśli `base_price < 150`, pokaż `standard`,
- w innym przypadku pokaż `premium`.

Wynik powinien zawierać:

- `product_id`
- `product_name`
- `base_price`
- `price_bucket`

Wynik posortuj po `product_id`.

## Zadanie 19

Pokaż zamówienia z kwotą powiększoną o VAT 23%.

Kwotę z VAT zaokrąglij do dwóch miejsc po przecinku.

Wynik powinien zawierać:

- `order_id`
- `total_amount`
- `total_with_vat`

Wynik posortuj po `order_id`.

## Zadanie 20

Pokaż unikalne kanały pozyskania klientów wielkimi literami.

Wynik powinien zawierać jedną kolumnę:

- `channel`

Wynik posortuj po `channel`.
