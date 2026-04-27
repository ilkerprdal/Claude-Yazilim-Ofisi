---
description: "Backlog refinement - hikayeleri sırala, eksikleri işaretle, büyükleri parçala. 'Backlog inceleme', 'refinement', 'hikayeleri sıralayalım', 'grooming' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit
---

# /backlog

`scrum-master` ajanını devreye al.

### Adımlar

1. **Mevcut backlog'u oku**
   - `production/backlog.md` varsa
   - Yoksa `production/stories/` altındaki tüm hikayeleri tara, listele

2. **Her hikayeyi değerlendir** (3 kriter):

   - **Hazırlık**: Kabul kriteri var mı? Net mi?
     - ❌ Yok → işaretle: `READINESS_GAP`
   - **Boyut**: Tahmin var mı? L/XL ise parçalanmalı mı?
     - ❌ Çok büyük → işaretle: `TOO_BIG`
   - **Tazelik**: 90 günden eski mi?
     - ❌ → işaretle: `STALE`

3. **Backlog dosyasını yenile**

```markdown
# Backlog

> Sıra: yukarıdan aşağıya öncelik

## Hazır (sprint'e alınabilir)
- 003 Kullanıcı girişi — M
- 005 Login ekranı — S
- 007 Şifre sıfırlama — M

## Refinement Gerekli
- 010 Bildirim sistemi — kabul kriterleri yok ⚠️ READINESS_GAP
- 012 Raporlama — XL ⚠️ TOO_BIG → /hikaye-olustur ile parçala
- 015 Eski mesajlaşma — 100 gün önce yazıldı ⚠️ STALE

## Buz Dolabı (gelecek)
- 020 Premium üyelik
- 022 Mobil app
```

4. Kullanıcıya öner:
   - "10 numaralı hikayeyi `/analiz` ile detaylandıralım mı?"
   - "12 numarayı `/hikaye-olustur 012-raporlama` ile parçalayalım mı?"

### Kurallar

- Sıra değiştirmeden önce kullanıcı onayı al
- Hikayeyi silme — `Buz Dolabı`'na taşı

### Çıktı

`scrum-master` standart formatla.
