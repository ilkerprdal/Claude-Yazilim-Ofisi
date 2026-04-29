# Software Office

[![CI](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml/badge.svg)](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/ilkerprdal/Claude-Software-Office)](https://github.com/ilkerprdal/Claude-Software-Office/releases)
[![Validator](https://img.shields.io/badge/frontmatter-validated-brightgreen)](scripts/validate.py)
![Agents](https://img.shields.io/badge/agents-7-blueviolet)
![Commands](https://img.shields.io/badge/commands-9-blue)

Claude Code oturumunu küçük ve düzenli bir yazılım ofisine dönüştürür.
**7 ajan. 9 slash komutu. Tek doğrusal akış. Sprint, retro, standup yok.**

🇬🇧 **English version**: [README.md](README.md)

> **Durum: early preview** (v0.2.x). Yalnızca maintainer'ın makinesinde
> doğrulandı. API'ler (ajan isimleri, komut davranışları, çıktı
> formatları) 1.0'dan önce değişebilir. Topluluk geri bildirimi bekleniyor.
>
> Claude Code Game Studios ve daha geniş Agile-agent ekosisteminden
> (BMAD-METHOD ve diğerleri) ilham alındı. Bilinçli olarak daha dar ve
> daha küçük tutuldu.

---

## İçindekiler

1. [Ne İşe Yarar](#ne-işe-yarar)
2. [Akış](#akış)
3. [Kimler İçin](#kimler-için)
4. [Kurulum](#kurulum)
5. [Takım](#takım)
6. [Slash Komutlar](#slash-komutlar)
7. [Tipik Bir İş Akışı](#tipik-bir-iş-akışı)
8. [Klasör Düzeni](#klasör-düzeni)
9. [Dil Desteği](#dil-desteği)
10. [Özelleştirme](#özelleştirme)

---

## Ne İşe Yarar

Tek bir Claude oturumu güçlüdür ama yapısızdır. Kimse "buna gerçekten
ihtiyacımız var mı?" diye sormaz, kimse code review'ı zorlamaz, kimse
test atladığını fark etmez.

**Software Office** Claude'a sıkı, doğrusal bir takım verir:

- **researcher** konuyu araştırır, kanıt döner (yorum yapmaz)
- **qa** kanıtı test edilebilir bir şartnameye çevirir, sonunda da çıktıyı doğrular
- **tech-lead** şartnameyi task'lara böler, kodu inceler
- **developer** task'ları uçtan uca uygular (paralel çalışan task'lar varsa birden çok developer aynı anda)
- **cto, security-reviewer, devops** on-call — varsayılan akışta YOK, sadece tetikleri ateşlendiğinde devreye girer

Her kararı yine sen verirsin — ama doğru soruları soran, sınırlarını
bilen ve rutin işi tören haline getirmeyen küçük bir takımın içinde.

---

## Akış

```
researcher → qa (analiz) → tech-lead (task'lar) → developer(lar) → tech-lead (review) → qa (doğrulama) → bitti
```

Bu `/feature` — herhangi bir önemli değişiklik için varsayılan yol.

| Yol | Ne zaman | Adımlar |
|---|---|---|
| `/feature` | Varsayılan. Tek satırlık olmayan her değişim. | researcher → qa → tech-lead → developer → tech-lead → qa |
| `/quick-fix` | < 50 LOC, mimari etki yok. | developer + tech-lead göz gezdirmesi |
| `/bug-fix` | Bildirilmiş bug. | researcher → developer → qa (regresyon testi zorunlu) |

**On-call roller** sadece tetik çakınca:

| Rol | Tetik |
|---|---|
| **cto** | Stack seçimi, mimari değişim, breaking API, scope çatışması, release onayı |
| **security-reviewer** | qa risk flag'i (auth / PII / payments / files / migration), pre-release audit |
| **devops** | Task listesinde CI / Docker / deployment / observability işi |

qa veya tech-lead bunları rutin iş için çağırırsa, ilgili rol işi geri
yollar. Akış yalın kalır.

---

## Kimler İçin

### Uygun
- Sıkı, opinionated bir akış isteyen **tek başına geliştirici** veya **küçük takım (2–5)**
- **Mainstream stack**'te (web, REST/GraphQL API, CLI, kütüphane) küçük-orta proje
- **Brownfield projeye** giriyorsan — Cursor / Copilot / Aider geçmişi var. `/takeover` o context'i ileriye taşır.
- Tek AI oturumu üzerinden **uçtan uca** geliştirme

### Yanlış araç
- **Tek seferlik script** (< 100 LOC) — direkt Claude Code daha hızlı
- **Hackathon / zaman kısıtlı sprint** — akış yükü kazandırmaz
- **Oturmuş Jira / sprint / retro süreci olan 20+ kişilik kurum** — bu oraya plug-in olamayacak kadar küçük
- **AI/ML araştırma, embedded firmware, donanım sürücüleri, blockchain protokol tasarımı** — ajan domain bilgisi genel-amaçlı
- Hızlı bir soru için **pair-programming sohbet** — slash-command yükü gereksiz
- **Kurumsal çoklu-takım, 50+ özelleşmiş ajan** ihtiyacı → [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD)

Scrum, sprint, retro, standup arıyorsan — onlar bu sürümde gitti. Bu
artık bir **akış framework'ü**, Agile framework'ü değil.

---

## Kurulum

Üç yol.

### A. Plugin install (Claude Code 2.x)

Bir Claude Code oturumunda:

```
/plugin marketplace add ilkerprdal/Claude-Software-Office
/plugin install claude-software-office@claude-software-office-marketplace
```

`/plugin update` ile otomatik güncelleme, kullanıcı veya proje seviyesinde scope.

### B. Tek satır

**macOS / Linux / Git Bash on Windows:**
```bash
curl -fsSL https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.ps1 | iex
```

Projenin kök klasöründen çalıştır. `.claude/`, `CLAUDE.md`, `.gitignore`
ve `production/` iskeletini kurar. Mevcut `CLAUDE.md` `CLAUDE.legacy.md`
olarak yedeklenir.

### C. Manuel

```bash
git clone https://github.com/ilkerprdal/Claude-Software-Office.git
cd projen
bash /path/to/Claude-Software-Office/install.sh        # Mac/Linux
.\path\to\Claude-Software-Office\install.ps1           # Windows
```

Veya `.claude/` ve `CLAUDE.md` dosyalarını klonladığın repo'dan elle kopyala.

### Kurulumdan sonra

```bash
claude
/start         # veya prior AI context'in varsa /takeover
```

Ajanlar dilini otomatik algılar (doğrulanan: İngilizce, Türkçe).

---

## Takım

```
On-call (Opus)
└── cto                 → stack, mimari, breaking change, release onayı

Akışta (Sonnet)
├── researcher          → konuyu araştırır, kanıt döner (yorum yok)
├── qa                  → şartname + AC + test planı, sonra sonucu doğrular
├── tech-lead           → task'lara böler, kodu inceler
└── developer           → uçtan uca uygular (backend, frontend, test)

On-call (Sonnet, security-reviewer Opus)
├── security-reviewer   → qa risk flag'inde STRIDE / OWASP audit
└── devops              → CI/CD, deployment, observability gerektiğinde
```

### Nasıl çalışır

- **Doğrusal delegasyon**: her adım bir öncekinin çıktısını tüketir. "İstediğin zaman istediğine sor" yok.
- **Paralel developer**: tech-lead paralelize edilebilir task'ları işaretler; aynı dosyaya dokunmayan birden çok developer aynı anda koşar.
- **Çatışmalar yukarı çıkar**: kod yapısı → tech-lead, test yeterliliği → qa, daha büyük her şey → cto.
- **On-call roller işi geri yollar** rutin iş için çağrıldıklarında. Onlar darboğaz değil, koruma.

---

## Slash Komutlar

| Komut | Amaç | Çağırır |
|---|---|---|
| **Onboarding** | | |
| `/start` | Stack + durum algıla, sıradakini öner | — |
| `/takeover` | Önceki AI context'i (Cursor / Copilot / Windsurf / Aider) import et | — |
| `/help` | Akıllı öneri + komut listesi | — |
| **Build** | | |
| `/feature` | Herhangi bir değişim için varsayılan akış | researcher → qa → tech-lead → developer |
| `/quick-fix` | Ufak değişim, akışı atla | developer + tech-lead |
| `/bug-fix` | Bul, düzelt, regresyon testi yaz | researcher → developer → qa |
| **Kapılar** | | |
| `/security-review` | İsteğe bağlı güvenlik denetimi (STRIDE + OWASP) | security-reviewer |
| `/release-check` | Release öncesi GO / NO-GO | cto |
| **Bilgi** | | |
| `/memory` | Proje öğrenmelerini gör / ekle | — |

---

## Tipik Bir İş Akışı

Bir TODO uygulamasında parola sıfırlama ekliyorsun:

### 1. Başlat (`/feature add password reset`)

Akış başlar. Beş adım:

### 2. researcher
- Codebase'i tarar: auth nerede, e-posta nasıl gönderiliyor, hangi e-posta kütüphanesi kurulu?
- Auth alanındaki önceki olayları not eder
- Döner: dosya işaretçileri + açık sorular. Yaklaşım önermez.

### 3. qa (analiz)
- researcher'ın brifini + senin isteğini okur
- Hipotez + 5 AC yazar (token isteği, geçerlilik penceresi, tek-kullanım, error mesajları account enumeration yapmaz, token-in-URL güvenli)
- Test planı: 3 unit + 2 integration. Risk flag çakar (auth) → security-reviewer kuyruğa alınır.
- Çıktı: `production/qa/spec-password-reset.md`

### 4. security-reviewer (risk flag tetikledi)
- Akış üzerinde STRIDE, OWASP A01/A04/A07 spot-check
- Bulgular (token entropy, account enumeration, log içeriği) şartnameye eklenir

### 5. tech-lead (task'lar)
- Şartnameyi 4 task'a böler, ikisi paralelize edilebilir
- Çıktı: `production/stories/password-reset.md` — her task için adı geçen dosyalar

### 6. developer (uygular)
- Her task: kod + test birlikte; testler koşar; rapor verilir
- Adı geçen dosyalarda kalır; scope sızarsa üst yönlendirme yapar

### 7. tech-lead (review)
- Kalite barları, AC kapsamı, security smoke
- Verdict: `APPROVE_WITH_NITS` (bir nit: log mesaj ifadesi)
- Developer nit'i düzeltir

### 8. qa (doğrulama)
- Her AC'yi kanıtla yürür; testler geçer
- GATE: PASS
- Çıktı: `production/qa/validation-password-reset.md`

### 9. Bitti

Standup yok. Retro yok. Sprint roll-over yok. Feature qa GATE = PASS olunca biter.

Release için: `/release-check` — cto kapıyı yürür ve GO/NO-GO onayı verir.

---

## Klasör Düzeni

```
projen/
├── CLAUDE.md                       # Her oturumda otomatik yüklenir
├── .claude/
│   ├── settings.json               # İzinler (allow/deny)
│   ├── agents/                     # 7 ajan tanımı
│   ├── commands/                   # 9 slash komut
│   ├── memory/                     # Birikmiş öğrenmeler
│   └── docs/                       # Coordination, collaboration, standards
├── src/                            # Kaynak kod
├── tests/                          # Testler
├── docs/
│   ├── architecture/               # cto'nun mimari dokümanları
│   ├── adr/                        # Architecture Decision Records
│   ├── api/                        # OpenAPI / GraphQL SDL / .proto
│   └── security/                   # security-reviewer threat model'leri
└── production/
    ├── qa/
    │   ├── spec-*.md               # qa Mode A şartnameleri
    │   ├── validation-*.md         # qa Mode B doğrulamaları
    │   ├── bugs/                   # bug raporları
    │   └── security-review-*.md
    ├── stories/                    # tech-lead task breakdown'ları
    ├── releases/                   # cto GO/NO-GO kararları
    └── session-state/
        └── active.md               # oturum context'i
```

`sprints/`, `retros/`, `standup-log.md` yok — bunlar gitti.

---

## Dil Desteği

Bu proje **Claude'un mevcut çoklu-dil yeteneğini kaldıraçlıyor**, lokalize
template göndermiyor.

Asıl yaptığı:
- Her ajanın bir **Language Protocol**'ü var: "kullanıcının dilini algıla ve onunla cevap ver" — davranış takım genelinde açık ve tutarlı.
- Tech terms (API, REST, ADR, Docker) İngilizce kalır.
- Kod İngilizce kalır (endüstri standardı).
- Yorum, doküman, sohbet kullanıcının dilinde.

**Local'de doğrulanan**: İngilizce, Türkçe.
**Tasarımı destekleyen**: Claude'un kendi desteklediği herhangi bir dil — ama bizim tarafımızdan doğrulanmadı.
Başka dilde kullandıysan
[Discussions](https://github.com/ilkerprdal/Claude-Software-Office/discussions)
üzerinden ekran görüntüsü paylaş.

---

## Özelleştirme

Bu bir **template**, kilitli framework değil.

- **Ajan ekle/çıkar**: `.claude/agents/` altına `.md` dosyası
- **Komut ekle/çıkar**: `.claude/commands/` altına `.md` dosyası
- **Ajan davranışını değiştir**: `.md` dosyasındaki system prompt'u düzenle
- **Kuralları sıkılaştır/gevşet**: `.claude/docs/coding-standards.md`
- **İzinler**: `.claude/settings.json`

Dosya ekledikten sonra Claude oturumunu yeniden başlat.

---

## SSS

**Sprint, retro, standup, story point'lere ne oldu?**
v0.2'de gittiler. Önceki kurulum 13 ajan ve 24 komutla full Scrum süreci
modelliyordu. Solo / küçük takım için bu değer değil yüktü. Bu sürüm bir
**akış framework'ü**, Agile framework'ü değil. Sprint ceremony lazımsa daha
ağır bir araç kullan — yukarıdaki "Yanlış araç" bölümüne bak.

**Cursor / Copilot / Windsurf ile çalışır mı?**
Framework **Claude Code** için yapılmış (`@anthropic-ai/claude-code`).
Diğer AI araçları `CLAUDE.md`'yi kısmen alabilir, ama agent delegation,
slash komutlar ve `Task` çağrıları Claude Code feature'ları. `/takeover`
o context dosyalarını memory layer'a import eder.

**Değişimim `/feature` için fazla küçük.**
`/quick-fix` kullan (< 50 LOC, mimari etkisi yok). researcher ve
qa-analizini atlar — direkt developer'a gider, tech-lead göz gezdirir.

**Dilim İngilizce değil. Yine de çalışır mı?**
Evet. Her ajanın bir Language Protocol'ü var — dilini algılar ve onunla
cevap verir. Kod İngilizce kalır (endüstri standardı), ama dokümanlar,
yorumlar ve sohbet senin dilinde olur. İngilizce ve Türkçe ile test edildi.

**Kendi ajan veya komutumu ekleyebilir miyim?**
Evet. `.claude/agents/` veya `.claude/commands/` altına yeni `.md` dosyaları
bırak. Yüklenmeleri için Claude oturumunu yeniden başlat. Format için
[CONTRIBUTING.md](CONTRIBUTING.md)'ye bak.

**Şirketimin mevcut süreciyle çakışır mı?**
Oturmuş Jira / sprint / retro süreci olan herhangi bir kurumda muhtemelen
çakışır — bu onları modellemeye çalışmıyor. Solo / küçük takım için süreç
*budur*.

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

### "Execution policy" hatası — Windows

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Installer sistem state'ini değiştirmiyor.

### "Mevcut CLAUDE.md üzerime yazıldı"

Proje kökünde `CLAUDE.legacy.md` var mı bak — önceki sürümün otomatik
yedeği. Gerekenleri yeniden `CLAUDE.md`'ye merge et.

### "Pre-commit hook frontmatter geçersiz diyor"

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
