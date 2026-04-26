---
description: "Bir dosya veya degisiklik setini standart, mimari ve test acisindan inceler. 'Kod review', 'PR incele', 'kod kalitesi kontrol', 'review yap' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Bash
argument-hint: '[dosya yolu veya bos - son degisiklik seti]'
---

# /kod-inceleme

`yazilim-lideri` ajanını devreye al.

### Kontrol Listesi

**Kod Kalitesi**
- [ ] İsimlendirme anlaşılır mı?
- [ ] Fonksiyonlar tek sorumluluk mu?
- [ ] Kopya kod / tekrar var mı?
- [ ] Magic number / hardcoded değer var mı?

**Mimari Uyum**
- [ ] Katman sınırları korunmuş mu? (UI ↔ iş mantığı ↔ veri)
- [ ] İlgili ADR'ye uyuyor mu?
- [ ] Public API değişti mi? (dokümante edildi mi?)

**Test**
- [ ] Hikayenin kabul kriterleri test ediliyor mu?
- [ ] Kenar durumlar kapsanmış mı?
- [ ] Testler deterministik mi?

**Güvenlik & Hata**
- [ ] Kullanıcı girdisi doğrulanıyor mu?
- [ ] Sırlar kod içine sızmış mı?
- [ ] Hata mesajları içeriden bilgi sızdırıyor mu?

### Çıktı

Markdown rapor: **ONAYLANDI / DÜZELTME GEREKLİ / BÜYÜK REVİZYON**
Her bulgu için dosya:satır referansı ver.
