---
description: "Yeni proje icin gereksinim toplama (FR/NFR/kisit) veya mevcut sistemin teknik analizi. 'Gereksinimleri cikar', 'mevcut sistemi analiz et', 'bu kodu incele', 'spec hazirla' denildiginde tetiklenir."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
argument-hint: '[opsiyonel: yeni veya mevcut]'
---

# /analiz

`is-analisti` ajanını devreye al.

İki mod var, kullanıcıya hangisi olduğunu sor:

### Mod 1: Yeni proje / özellik

Girdi: `docs/urun/konsept.md` (varsa) veya kullanıcının sözlü tarifi.

#### Adımlar

1. **Paydaş soru listesi** üret — kullanıcı, sistem, başarı, kısıt
2. Kullanıcı cevapladıkça doldur:

```markdown
# Gereksinimler — [Proje/Özellik Adı]

## Bağlam
[Tek paragraf — neyi neden çözüyoruz]

## Paydaşlar
- [Rol] — [İlgisi/etkisi]

## Fonksiyonel Gereksinimler (FR)
- FR-001: Sistem [şunu] yapabilmeli
- FR-002: Kullanıcı [şunu] yapabilmeli
- ...

## Fonksiyonel Olmayan Gereksinimler (NFR)
- NFR-001 (Performans): ...
- NFR-002 (Güvenlik): ...
- NFR-003 (Erişilebilirlik): ...
- NFR-004 (Ölçek): ...

## Kısıtlar
- [Teknolojik / yasal / bütçe / zaman]

## Açık Sorular
- [Henüz cevaplanmamış]

## Kaynaklar
- [Hangi gereksinim hangi konuşma/dokümandan geldi]
```

3. `docs/analiz/gereksinimler.md` olarak yaz

### Mod 2: Mevcut sistem analizi

Girdi: mevcut kod/proje.

#### Adımlar

1. `src/`, `docs/`, `package.json` / `requirements.txt` / `pom.xml` vb. tara
2. Modülleri ve sorumluluklarını çıkar
3. Bağımlılıkları (iç/dış) listele
4. Belirsiz / dokümante olmayan kısımları işaretle

```markdown
# Mevcut Sistem Analizi

## Genel Bakış
[Sistem ne yapıyor — 1 paragraf]

## Modüller
| Modül | Sorumluluk | Dosya/Klasör |

## Dış Bağımlılıklar
| Servis/Kütüphane | Kullanım Yeri | Versiyon |

## Veri Akışı
[Kabaca diyagram veya bullet]

## Belirsizlikler / Eksikler
- [Doküman olmayan, anlaşılmayan kısımlar]

## Etki Bölgeleri (varsa hedef değişiklik için)
- [X değişirse Y etkilenir]
```

3. `docs/analiz/mevcut-sistem.md` olarak yaz

### Kurallar

- Varsayım yapma. Sorman gereken her şeyi listele, kullanıcı cevaplamadan
  yazma
- Her gereksinim/bulguya **kaynak** ekle (konuşma referansı veya kod yolu)
- Çıktı taslağını göster, onay almadan yazma
