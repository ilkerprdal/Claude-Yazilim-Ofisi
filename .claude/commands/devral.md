---
description: "Mevcut projeyi devral - Claude'un (veya başka AI'ın) birikmiş hafıza/bağlam dosyalarını oku, .claude/memory/'ye dönüştür, projenin şu anki durumunu özetle. 'Bu projeyi devral', 'context.md var oku', 'önceki notları topla', 'devraldım' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
argument-hint: "[opsiyonel: belirli bir bağlam dosyasının yolu]"
---

# /devral

Önceki AI oturumlarından (Claude, Cursor, Copilot, Windsurf vb.) kalan
bağlam dosyalarını oku, anla, kendi sistemimize aktar.

### Amaç

Yeni bir projeye Yazılım Ofisi kurulduğunda, **eski bağlam kaybolmasın**.
Önceki notlar `.claude/memory/` altına dönüştürülür, ajanlar bu bilgilerle
çalışır.

### Adımlar

#### 1. Bağlam Kaynaklarını Tara

Şu dosyaları sırayla ara (var olanları listele):

**Genel bağlam dosyaları**:
- `context.md`, `CONTEXT.md`
- `MEMORY.md`, `NOTES.md`, `AGENTS.md`
- `docs/CONTEXT.md`, `docs/STATE.md`, `docs/MEMORY.md`
- `STATE.md`, `PROJECT.md`

**AI aracı kuralları**:
- `CLAUDE.md` (varsa — bizimkiyle çakışmasın!)
- `.cursorrules`, `.cursor/rules/*.mdc`
- `.windsurfrules`, `.windsurf/rules/*.md`
- `.github/copilot-instructions.md`
- `.aider.conf.yml`, `.aiderignore`
- `.continue/config.json`, `.continuerules`

**Proje meta dosyaları**:
- `README.md` (zaten okuyacağız)
- `ARCHITECTURE.md`, `DESIGN.md`
- `CHANGELOG.md` (son 20 kayıt)
- `TODO.md`, `ROADMAP.md`

Bulunanları liste:
```
Bulduklarım:
✓ context.md (1240 satır)
✓ .cursorrules (45 satır)
✓ docs/ARCHITECTURE.md (320 satır)
✓ TODO.md (78 satır)
✗ CLAUDE.md (yok — sorun değil)
```

#### 2. Çakışma Kontrolü

Eğer `CLAUDE.md` projede ZATEN varsa:
- Bizimkiyle merge edilmeli, üzerine yazılmamalı
- Kullanıcıya sor:
  - "Mevcut CLAUDE.md'yi `CLAUDE.legacy.md` olarak yedekleyeyim, yenisini bizimki + senin notların olarak birleştireyim mi?"

#### 3. İçerik Tasnifi

Bulunan tüm içeriği şu kategorilere ayır (kullanıcıya göster, doğrulat):

| Kategori | Hedef Memory Dosyası |
|----------|---------------------|
| Teknik tercihler (kütüphane, pattern, mimari) | `.claude/memory/teknik.md` |
| Yapılmaması gerekenler / antipattern'ler | `.claude/memory/kacinilacak.md` |
| İş süreci kuralları (PR boyutu, naming, vb.) | `.claude/memory/surec.md` |
| Domain/iş alanı terimleri | `.claude/memory/domain.md` |
| Araçlar/komutlar/CLI ayarları | `.claude/memory/araclar.md` |
| Tamamlanan işler özeti | `production/session-state/active.md` |
| Açık görevler / TODO'lar | `production/backlog.md` |

#### 4. Proje Durum Özeti Çıkar

`production/session-state/active.md` içine **Devralma Özeti** yaz:

```markdown
# Devralma Özeti — [yyyy-mm-dd]

## Önceki Çalışma
- Hangi alanda ilerlenmiş?
- Hangi dosyalar dokunulmuş (git log son 30)?
- Hangi özellikler tamamlanmış?

## Açık İşler
- [TODO.md'den, context'ten gelen]

## Mevcut Durum
- Aktif branch: [git branch]
- Son commit: [git log -1]
- Açık dal sayısı: [git branch | wc -l]

## Riskler / Dikkat Edilecekler
- [Önceki notlardaki uyarılar]

## Kaynak Dosyalar
- context.md, .cursorrules, docs/ARCHITECTURE.md (yedeklendi: `.devraldim/`)
```

#### 5. Orijinal Dosyaları Yedekle

Hiçbir şeyi silme — `.devraldim/` klasörü oluştur, orijinal context dosyalarını
oraya **kopyala** (taşıma değil). Kullanıcı isterse silebilir, istemezse referans kalır.

```
.devraldim/
├── context.md
├── .cursorrules.txt
├── docs-ARCHITECTURE.md
└── README.md (devralma raporu)
```

#### 6. Kullanıcıyı Yönlendir

Devralma bitince:
- "Memory'ye N öğrenme eklendi"
- "active.md'de proje durumu hazır"
- "Sonraki adım için `/yardim` veya `/basla` çalıştır"

### Kurallar

- **Hiçbir şeyi silme** — kaynak dosyalar `.devraldim/`'e kopyalanır
- **Çakışmada üzerine yazma** — `.legacy.md` olarak yedekle
- **Karar kullanıcıya** — her tasnif için onay al
- **Çevir, eskime alma** — Türkçe memory'mize aktarken kısalt, özünü tut

### Çıktı

```
STATUS: COMPLETED | NEEDS_INPUT
SOURCES_FOUND: [bulunan dosyalar]
MEMORY_NOTES_ADDED: [her kategoride kaç not]
ACTIVE_MD_UPDATED: YES | NO
BACKUP_LOCATION: .devraldim/
CONFLICTS: [varsa, çözüm yolu]
NEXT: /basla veya /yardim
```
