Parser dla programów w języku Pascal
Autor: Jakub Kasiński

Sposób uruchomienia na maszynie sxterm:
1. Utwórz folder roboczy, w którym umieść wszystkie pliki
2. Skopiuj kod programu, który chcesz zbadać do pliku przyklad.pas
3. Uruchom polecenie make

Uwagi:
Parser nie obsługuje w pełni całej składni języka Pascal.
Nie wykrywa on np. poleceń uses i deklaracji const.
Wykrywa jednak niektóre z instrukcji i liczy ich wystąpienia oraz liczbę wierszy.
Przykładowy kod, dla którego parser wykrywa poprawną składnie znajduje się domyślnie w pliku przyklad.pas