## Zadanie 1

Przygotuj raport klientow, ktorzy maja laczna wartosc zamowien wieksza niz srednia laczna wartosc zamowien per klient.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `country`
- `orders_count`
- `total_revenue`
- `average_order_value`
- `customer_revenue_tier`

Zasady:

- `customer_revenue_tier` ma miec wartosc:
    - `above_average`, jesli klient jest powyzej sredniej,
      - inne rekordy nie powinny pojawic sie w wyniku,
- pokaz tylko klientow z przynajmniej dwoma zamowieniami,
- wynik posortuj po `total_revenue` malejaco.

## Zadanie 2

Przygotuj raport miesiecznej sprzedazy per status zamowienia.

Wynik powinien zawierac:

- `sales_month`
- `status`
- `orders_count`
- `customers_count`
- `total_revenue`
- `average_order_value`
- `status_share_in_month`

Zasady:

- `customers_count` ma liczyc unikalnych klientow,
- `status_share_in_month` to udzial sprzedazy danego statusu w sprzedazy calego miesiaca,
- pokaz tylko grupy, gdzie `orders_count > 0` i `total_revenue > 50`,
- wynik posortuj po `sales_month`, potem po `total_revenue` malejaco.

## Zadanie 3

Znajdz produkty, ktorych sprzedaz jest wyzsza niz srednia sprzedaz produktu w tej samej kategorii.

Wynik powinien zawierac:

- `product_id`
- `product_name`
- `category`
- `units_sold`
- `product_revenue`
- `category_average_revenue`

Zasady:

- pokaz tylko produkty sprzedane przynajmniej raz,
- wynik posortuj po `category`, potem po `product_revenue` malejaco.

## Zadanie 4

Przygotuj raport kontrolny klientow i produktow wymagajacych sprawdzenia.

Wynik powinien zawierac:

- `issue_type`
- `object_id`
- `object_name`
- `metric_value`

Raport ma skladac sie z trzech czesci polaczonych przez `UNION ALL`:

1. klienci bez zamowien,
2. produkty bez sprzedazy,
3. klienci, ktorzy maja wiecej niz jedno anulowane zamowienie.

Zasady:

- `metric_value` ma byc:
    - `0` dla brakow,
      - liczba anulowanych zamowien dla trzeciej czesci,
- wynik posortuj po `issue_type`, potem po `object_id`.

## Zadanie 5

Przygotuj raport zamowien, ktore sa podejrzane kwotowo.

Wynik powinien zawierac:

- `order_id`
- `customer_name`
- `status`
- `order_total_amount`
- `items_total_amount`
- `difference_amount`
- `amount_check`

Zasady:

- pokaz wszystkie zamowienia, rowniez bez pozycji,
- `difference_amount` to roznica miedzy `orders.total_amount` i suma pozycji,
- `amount_check` ma miec wartosc:
  - `missing_items`, jesli zamowienie nie ma pozycji,
  - `match`, jesli roznica wynosi `0`,
  - `different`, jesli roznica jest inna niz `0`,
- pokaz tylko rekordy, gdzie `amount_check` nie jest `match`,
- wynik posortuj po `amount_check`, potem po `order_id`.

## Zadanie 6

Znajdz kraje, w ktorych klienci kupili produkty z co najmniej dwoch roznych kategorii.

Wynik powinien zawierac:

- `country`
- `customers_count`
- `orders_count`
- `categories_count`
- `total_revenue`

Zasady:

- `customers_count` ma liczyc unikalnych klientow,
- `categories_count` ma liczyc unikalne kategorie produktow,
- `total_revenue` ma liczyc sume `quantity * unit_price`,
- pokaz tylko kraje z przynajmniej dwiema kategoriami,
- pokaz tylko kraje, gdzie `total_revenue > 100`,
- wynik posortuj po `categories_count` malejaco, potem po `total_revenue` malejaco.

## Zadanie 7

Pokaz klientow, ktorzy kupili produkt z kategorii `course`, ale ich laczna wartosc zamowien jest nizsza niz srednia laczna wartosc zamowien per klient.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `country`
- `total_revenue`
- `orders_count`

Zasady:

- warunek zakupu produktu z kategorii `course` sprawdz przez `EXISTS`,
- srednia laczna wartosc zamowien per klient ma byc policzona w subquery,
- wynik nie powinien zawierac klientow bez zamowien,
- wynik posortuj po `total_revenue` rosnaco.

## Zadanie 8

Przygotuj raport produktow i kanalow pozyskania klientow.

Wynik powinien zawierac:

- `product_id`
- `product_name`
- `acquisition_channel`
- `customers_count`
- `orders_count`
- `units_sold`
- `total_revenue`

Zasady:

- `customers_count` ma liczyc unikalnych klientow,
- `orders_count` ma liczyc unikalne zamowienia,
- `total_revenue` to suma `quantity * unit_price`,
- pokaz tylko kombinacje produktu i kanalu, gdzie `units_sold > 1`,
- wynik posortuj po `product_name`, potem po `total_revenue` malejaco.

## Zadanie 9

Przygotuj raport klientow z etykieta zachowania zakupowego.

Wynik powinien zawierac:

- `customer_id`
- `customer_name`
- `country`
- `orders_count`
- `paid_orders_count`
- `cancelled_orders_count`
- `total_revenue`
- `customer_label`

Zasady:

- pokaz wszystkich klientow,
- `customer_label` ma miec wartosc:
  - `no_orders`, jesli klient nie ma zamowien,
  - `cancel_risk`, jesli liczba anulowanych zamowien jest wieksza od liczby oplaconych,
  - `high_value`, jesli laczna wartosc zamowien klienta jest wieksza niz srednia laczna wartosc zamowien per klient,
  - `standard`, w pozostalych przypadkach,
- wynik posortuj po `customer_label`, potem po `total_revenue` malejaco.

## Zadanie 10

Przygotuj koncowy raport miesieczny per kraj i kategoria produktu.

Wynik powinien zawierac:

- `sales_month`
- `country`
- `category`
- `customers_count`
- `orders_count`
- `products_count`
- `units_sold`
- `total_revenue`
- `average_line_value`

Zasady:

- `customers_count`, `orders_count`, `products_count` maja liczyc unikalne wartosci,
- `units_sold` to suma `quantity`,
- `total_revenue` to suma `quantity * unit_price`,
- `average_line_value` to srednia wartosc pozycji `quantity * unit_price`, zaokraglona do 2 miejsc,
- pokaz tylko miesiace/kraje/kategorie, gdzie `total_revenue` jest wieksze niz srednia wartosc `total_revenue` dla takich grup,
- wynik posortuj po `sales_month`, `country`, `total_revenue` malejaco.
