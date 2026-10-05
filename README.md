Locumie — prototyp aplikacji Android

Locumie to projekt aplikacji społecznościowej, której docelowym celem jest ułatwianie nawiązywania kontaktów z osobami w okolicy. Rozwijam go w Kotlinie, budując interfejs mobilny, nawigację między ekranami i warstwę komunikacji z API.

**Status: prototyp w trakcie rozwoju.** Projekt nie jest przedstawiany jako gotowa aplikacja produkcyjna.

## Co zostało zaimplementowane

W pełnej lokalnej kopii projektu znajdują się:

- Główna aktywność aplikacji i nawigacja między sekcjami: ekran główny, wyszukiwanie, dodawanie treści, wiadomości oraz profil.
- Ekran główny z listą postów opartą na RecyclerView i obsługą widoków przez View Binding.
- Klient REST API z Retrofit, OkHttp i konwersją JSON przez Gson.
- Warstwa obsługi logowania i rejestracji, profilu użytkownika oraz przechowywania tokenów sesji.
- Kontrakty API dla logowania przez Google i Facebook, odświeżania sesji oraz wylogowania. Ich obecność nie oznacza potwierdzonego działania zewnętrznych usług.
- Interceptor odpowiedzi testowych dla wybranych endpointów, umożliwiający rozwijanie części aplikacji bez działającego serwera.

## Technologie

| Obszar | Technologie |
| --- | --- |
| Platforma | Android, Kotlin |
| Interfejs | XML, AppCompat, Material Components, View Binding, RecyclerView |
| Nawigacja | Jetpack Navigation |
| Komunikacja z API | Retrofit, OkHttp, Gson |
| Operacje asynchroniczne | Kotlin Coroutines |
| Budowanie | Gradle 8.14.3, Android Gradle Plugin 8.13.0, JDK 21 |
| Wersje Androida | minSdk 29 (Android 10), compileSdk i targetSdk 35 |

Interfejs korzysta z widoków XML; Jetpack Compose jest wyłączony w konfiguracji projektu.

## Zawartość repozytorium

Bieżąca wersja repozytorium zawiera konfigurację projektu i skrypty pomocnicze, ale **nie zawiera pełnego modułu `app/` ani katalogu `gradle/wrapper/`**. Samo sklonowanie tej wersji nie wystarczy do zbudowania aplikacji.

Opis implementacji w tym README odpowiada pełnej lokalnej kopii projektu. Udostępnienie jej kodu w repozytorium pozostaje kolejnym krokiem.

Docelowy układ pełnego projektu:

```text
app/src/main/
├── ui/                  # Ekrany i nawigacja
├── network/             # Klient Retrofit, kontrakty API i odpowiedzi testowe
├── repository/          # Obsługa danych i sesji użytkownika
├── utils/               # Konfiguracja i funkcje pomocnicze
└── res/                 # Layouty XML i zasoby Androida
```

## Uruchomienie pełnej kopii projektu

Poniższe kroki dotyczą kopii zawierającej moduł `app/` i kompletny Gradle Wrapper.

1. Otwórz projekt w Android Studio.
2. Ustaw JDK 21 i zainstaluj Android SDK 35.
3. Sprawdź adres API w `app/src/main/java/com/example/radiusapp/utils/Config.kt` oraz konfigurację klienta w `network/RetrofitClient.kt`.
4. Zsynchronizuj projekt z Gradle.
5. Uruchom aplikację na emulatorze lub urządzeniu z Androidem 10 albo nowszym.

Aby zbudować APK debug na Windows:

```powershell
.\gradlew.bat :app:assembleDebug
```

Klient ma tryb odpowiedzi testowych włączany dla adresów zawierających `localhost`, `10.0.2.2` lub `mock`. Dane i tokeny w tym trybie są przykładowe; nie potwierdzają integracji z rzeczywistym backendem.

Dla integracji zewnętrznych konfiguracja przewiduje właściwości Gradle, m.in. `GOOGLE_WEB_CLIENT_ID`, `FACEBOOK_APP_ID`, `FACEBOOK_CLIENT_TOKEN`, `PAYPAL_CLIENT_ID` i `PAYPAL_ENVIRONMENT`. Konfigurację środowiska należy przechowywać poza repozytorium.

## Ograniczenia i dalszy rozwój

- Geolokalizacja i interaktywna mapa są planowanymi elementami produktu. Obecny plik `MapFragment.kt` jest pusty.
- Działanie komunikacji, płatności i logowania z zewnętrznymi usługami wymaga osobnej weryfikacji; zależności SDK nie są dowodem ukończonej integracji.
- W sprawdzonej kopii nie ma katalogów `src/test` ani `src/androidTest`. Nie deklaruję liczby wykonanych testów ani procentowego pokrycia kodu.
- Kompilacja i działanie aplikacji nie zostały zweryfikowane podczas aktualizacji tego README.

Najbliższe kroki: uzupełnienie repozytorium o kod aplikacji, sprawdzenie procesu budowania, weryfikacja przepływów użytkownika i dodanie testów kluczowej logiki.

## Autor

Patryk Rybacki — [GitHub](https://github.com/wujasino)
