---
name: basla
description: "İlk oturum onboarding — projenin hangi aşamada olduğunu tespit edip doğru skill'e yönlendirir."
user-invocable: true
model: sonnet
---

# /basla

Kullanıcıya nerede olduğunu sor:

1. **Hiçbir fikrim yok** → `/fikir` öner
2. **Fikrim var, gereksinim/analiz yok** → `/analiz` öner
3. **Analiz var, mimari yok** → `/mimari` öner
4. **Mimari var, kod yok** → `/hikaye-olustur` öner
5. **Mevcut bir kod tabanı var (yeni katıldım)** → `/analiz` (mevcut sistem modu) öner
6. **Kod var, devam ediyorum** → `production/session-state/active.md` oku, sprint durumunu özetle

Mevcut dosyaları tara: `CLAUDE.md`, `src/`, `docs/`, `production/stories/`.
Gözlemini kullanıcıya söyle, doğrula, sonra yönlendir.

Hiçbir şey varsaymadan sor. Kullanıcı "benim için karar ver" derse
en mantıklı başlangıcı öner ama onay iste.
