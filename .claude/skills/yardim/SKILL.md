---
name: yardim
description: "Kullanılabilir komutları ve temel iş akışını göster."
user-invocable: true
model: haiku
---

# /yardim

### Akış Sırası

```
/basla → /fikir → /analiz → /mimari → /hikaye-olustur → /hikaye-gelistir
                                                              ↓
                              /kod-inceleme ← /qa-plan → /surum-kontrol
                                                              ↓
                                                       /hata-raporu
```

### Tüm Komutlar

| Komut | Ne Yapar | Ajan |
|-------|----------|------|
| `/basla` | Aşama tespiti + yönlendirme | - |
| `/fikir` | Proje fikri geliştirme | urun-yoneticisi |
| `/analiz` | Gereksinim / mevcut sistem analizi | is-analisti |
| `/mimari` | Teknik mimari dokümanı | teknik-direktor |
| `/hikaye-olustur` | Mimariden hikayelere | urun-yoneticisi |
| `/hikaye-gelistir` | Hikayeyi uygula | backend/frontend |
| `/kod-inceleme` | Kod review | yazilim-lideri |
| `/qa-plan` | Test planı | qa-lideri |
| `/hata-raporu` | Yapılandırılmış bug raporu | qa-lideri |
| `/surum-kontrol` | Sürüm hazırlık listesi | teknik-direktor |
| `/yardim` | Bu ekran | - |

### Ajanlar

**Direktörler**: teknik-direktor, urun-yoneticisi
**Liderler**: yazilim-lideri, qa-lideri, tasarim-lideri, is-analisti
**Uzmanlar**: backend-gelistirici, frontend-gelistirici, devops
