# Sortowanie, NULL i filtry

## ORDER BY

`ORDER BY` sortuje wynik zapytania.

```sql
SELECT order_id, total_amount
FROM course.orders
ORDER BY total_amount;
```

Domyślnie sortowanie jest rosnące.

## ASC i DESC

`ASC` oznacza rosnąco.

```sql
ORDER BY total_amount ASC
```

`DESC` oznacza malejąco.

```sql
ORDER BY total_amount DESC
```

Przykład:

```sql
SELECT order_id, total_amount
FROM course.orders
ORDER BY total_amount DESC
LIMIT 10;
```

To zapytanie pokazuje 10 największych zamówień.

## IN

`IN` sprawdza, czy wartość znajduje się na liście.

```sql
SELECT customer_id, customer_name, country
FROM course.customers
WHERE country IN ('PL', 'DE', 'CZ');
```

To jest czytelniejsze niż kilka warunków `OR`.

## BETWEEN

`BETWEEN` sprawdza zakres.

```sql
SELECT order_id, total_amount
FROM course.orders
WHERE total_amount BETWEEN 50 AND 200;
```

Ważne: `BETWEEN` obejmuje granice zakresu.

To znaczy, że `BETWEEN 50 AND 200` zawiera również 50 i 200.

## LIKE

`LIKE` służy do prostego szukania wzorców w tekście.

```sql
SELECT customer_id, email
FROM course.customers
WHERE email LIKE '%gmail%';
```

`%` oznacza dowolny fragment tekstu.

Przykłady:

```sql
LIKE 'A%'      -- zaczyna się od A
LIKE '%gmail%' -- zawiera gmail
LIKE '%.com'   -- kończy się na .com
```

## NULL

`NULL` oznacza brak wartości.

To nie jest:

- zero,
- pusty tekst,
- słowo `null`,
- fałsz.

`NULL` oznacza, że wartość jest nieznana albo nie została podana.

## IS NULL

Do sprawdzania `NULL` używamy `IS NULL`.

```sql
SELECT customer_id, customer_name, email
FROM course.customers
WHERE email IS NULL;
```

## IS NOT NULL

```sql
SELECT customer_id, customer_name, email
FROM course.customers
WHERE email IS NOT NULL;
```

To zapytanie pokazuje rekordy, które mają email.

## ORDER BY po filtrowaniu

W praktyce często łączysz filtr i sortowanie:

```sql
SELECT order_id, status, total_amount
FROM course.orders
WHERE status = 'paid'
ORDER BY total_amount DESC;
```

Najpierw zostają tylko zamówienia opłacone, a dopiero potem wynik jest
sortowany od największej kwoty.

## BETWEEN obejmuje granice

```sql
WHERE total_amount BETWEEN 100 AND 200
```

oznacza:

```sql
WHERE total_amount >= 100
  AND total_amount <= 200
```

Czyli wartości `100` i `200` też pasują.

## LIKE i symbole wieloznaczne

W `LIKE` najczęściej użyjesz dwóch znaków:

- `%` oznacza dowolny ciąg znaków, także pusty,
- `_` oznacza dokładnie jeden dowolny znak.

Przykład:

```sql
WHERE product_name LIKE '%Course%'
```

pasuje do nazw, które mają słowo `Course` gdziekolwiek w środku.

## NULL nie jest zwykłą wartością

`NULL` oznacza brak wartości, więc nie porównujemy go tak:

```sql
WHERE email = NULL
```

Poprawnie:

```sql
WHERE email IS NULL
```

albo:

```sql
WHERE email IS NOT NULL
```
