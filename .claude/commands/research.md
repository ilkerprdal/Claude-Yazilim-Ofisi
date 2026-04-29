---
description: "Standalone investigation — invokes researcher to gather facts (codebase, library docs, prior incidents) without kicking off the build flow. Triggers on 'araştır', 'research', 'investigate', 'how does X work', 'where is X', 'şunu incele', 'neresi'."
allowed-tools: Read, Glob, Grep, Bash, Task
argument-hint: "[topic to research]"
---

# /research

Single-step keşif. researcher'a konuyu verir, kanıt brifini geri alır.
Akışı tetiklemez — qa, tech-lead, developer çağrılmaz.

Ne zaman kullanılır:
- Bir özelliğe karar vermeden önce codebase'i tanımak
- Bir kütüphanenin / API'nin nasıl davrandığını öğrenmek
- Önceki bir incident / ADR / commit silsilesini tarayıp özet almak
- Bir sonraki `/feature`'a girmeden önce "burada zaten ne var" sorusunu netleştirmek

### Steps

1. Argümandan scope çıkar (yoksa kullanıcıdan tek satırda iste)
2. **researcher** (Task: subagent_type=researcher)
   - Codebase grep + relevant file reads
   - Library docs lookup (sadece kullanıcının verdiği URL ile — uydurmaz)
   - Prior incidents / ADRs / retros tarama
3. Brief geri döner: dosya:line işaretçileri + açık sorular
4. Çıktı kullanıcıya gösterilir; bir sonraki adım kullanıcıya bırakılır

### Rules

- **Yorum yok**: researcher öneri yapmaz, sadece kanıt döner. Bu komut sonunda "şunu yap" çıkmaz.
- **Akış başlatmaz**: brief'i kullanmak için kullanıcı `/feature` veya `/quick-fix` gibi bir komutla devam etmeli.
- **Kapsam dar tutulmalı**: researcher derinlik bayrağıyla rapor verir (SHALLOW / NORMAL / DEEP). Daha derine gitmek gerekirse kullanıcı yeniden çağırır.

### Output

```
STATUS: COMPLETED | BLOCKED | NEEDS_INPUT
SCOPE: [konu — tek satır]
FINDINGS: [count]
RELATED_CODE: [most-likely-to-change file paths]
RELATED_DOCS: [ADR / bug / retro references]
OPEN_QUESTIONS: [list]
DEPTH: SHALLOW | NORMAL | DEEP
NEXT: [usually "user decides — /feature, /quick-fix, /bug-fix, or another /research with narrower scope"]
```
