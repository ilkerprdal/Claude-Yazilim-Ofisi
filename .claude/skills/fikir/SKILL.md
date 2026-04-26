---
name: fikir
description: "Proje veya özellik fikrini yapılandırılmış bir konsept dokümanına dönüştür."
user-invocable: true
model: sonnet
---

# /fikir

Rehberli fikir geliştirme. `urun-yoneticisi` ajanını devreye al.

### Akış

1. **Problem**: Hangi problemi çözüyoruz? Kim etkileniyor?
2. **Kullanıcı**: Kim kullanacak? Şu an ne kullanıyorlar?
3. **Değer önerisi**: Alternatiflerden farkı ne?
4. **Kapsam**: MVP için minimum ne olmalı? Neleri dışarıda tutuyoruz?
5. **Başarı kriteri**: Nasıl ölçeceğiz?

Her bölümde 2-3 seçenek üret, kullanıcıdan seç/düzelt al.

### Çıktı

`docs/urun/konsept.md` dosyasına yaz:

```markdown
# [Proje Adı]

## Problem
## Hedef Kullanıcı
## Değer Önerisi
## MVP Kapsamı (dahil / hariç)
## Başarı Kriteri
## Açık Sorular
```

Yazmadan önce tüm bölüm taslağını göster, onay iste.
