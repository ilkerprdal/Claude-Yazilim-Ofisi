# Memory — Proje Öğrenmeleri

Bu klasör projeye özel birikmiş öğrenmeleri tutar. Her dosya bir kategori.

`/memory` komutuyla yönetilir. CLAUDE.md'den otomatik yüklenir.

## Kategoriler (varsayılan)

- `teknik.md` — kütüphane, pattern, mimari tercihler
- `kacinilacak.md` — yapılmaması gerekenler
- `surec.md` — iş süreci kuralları
- `domain.md` — alana özel terim/kural
- `araclar.md` — kullanılan araçlar/ayarlar

Boş kategoriler oluşturulmasına gerek yok — `/memory ekle` komutu kategori
dosyasını otomatik oluşturur.

## Format

Her satır bir not, başında tarih + kaynak:

```
- [yyyy-mm-dd] Not metni — kaynak: ADR-005
- [yyyy-mm-dd] Başka not — kaynak: retro-S03
```

## Örnek

`teknik.md`:
```
# Teknik Tercihler

- [2026-04-26] HTTP istemci olarak `httpx` (requests yerine) — async destek — kaynak: ADR-003
- [2026-04-26] Loglar JSON formatta — kaynak: retro-S01
```
