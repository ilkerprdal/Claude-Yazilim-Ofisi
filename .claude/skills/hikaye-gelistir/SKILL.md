---
name: hikaye-gelistir
description: "Bir hikayeyi uçtan uca uygula — bağlam yükle, doğru ajana yönlendir, kodu ve testi yaz."
user-invocable: true
model: sonnet
---

# /hikaye-gelistir

Girdi: hikaye slug'ı (ör. `/hikaye-gelistir 003-login`).

### Akış

1. **Bağlamı yükle**
   - Hikaye dosyası
   - Mimari dokümandaki ilgili bölüm
   - ADR referansları
   - Dokunulacak mevcut dosyalar

2. **Doğru ajana yönlendir**
   - Backend / API / DB → `backend-gelistirici`
   - UI / bileşen / ekran → `frontend-gelistirici`
   - Tam yığın → önce backend, sonra frontend (veya paralel)

3. **Uygulama protokolü** (ajan tarafında)
   - Dosya listesi + imzaları öner
   - Onay al
   - Kod + test aynı anda
   - Testi çalıştır, sonucu göster
   - Kabul kriterlerini tek tek işaretle

4. **Bitirme**
   - Hikayenin **Durum**'unu `İnceleme` yap
   - `/kod-inceleme` öner
