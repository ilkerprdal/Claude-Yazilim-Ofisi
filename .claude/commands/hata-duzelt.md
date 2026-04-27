---
description: "Bir hata raporundan başlayıp düzeltmeyi uçtan uca götüren QA→Dev→QA döngüsü. 'X hatasını düzelt', 'bug fix', 'şu raporu çöz' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[hata-id veya raporun yolu, ornek: 042 veya production/qa/hatalar/042-login-crash.md]"
---

# /hata-duzelt

QA → Dev → QA kapalı döngü.

### Akış

1. **Bağlam yükle**
   - `production/qa/hatalar/[id]-*.md` dosyasını oku
   - İlgili hikayeyi bul (varsa)
   - Etkilenen kod dosyalarını tespit et

2. **Hipotez kur**
   - Tekrarlama adımlarına bak, kodla eşleştir
   - 1-3 olası sebep listele
   - Kullanıcıya sun: "En olası: [X]. Doğru mu?"

3. **Doğru ajana yönlendir**
   - Backend hata → `backend-gelistirici`
   - Frontend hata → `frontend-gelistirici`
   - Altyapı/CI hatası → `devops`

4. **Düzeltme** (ajan tarafında)
   - Düzeltmeyi sun, onay al
   - **Regresyon testi yaz** (bu hata tekrar etmesin diye)
   - Var olan testler hâlâ geçiyor mu kontrol et

5. **QA kapısı**
   - `qa-lideri` ajanı:
     - Tekrarlama adımlarını çalıştır → hata yok mu?
     - Regresyon testi var mı, geçiyor mu?
     - Yan etki yok mu?
   - GATE: PASS → hatayı `Çözüldü` işaretle
   - GATE: FAIL → adım 4'e geri dön

6. **Kapanış**
   - Hata raporuna `Çözüm` bölümü ekle:
     ```
     ## Çözüm
     **Tarih**: yyyy-mm-dd
     **Düzeltilen dosyalar**: [liste]
     **Regresyon testi**: tests/regression/bug-042.test.js
     **Commit**: [varsa hash]
     ```
   - `production/standup-log.md`'e not düş

### Kurallar

- Test yazmadan kapatma
- "Sebebini bilmiyorum ama düzeltim" → reddet, hipotez doğrula
- 3 deneme sonra çözülmediyse → `STATUS: BLOCKED`, kullanıcıya geri ver

### Çıktı

```
STATUS: COMPLETED | BLOCKED
HATA_ID: [id]
ROOT_CAUSE: [tek cümle gerçek sebep]
FILES_CHANGED: [liste]
REGRESSION_TEST: [dosya yolu]
QA_GATE: PASS | FAIL
NEXT: [varsa]
```
