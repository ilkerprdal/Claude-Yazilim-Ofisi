---
description: "Akıllı onboarding - proje aşamasını ve teknoloji yığınını otomatik tespit edip doğru komuta yönlendirir. Yeni oturumda, 'nereden baslayim', 'yardim et baslamak istiyorum', 'baslat' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, AskUserQuestion
---

# /basla

Proje durumunu **otomatik** tespit et, sonra yönlendir.

### Adım 1: Proje Aşaması Tespiti

Şu sırayla kontrol et:

| Belirti | Aşama | Yönlendirme |
|---------|-------|-------------|
| Hiçbir şey yok | Boş proje | `/fikir` öner |
| `docs/urun/konsept.md` var, başka yok | Fikir aşaması | `/analiz` öner |
| `docs/analiz/` var, mimari yok | Analiz aşaması | `/mimari` öner |
| `docs/architecture/mimari.md` var, hikaye yok | Mimari aşaması | `/hikaye-olustur` öner |
| `production/stories/*.md` var, sprint yok | Backlog hazır | `/sprint-plan` öner |
| Aktif sprint var (`production/sprints/`) | Sprint içinde | `/standup` öner |
| `src/` var ama bizim doküman yok | **Mevcut kod tabanı** | `/analiz` (mevcut sistem modu) öner |
| `production/session-state/active.md` dolu | Devam ediyor | `active.md`'yi oku, son durumu özetle |

### Adım 2: Tech Stack Tespiti

`src/` veya kök klasörde şunları ara — bulduğunu kullanıcıya söyle, doğrula:

| Dosya | Tespit |
|-------|--------|
| `package.json` | Node.js → `dependencies` taranıp framework belirle (next/react/vue/express/nest/...) |
| `requirements.txt` / `pyproject.toml` | Python → fastapi/django/flask |
| `pom.xml` / `build.gradle` | Java → spring/quarkus |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `composer.json` | PHP → laravel/symfony |
| `Gemfile` | Ruby → rails |
| `.csproj` | .NET |
| `Dockerfile` | Konteyner |
| `docker-compose.yml` | Çoklu servis |
| `.github/workflows/` | CI var |

Tespitleri özetle:
```
Tespit ettiklerim:
- Dil: Python 3.11
- Framework: FastAPI 0.110
- DB: PostgreSQL (docker-compose'tan)
- CI: GitHub Actions

Doğru mu?
```

### Adım 3: Memory Yükle

`.claude/memory/` varsa içindeki dersleri **özetle** ve devam et.

### Adım 4: Yönlendir

Tespit ettiğin aşamaya göre **bir** komut öner. Kullanıcı isterse alternatif sun.

### Kurallar

- Hiçbir varsayım yapma — tespitlerini söyle, doğrulat
- Birden fazla aşama aynı anda görünüyorsa (ör. hem konsept hem kod) → kullanıcıya sor
- Tespit edemediysen: "Klasör yapısını anlayamadım, manuel söyler misin?" diye sor

### Çıktı

```
STATUS: COMPLETED
DETECTED_STAGE: [aşama]
DETECTED_STACK: [yığın özeti]
MEMORY_LOADED: [kaç not]
SUGGESTED_NEXT: [önerilen komut]
```
