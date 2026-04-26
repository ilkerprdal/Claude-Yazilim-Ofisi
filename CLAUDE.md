# Yazılım Ofisi — Ajan Yapılandırması

Küçük bir yazılım ofisinin Claude Code içinde çalışan hali.
8 ajan, 10 skill, minimum gürültü.

## Teknoloji

- **Dil / Framework**: [Yapılandırılacak]
- **Veritabanı**: [Yapılandırılacak]
- **Versiyon Kontrol**: Git
- **Test Çerçevesi**: [Yapılandırılacak]

## Klasör Yapısı

```
src/         # Kaynak kod
tests/       # Unit + entegrasyon testleri
docs/        # Mimari, ADR'ler, teknik dokümanlar
production/
  stories/          # Hikaye/task dosyaları
  session-state/    # active.md (oturum durumu)
```

## İşbirliği Protokolü

**Kullanıcı sürücü koltuğunda. Ajanlar otonom değil.**

Her görev: **Soru → Seçenekler → Karar → Taslak → Onay**

- Write/Edit öncesi "bunu [dosya]'ya yazayım mı?" sorulur
- Çok dosyalı değişikliklerde tüm değişiklik seti tek seferde onaya sunulur
- Kullanıcı açıkça istemediği sürece commit atılmaz

Detay: @.claude/docs/isbirligi.md

## Koordinasyon

**Dikey delege**: Direktörler → Liderler → Uzmanlar.
**Yatay danışma**: Aynı katman birbirine danışır ama karar vermez.
**Çatışma**: Tasarım çatışması → ürün-yöneticisi. Teknik çatışma → teknik-direktör.

Detay: @.claude/docs/koordinasyon.md

## Kodlama Standartları

@.claude/docs/kodlama-standartlari.md

## Bağlam Yönetimi

- Uzun oturumlarda `production/session-state/active.md` dosyasını canlı tut.
- Belgeleri bölüm bölüm yaz; her onaydan sonra dosyaya işle.
- Compaction sonrası önce `active.md`'yi oku.

## İlk Oturum

Proje taze ise `/basla` ile başlayın.
