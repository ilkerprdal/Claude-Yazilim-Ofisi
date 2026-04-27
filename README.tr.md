# Software Office

[![CI](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml/badge.svg)](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/ilkerprdal/Claude-Software-Office)](https://github.com/ilkerprdal/Claude-Software-Office/releases)
[![Validator](https://img.shields.io/badge/frontmatter-validated-brightgreen)](scripts/validate.py)
[![Example tests](https://img.shields.io/badge/example-13%2F13_passing-brightgreen)](examples/todo-cli/tests/)
![Agents](https://img.shields.io/badge/agents-12-blueviolet)
![Commands](https://img.shields.io/badge/commands-23-blue)

Claude Code oturumunu küçük ve düzenli bir yazılım ofisine dönüştürür.
**12 ajan. 23 slash komutu. Brownfield-friendly. Scale-adaptive.**

🇬🇧 **English version**: [README.md](README.md)

> **Durum: early preview** (v0.1.x). Yalnızca maintainer'ın makinesinde ve
> ekteki örnek üzerinde doğrulanmıştır. API'ler (ajan isimleri, komut
> davranışları, çıktı formatları) 1.0'dan önce değişebilir. Topluluk geri
> bildirimi bekleniyor.
>
> Claude Code Game Studios ve daha geniş Agile-agent ekosisteminden
> (BMAD-METHOD ve diğerleri) ilham alındı. Bilinçli olarak daha dar ve
> daha küçük tutuldu.

## ▶ Demo

![Software Office workflow](demo/workflow.svg)

30 saniyelik akış: `/start` → `/idea` → `/architecture` →
`/develop-story` → `/code-review`. Takım her adımda doğru ajanı seçer,
kalite barlarını uygular (güvenlik / performans / test) ve değişimleri
sen onaylamadan yazmaz.

---

## İçindekiler

1. [Ne İşe Yarar](#ne-işe-yarar)
2. [Kimler İçin](#kimler-için)
3. [Ayırt Edici Özellikler](#ayırt-edici-özellikler)
4. [Kurulum](#kurulum)
5. [Nasıl Çalışır](#nasıl-çalışır)
6. [Takım](#takım)
7. [Slash Komutlar](#slash-komutlar)
8. [Tipik Bir İş Akışı](#tipik-bir-iş-akışı)
9. [Klasör Düzeni](#klasör-düzeni)
10. [Collaboration Protocol](#collaboration-protocol)
11. [Dil Desteği](#dil-desteği)
12. [Özelleştirme](#özelleştirme)

---

## Ne İşe Yarar

Tek bir Claude oturumu güçlüdür ama yapısızdır. Kimse "buna gerçekten
ihtiyacımız var mı?" diye sormaz, kimse code review'ı zorlamaz, kimse
test atladığını fark etmez.

**Software Office** Claude'a küçük bir takım yapısı verir:

- **Karar vericiler** (Directors): vizyon ve teknik kalite
- **Uygulayıcılar** (Leads): kod yapısı, UX, kalite
- **Uzmanlar** (Specialists): backend, frontend, devops kodu

Her kararı yine sen verirsin — ama doğru soruları soran, sınırlarını
bilen ve birbirine danışan bir takımın içinde.

---

## Kimler İçin

### ✅ Şu profillere uygun:
- Takım disiplini isteyen **tek başına geliştirici** veya **küçük takım (2–5 kişi)**
- **Mainstream stack**'te (web, REST/GraphQL API, CLI, kütüphane)
  ~500–10.000 LOC ölçeğinde, en az 2 ay yaşayacak proje
- **Brownfield projeye** giriyorsan — mevcut kod, belki Cursor/Copilot/Aider
  geçmişi var. `/takeover` o context'i ileriye taşır.
- Tek AI oturumu üzerinden **uçtan uca** geliştirme yapanlar

### ❌ Muhtemelen yanlış araç:
- **Tek seferlik script** (< 100 LOC) yazıyorsan — direkt Claude Code daha hızlı
- **Hackathon / zaman kısıtlı sprint** — süreç maliyeti çıkmaz
- **20+ kişilik kurum**, oturmuş Jira / ADR / retro yapısı varsa — çakışır
- **AI/ML araştırma**, **embedded firmware**, **donanım sürücüleri**,
  **blockchain protokol tasarımı** — ajan domain bilgisi genel-amaçlı
- Sadece **kodla ilgili sohbet** istiyorsan — slash-command yükü gereksiz
- **Kurumsal çoklu-takım koordinasyonu**, 50+ özelleşmiş ajan ihtiyacı varsa
  → [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD)

### Hangisini ne zaman?

| Durum | Araç |
|---|---|
| Tek konuşma, yapı yok | Direkt Claude Code |
| Hafif Agile, solo / küçük takım | **Software Office** |
| 50+ ajan, kurumsal greenfield | BMAD-METHOD |
| Mevcut projem var, prior AI context'im var | **Software Office** (`/takeover`) |
| Değişim büyüklüğüne göre süreç (one-liner ↔ feature ↔ sprint) | **Software Office** (`/quick-fix`, `/feature`, `/sprint-plan`) |
| Sadece pair-programming sohbet | Direkt Claude Code |

---

## Ayırt Edici Özellikler

Bu projenin daha büyük Agile-agent framework'lerinden bilinçli olarak
farklı yaptıkları:

### Brownfield-first
- **`/takeover`** prior AI context'i (`.cursorrules`, `.windsurfrules`,
  `context.md`, generic proje notları) import eder, yedekler ve memory
  layer'a distil eder. Sıfırdan başlamazsın.
- Mevcut `CLAUDE.md` `CLAUDE.legacy.md` olarak korunur — sessizce
  üstüne yazılmaz.
- `.gitignore` **merge** edilir, değiştirilmez.

### Scale-adaptive workflow
Süreç değişimin büyüklüğüne göre. Üç açık katman:

| Değişim | Komut | Atlananlar |
|---|---|---|
| < 50 LOC, mimari etkisi yok | `/quick-fix` | story, sprint, retro, full review |
| 50–500 LOC, tek özellik | `/feature` | sprint planning, retro |
| > 500 LOC, çoklu story | `/sprint-plan` + `/develop-story` | hiçbir şey |

Önemsiz fix'ler için zorla ceremony yok.

### Defensive infrastructure
- **Hook'lar fail-open** — Python yok, test framework yok, git yok →
  sessizce no-op. Hook'lar işini bloklamaz.
- **Cross-platform installer'lar** (bash + PowerShell + bat wrapper) —
  Node/npm bağımlılığı yok.
- **Üç kurulum yolu**: plugin, tek satır, manuel. Sana uygunu seç.

### Açık sınırlar
- **Anti-persona listesi** — README ne zaman *kullanmaman* gerektiğini söyler (yukarı bak).
- **Vertical delegation kuralları** — Director → Lead → Specialist, atlama yok.
- **Memory layer** (`.claude/memory/`) — oturumlar arası birikmiş öğrenmeler, 5 kategori.

### Dürüst kapsam
- **Tek-maintainer projesi** — bus factor riski açıkça belirtilmiş.
- **Verified vs. designed-for** ayrımı multilingual iddiasında (aşağıda).
- **Early preview** durumu (v0.1.x) — API'ler değişebilir.

---

## Kurulum

Üç yol — sana uygun olanı seç.

### A. Plugin install (Claude Code 2.x için önerilen)

Bir Claude Code oturumunda:

```
/plugin marketplace add ilkerprdal/Claude-Software-Office
/plugin install claude-software-office@claude-software-office-marketplace
```

Bu, ajanları, komutları ve hook'ları Claude Code plugin'i olarak bağlar —
`/plugin update` ile otomatik güncelleme, kullanıcı veya proje seviyesinde
scope.

### B. Tek satır (her projeye, plugin desteği gerekmez)

**macOS / Linux / Git Bash on Windows:**
```bash
curl -fsSL https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.ps1 | iex
```

Projenin kök klasöründen çalıştır. Script son release'i indirir;
`.claude/`, `CLAUDE.md`, `.gitignore` ve `production/` iskeletini kurar.
Mevcut `CLAUDE.md` `CLAUDE.legacy.md` olarak yedeklenir.

### C. Manuel

```bash
git clone https://github.com/ilkerprdal/Claude-Software-Office.git
cd projen
bash /path/to/Claude-Software-Office/install.sh        # Mac/Linux
.\path\to\Claude-Software-Office\install.ps1           # Windows
```

Veya klonladığın repo'dan `.claude/` ve `CLAUDE.md`'yi projene elle kopyala.

### Kurulumdan sonra

```bash
claude
/start         # veya prior AI context'in varsa /takeover
```

Ajanlar dilini otomatik algılar (doğrulanan: İngilizce, Türkçe).

---

## Nasıl Çalışır

Software Office üç sistem üzerine kurulu:

### 1. Slash Komutlar (`/command`)

`.claude/commands/` altındaki her `.md` dosyası bir slash komutu.
Sohbette `/` yaz, autocomplete listeler.

Komut dosyası yapısı:

```markdown
---
description: "Ne yapar ve ne zaman tetiklenir"
allowed-tools: Read, Write, ...
---

[Bu komut çağrıldığında Claude'un izleyeceği talimatlar]
```

Bir komut çağırdığında Claude body'i görev tanımı olarak okur ve adımları
takip eder. Çoğu komut "engage [agent]" ile başlar.

### 2. Ajanlar (Subagents)

`.claude/agents/` altındaki her `.md` dosyası özelleşmiş bir subagent.
Her biri kendi alanını ve sınırlarını bilir.

Ajan dosyası yapısı:

```markdown
---
name: agent-name
description: "Bu ajan ne zaman kullanılır"
tools: Read, Write, Edit, ...    # erişebileceği araçlar
model: opus / sonnet              # model ataması
---

[Ajanın system prompt'u — sorumluluklar, kurallar, sınırlar]
```

Bir komut "engage agent-name" dediğinde Claude o ajanın system prompt'unu
yükler ve onun perspektifinden çalışır. Ajan kendi sandbox'ında kalır —
örn. `backend-developer` UI dosyalarına dokunmaz.

### 3. CLAUDE.md ve Konfigürasyon

`CLAUDE.md` (proje kökünde) **her oturumda otomatik yüklenir**:

- Tech stack
- Klasör düzeni
- Collaboration protocol
- Coding standards (`@` referanslarıyla yüklenir)
- Project memory (`@.claude/memory/*.md` ile yüklenir)

Böylece Claude her oturuma "bu proje nasıl çalışıyor" bilgisiyle girer.

`.claude/settings.json` izinleri kontrol eder: hangi komutlar otomatik
allow, hangileri yasak (`rm -rf` blok, `.env` okumaları blok).

---

## Takım

```
Directors (Opus)
├── tech-director         → mimari, teknoloji seçimi, teknik anlaşmazlık
└── product-manager       → kapsam, öncelik, ürün kararları

Leads (Sonnet, security-reviewer Opus)
├── engineering-lead      → kod yapısı, API, code review, refactoring patterns
├── qa-lead               → test pyramid, contract testing, kalite kapısı
├── design-lead           → UX, ekran tasarımı, kullanıcı akışı, erişilebilirlik
├── business-analyst      → gereksinim, JTBD, mevcut sistem analizi
├── scrum-master          → sprint, velocity, blocker SLA, retro
├── security-reviewer     → STRIDE tehdit modeli, OWASP audit, uyumluluk
└── technical-writer      → README, CHANGELOG, ADR, API docs, drift audit

Specialists (Sonnet)
├── backend-developer     → API, servis, DB, business logic
├── frontend-developer    → UI bileşen, ekran
└── devops                → CI/CD, deployment, environment
```

### Hiyerarşi nasıl çalışır

- **Vertical delegation**: Director → Lead → Specialist. Director'lar
  doğrudan specialist'e delege etmez (lead üzerinden gider).
- **Horizontal consultation**: Aynı seviyedeki ajanlar danışır ama
  birbirleri için karar vermez. Backend ↔ Frontend API contract konuşur,
  ama mimari kararlar engineering-lead'e gider.
- **Çatışmalar**: Tasarım çatışması → product-manager.
  Teknik çatışma → tech-director.

---

## Slash Komutlar

| Komut | Ne yapar | Ajan |
|---------|--------------|-------|
| **Onboarding** | | |
| `/takeover` | Mevcut proje context'ini import et (context.md, .cursorrules, vb.) | — |
| `/start` | Akıllı: aşama + tech stack algılama, yönlendirme | — |
| `/help` | Bağlama göre öneri + tam komut listesi | — |
| **Tasarım** | | |
| `/idea` | Fikri concept dokümanına çevir | product-manager |
| `/analyze` | Gereksinim / mevcut sistem analizi | business-analyst |
| `/architecture` | Teknik mimari + ADR'ler | tech-director |
| **Sprint (Agile)** | | |
| `/create-stories` | İşi story'lere böl | product-manager |
| `/backlog` | Backlog refinement | scrum-master |
| `/sprint-plan` | Sprint planlama (kapasite + seçim) | scrum-master |
| `/standup` | Günlük durum + blocker | scrum-master |
| `/retro` | Sprint retrospektifi | scrum-master |
| **Geliştirme** | | |
| `/api-design` | Schema-first API tasarımı (OpenAPI / GraphQL / .proto) — koddan önce | engineering-lead → backend/qa |
| `/develop-story` | Story'i uçtan uca implement et (full sprint context) | backend/frontend |
| `/feature` | Mid-tier: story + AC + implementation, sprint ceremonisi yok (50–500 LOC) | engineering-lead → specialist |
| `/quick-fix` | Hafif fix yolu, story yok (< 50 LOC) | backend/frontend/devops |
| `/code-review` | Kod kalitesi / mimari / test review | engineering-lead |
| **QA & Güvenlik** | | |
| `/qa-plan` | Sprint veya feature için test planı | qa-lead |
| `/bug-report` | Yapılandırılmış bug raporu | qa-lead |
| `/bug-fix` | QA → Dev → QA bug fix döngüsü | bug owner |
| `/security-review` | STRIDE + OWASP Top-10 audit | security-reviewer |
| **Karar / Bilgi** | | |
| `/consult` | Çoklu-ajan paralel danışma (panel mode) | (panel) |
| `/memory` | Proje öğrenmelerini yönet | — |
| `/release-check` | Yayım öncesi go/no-go checklist | tech-director |

---

## Tipik Bir İş Akışı

Bir TODO uygulaması yapıyorsun:

### 1. Concept (`/idea`)
- product-manager: "Hangi problem? Kim kullanıyor?"
- Sen cevaplarsın, o seçenekler üretir, sen seçersin
- Çıktı: `docs/product/concept.md`

### 2. Gereksinimler (`/analyze`)
- business-analyst: paydaş soruları, FR/NFR/kısıtlama listesi
- Mevcut sistem varsa: modüller, bağımlılıklar, etki bölgeleri
- Çıktı: `docs/analysis/requirements.md`

### 3. Mimari (`/architecture`)
- tech-director: "Web mi mobile mi? Backend? DB?"
- Her bölüm için 2-3 seçenek + artı/eksi
- Çıktı: `docs/architecture/architecture.md` + `docs/adr/0001-*.md`

### 4. Story'ler (`/create-stories`)
- product-manager mimariden story listesi üretir
- Çıktı: `production/stories/001-user-login.md`,
  `002-todo-list.md`, `003-todo-add.md`...

### 5. Sprint Planı (`/sprint-plan`)
- scrum-master: backlog'tan kapasite + story seçimi
- Çıktı: `production/sprints/S01-2026-04-26.md`

### 6. Geliştirme (`/develop-story 001`)
- engineering-lead story'i okur, doğru specialist'e yönlendirir
- backend-developer (örn.) dosya listesi önerir, onay alır
- Kod + unit test birlikte
- Test çalışır, acceptance criteria checkbox'ları işaretlenir

### 7. Code Review (`/code-review`)
- engineering-lead kalite, mimari uyumu, testleri kontrol eder
- Markdown rapor: APPROVED / REVISION / MAJOR REVISION

### 8. QA (`/qa-plan` + `/bug-report` + `/bug-fix`)
- qa-lead test planı üretir
- Bug varsa: yapılandırılmış `/bug-report`, sonra `/bug-fix` döngüyü kapatır

### 9. Standup, Retro, Memory
- `/standup` günlük, `/retro` sprint sonu
- Dersler `.claude/memory/`'ye gider

### 10. Yayım (`/release-check`)
- tech-director: kod, test, deployment, dokümantasyon checklist'i
- Blocking item'lar geçmeli — yoksa NO-GO

---

## Klasör Düzeni

```
projen/
├── CLAUDE.md                       # Her oturumda otomatik yüklenir
├── .claude/
│   ├── settings.json               # İzinler (allow/deny)
│   ├── agents/                     # 12 ajan tanımı
│   ├── commands/                   # 23 slash komut
│   ├── memory/                     # Birikmiş öğrenmeler
│   └── docs/                       # Collaboration, coordination, standards
├── src/                            # Kaynak kod
├── tests/                          # Testler
├── docs/
│   ├── product/                    # Concept, vision (product-manager)
│   ├── analysis/                   # Gereksinim, mevcut sistem (business-analyst)
│   ├── architecture/               # Mimari (tech-director)
│   ├── adr/                        # Architecture Decision Records
│   └── ux/                         # Ekran spec'leri (design-lead)
└── production/
    ├── backlog.md                  # Sıralı story listesi
    ├── stories/                    # Story dosyaları
    ├── sprints/                    # Sprint planları (SXX-yyyy-mm-dd.md)
    ├── retros/                     # Retrospektifler
    ├── qa/
    │   ├── bugs/                   # Bug raporları
    │   └── plan-*.md               # Test planları
    ├── standup-log.md              # Günlük durum
    └── session-state/
        └── active.md               # Oturum context'i
```

---

## Collaboration Protocol

**Direksiyondaki kullanıcı. Ajanlar otonom değil.**

Her görev: **Soru → Seçenek → Karar → Taslak → Onay**

1. **Soru**: ajan bilmediğini sorar
2. **Seçenek**: 2-4 alternatif, artı/eksi
3. **Karar**: sen seçersin
4. **Taslak**: ne yazılacağının önizlemesi
5. **Onay**: "May I write this to [path]?" — açık onay

Ajanlar kendi alanı içinde kalır. Emin değilse yukarı eskalasyon
(specialist → lead → director).

Detay: [.claude/docs/collaboration.md](.claude/docs/collaboration.md)

---

## Dil Desteği

Dürüst çerçeve: bu proje **Claude'un mevcut çoklu-dil yeteneğini
kaldıraçlıyor**, lokalize template göndermiyor. Henüz dil-başına story /
sprint / retro şablonu yok (roadmap'te — aşağıda).

Asıl yaptığı:
- Her ajanın system prompt'unda bir paragraf **Language Protocol** var:
  "kullanıcının dilini algıla ve onunla cevap ver" — davranış takım genelinde
  açık ve tutarlı.
- Tech terms (API, REST, ADR, Docker) İngilizce kalır.
- Kod İngilizce kalır (endüstri standardı).
- Yorum, doküman, sohbet çıktısı kullanıcının dilinde.

**Local'de doğrulanan**: İngilizce, Türkçe.
**Tasarımı destekleyen**: Claude'un kendi desteklediği herhangi bir dil —
İspanyolca, Almanca, Fransızca, Japonca, Arapça, Çince vb. — ama bizim
tarafımızdan doğrulanmadı. Başka dilde kullandıysan
[Discussions](https://github.com/ilkerprdal/Claude-Software-Office/discussions)
üzerinden ekran görüntüsü paylaş.

**Roadmap'te (henüz gönderilmedi)**: lokalize story / sprint / retro
şablon dosyaları (`templates/<lang>/`) — İngilizce-olmayan kullanıcılar
boş İngilizce iskelet yerine kendi dilinde scaffold alsın.

---

## Özelleştirme

Bu bir **template**, kilitli framework değil.

- **Ajan ekle/çıkar**: `.claude/agents/` altına `.md` dosyası
- **Komut ekle/çıkar**: `.claude/commands/` altına `.md` dosyası
- **Ajan davranışını değiştir**: `.md` dosyasındaki system prompt'u düzenle
- **Kuralları sıkılaştır/gevşet**: `.claude/docs/coding-standards.md`
- **İzinler**: `.claude/settings.json`

Dosya ekledikten sonra Claude oturumunu yeniden başlat (yeni dosyaların yüklenmesi için).

---

## SSS

**Cursor / Copilot / Windsurf ile çalışır mı?**
Framework **Claude Code** için yapılmış (`@anthropic-ai/claude-code`).
Diğer AI araçları `CLAUDE.md`'yi kısmen alabilir, ama agent delegation,
slash komutlar ve `Task` çağrıları Claude Code feature'ları. Cursor /
Copilot / Windsurf'tan geçiyorsan `/takeover` o context dosyalarını
memory layer'a import eder.

**23 komutun hepsini kullanmak zorunda mıyım?**
Hayır. Sıfır komutla bile değerin ~%60'ı pasif olarak çalışır:
ajanlar doğal sorularda ("şu kodu review et", "bu bug'ı düzelt")
otomatik tetiklenir, `CLAUDE.md` collaboration protocol'ünü zorlar,
memory oturumlar arası kalır. Komutlar açık workflow disiplini ekler
(sprint, retro, vb.).

**Sprint için fazla küçük bir değişimim var, ne yapayım?**
Üç katman, boyuta göre seç:
- **< 50 LOC, mimari etkisi yok** → `/quick-fix` (story yok, sadece fix + test)
- **50–500 LOC, tek özellik** → `/feature` (story + AC, sprint ceremonisi yok)
- **> 500 LOC, çoklu story** → `/sprint-plan` + `/develop-story` (tam döngü)

**Dilim İngilizce değil. Yine de çalışır mı?**
Evet. Her ajanın bir Language Protocol'ü var — dilini algılar ve onunla
cevap verir. Kod İngilizce kalır (endüstri standardı), ama dokümanlar,
yorumlar ve sohbet senin dilinde olur. İngilizce ve Türkçe ile test edildi.

**Kendi ajan veya komutumu ekleyebilir miyim?**
Evet. `.claude/agents/` veya `.claude/commands/` altına yeni `.md` dosyaları
bırak. Yüklenmeleri için Claude oturumunu yeniden başlat. Format için
[CONTRIBUTING.md](CONTRIBUTING.md)'ye bak.

**Şirketimin mevcut süreciyle çakışır mı?**
20+ kişilik, oturmuş Jira / ADR / retro yapısı olan kurumlarda muhtemelen
çakışır — yukarıdaki "Kimler İçin" bölümüne bak. Solo / küçük takım için
süreç bunun kendisidir; mevcutla çatışmaz.

**Dış servislere çağrı yapıyor mu?**
Hayır. Her şey local dosya + senin Claude Code oturumun. Telemetri yok,
analytics yok. Tek network çağrısı senin kontrolündeki git operasyonları.

**Yeni sürüme nasıl güncellerim?**
Installer'ı tekrar çalıştır (`curl|bash` veya `irm|iex`). `CLAUDE.md`
`CLAUDE.legacy.md` olarak yedeklenir; `.gitignore` merge edilir. Senin
eklediğin custom dosyalar `.claude/agents/` içinde kalır; standart
dosyalar yenilenir.

**Birden fazla geliştirici `.claude/memory/`'i paylaşabilir mi?**
Evet — sadece markdown dosyaları. Diğer proje dokümanları gibi davran:
commit, review, PR'da merge. Çatışmalar markdown satır çatışması olur.

---

## Sorun Giderme

### "Unknown command: /start"

Kurulum öncesi ya da farklı klasörden yazdın. `.claude/commands/start.md`
proje kökünde duruyor mu kontrol et, sonra Claude Code'u yeniden başlat.

### "Ajan yanlış dilde cevap veriyor"

Language Protocol son mesajlardan algılar. Kendi dilinde 1-2 mesaj at,
ajan geçer. Geçmezse `### Language Protocol` bölümünün ajanın `.md`
dosyasında durduğunu kontrol et.

### "Permission denied" — Linux/Mac'te install.sh çalıştırırken

```bash
chmod +x install.sh
bash install.sh
```

Veya executable yapmadan direkt `bash install.sh`.

### "Execution policy" hatası — Windows

`install.ps1` çalışmazsa:
```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Sorun yok — installer sistem state'ini değiştirmiyor.

### "Mevcut CLAUDE.md üzerime yazıldı"

Proje kökünde `CLAUDE.legacy.md` var mı bak — önceki sürümün otomatik
yedeği. Gerekenleri yeniden `CLAUDE.md`'ye merge et.

### "İşi anlattığımda hiç ajan tetiklenmiyor"

Ajan auto-trigger'ı Claude Code sürümüne bağlı. Eski sürümlerde ajanlar
sadece açık `Task` veya slash komutla çalışır. Claude Code'u güncelle:
`npm update -g @anthropic-ai/claude-code` (npm) veya platform
installer'ını tekrar çalıştır.

### "Pre-commit hook frontmatter geçersiz diyor"

Validator'ı çalıştır:
```bash
python scripts/validate.py
```

Hangi dosyada ne eksik söyler. Yaygın düzeltmeler: `description:` alanı
yok, `model:` değeri yanlış (opus/sonnet/haiku/inherit olmalı).

### Başka bir sorun?

[Bug report template](https://github.com/ilkerprdal/Claude-Software-Office/issues/new?template=bug_report.yml)
ile issue aç.

---

## Lisans

MIT
