---
description: "Mimariden uygulanabilir hikayelere bölme — her hikaye bağımsız, test edilebilir ve kabul kriterli."
---

# /hikaye-olustur

Girdi: `docs/architecture/mimari.md` + `docs/urun/konsept.md`.
Çıktı: `production/stories/NNN-slug.md` dosyaları.

### Hikaye Şablonu

```markdown
# [NNN] Hikaye Başlığı

**Tip**: Backend / Frontend / Tam yığın / Config
**Tahmin**: XS / S / M / L

## Amaç
Tek cümle — bu hikaye neyi mümkün kılıyor?

## Kabul Kriterleri
- [ ] Kullanıcı X yapabilmeli
- [ ] Y durumunda Z olmalı
- [ ] Hata halleri: ...

## Teknik Notlar
- İlgili ADR: ...
- Dokunulacak dosyalar: ...
- Bağımlılık: (diğer hikaye)

## Test Kanıtı
- Mantık testi / entegrasyon testi / manuel yürüyüş

## Durum
Taslak / Hazır / Yapılıyor / İnceleme / Tamam
```

### Akış

1. `urun-yoneticisi` hikaye listesini önerir (başlık + amaç)
2. Kullanıcı onayı → her hikaye için ayrı dosya
3. Her hikayenin bağımlılığı açıkça belirtilir
4. Hikaye sırası (öneri) verilir

Büyük hikayeler için "bölmemi ister misin?" diye sor.
