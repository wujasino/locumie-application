# 🏠 Locumie – Innowacyjna Platforma Zakwaterowania

Locumie to nowoczesna aplikacja mobilna, ułatwiający nawiązywanie kontaktów między osobami poszukującymi zakwaterowania a wynajmującymi. Projekt stawia na szybkość działania oraz precyzyjną lokalizację ofert dzięki interaktywnej mapie.

## 🚀 Kluczowe Osiągnięcia Techniczne
* **Optymalizacja Backendowa:** Zoptymalizowałem zapytania PostgreSQL, co skróciło czas odpowiedzi bazy danych o **30%**.
* **Jakość i Stabilność:** Całość logiki biznesowej jest objęta testami, utrzymując poziom **80% test coverage**.
* **Integracja AI:** Wdrożyłem moduł automatycznego generowania raportów przy użyciu **OpenAI API**[cite: 19].
* **Bezpieczeństwo:** System wykorzystuje autoryzację opartą na tokenach **JWT**[cite: 6, 17].

## 🛠 Stack Techniczny
* **Frontend:** React.js [cite: 4, 26]
* **Mobile:** Flutter & Dart
* **Backend:** Node.js, Python [cite: 4, 27]
* **Baza danych:** PostgreSQL[cite: 6, 27], Firebase (Realtime Database / Firestore)
* **Inne:** OpenAI API, REST API [cite: 5, 19, 27]

## 🌟 Funkcjonalności
* **Interaktywna Mapa:** Lokalizowanie ofert poprzez geolokalizację (customowa implementacja bez Google Maps).
* **System Komunikacji:** Bezpośrednie wysyłanie wiadomości do użytkowników z poziomu mapy.
* **Zarządzanie Stanem:** Zaawansowana obsługa stanów zapewniająca płynność interfejsu.

## ⚙️ Instalacja i Uruchomienie
1. Sklonuj repozytorium: `git clone https://github.com/wujasino/locumie.git`
2. Przejdź do folderu: `cd locumie`
3. Pobierz zależności: `flutter pub get`
4. Skonfiguruj plik `.env` (klucze API Firebase i OpenAI).
5. Uruchom aplikację: `flutter run`

---
[cite_start]*Projekt rozwijany z naciskiem na architekturę Clean Code oraz wydajność systemową.* [cite: 7]
