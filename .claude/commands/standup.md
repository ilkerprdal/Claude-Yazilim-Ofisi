---
description: "Günlük standup - aktif sprint hikayelerinin durumu, engeller, bugünkü riskler. 'Standup', 'durum nasıl', 'günlük rapor', 'nerede kaldık' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit
---

# /standup

`scrum-master` ajanını devreye al.

### Adımlar

1. Aktif sprint dosyasını bul (`production/sprints/` altında en güncel)
2. Sprint'in her hikayesi için **dosya durumunu** oku (`production/stories/`)
3. Tabloyu özetle:

```
SPRINT: SXX (gün X / Y)
PROGRESS: [tamamlanan]/[toplam] hikaye

YAPILIYOR:
- 003 Kullanıcı girişi (backend-gelistirici, dün başladı)
- 005 Login ekranı (frontend-gelistirici, %50)

İNCELEMEDE:
- 002 Şifre kuralları (kod-inceleme bekliyor)

ENGELLENDI:
- 007 OAuth — auth provider seçimi yok (sahip: urun-yoneticisi)

BUGÜNÜN RİSKLERİ:
- 005 yarınki sprint sonuna yetişmeyebilir (UX henüz onaylanmadı)

TAMAM:
- 001, 004
```

4. `production/standup-log.md` dosyasına tarih başlığıyla append

### Kurallar

- Hikaye dosyalarındaki `Durum:` alanından oku, varsayma
- Engelleri net göster — kim çözecek, ne lazım
- Risk varsa erken bildir

### Çıktı

`scrum-master` standart formatla.
