# Smart Nutrition Tracker

Aplikasi mobile untuk memantau asupan kalori harian, pemenuhan gizi, dan konsistensi pola makan secara real-time.

> Tugas Besar — Mata Kuliah Konstruksi Perangkat Lunak (KPL) & Basis Data

---

## Deskripsi Produk

Smart Nutrition Tracker adalah aplikasi mobile berbasis Flutter yang membantu pengguna memantau asupan kalori dan gizi harian secara real-time. Pengguna dapat mencari makanan dari database USDA FoodData Central, mencatat porsi yang dikonsumsi, dan melihat ringkasan gizi harian beserta grafik konsistensi pola makan.

Sistem memberikan notifikasi otomatis ketika target kalori harian telah tercapai, serta mendukung dua pilihan algoritma kalkulasi kebutuhan gizi (Mifflin-St Jeor dan Harris-Benedict) yang dapat dipilih pengguna sesuai preferensi.

---

## Tech Stack

### Frontend (Mobile)

| Teknologi    | Versi  | Kegunaan                               |
| ------------ | ------ | -------------------------------------- |
| Flutter      | 3.x    | Framework utama mobile app             |
| Riverpod     | 2.x    | State management                       |
| FL Chart     | latest | Grafik kalori & konsistensi pola makan |
| Lucide Icons | latest | Library icon UI                        |
| Dio          | latest | HTTP client untuk konsumsi REST API    |

### Backend

| Teknologi         | Versi | Kegunaan                        |
| ----------------- | ----- | ------------------------------- |
| Java              | 17+   | Bahasa pemrograman utama        |
| Spring Boot       | 3.x   | Framework backend utama         |
| Spring MVC        | —     | REST API layer                  |
| Spring Security   | —     | Autentikasi & otorisasi, BCrypt |
| Spring Data JPA   | —     | Data access layer               |
| Hibernate         | —     | ORM untuk Oracle                |
| JUnit 5 + Mockito | —     | Unit testing                    |
| Lombok            | —     | Boilerplate reduction           |
| Maven             | —     | Dependency management           |

### Database

| Teknologi            | Kegunaan                           |
| -------------------- | ---------------------------------- |
| Oracle Database      | Database utama                     |
| Oracle SQL Developer | GUI manajemen database             |
| OJDBC Driver         | Koneksi Java ke Oracle             |
| Trigger              | Audit log perubahan status nutrisi |
| Stored Procedure     | Kalkulasi agregasi gizi harian     |
| Sequence             | Auto-increment ID semua tabel      |

### External API

| API                   | Kegunaan                                 |
| --------------------- | ---------------------------------------- |
| USDA FoodData Central | Data makanan dan kandungan gizi (gratis) |

### Tooling

| Tools                 | Kegunaan                     |
| --------------------- | ---------------------------- |
| Git + GitHub          | Version control & kolaborasi |
| IntelliJ IDEA         | IDE backend                  |
| VS Code + Flutter SDK | IDE frontend                 |
| Postman               | Testing REST API             |

---

## Arsitektur Sistem

```
Flutter App
    │
    │  REST API (JSON)
    ▼
Spring Boot Backend ──── USDA FoodData Central API
    │
    │  OJDBC / JPA
    ▼
Oracle Database
```

> API key USDA disimpan di backend (application.properties), bukan di dalam aplikasi Flutter, untuk menjaga keamanan (prinsip secure coding).

---

## Fitur Utama

- **Autentikasi** — Register, login, logout dengan password ter-hash BCrypt
- **Pencarian makanan** — Cari makanan dari USDA FoodData Central secara real-time
- **Log makanan harian** — Catat makanan dan porsi yang dikonsumsi
- **Kalkulasi gizi otomatis** — Hitung kalori, protein, lemak, karbohidrat secara otomatis
- **Status nutrisi** — Tracking status harian: `EMPTY → PARTIAL → FULFILLED`
- **Notifikasi target kalori** — Peringatan otomatis saat target kalori harian tercapai
- **Grafik konsistensi** — Visualisasi pola makan harian/mingguan dengan FL Chart
- **Pilihan algoritma BMR** — Mifflin-St Jeor atau Harris-Benedict (Strategy pattern)
- **Multi-bahasa** — Antarmuka tersedia dalam Bahasa Indonesia dan English
- **Audit log** — Riwayat perubahan status nutrisi tersimpan otomatis via Oracle Trigger

---

## Pemetaan Sub-CLO KPL

| Sub-CLO   | Materi                                                        | Implementasi                                                                                                                     |
| --------- | ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| **9.1.1** | IDE, GUI Builder, Version Control                             | IntelliJ IDEA, VS Code + Flutter SDK, Git + GitHub, Spring Initializr                                                            |
| **9.2.1** | State-based, table-driven, generics                           | State machine status nutrisi (`EMPTY→PARTIAL→FULFILLED`), `Repository<T,ID>` Spring Data JPA, table-driven target kalori         |
| **9.2.2** | Design by contract, assertions, defensive programming         | Bean Validation (`@NotNull`, `@Min`, `@Max`, `@Email`), assertion kalori tidak negatif, grammar-based parsing format porsi       |
| **9.2.3** | Runtime config, i18n, API, code reuse                         | `application-dev/prod.properties`, i18n EN/ID (`messages.properties`), integrasi USDA API via `RestTemplate`, Lombok & MapStruct |
| **9.3.1** | Performance analysis, unit testing, debugging, design pattern | JUnit 5 + Mockito, Observer pattern (notifikasi kalori), Strategy pattern (algoritma BMR), SLF4J logging                         |
| **9.3.2** | Clean code, coding standard, secure coding                    | Checkstyle, BCrypt, API key di backend (bukan di Flutter), input sanitization sebelum query Oracle                               |

---

## Struktur Folder Backend

```
smart-nutrition-tracker/
├── src/
│   ├── main/
│   │   ├── java/com/nutritiontracker/
│   │   │   ├── config/          # AppConfig, SecurityConfig, LocaleConfig
│   │   │   ├── controller/      # AuthController, FoodController, FoodLogController, NutritionController, UserController
│   │   │   ├── service/         # Business logic + strategy/
│   │   │   │   └── strategy/    # NutritionCalculator (interface), MifflinCalculator, HarrisCalculator
│   │   │   ├── repository/      # UserRepository, FoodLogRepository, NutritionSummaryRepository
│   │   │   ├── model/           # User, FoodLog, NutritionSummary, NutritionStatus (enum)
│   │   │   ├── dto/             # Request & Response classes
│   │   │   ├── exception/       # GlobalExceptionHandler, ResourceNotFoundException
│   │   │   └── NutritionTrackerApp.java
│   │   └── resources/
│   │       ├── application.properties
│   │       ├── application-dev.properties
│   │       ├── application-prod.properties
│   │       ├── messages.properties       # i18n English
│   │       ├── messages_id.properties    # i18n Indonesia
│   │       └── db/migration/
│   │           ├── V1__create_tables.sql
│   │           ├── V2__create_sequences.sql
│   │           └── V3__create_triggers.sql
│   └── test/
│       └── java/com/nutritiontracker/
│           ├── FoodLogServiceTest.java
│           ├── NutritionServiceTest.java
│           └── StrategyCalculatorTest.java
├── pom.xml
├── .env.example
├── .gitignore
└── README.md
```

---

## Cara Menjalankan Backend

### Prasyarat

- Java 17+
- Maven 3.8+
- Oracle Database (aktif dan dapat diakses)
- Oracle SQL Developer
- USDA FoodData Central API key (daftar gratis di https://fdc.nal.usda.gov/api-guide.html)

### Setup

1. Clone repository

```bash
git clone https://github.com/<username>/smart-nutrition-tracker.git
cd smart-nutrition-tracker
```

2. Salin file environment dan isi nilainya

```bash
cp .env.example .env
```

Isi `.env`:

```
ORACLE_URL=jdbc:oracle:thin:@localhost:1521:xe
ORACLE_USERNAME=your_username
ORACLE_PASSWORD=your_password
USDA_API_KEY=your_usda_api_key
JWT_SECRET=your_jwt_secret
```

3. Jalankan SQL migration di Oracle SQL Developer

```sql
-- Jalankan secara berurutan:
-- V1__create_tables.sql
-- V2__create_sequences.sql
-- V3__create_triggers.sql
```

4. Build dan jalankan

```bash
mvn clean install
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

Backend berjalan di `http://localhost:8080`

---

## REST API Endpoints

| Method   | Endpoint                             | Deskripsi                     |
| -------- | ------------------------------------ | ----------------------------- |
| `POST`   | `/api/auth/register`                 | Register pengguna baru        |
| `POST`   | `/api/auth/login`                    | Login dan dapatkan token      |
| `GET`    | `/api/food/search?query={q}`         | Cari makanan dari USDA        |
| `POST`   | `/api/food-log`                      | Tambah log makanan            |
| `GET`    | `/api/food-log?date={date}`          | Ambil log makanan per tanggal |
| `PUT`    | `/api/food-log/{id}`                 | Update log makanan            |
| `DELETE` | `/api/food-log/{id}`                 | Hapus log makanan             |
| `GET`    | `/api/nutrition/summary?date={date}` | Ringkasan gizi harian         |
| `GET`    | `/api/user/profile`                  | Ambil profil pengguna         |
| `PUT`    | `/api/user/profile`                  | Update profil & target kalori |

---

## Pembagian Tugas Tim

| Anggota | Peran                          | Tanggung Jawab Utama                                                        |
| ------- | ------------------------------ | --------------------------------------------------------------------------- |
| M1      | Project Lead & DevOps          | Setup project, GitHub, Checkstyle, konfigurasi environment, dokumentasi     |
| M2      | Database Engineer              | Skema Oracle, Sequence, Trigger, Stored Procedure, koneksi JPA              |
| M3      | Backend Dev — Auth & User      | AuthController, Spring Security, BCrypt, validasi DTO, exception handling   |
| M4      | Backend Dev — Food & Nutrition | Integrasi USDA API, FoodLogService, state machine, Strategy pattern         |
| M5      | Frontend Dev — Flutter         | UI Flutter, Riverpod, FL Chart, integrasi API, i18n Flutter                 |
| M6      | QA & Design Pattern            | Observer pattern, JUnit 5 + Mockito, performance analysis, laporan evaluasi |

---

## Kontribusi

1. Buat branch baru dari `dev`: `git checkout -b feature/nama-fitur`
2. Commit dengan pesan yang jelas: `git commit -m "feat: tambah endpoint food log"`
3. Push dan buat Pull Request ke branch `dev`
4. Minta review minimal 1 anggota tim sebelum merge

---

## Lisensi

Proyek ini dibuat untuk keperluan akademik — Tugas Besar Mata Kuliah Konstruksi Perangkat Lunak & Basis Data.
