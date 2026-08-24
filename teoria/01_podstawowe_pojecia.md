# Podstawowe pojęcia

## Dane

Dane to zapisane informacje.

Przykłady danych:

- imię klienta,
- data zamówienia,
- kwota płatności,
- kraj użytkownika,
- status zamówienia.

Na kursie będziemy pracować głównie na danych biznesowych, np. klientach,
zamówieniach i produktach.

## Baza danych

Baza danych to uporządkowane miejsce do przechowywania danych.

Prosta analogia:

- baza danych jest jak segregator,
- tabela jest jak arkusz w segregatorze,
- kolumna jest jak typ informacji,
- wiersz jest jak jeden konkretny rekord.

## Tabela

Tabela przechowuje dane jednego rodzaju.

Przykłady tabel:

- `customers` - klienci,
- `orders` - zamówienia,
- `products` - produkty,
- `payments` - płatności.

Tabela wygląda podobnie do arkusza kalkulacyjnego, ale jest bardziej
uporządkowana. Kolumny mają nazwy, typy danych i znaczenie.

## Kolumna

Kolumna mówi, jakiego typu informację przechowujemy.

Przykład tabeli `customers`:

```sql
customer_id
customer_name
email
country
```

Kolumna `country` przechowuje kraj klienta.

## Wiersz

Wiersz to jeden konkretny rekord.

W tabeli `customers` jeden wiersz oznacza jednego klienta.

W tabeli `orders` jeden wiersz oznacza jedno zamówienie.

To jest ważne, bo w SQL często musimy rozumieć, co oznacza jeden rekord w tabeli.
Później będziemy nazywać to słowem `grain`.

## SQL

SQL to język zadawania pytań do bazy danych.

Przykład pytania biznesowego:

> Pokaż klientów z Polski.

Przykład SQL:

```sql
SELECT customer_id, customer_name, country
FROM course.customers
WHERE country = 'PL';
```

## Jak czytać takie zapytanie od zera

Na początku nie próbuj zapamiętywać wszystkiego naraz. Czytaj zapytanie jak
krótką instrukcję:

```sql
SELECT customer_id, customer_name, country
FROM course.customers
WHERE country = 'PL';
```

Znaczenie:

- `customers` to tabela, czyli miejsce, z którego bierzemy dane,
- `customer_id`, `customer_name`, `country` to kolumny, które chcemy zobaczyć,
- `'PL'` to zwykła wartość tekstowa,
- `WHERE country = 'PL'` oznacza: zostaw tylko wiersze klientów z Polski.

Wynik zapytania też jest tabelą: ma kolumny i wiersze. Różnica jest taka, że
ta tabela wyniku nie musi istnieć na stałe w bazie. Jest tworzona na potrzeby
jednego zapytania.

## Schemat

W PostgreSQL tabela może być zapisana razem ze schematem, np.:

```sql
course.customers
```

Tutaj:

- `course` to schemat,
- `customers` to tabela.

Schemat działa trochę jak folder na tabele. W kursie używamy schematu
`course`, żeby oddzielić dane kursowe od innych obiektów w bazie.
