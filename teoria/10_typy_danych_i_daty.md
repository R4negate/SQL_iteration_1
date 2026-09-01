# Typy danych i praca z datami

## Po co ta lekcja

Kolumny w tabelach mają typy danych.

Typ danych mówi bazie, jakiego rodzaju wartość znajduje się w kolumnie.

To ważne, bo inaczej pracuje się z:

- liczbą,
- tekstem,
- datą,
- kwotą,
- wartością `NULL`.

## Dlaczego typy danych są ważne

Zobacz trzy wartości:

```text
'100'
100
100.00
```

Dla człowieka wyglądają podobnie.

Dla bazy danych to mogą być trzy różne typy:

- tekst,
- liczba całkowita,
- liczba z miejscami po przecinku.

## INT

`INT` przechowuje liczby całkowite.

Przykłady:

- `customer_id`
- `order_id`
- `quantity`

## BIGINT

`BIGINT` też przechowuje liczby całkowite, ale pozwala zapisać dużo większe
wartości niż `INT`.

W prostych ćwiczeniach zwykle wystarczy `INT`.

W prawdziwych systemach `BIGINT` często pojawia się przy:

- identyfikatorach zdarzeń,
- technicznych ID w dużych tabelach,
- licznikach w systemach o bardzo dużym ruchu.

Przykład:

```sql
event_id BIGINT
```

## VARCHAR

`VARCHAR` przechowuje tekst.

Przykłady:

- `customer_name`
- `email`
- `country`
- `status`

Tekst w SQL zapisujemy w apostrofach:

```sql
WHERE country = 'PL'
```

`VARCHAR(120)` oznacza tekst o maksymalnej długości 120 znaków.

Limit długości jest formą kontroli jakości danych. Jeżeli `country` ma mieć
krótki kod kraju, nie chcemy przypadkowo wstawić tam długiego opisu.

## TEXT

`TEXT` przechowuje dłuższy tekst bez konkretnego limitu długości.

Przykłady:

- opis produktu,
- komentarz,
- treść wiadomości.

W danych analitycznych często spotkasz i `VARCHAR`, i `TEXT`.

Prosta intuicja:

- `VARCHAR(n)` - tekst z limitem długości,
- `TEXT` - długi tekst bez ustalonego limitu.

## NUMERIC

`NUMERIC` przechowuje dokładne liczby z miejscami po przecinku.

Przykłady:

- `total_amount`
- `base_price`
- `unit_price`

Do kwot pieniężnych często używa się właśnie `NUMERIC`.

Przykład:

```sql
total_amount NUMERIC(10, 2)
```

Znaczenie:

- maksymalnie 10 cyfr łącznie,
- 2 cyfry po przecinku.

Do pieniędzy lepiej używać `NUMERIC`, a nie `FLOAT`.

`FLOAT` jest typem przybliżonym i może powodować drobne błędy zaokrągleń.
Dla pomiarów technicznych może być w porządku, ale dla kwot i raportów
finansowych chcemy dokładności.

## DATE

`DATE` przechowuje datę bez godziny.

Przykłady:

- `signup_date`
- `order_date`

Przykład wartości:

```text
2026-05-01
```

## TIMESTAMP

`TIMESTAMP` przechowuje datę i godzinę.

Przykład wartości:

```text
2026-05-01 14:30:00
```

W naszej bazie ćwiczeniowej mamy głównie `DATE`, ale w prawdziwych systemach `TIMESTAMP` jest bardzo częsty.

W PostgreSQL spotkasz też `TIMESTAMPTZ`, czyli timestamp z informacją o strefie
czasowej.

Uproszczona różnica:

- `TIMESTAMP` - data i godzina bez strefy czasowej,
- `TIMESTAMPTZ` - konkretny moment w czasie, zapisywany z uwzględnieniem strefy.

W pipeline'ach danych dobra praktyka jest taka:

- wewnątrz systemu zapisuj czas spójnie, najczęściej w UTC,
- na lokalny czas zamieniaj dopiero przy prezentacji użytkownikowi,
- nie mieszaj bezmyślnie dat lokalnych i timestampów z różnych stref.

To chroni przed cichymi błędami, np. przy zmianie czasu letniego i zimowego.

## BOOLEAN

`BOOLEAN` przechowuje prawdę albo fałsz.

Przykładowe wartości:

```text
true
false
```

## Sprawdzanie typów kolumn

Typy kolumn można sprawdzić w `information_schema.columns`.

```sql
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'course'
ORDER BY table_name, ordinal_position;
```

## CAST

`CAST` zmienia typ wartości w wyniku zapytania.

```sql
SELECT
    order_id,
    CAST(total_amount AS INT) AS total_as_int
FROM course.orders;
```

To nie zmienia danych w tabeli.

Zmienia tylko wynik zapytania.

## Filtrowanie po datach

Daty zapisujemy w apostrofach.

```sql
SELECT
    order_id,
    order_date,
    total_amount
FROM course.orders
WHERE order_date >= '2026-05-10';
```

## BETWEEN na datach

```sql
SELECT
    order_id,
    order_date,
    total_amount
FROM course.orders
WHERE order_date BETWEEN '2026-05-01' AND '2026-05-10';
```

`BETWEEN` obejmuje początek i koniec zakresu.

## CURRENT_DATE

`CURRENT_DATE` zwraca aktualną datę.

```sql
SELECT CURRENT_DATE AS today;
```

## CURRENT_TIMESTAMP

`CURRENT_TIMESTAMP` zwraca aktualną datę i godzinę.

```sql
SELECT CURRENT_TIMESTAMP AS now;
```

W PostgreSQL często używa się też:

```sql
SELECT NOW() AS now;
```

`NOW()` zwraca aktualny timestamp dla bieżącego zapytania.

## EXTRACT

`EXTRACT` wyciąga część daty.

```sql
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    EXTRACT(DAY FROM order_date) AS order_day
FROM course.orders;
```

## DATE_TRUNC

`DATE_TRUNC` ucina datę do wybranego poziomu.

Przykład: miesiąc sprzedaży.

```sql
SELECT
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(total_amount) AS total_revenue
FROM course.orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;
```

## INTERVAL

`INTERVAL` oznacza odstęp czasu.

```sql
SELECT CURRENT_DATE - INTERVAL '7 days' AS seven_days_ago;
```

`INTERVAL` można łączyć z datami i timestampami:

```sql
SELECT
    order_id,
    order_date,
    order_date + INTERVAL '30 days' AS order_date_plus_30_days
FROM course.orders;
```

To jest przydatne np. przy terminach płatności, terminach dostawy albo analizie
okien czasowych.

## TO_CHAR

`TO_CHAR` formatuje datę jako tekst.

```sql
SELECT
    order_id,
    TO_CHAR(order_date, 'YYYY-MM') AS order_month
FROM course.orders;
```

## DATE a TIMESTAMP

`DATE` przechowuje tylko datę, np. `2026-05-10`.

`TIMESTAMP` przechowuje datę i godzinę, np. `2026-05-10 14:30:00`.

To ma znaczenie przy filtrowaniu. Dla kolumny typu `DATE` taki warunek jest
czytelny:

```sql
WHERE order_date = '2026-05-10'
```

Dla kolumny typu `TIMESTAMP` często lepiej filtrować zakresem:

```sql
WHERE created_at >= '2026-05-10'
  AND created_at < '2026-05-11'
```

Dzięki temu łapiesz cały dzień, a nie tylko dokładną północ.

## Konwersja strefy czasowej

Jeżeli pracujesz z timestampem reprezentującym konkretny moment, czasem trzeba
pokazać go w lokalnej strefie.

Przykład:

```sql
SELECT
    TIMESTAMPTZ '2026-07-03 12:00:00+00'
        AT TIME ZONE 'Europe/Warsaw' AS warsaw_time;
```

Wynik pokaże ten sam moment przeliczony na czas warszawski.

Na tym etapie nie musisz znać wszystkich szczegółów stref czasowych. Ważne jest
jedno: daty i godziny w systemach produkcyjnych wymagają dyscypliny, bo błędy
czasowe są trudne do zauważenia.

## Dodawanie i odejmowanie dat

Daty można porównywać i odejmować.

```sql
SELECT
    customer_id,
    signup_date,
    signup_date + INTERVAL '7 days' AS week_after_signup
FROM course.customers;
```

Możesz też policzyć różnicę między dwiema datami:

```sql
SELECT DATE '2026-05-10' - DATE '2026-05-01' AS days_between;
```

Wynikiem będzie liczba dni.

## Najważniejsze rzeczy do zapamiętania

- Każda kolumna ma typ danych.
- `INT` to liczby całkowite.
- `BIGINT` to bardzo duże liczby całkowite.
- `VARCHAR` to tekst.
- `TEXT` to długi tekst bez stałego limitu.
- `NUMERIC` jest dobry do kwot.
- `FLOAT` jest przybliżony, więc nie jest dobrym wyborem dla pieniędzy.
- `DATE` to data bez godziny.
- `TIMESTAMP` to data z godziną.
- `TIMESTAMPTZ` reprezentuje moment w czasie z uwzględnieniem strefy.
- `CAST` zmienia typ w wyniku zapytania.
- `EXTRACT` wyciąga część daty.
- `DATE_TRUNC` pomaga grupować dane po czasie.
- `INTERVAL` oznacza odstęp czasu.
- W pipeline'ach trzymaj czas spójnie, najlepiej w UTC.
- Przy `TIMESTAMP` filtrowanie całego dnia zwykle rób zakresem od początku dnia
  do początku następnego dnia.
