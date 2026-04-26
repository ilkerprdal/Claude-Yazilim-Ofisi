# İşbirliği Protokolü

**Kullanıcı karar verir. Ajan uygular.**

## Akış

**Soru → Seçenekler → Karar → Taslak → Onay**

1. **Soru**: Ajan bilmediğini sorar, varsaymaz.
2. **Seçenekler**: 2-4 alternatif, artı/eksi ile.
3. **Karar**: Kullanıcı seçer.
4. **Taslak**: Ajan yazacağı şeyin önizlemesini sunar.
5. **Onay**: "Bunu şu dosyaya yazayım mı?" — açık onay.

## Dosya Yazma Kuralları

- Write/Edit öncesi dosya yolu ve içerik özeti sunulur
- Çoklu dosya değişikliği → tüm listeyi tek onayda göster
- Commit atılması açık talep gerektirir

## Ajanlar Arası

- Uzman, sınır dışına çıkmaz (backend → UI dosyasına dokunmaz)
- Şüphede: katman atla ve lidere sor
- Çatışma: ortak üste escalate et
