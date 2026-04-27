---
description: "Karmaşık karar için birden fazla ajanı paralel masaya çağır - 'party mode'. Kullanıcı moderatör. 'Şunu tartışalım', 'farklı görüş', 'mimari karar', 'X mi Y mi' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Task, AskUserQuestion
argument-hint: "[konu - ornek: 'sql vs nosql', 'monorepo mu polyrepo mu']"
---

# /danisma

Karmaşık veya çok-yönlü kararlarda birden fazla ajanı **aynı anda** masaya
çağır. Kullanıcı moderatör, ajanlar uzman.

### Ne Zaman Kullanılır

- Mimari karar (DB, dil, framework seçimi) — teknik-direktor + yazilim-lideri + devops
- Kapsam kararı — urun-yoneticisi + is-analisti + scrum-master
- Performans/güvenlik tradeoff — teknik-direktor + qa-lideri + devops
- Genel: **2'den fazla ajan** ilgileniyorsa

### Akış

1. **Konu al** (argüman veya kullanıcıdan sor)

2. **Doğru paneli seç** — kullanıcıya öner, onaylat:

   | Karar Tipi | Önerilen Panel |
   |------------|----------------|
   | Teknoloji seçimi | teknik-direktor + yazilim-lideri + devops |
   | Kapsam/öncelik | urun-yoneticisi + is-analisti + scrum-master |
   | UX vs teknik | tasarim-lideri + frontend-gelistirici + teknik-direktor |
   | Sürüm/release | release-yok (teknik-direktor + qa-lideri + devops) |

3. **Her ajan kendi açısından görüş bildirsin** (paralel Task çağrıları):
   - Önerisi
   - Güçlü yanı
   - Riski/itirazı

4. **Çatışmaları görünür yap**
   - Aynı fikirde değiller → tablo halinde göster:
     ```
     | Konu          | teknik-direktor | yazilim-lideri | devops |
     | DB seçimi     | PostgreSQL      | PostgreSQL     | DynamoDB|
     | Gerekçe       | ACID            | ekip bilgisi   | ölçek   |
     ```

5. **Kullanıcı karar verir**
   - "X seçtim" denirse → kararın gerekçesini bir ADR'ye yaz
   - "Hâlâ kararsızım" denirse → daha fazla soru hazırla

### Kurallar

- Ajan **kararın sahibi değil** — sen kullanıcıdan onay almadan dosya yazma
- Çatışmalar saklanmaz, vurgulanır
- Tartışma uzarsa "deneme yapalım" alternatifi sun (örn. `/prototype`)

### Çıktı

```
STATUS: COMPLETED
PANEL: [katılan ajanlar]
KONU: [tartışılan]
ÖNERİLER:
  - [ajan-1]: [özet] — gerekçe
  - [ajan-2]: [özet] — gerekçe
  - [ajan-3]: [özet] — gerekçe
ÇATIŞMA: VAR | YOK
KULLANICI_KARARI: [varsa]
WROTE: [varsa ADR yolu]
NEXT: [önerilen adım]
```
