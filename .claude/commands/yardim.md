---
description: "Akıllı yardım - projenin durumuna bakıp en mantıklı sonraki komutu önerir + tüm komut listesini gösterir. 'Yardim', 'komutlar nedir', 'ne yapabilirim', '/help', 'sonra ne yapayım' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep
---

# /yardim

İki bölümden oluşur: **akıllı öneri** + **tüm komutlar**.

### Bölüm 1: Akıllı Öneri (öncelikli)

Proje durumuna bak ve **en mantıklı 1-3 komut** öner:

| Durum | Öneri |
|-------|-------|
| Eski AI bağlam dosyaları var (context.md, .cursorrules vb.) | `/devral` (önce) |
| Boş proje | `/basla` veya `/fikir` |
| Konsept var, analiz yok | `/analiz` |
| Mimari yok | `/mimari` |
| Hikaye yok | `/hikaye-olustur` |
| Sprint yok | `/sprint-plan` |
| Sprint aktif, hikayelerin yarısı yapılıyor | `/standup` veya `/hikaye-gelistir [sıradaki]` |
| Sprint aktif, çoğu hikaye `İnceleme`'de | `/kod-inceleme` |
| Kod var, test yok | `/qa-plan` |
| Açık bug var (`production/qa/hatalar/*.md`) | `/hata-duzelt` |
| Sprint sonu yaklaşıyor | `/retro` veya `/standup` |
| Sürüm yaklaşıyor | `/surum-kontrol` |
| Birden fazla görüş çatışması var | `/danisma` |

Format:
```
📍 Proje durumu: [özet]

💡 Önerilen sıradaki adım:
   /komut [argüman] — [neden]

Alternatif:
   /baska-komut — [neden]
```

### Bölüm 2: Tüm Komutlar

```
İŞ AKIŞI:
/basla → /fikir → /analiz → /mimari → /hikaye-olustur
                                            ↓
                                      /sprint-plan
                                            ↓
                            /hikaye-gelistir → /kod-inceleme
                                            ↓
                                       /qa-plan
                                            ↓
                                    /surum-kontrol
```

| Komut | Ne Yapar | Ajan |
|-------|----------|------|
| **Onboarding** | | |
| `/devral` | Mevcut projeyi devral - context.md/.cursorrules vb. oku | — |
| `/basla` | Aşama + tech stack tespit, yönlendir | — |
| `/yardim` | Bu ekran (bağlamlı öneri ile) | — |
| **Tasarım** | | |
| `/fikir` | Konsept dokümanı | urun-yoneticisi |
| `/analiz` | Gereksinim / mevcut sistem analizi | is-analisti |
| `/mimari` | Teknik mimari + ADR | teknik-direktor |
| **Sprint** | | |
| `/hikaye-olustur` | Hikayeleri oluştur | urun-yoneticisi |
| `/backlog` | Backlog refinement | scrum-master |
| `/sprint-plan` | Sprint planlama | scrum-master |
| `/standup` | Günlük durum | scrum-master |
| `/retro` | Sprint retrospektifi | scrum-master |
| **Geliştirme** | | |
| `/hikaye-gelistir` | Hikayeyi uygula | backend/frontend |
| `/kod-inceleme` | Kod review | yazilim-lideri |
| **QA** | | |
| `/qa-plan` | Test planı | qa-lideri |
| `/hata-raporu` | Bug raporu oluştur | qa-lideri |
| `/hata-duzelt` | Bug fix QA→Dev→QA döngüsü | bug sahibi |
| **Karar / Bilgi** | | |
| `/danisma` | Çoklu ajan danışma | (panel) |
| `/memory` | Proje öğrenmelerini yönet | — |
| `/surum-kontrol` | Sürüm hazırlık | teknik-direktor |

### Ajanlar (10)

**Direktörler**: teknik-direktor, urun-yoneticisi
**Liderler**: yazilim-lideri, qa-lideri, tasarim-lideri, is-analisti, scrum-master
**Uzmanlar**: backend-gelistirici, frontend-gelistirici, devops

### Çıktı

```
STATUS: COMPLETED
DETECTED_STATE: [özet]
SUGGESTED: [komut]
ALTERNATIVES: [varsa]
```
