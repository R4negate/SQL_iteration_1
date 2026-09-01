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

## TRIM

`TRIM` usuwa białe znaki z początku i końca tekstu.

Przykład:

```sql
SELECT
    customer_name,
    TRIM(customer_name) AS customer_name_clean
FROM course.customers;
```

Białe znaki to np. spacje. W danych z prawdziwych systemów zdarzają się takie
wartości:

```text
' Anna Kowalska '
```

Dla człowieka to nadal Anna Kowalska, ale dla bazy tekst ze spacjami jest inną
wartością niż tekst bez spacji.

Dlatego w czyszczeniu danych często łączy się funkcje:

```sql
SELECT
    LOWER(TRIM(email)) AS email_clean
FROM course.customers;
```

To zapytanie najpierw usuwa spacje z początku i końca, a potem zamienia tekst na
małe litery.

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

## NULLIF

`NULLIF` zwraca `NULL`, jeżeli dwie wartości są sobie równe.

Przykład:

```sql
SELECT NULLIF('', '') AS empty_text_as_null;
```

Wynikiem będzie `NULL`.

W praktyce `NULLIF` bywa przydatny przy czyszczeniu danych, kiedy źródło zapisuje
brak wartości jako pusty tekst:

```sql
SELECT
    customer_id,
    NULLIF(email, '') AS email
FROM course.customers;
```

Znaczenie:

- jeśli `email` jest pustym tekstem, pokaż `NULL`,
- w innym przypadku pokaż normalny email.

`COALESCE` i `NULLIF` często występują razem:

```sql
SELECT
    customer_id,
    COALESCE(NULLIF(email, ''), 'missing email') AS email
FROM course.customers;
```

To zapytanie najpierw zamienia pusty tekst na `NULL`, a potem `NULL` na tekst
zastępczy.

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

Jeżeli masz kilka warunków, SQL sprawdza je od góry do dołu i bierze pierwszy
pasujący:

```sql
SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 200 THEN 'very high'
        WHEN total_amount >= 100 THEN 'medium'
        ELSE 'low'
    END AS order_tier
FROM course.orders;
```

Dla kwoty `250` wynikiem będzie `very high`, bo pierwszy warunek już pasuje.
SQL nie przechodzi wtedy do następnych warunków.

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

## DATE_TRUNC i EXTRACT w SELECT

Niektóre funkcje pomagają pracować z datami.

`DATE_TRUNC` ucina datę do wybranego poziomu, np. miesiąca:

```sql
SELECT
    order_id,
    order_date,
    DATE_TRUNC('month', order_date) AS order_month
FROM course.orders;
```

`EXTRACT` wyciąga konkretną część daty:

```sql
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month_number
FROM course.orders;
```

Te funkcje pojawią się też w lekcji o typach danych i datach, ale warto je
kojarzyć jako przydatne narzędzia w `SELECT`.

## Najważniejsze rzeczy do zapamiętania

- `DISTINCT` usuwa duplikaty z wyniku.
- `UPPER` zamienia tekst na wielkie litery.
- `LOWER` zamienia tekst na małe litery.
- `TRIM` usuwa spacje z początku i końca tekstu.
- `LENGTH` liczy długość tekstu.
- `||` łączy tekst w PostgreSQL.
- `ROUND` zaokrągla liczby.
- `COALESCE` pozwala zastąpić `NULL` inną wartością.
- `NULLIF` pozwala zamienić konkretną wartość na `NULL`.
- `CASE WHEN` tworzy kolumnę warunkową.
- `DATE_TRUNC` i `EXTRACT` pomagają pracować z datami.
- Funkcje w `SELECT` nie zmieniają danych w tabeli.

## Jak myśleć o funkcjach w SELECT

Funkcje w `SELECT` działają na wartościach z pojedynczego wiersza albo na
wyniku agregacji.

Przykład na pojedynczym wierszu:

```sql
SELECT UPPER(customer_name) AS customer_name_upper
FROM course.customers;
```

Przykład po agregacji:

```sql
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM course.orders;
```

W obu przypadkach dane w tabeli zostają bez zmian. Zmieniasz tylko sposób
pokazania danych w wyniku.
