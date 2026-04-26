---
description: "Yapılandırılmış hata raporu oluştur — tekrarlama adımları, beklenen/gerçekleşen, önem derecesi."
---

# /hata-raporu

### Şablon

`production/qa/hatalar/NNN-slug.md`:

```markdown
# [NNN] Hata Başlığı

**Önem**: Kritik / Yüksek / Orta / Düşük
**Önem Gerekçesi**: Neden bu önem?
**Bulunduğu Yer**: Dev / Stage / Prod
**Versiyon**: X.Y.Z (veya commit hash)

## Özet
Tek cümle.

## Tekrarlama Adımları
1. ...
2. ...

## Beklenen Davranış
## Gerçekleşen Davranış

## Kanıt
[Loglar, ekran görüntüsü yolu, hata izi]

## Olası Etki
Kaç kullanıcı, hangi akış

## Öneri / Notlar
[Varsa ilk hipotez]
```

### Kurallar

- Tekrarlama adımı eksikse **yazma**, önce kullanıcıdan iste
- Önem derecesini gerekçesiz atama
