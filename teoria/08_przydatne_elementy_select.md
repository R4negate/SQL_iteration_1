# Przydatne elementy w SELECT

## Po co ta lekcja

Do tej pory używaliśmy `SELECT` głównie do wybierania kolumn.

Teraz dodamy kilka narzędzi, które pomagają przygotować bardziej czytelny wynik zapytania.

Te elementy są bardzo często używane w analizie danych:

- usuwanie duplikatów z wyniku,
- zaokrąglanie liczb,
- praca z tekstem,
- zastępowanie brakujących wartości,
- tworzenie prostych kategorii.

## DISTINCT

`DISTINCT` usuwa duplikaty z wyniku zapytania.

Przykład:

```sql
SELECT DISTINCT country
FROM course.customers;
```

To zapytanie pokazuje listę krajów klientów, ale każdy kraj pojawi się tylko raz.

Bez `DISTINCT` kraj może pojawić się wiele razy, bo wielu klientów może być z tego samego kraju.

## DISTINCT na kilku kolumnach

`DISTINCT` działa na cały zestaw kolumn w `SELECT`.

```sql
SELECT DISTINCT country, acquisition_channel
FROM course.customers;
```

To zapytanie pokazuje unikalne pary:

- `country`,
- `acquisition_channel`.

To nie jest osobna lista unikalnych krajów i osobna lista unikalnych kanałów.

## UPPER

`UPPER` zamienia tekst na wielkie litery.

```sql
SELECT
    customer_name,
    UPPER(customer_name) AS customer_name_upper
FROM course.customers;
```

## LOWER

`LOWER` zamienia tekst na małe litery.

```sql
SELECT
    email,
    LOWER(email) AS email_lower
FROM course.customers;
```

## LENGTH

`LENGTH` liczy liczbę znaków w tekście.

```sql
SELECT
    customer_name,
    LENGTH(customer_name) AS name_length
FROM course.customers;
```

## Łączenie tekstu

W PostgreSQL tekst można łączyć operatorem `||`.

```sql
SELECT
    customer_name || ' - ' || country AS customer_label
FROM course.customers;
```

Przykładowy wynik:

```text
Anna Kowalska - PL
```

## ROUND

`ROUND` zaokrągla liczbę.

```sql
SELECT
    order_id,
    total_amount,
    ROUND(total_amount * 1.23, 2) AS total_with_vat
FROM course.orders;
```

`2` oznacza dwa miejsca po przecinku.

`ROUND` jest przydatny przy:

- kwotach,
- średnich,
- procentach,
- wynikach obliczeń.

## ROUND razem z AVG

Funkcje można ze sobą łączyć.

```sql
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM course.orders;
```

To zapytanie:

1. liczy średnią wartość zamówienia,
2. zaokrągla wynik do dwóch miejsc po przecinku.

## COALESCE

`COALESCE` zwraca pierwszą wartość, która nie jest `NULL`.

Przykład:

```sql
SELECT
    customer_id,
    customer_name,
    COALESCE(email, 'missing email') AS email
FROM course.customers;
```

Znaczenie:

- jeśli `email` istnieje, pokaż email,
- jeśli `email` jest `NULL`, pokaż tekst `missing email`.

`COALESCE` nie zmienia danych w tabeli. Zmienia tylko wynik zapytania.

## CASE WHEN

`CASE WHEN` pozwala stworzyć kolumnę zależną od warunku.

Przykład:

```sql
SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 150 THEN 'high'
        ELSE 'standard'
    END AS order_tier
FROM course.orders;
```

Znaczenie:

- jeśli `total_amount` jest większe lub równe `150`, pokaż `high`,
- w innym przypadku pokaż `standard`.

`CASE WHEN` działa podobnie do prostego `if / else`.

## Obliczenia w SELECT

W `SELECT` można wykonywać proste obliczenia.

```sql
SELECT
    order_item_id,
    quantity,
    unit_price,
    quantity * unit_price AS line_value
FROM course.order_items;
```

To zapytanie liczy wartość jednej pozycji zamówienia.

## CAST

`CAST` zmienia typ wartości w wyniku zapytania.

Przykład:

```sql
SELECT
    order_id,
    CAST(total_amount AS INT) AS total_amount_as_int
FROM course.orders;
```

To nie zmienia danych w tabeli.

Zmienia tylko sposób pokazania wartości w wyniku zapytania.

## Najważniejsze rzeczy do zapamiętania

- `DISTINCT` usuwa duplikaty z wyniku.
- `UPPER` zamienia tekst na wielkie litery.
- `LOWER` zamienia tekst na małe litery.
- `LENGTH` liczy długość tekstu.
- `||` łączy tekst w PostgreSQL.
- `ROUND` zaokrągla liczby.
- `COALESCE` pozwala zastąpić `NULL` inną wartością.
- `CASE WHEN` tworzy kolumnę warunkową.
- Funkcje w `SELECT` nie zmieniają danych w tabeli.

