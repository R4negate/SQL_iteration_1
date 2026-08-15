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
FROM customers
WHERE country = 'PL';
```
