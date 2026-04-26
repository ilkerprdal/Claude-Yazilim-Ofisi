---
description: "Sürüm öncesi hazırlık kontrol listesi — kod, test, dağıtım, doküman."
---

# /surum-kontrol

Sürüme çıkmadan önce her kalemi doğrula. BLOKLAYICI olanlar geçmeden sürüm yok.

### Kod
- [ ] Tüm hikayeler `Tamam` durumunda
- [ ] `main` branch'inde beklenen commit'ler var
- [ ] Açık kritik/yüksek önem hata yok **(BLOKLAYICI)**

### Test
- [ ] CI pipeline yeşil **(BLOKLAYICI)**
- [ ] Duman testi geçti **(BLOKLAYICI)**
- [ ] QA imzası var

### Dağıtım
- [ ] `.env.example` güncel
- [ ] Migration script'leri test edildi
- [ ] Rollback planı belgelendi **(BLOKLAYICI)**
- [ ] İzleme / alarm aktif

### Doküman
- [ ] CHANGELOG güncel
- [ ] README değişiklikler yansıtıyor
- [ ] API değişikliği varsa iletişim yapıldı

### Sürüm Notları
- [ ] Kullanıcıya yönelik notlar hazır
- [ ] Değişiklikler öncelik sırasına göre

### Çıktı

**GO / NO-GO** kararı + eksikler listesi.
`production/surumler/[versiyon]-kontrol.md` olarak kaydet.
