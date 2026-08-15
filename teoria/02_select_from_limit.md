# SELECT, FROM i LIMIT

## Do czego służy SELECT

`SELECT` służy do czytania danych z bazy.

`SELECT` nie zmienia danych.

## Podstawowy schemat zapytania

```sql
SELECT kolumna_1, kolumna_2
FROM nazwa_tabeli;
```

Znaczenie:

- `SELECT` - jakie kolumny chcemy zobaczyć,
- `FROM` - z której tabeli bierzemy dane.

## Pierwsze zapytanie

```sql
SELECT *
FROM customers;
```

`*` oznacza: pokaż wszystkie kolumny.

To jest wygodne do pierwszego podglądu tabeli, ale w realnej pracy często
wybieramy tylko konkretne kolumny.

## LIMIT

`LIMIT` ogranicza liczbę wierszy w wyniku.

```sql
SELECT *
FROM customers
LIMIT 10;
```

To zapytanie pokazuje maksymalnie 10 wierszy z tabeli `customers`.

## Dlaczego LIMIT jest ważny

W prawdziwych bazach tabele mogą mieć tysiące, miliony albo miliardy rekordów.

Na początku pracy z tabelą warto używać `LIMIT`, żeby:

- szybko podejrzeć strukturę danych,
- nie pobierać zbyt wielu rekordów,
- łatwiej sprawdzić, czy query działa.

## Jak tłumaczyć sobie kolejność zapytania

Człowiek pisze:

```sql
SELECT *
FROM customers;
```

Ale SQL zapytania wykonuje w innej kolejności:

1. Weź tabelę `customers`.
2. Pokaż wszystkie kolumny.