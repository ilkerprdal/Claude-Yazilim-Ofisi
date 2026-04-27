---
description: "Projeye özel öğrenilen dersleri görüntüle veya ekle. Her oturumda yüklenir, ajanlar tutarlı davranır. 'Memory', 'öğrenilen dersler', 'proje notları', 'şunu hatırla' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
argument-hint: "[opsiyonel: 'goster' | 'ekle' | 'temizle']"
---

# /memory

`.claude/memory/` altında biriken proje-özel öğrenmeler. Bunlar her oturumda
`CLAUDE.md` üzerinden otomatik yüklenir → ajanlar tutarlı davranır.

### Modlar

#### `/memory goster` (varsayılan)
Mevcut tüm öğrenmeleri kategoride listele:

```
## Teknik Tercihler
- HTTP istemci olarak `httpx` (requests yerine) — async destek
- Loglar JSON formatta — analiz kolaylığı

## Kaçınılacaklar
- Direkt SQL çalıştırma — her zaman ORM
- Setting'leri os.environ'dan değil config sınıfından al

## İş Süreci
- PR'lar 200 satırı geçmesin
- Her bug fix'e regresyon testi
```

#### `/memory ekle [kategori] [not]`
Yeni öğrenmeyi `.claude/memory/[kategori].md` dosyasına ekle.

Kategoriler:
- `teknik` — kütüphane, pattern, mimari tercihler
- `kacinilacak` — yapılmaması gerekenler
- `surec` — iş süreci kuralları
- `domain` — alana özel terim/kural
- `araclar` — kullanılan araçlar/ayarlar

#### `/memory temizle`
Eski/güncelliğini yitirmiş notları kullanıcıyla beraber gözden geçir.

### Otomatik Tetiklenme

Bu komutu **kullanıcı çağırmadan** da düşün:
- Retrospektifte iyi giden bir şey öğrenildiyse → `/memory ekle surec`
- ADR yazıldığında → `/memory ekle teknik` ile özet ekle
- Tekrarlanan bir hata gözlemlendiyse → `/memory ekle kacinilacak`

### Format

`.claude/memory/[kategori].md` dosyaları:

```markdown
# [Kategori Adı]

- [yyyy-mm-dd] [Not] — [kaynak: ADR-005 / retro-S03 / vs]
- [yyyy-mm-dd] [Not] — [kaynak]
```

CLAUDE.md'den `@.claude/memory/teknik.md` gibi yüklenir.

### Çıktı

```
STATUS: COMPLETED
ACTION: GOSTER | EKLE | TEMIZLE
KATEGORI: [varsa]
EKLENDI: [yeni notlar]
TOPLAM_NOT_SAYISI: [memory'deki toplam]
```
