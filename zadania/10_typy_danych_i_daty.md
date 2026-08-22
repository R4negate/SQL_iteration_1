# Zadania 10 - typy danych i praca z datami

## Zadanie 1

Sprawdź typy kolumn w tabelach ze schematu `course`.

Wynik powinien zawierać:

- `table_name`
- `column_name`
- `data_type`

## Zadanie 2

Pokaż `total_amount` jako liczbę całkowitą.

Wynik powinien zawierać:

- `order_id`
- `total_as_int`

## Zadanie 3

Pokaż zamówienia od dnia `2026-05-10`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `total_amount`

## Zadanie 4

Pokaż zamówienia między `2026-05-01` i `2026-05-10`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `total_amount`

## Zadanie 5

Pokaż rok, miesiąc i dzień z kolumny `order_date`.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `order_year`
- `order_month`
- `order_day`

## Zadanie 6

Policz sprzedaż per miesiąc używając `DATE_TRUNC`.

Wynik powinien zawierać:

- `sales_month`
- `total_revenue`

## Zadanie 7

Policz liczbę rejestracji klientów per miesiąc.

Użyj kolumny `signup_date`.

Wynik powinien zawierać:

- `signup_month`
- `customers_count`

## Zadanie 8

Pokaż dzisiejszą datę i aktualny timestamp.

Wynik powinien zawierać:

- `today`
- `now`

## Zadanie 9

Pokaż datę sprzed 7 dni używając `INTERVAL`.

Nazwa kolumny w wyniku:

```text
seven_days_ago
```

## Zadanie 10

Pokaż `order_date` jako tekst w formacie:

```text
YYYY-MM
```

Wynik powinien zawierać:

- `order_id`
- `order_month`

## Zadanie 11

Pokaż zamówienia z kolumną `order_age_days`, która liczy liczbę dni od daty zamówienia do dzisiaj.

Wynik powinien zawierać:

- `order_id`
- `order_date`
- `order_age_days`

## Zadanie 12

Policz sprzedaż per dzień tygodnia na podstawie `order_date`.

Wynik powinien zawierać:

- `day_of_week`
- `total_revenue`

