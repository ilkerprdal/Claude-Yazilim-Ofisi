# Yazılım Ofisi

Claude Code oturumunu küçük ve düzenli bir yazılım ofisine dönüştürür.
**10 ajan. 17 slash komut. Sade ve Agile bir ekip.**


---

## İçindekiler

1. [Bu Ne İşe Yarar](#bu-ne-işe-yarar)
2. [Kurulum](#kurulum)
3. [Nasıl Çalışır](#nasıl-çalışır)
4. [Ekip (Ajanlar)](#ekip-ajanlar)
5. [Slash Komutlar](#slash-komutlar)
6. [Tipik Bir Akış](#tipik-bir-akış)
7. [Klasör Yapısı](#klasör-yapısı)
8. [İşbirliği Protokolü](#işbirliği-protokolü)
9. [Özelleştirme](#özelleştirme)
10. [Sınırlar](#sınırlar)

---

## Bu Ne İşe Yarar

Tek bir Claude oturumu güçlüdür ama yapısızdır. Kimse "bu gerçekten gerekli
mi?" diye sormaz, kod incelemesi yapmaz, test atlamanı engellemez.

**Yazılım Ofisi** Claude'a küçük bir ekip yapısı verir:

- **Karar verenler** (Direktörler): vizyon ve teknik kalite
- **Uygulayanlar** (Liderler): kod yapısı, UX, kalite
- **Yapanlar** (Uzmanlar): backend, frontend, devops kodu

Siz yine her kararı verirsiniz — ama doğru soruları soran, sınırlarını bilen
ve birbirine danışan bir ekibin arasında.

---

## Kurulum

**Tek dosya: `yazilim-ofisi-kur.bat`**

1. Bu .bat dosyasını projenizin **kök klasörüne** kopyalayın
2. Çift tıklayın
3. "e" yazıp Enter
4. Tamam — `.bat`'i silebilirsiniz

`.bat` içinde 8 ajan, 10 komut, dokümanlar ve ayarlar gömülü olarak gelir.
Hiçbir başka dosyaya bağımlılık yoktur. USB'ye atın, mail atın, herhangi bir
Windows makinesinde çalışır (PowerShell hazır gelir).

Kurulumdan sonra proje klasöründe:

```bash
claude
/basla
```

---

## Nasıl Çalışır

Yazılım Ofisi üç sistem üzerine kuruludur:

### 1. Slash Komutlar (`/komut`)

`.claude/commands/` altındaki her `.md` dosyası bir slash komuttur.
Chat'te `/` yazınca otomatik tamamlanır.

Komut dosyası iki bölümden oluşur:

```markdown
---
description: "Komutun ne yaptığını anlatan tek satır"
---

[Komut çağrıldığında Claude'un takip edeceği talimatlar]
```

Komutu çağırdığında Claude, dosyanın gövdesini bir görev tanımı olarak
okur ve adımları takip eder. Çoğu komut "şu ajanı devreye al" diye başlar.

### 2. Ajanlar (Subagent)

`.claude/agents/` altındaki her `.md` dosyası bir uzmanlaşmış alt-ajandır.
Her ajan kendi alanını bilir, sınırlarını bilir.

Ajan dosyasının yapısı:

```markdown
---
name: ajan-adi
description: "Ne zaman bu ajan kullanılmalı"
tools: Read, Write, Edit, ...    # erişebileceği araçlar
model: opus / sonnet              # model atama
---

[Ajanın sistem prompt'u — sorumluluklar, kurallar, sınırlar]
```

Bir komut "ajan-adi devreye al" derse, Claude o ajanın sistem prompt'unu
yükleyip görevi onun bakış açısıyla yapar. Ajan kendi sınırı dışına
çıkamaz — örneğin `backend-gelistirici` UI dosyasına dokunmaz.

### 3. CLAUDE.md ve Yapılandırma

Proje köküne kopyalanan `CLAUDE.md` dosyası **her oturumda otomatik
yüklenir**. Burada:

- Teknoloji yığını
- Klasör yapısı
- İşbirliği protokolü
- Kodlama standartları (`@` ile referansla yüklenir)

bulunur. Yani Claude her oturuma "bu projede nasıl çalışıyoruz" bilgisiyle
girer.

`.claude/settings.json` izinleri kontrol eder: hangi komutlar otomatik
çalışsın, hangileri yasak (örnek: `rm -rf` yasak, `.env` okuması yasak).

---

## Ekip (Ajanlar)

```
Direktörler (Opus modeli)
├── teknik-direktor       → mimari, teknoloji seçimi, teknik çatışma
└── urun-yoneticisi       → kapsam, öncelik, ürün kararı

Liderler (Sonnet modeli)
├── yazilim-lideri        → kod yapısı, API, kod review
├── qa-lideri             → test stratejisi, kalite kapısı
├── tasarim-lideri        → UX, ekran tasarımı, kullanıcı akışı
├── is-analisti           → gereksinim, mevcut sistem analizi, süreç
└── scrum-master          → sprint, standup, retro, backlog yönetimi

Uzmanlar (Sonnet modeli)
├── backend-gelistirici   → API, servis, DB, iş mantığı
├── frontend-gelistirici  → UI bileşenleri, ekranlar
└── devops                → CI/CD, dağıtım, ortam
```

### Hiyerarşi Nasıl Çalışır

- **Dikey delege**: Direktör → Lider → Uzman. Direktör doğrudan uzmana
  delege etmez (liderden geçer).
- **Yatay danışma**: Aynı katman birbirine sorar ama karar veremez.
  Backend ↔ Frontend API sözleşmesi konuşur, ama mimari kararı
  yazilim-lideri verir.
- **Çatışma**: Tasarım çatışması → urun-yoneticisi.
  Teknik çatışma → teknik-direktor.

---

## Slash Komutlar

| Komut | Ne Yapar | Hangi Ajan |
|-------|----------|------------|
| **Onboarding** | | |
| `/basla` | Akıllı: aşama + tech stack tespit, yönlendir | — |
| `/yardim` | Bağlamlı yardım: en mantıklı sonraki komutu öner | — |
| **Tasarım** | | |
| `/fikir` | Proje/özellik fikrini konsept dokümanına çevir | urun-yoneticisi |
| `/analiz` | Gereksinim toplama / mevcut sistem analizi | is-analisti |
| `/mimari` | Teknik mimari + ADR | teknik-direktor |
| **Sprint (Agile)** | | |
| `/hikaye-olustur` | Mimariden uygulanabilir hikayelere böl | urun-yoneticisi |
| `/backlog` | Backlog refinement | scrum-master |
| `/sprint-plan` | Sprint planlama (kapasite + hikaye seçimi) | scrum-master |
| `/standup` | Günlük durum + engel raporu | scrum-master |
| `/retro` | Sprint retrospektifi | scrum-master |
| **Geliştirme** | | |
| `/hikaye-gelistir` | Bir hikayeyi uçtan uca uygula | backend/frontend |
| `/kod-inceleme` | Kod kalite/mimari/test incelemesi | yazilim-lideri |
| **QA** | | |
| `/qa-plan` | Sprint veya özellik için test planı | qa-lideri |
| `/hata-raporu` | Yapılandırılmış bug raporu | qa-lideri |
| `/hata-duzelt` | QA→Dev→QA bug fix döngüsü | bug sahibi |
| **Karar / Bilgi** | | |
| `/danisma` | Çoklu ajan paralel danışma (party mode) | (panel) |
| `/memory` | Proje öğrenmelerini yönet | — |
| `/surum-kontrol` | Sürüm öncesi go/no-go kontrol listesi | teknik-direktor |

Her komut çağrıldığında Claude:

1. Komut dosyasının gövdesini okur
2. İlgili ajanı (varsa) devreye alır
3. Sırayla soru sorar, seçenek sunar
4. Onayınızı alıp dosya oluşturur

---

## Tipik Bir Akış

Yeni bir TODO uygulaması yaptığınızı düşünün:

### 1. Konsept (`/fikir`)
- urun-yoneticisi: "Hangi problemi çözüyoruz? Kim kullanacak?"
- Sen yanıtlarsın, o seçenek üretir, sen seçersin
- Çıktı: `docs/urun/konsept.md`

### 2. Gereksinim Analizi (`/analiz`)
- is-analisti: paydaş soruları, FR/NFR/kısıt listesi
- Mevcut sistem varsa: modüller, bağımlılıklar, etki bölgeleri
- Çıktı: `docs/analiz/gereksinimler.md` (veya `mevcut-sistem.md`)

### 3. Mimari (`/mimari`)
- teknik-direktor: "Web mi mobil mi? Hangi backend? DB?"
- Her bölüm için 2-3 seçenek + artı/eksi
- Çıktı: `docs/architecture/mimari.md` + `docs/adr/0001-*.md`

### 4. Hikayelere Bölme (`/hikaye-olustur`)
- urun-yoneticisi mimariye bakıp hikaye listesi önerir
- Çıktı: `production/stories/001-kullanici-girisi.md`,
  `002-todo-listesi.md`, `003-todo-ekleme.md`...

### 5. Hikaye Geliştirme (`/hikaye-gelistir 001`)
- yazilim-lideri hikayeyi okur, doğru uzmana yönlendirir
- backend-gelistirici (örn.) dosya listesi sunar, onay alır
- Kod + birim test aynı anda yazılır
- Test çalıştırılır, kabul kriterleri tek tek işaretlenir

### 6. Kod İnceleme (`/kod-inceleme`)
- yazilim-lideri kod kalitesi, mimari uyum, test yeterliliği inceler
- Markdown rapor: ONAYLANDI / DÜZELTME / BÜYÜK REVİZYON

### 7. QA (`/qa-plan` + `/hata-raporu`)
- qa-lideri test planı çıkarır
- Hata bulunursa `/hata-raporu` ile yapılandırılmış kayıt

### 8. Sürüm (`/surum-kontrol`)
- teknik-direktor: kod, test, dağıtım, doküman kontrol listesi
- Bloklayıcı kalemler geçmeden GO denmez

---

## Klasör Yapısı

```
projen/
├── CLAUDE.md                       # Her oturumda yüklenen ana yapılandırma
├── .claude/
│   ├── settings.json               # İzinler (allow/deny)
│   ├── agents/                     # 8 ajan tanımı
│   │   ├── teknik-direktor.md
│   │   ├── urun-yoneticisi.md
│   │   └── ...
│   ├── commands/                   # 10 slash komut
│   │   ├── basla.md
│   │   ├── fikir.md
│   │   └── ...
│   ├── skills/                     # Aynı şeyin skill formatı (yedek)
│   └── docs/                       # İşbirliği, koordinasyon, kodlama std.
├── src/                            # Kaynak kod
├── tests/                          # Testler
├── docs/                           # Mimari, ADR, ürün dokümanı
│   ├── urun/                       # Konsept, vizyon (urun-yoneticisi)
│   ├── analiz/                     # Gereksinim, mevcut sistem (is-analisti)
│   ├── architecture/               # Mimari (teknik-direktor)
│   ├── adr/                        # Architecture Decision Records
│   └── ux/                         # Ekran spec'leri (tasarim-lideri)
└── production/
    ├── backlog.md                  # Sıralı hikaye listesi
    ├── stories/                    # Hikaye/task dosyaları
    ├── sprints/                    # Sprint planları (SXX-yyyy-mm-dd.md)
    ├── retros/                     # Sprint retrospektifleri
    ├── qa/
    │   ├── hatalar/                # Bug raporları
    │   └── plan-*.md               # Test planları
    ├── standup-log.md              # Günlük durum kayıtları
    └── session-state/
        └── active.md               # Oturum bağlamı

.claude/memory/                     # Birikmiş proje öğrenmeleri (CLAUDE.md ile yüklenir)
├── teknik.md                       # Kütüphane, pattern tercihleri
├── kacinilacak.md                  # Yapılmaması gerekenler
├── surec.md                        # İş süreci kuralları
├── domain.md                       # Alana özel terim/kural
└── araclar.md                      # Kullanılan araçlar
```

---

## İşbirliği Protokolü

**Kullanıcı sürücü koltuğunda. Ajanlar otonom değil.**

Her görev şu sırayı izler:

```
Soru → Seçenekler → Karar → Taslak → Onay
```

1. **Soru**: Ajan bilmediğini sorar, varsaymaz
2. **Seçenekler**: 2-4 alternatif, artı/eksi ile
3. **Karar**: Sen seçersin
4. **Taslak**: Yazılacak şeyin önizlemesi
5. **Onay**: "Bunu şu dosyaya yazayım mı?" — açık onay

Ajanlar kendi alanları dışına çıkamaz. Şüphede yukarı sorarlar
(uzman → lider → direktör).

Detay: [.claude/docs/isbirligi.md](.claude/docs/isbirligi.md)

---

## Özelleştirme

Bu bir **şablondur**, kilitli sistem değil.

- **Ajan ekle/çıkar**: `.claude/agents/` altında `.md` dosyası
- **Komut ekle/çıkar**: `.claude/commands/` altında `.md` dosyası
- **Ajan davranışı değiştir**: ilgili ajanın `.md`'sindeki sistem prompt'u düzenle
- **Kuralları sıkılaştır/gevşet**: `.claude/docs/kodlama-standartlari.md`
- **İzinler**: `.claude/settings.json`

Bir dosya eklediğinde Claude oturumunu yeniden başlat (yeni dosyalar
yüklensin diye).

---

## Sınırlar

Bu sistem **kararları senin yerine vermez**. Her aşamada onay ister.
Otomatik commit, otomatik push, otomatik dağıtım yoktur — bunları sen
açıkça istersin.

Önerilen kullanım:
- Solo veya küçük ekip projelerinde
- MVP / prototip / orta ölçekli projelerde
- Düzeni/disiplini hatırlatan dış bir kuvvet istediğinde

Önerilmeyen kullanım:
- Çok büyük kurumsal projelerde (kendi süreciniz vardır)
- Ajanların alan bilgisini test etmediğin domain'lerde
  (örn. embedded, gömülü güvenlik) — önce küçük bir görevle dene

---

## Lisans

MIT
