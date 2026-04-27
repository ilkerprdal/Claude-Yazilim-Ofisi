---
description: "Sprint retrospektifi - ne iyi gitti, ne kötü, ne deneyelim, aksiyon maddeleri. 'Retro', 'sprint sonu', 'değerlendirme', 'retrospective' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
---

# /retro

`scrum-master` ajanını devreye al.

### Adımlar

1. Kapanan sprint dosyasını oku
2. Velocity hesapla:
   - Planlanan vs tamamlanan hikaye sayısı
   - Tahmin sapması (M demiştik, gerçekte L olduysa not et)
3. Kullanıcıya 3 soru sor (sırayla):
   - **Ne iyi gitti?** Hangi pratik / araç / yaklaşım işe yaradı?
   - **Ne kötü gitti?** Engeller, gecikmeler, sürtünmeler?
   - **Ne deneyelim?** Bir sonraki sprint için 1-3 küçük değişiklik

4. Aksiyon maddeleri üret:
   - Her aksiyona **sahip** ve **tarih** ata
   - "Genel olarak iyileştir" gibi muğlak şeyleri reddet, somut yap

5. Dosyayı yaz:

```markdown
# Retro — Sprint SXX

**Tarih**: yyyy-mm-dd
**Süre**: X gün

## Velocity
- Planlanan: 5 hikaye
- Tamamlanan: 4
- Sapma sebebi: 1 hikaye OAuth bağımlılığında engellendi

## İyi Giden
- Kod inceleme döngüsü hızlandı
- ...

## Kötü Giden
- Mimari kararı sprint ortasında değişti — fakir backlog refinement
- ...

## Deneyelim
- [ ] Backlog refinement her Cuma 30 dk (sahip: scrum-master, bitiş: sprint sonu)
- [ ] Mimari kararlar sprint öncesi netleşsin (sahip: teknik-direktor)
```

6. `production/retros/SXX.md` olarak yaz
7. Sonraki sprint için `.claude/memory/` altına öğrenilen dersler özetini ekle (varsa)

### Çıktı

`scrum-master` standart formatla.
