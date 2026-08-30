# Zadania 12 - zadania podsumowujace

Te zadania sprawdzaja cala wiedze z pierwszej iteracji SQL.

Uzywaj tabel:

- `course.customers`
- `course.products`
- `course.orders`
- `course.order_items`

Kazde zadanie wymaga polaczenia kilku tematow naraz: `SELECT`, aliasow, filtrow, sortowania, agregacji, `GROUP BY`, `HAVING`, joinow, subquery, funkcji tekstowych, `CASE` i pracy z datami.

## Zadanie 1

Przygotuj raport klientow i ich aktywnosci zakupowej.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `country`
- `acquisition_channel`
- `orders_count`
- `paid_orders_count`
- `cancelled_orders_count`
- `total_revenue`
- `average_order_value`
- `first_order_date`
- `last_order_date`
- `customer_status`

Zasady:

- pokaz wszystkich klientow, rowniez tych bez zamowien,
- `orders_count` ma liczyc wszystkie zamowienia klienta,
- `paid_orders_count` ma liczyc tylko zamowienia ze statusem `paid`,
- `cancelled_orders_count` ma liczyc tylko zamowienia ze statusem `cancelled`,
- `total_revenue` ma sumowac `total_amount`,
- `average_order_value` ma byc zaokraglone do 2 miejsc po przecinku,
- `customer_status` ma miec wartosc:
  - `no_orders`, jesli klient nie ma zamowien,
  - `buyer`, jesli klient ma przynajmniej jedno zamowienie.

Wynik posortuj od najwiekszego `total_revenue` do najmniejszego.

## Zadanie 2

Przygotuj raport sprzedazy produktow.

Wynik powinien zawierac:

- `product_id`
- `product_name`
- `category`
- `base_price`
- `units_sold`
- `orders_count`
- `gross_revenue`
- `average_unit_price`
- `sale_status`

Zasady:

- pokaz wszystkie produkty, rowniez te, ktore nigdy nie zostaly sprzedane,
- `units_sold` to suma `quantity`,
- `orders_count` to liczba roznych zamowien, w ktorych wystapil produkt,
- `gross_revenue` to suma `quantity * unit_price`,
- `average_unit_price` zaokraglij do 2 miejsc po przecinku,
- `sale_status` ma miec wartosc:
  - `not_sold`, jesli produkt nie ma zadnej pozycji zamowienia,
  - `sold`, jesli produkt pojawil sie w zamowieniach.

Wynik posortuj po `gross_revenue` malejaco.

## Zadanie 3

Przygotuj miesieczny raport sprzedazy per kraj klienta.

Wynik powinien zawierac:

- `sales_month`
- `country`
- `orders_count`
- `customers_count`
- `paid_orders_count`
- `cancelled_orders_count`
- `total_revenue`
- `average_order_value`

Zasady:

- uzyj `DATE_TRUNC`,
- miesiac wylicz z `orders.order_date`,
- `customers_count` ma liczyc unikalnych klientow,
- `paid_orders_count` ma liczyc tylko zamowienia ze statusem `paid`,
- `cancelled_orders_count` ma liczyc tylko zamowienia ze statusem `cancelled`,
- `average_order_value` zaokraglij do 2 miejsc po przecinku,
- pokaz tylko miesiace i kraje, gdzie `total_revenue` jest wieksze niz `100`.

Wynik posortuj po `sales_month`, a potem po `total_revenue` malejaco.

## Zadanie 4

Znajdz klientow, ktorzy maja laczna wartosc zamowien wieksza niz srednia laczna wartosc zamowien per klient.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `country`
- `total_revenue`
- `orders_count`

Zasady:

- policz najpierw laczna wartosc zamowien dla kazdego klienta,
- potem porownaj wynik klienta do sredniej z tych lacznych wartosci,
- uzyj subquery albo CTE,
- nie pokazuj klientow bez zamowien,
- wynik posortuj po `total_revenue` malejaco.

## Zadanie 5

Przygotuj raport kontrolny problemow w danych.

Wynik powinien zawierac:

- `issue_type`
- `object_id`
- `object_name`
- `details`

Raport ma laczyc kilka typow problemow jednym wynikiem przez `UNION ALL` (nowość :D):

- klienci bez zamowien,
- produkty bez sprzedazy,
- zamowienia bez pozycji zamowienia,
- klienci bez emaila.

Zasady:

- dla klientow bez zamowien uzyj anti joina,
- dla produktow bez sprzedazy uzyj anti joina,
- dla zamowien bez pozycji uzyj anti joina,
- dla klientow bez emaila uzyj `IS NULL`,
- kazdy fragment `UNION ALL` musi zwracac te same kolumny,
- `details` ma zawierac krotki opis problemu.

Wynik posortuj po `issue_type`, a potem po `object_id`.

## Zadanie 6

Przygotuj raport zamowien z porownaniem kwoty z tabeli `orders` do sumy pozycji z `order_items`.

Wynik powinien zawierac:

- `order_id`
- `customer_name`
- `status`
- `order_total_amount`
- `items_total_amount`
- `difference_amount`
- `amount_check`

Zasady:

- `order_total_amount` to `orders.total_amount`,
- `items_total_amount` to suma `quantity * unit_price`,
- `difference_amount` to roznica miedzy `orders.total_amount` i suma pozycji,
- `amount_check` ma miec wartosc:
  - `match`, jesli roznica wynosi `0`,
  - `different`, jesli roznica jest inna niz `0`,
- zaokraglij wartosci liczbowe do 2 miejsc po przecinku,
- pokaz wszystkie zamowienia, rowniez te bez pozycji.

Wynik posortuj tak, aby najpierw byly rekordy z `amount_check = 'different'`.

## Zadanie 7

Przygotuj raport kanalow pozyskania klientow i ich sprzedazy.

Wynik powinien zawierac:

- `acquisition_channel`
- `customers_count`
- `customers_with_orders_count`
- `orders_count`
- `paid_orders_count`
- `total_revenue`
- `average_revenue_per_customer`

Zasady:

- uwzglednij wszystkich klientow,
- `customers_count` ma liczyc wszystkich klientow w danym kanale,
- `customers_with_orders_count` ma liczyc tylko klientow, ktorzy maja przynajmniej jedno zamowienie,
- `orders_count` ma liczyc wszystkie zamowienia,
- `paid_orders_count` ma liczyc tylko zamowienia `paid`,
- `average_revenue_per_customer` to `total_revenue / customers_count`,
- wynik zaokraglij tam, gdzie ma to sens.

Wynik posortuj po `total_revenue` malejaco.

## Zadanie 8

Znajdz produkty, ktore byly sprzedane w zamowieniach klientow z Polski albo Niemiec.

Wynik powinien zawierac:

- `product_id`
- `product_name`
- `category`
- `countries`
- `units_sold`
- `total_revenue`

Zasady:

- uzyj joinow przez tabele `order_items`, `orders` i `customers`,
- wez pod uwage tylko klientow z krajow `PL` i `DE`,
- `countries` ma pokazac kraje, w ktorych produkt zostal sprzedany,
- `units_sold` to suma `quantity`,
- `total_revenue` to suma `quantity * unit_price`,
- pokaz tylko produkty, ktore sprzedaly sie lacznie w liczbie wiekszej niz `1`.

Wynik posortuj po `units_sold` malejaco, potem po `total_revenue` malejaco.

## Zadanie 9

Pokaz klientow, ktorzy kupili przynajmniej jeden produkt z kategorii `course`, ale nigdy nie kupili produktu z kategorii `template`.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `country`

Zasady:

- uzyj `EXISTS` dla warunku, ze klient kupil produkt z kategorii `course`,
- uzyj `NOT EXISTS` dla warunku, ze klient nie kupil produktu z kategorii `template`,
- pamietaj, ze droga od klienta do produktu prowadzi przez:
  - `orders`,
  - `order_items`,
  - `products`.

Wynik posortuj po `customer_id`.

## Zadanie 10

Przygotuj koncowy raport sprzedazy na poziomie zamowienia.

Wynik powinien zawierac:

- `order_id`
- `order_date`
- `sales_month`
- `customer_id`
- `customer_name`
- `country`
- `status`
- `items_count`
- `units_count`
- `order_total_amount`
- `items_total_amount`
- `order_tier`

Zasady:

- `sales_month` policz przez `DATE_TRUNC`,
- `items_count` to liczba pozycji zamowienia,
- `units_count` to suma `quantity`,
- `order_total_amount` to kwota z tabeli `orders`,
- `items_total_amount` to suma `quantity * unit_price`,
- `order_tier` ma miec wartosc:
  - `high`, jesli `order_total_amount >= 150`,
  - `standard`, jesli `order_total_amount < 150`,
- pokaz tylko zamowienia od `2026-05-01`,
- uwzglednij tylko statusy `paid` i `pending`.

Wynik posortuj po `order_date`, potem po `order_id`.
