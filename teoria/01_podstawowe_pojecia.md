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

W aplikacjach SQL często kojarzy się z prostym CRUD:

- dodaj rekord,
- odczytaj rekord,
- zmień rekord,
- usuń rekord.

W data engineeringu SQL jest czymś większym. Służy do:

- łączenia danych z wielu tabel,
- czyszczenia i standaryzowania rekordów,
- liczenia metryk biznesowych,
- budowania tabel pod raporty i dashboardy,
- przygotowywania danych dla kolejnych etapów pipeline'u.

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

## Baza, schemat i tabela razem

W PostgreSQL można myśleć o trzech poziomach:

```text
baza danych -> schemat -> tabela
```

Przykład:

```text
moja_baza -> course -> customers
```

Czyli pełna nazwa tabeli to:

```sql
course.customers
```

To jest ważne, bo w prawdziwych projektach jedna baza może zawierać wiele
schematów, np.:

- `raw` albo `bronze` - dane surowe,
- `silver` - dane oczyszczone,
- `gold` - dane gotowe do raportowania.

Na razie pracujemy na jednym schemacie `course`, ale sposób myślenia jest taki
sam: schemat pomaga uporządkować tabele według ich roli.

## Co oznacza jeden wiersz

Każda tabela ma swój sens biznesowy.

Przykłady:

- jeden wiersz w `course.customers` oznacza jednego klienta,
- jeden wiersz w `course.products` oznacza jeden produkt,
- jeden wiersz w `course.orders` oznacza jedno zamówienie,
- jeden wiersz w `course.order_items` oznacza jedną pozycję zamówienia.

To pytanie będzie wracało bardzo często:

> Co oznacza jeden wiersz w tej tabeli?

W data engineeringu nazywa się to czasem `grain`, czyli poziom szczegółowości
danych. Jeżeli nie rozumiemy, co oznacza jeden wiersz, łatwo policzyć błędne
sumy, średnie albo liczby rekordów.

## Najważniejsze rzeczy do zapamiętania

- SQL służy do pracy z danymi w bazie.
- `SELECT` odczytuje dane i nie zmienia tabel.
- Baza danych zawiera schematy.
- Schemat zawiera tabele.
- Tabela zawiera wiersze i kolumny.
- Jeden wiersz powinien mieć jasne znaczenie biznesowe.
