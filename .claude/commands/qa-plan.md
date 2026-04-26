---
description: "Sprint veya ozellik icin test plani uretir. 'Test plani hazirla', 'QA plani', 'test stratejisi', 'neyi test edelim' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit
---

# /qa-plan

`qa-lideri` ajanını devreye al.

### Girdi

- Hikaye dosyaları (sprint'in hikayeleri veya tek özellik)
- İlgili GDD / spec / mimari referansı

### Çıktı

`production/qa/plan-[tarih].md`:

```markdown
# Test Planı — [Sprint / Özellik]

## Kapsam
[Hangi hikayeler]

## Otomatik Test Gereksinimleri
| Hikaye | Test Tipi | Dosya Yeri |
|--------|-----------|------------|
| 003    | Unit      | tests/unit/auth/ |

## Manuel Test Senaryoları
1. [Adım adım senaryo]
2. ...

## Duman Testi Kapsamı
- [Kritik yol listesi]

## Kabul Kanıtı
- [Her hikayenin Durum=Tamam olması için neye ihtiyaç var]
```

Plan taslağını kullanıcıya onaylatmadan yazma.
