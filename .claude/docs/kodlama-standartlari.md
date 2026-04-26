# Kodlama Standartları

## Genel

- Public API'ler doc yorumu içerir
- Magic number yok — config veya sabit olarak dışa al
- Her public fonksiyon test edilebilir (DI, singleton değil)
- Commit mesajı hikaye ID'sine referans verir
- Verification-driven: önce test, sonra implementasyon (mantık stories için)

## İsimlendirme

Dil/framework konvansiyonuna uy. Proje seçildikten sonra
`CLAUDE.md` içinde özelleştir.

## Test Standartları

| Hikaye Tipi | Gerekli Kanıt | Kapı |
|-------------|---------------|------|
| Mantık | Birim test | BLOKLAYICI |
| Entegrasyon | Entegrasyon veya manuel yürüyüş | BLOKLAYICI |
| UI | Manuel yürüyüş veya etkileşim testi | TAVSİYE |
| Config / veri | Duman testi | TAVSİYE |

### Test Kuralları

- Deterministik — rastgele seed yok, zamana bağlı assertion yok
- Her test kendi kurulum/yıkımını yapar
- Inline magic number yok (sınır değer testi hariç)
- Harici bağımlılık mock'lanır veya DI ile izole edilir

## Güvenlik

- Sır kod içine yazılmaz, `.env` ve secret yöneticisi kullanılır
- Kullanıcı girdisi mutlaka doğrulanır
- SQL injection, XSS, CSRF temel kontrolleri
- `.env` dosyası commit edilmez; `.env.example` commit edilir

## Doküman

- Her büyük karar → `docs/adr/NNNN-baslik.md`
- API değişikliği → `docs/api/` güncellemesi
- Kırıcı değişiklik → CHANGELOG'a ekle
