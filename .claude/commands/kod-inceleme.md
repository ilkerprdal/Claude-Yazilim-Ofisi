---
description: "Bir dosya veya değişiklik setini kod standardı, mimari uyum, test yeterliliği açısından incele."
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
