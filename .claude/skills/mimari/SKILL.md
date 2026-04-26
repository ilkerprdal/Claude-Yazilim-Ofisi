---
name: mimari
description: "Teknik mimari dokümanı yazımı — sistem sınırları, veri akışı, teknoloji seçimleri."
user-invocable: true
model: opus
---

# /mimari

`teknik-direktor` ajanını devreye al. `docs/urun/konsept.md` varsa oku.

### Doldurulacak Bölümler

1. **Genel Bakış** — 1 paragraf sistem özeti
2. **Bileşenler** — servisler, katmanlar, modüller
3. **Veri Modeli** — ana varlıklar ve ilişkileri
4. **Entegrasyonlar** — dış servisler, API'ler
5. **Teknoloji Seçimleri** — dil, framework, DB (her biri için gerekçe)
6. **Güvenlik** — kimlik doğrulama, yetkilendirme, sır yönetimi
7. **Dağıtım** — ortamlar, CI/CD, izleme
8. **Açık Kararlar** — henüz kapanmamış ADR'ler

### Akış

- Her bölümde 2-3 seçenek üret, pros/cons göster
- Kullanıcı seçimini yaptıkça `docs/architecture/mimari.md` dosyasına işle
- Büyük kararlar için `docs/adr/NNNN-baslik.md` oluştur

### Kurallar

- Hazırda olmayan teknolojilere atıf yapma — seç ve yaz
- "TODO" yerine "Açık Kararlar" bölümünde takip et
