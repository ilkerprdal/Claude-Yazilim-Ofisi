# Koordinasyon Kuralları

## Dikey Delege

```
Direktörler → Liderler → Uzmanlar
```

- Direktör doğrudan uzmana delege etmez (liderden geçer)
- Uzman doğrudan direktöre çıkmaz (liderden geçer)
- İstisna: lider yoksa veya acil durum

## Yatay Danışma

Aynı katman birbirine danışır, ama karar veremez:

- backend-gelistirici ↔ frontend-gelistirici (API sözleşmesi)
- yazilim-lideri ↔ qa-lideri (test stratejisi)

## Çatışma Çözümü

| Çatışma Tipi | Çözen |
|--------------|-------|
| Tasarım / kapsam | urun-yoneticisi |
| Teknik / mimari | teknik-direktor |
| Kalite / test yeterliliği | qa-lideri |

## Model Atamaları

| Model | Kullanım |
|-------|----------|
| Haiku | Salt okuma, format, basit listeme |
| Sonnet | Uygulama, inceleme, tek sistem analizi (varsayılan) |
| Opus | Çoklu belge senteze, yüksek riskli karar |

Skill'ler varsayılan Sonnet'tir. `/yardim` Haiku, `/mimari` ve
`/surum-kontrol` Opus.
