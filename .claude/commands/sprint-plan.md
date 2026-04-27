---
description: "Yeni sprint planlama. Backlog'tan hikaye seç, kapasite hesabı yap, sprint dosyası oluştur. 'Sprint başlatalım', 'yeni sprint planı', 'haftalık plan' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit
argument-hint: "[opsiyonel: sprint suresi - 1w | 2w]"
---

# /sprint-plan

`scrum-master` ajanını devreye al.

### Adımlar

1. **Bağlam topla**
   - `production/backlog.md` (yoksa `production/stories/*.md` listele)
   - `production/sprints/` altındaki son sprint dosyası (velocity için)
   - Aktif sprint var mı? Varsa kapatılması lazım önce

2. **Kapasite hesabı**
   - Kullanıcıya sor: "Bu sprint kaç gün? (1 hafta / 2 hafta)"
   - Önceki sprint velocity (varsa) → bu sprint hedef
   - Yoksa: "Bilmiyoruz, küçük başlayalım — 3-5 hikaye"

3. **Hikaye seçimi**
   - Backlog'tan **kabul kriterleri net** olanlardan başla
   - Bağımlılığı olmayanları öne al
   - Karışım: 1-2 büyük + 2-3 orta + 1-2 küçük
   - Her seçimi kullanıcıya onaylat

4. **Sprint dosyası oluştur**

```markdown
# Sprint SXX — [yyyy-mm-dd → yyyy-mm-dd]

## Hedef
[1-2 cümle — bu sprint sonunda ne olmuş olmalı]

## Hikayeler

| ID | Başlık | Tip | Tahmin | Durum | Sahip |
|----|--------|-----|--------|-------|-------|
| 003 | Kullanıcı girişi | Backend | M | Yapılıyor | backend-gelistirici |

## Kabul Kriteri (Sprint için)
- [ ] Tüm hikayeler `Tamam`
- [ ] Smoke test geçti
- [ ] Kullanıcı kabul etti

## Riskler
- [Bilinen riskler]

## Notlar
- [Toplantıda alınan notlar]
```

5. `production/sprints/SXX-yyyy-mm-dd.md` olarak yaz
6. `active.md` STATUS bloğunu güncelle

### Çıktı

`scrum-master` standart çıktı formatıyla kapan.
