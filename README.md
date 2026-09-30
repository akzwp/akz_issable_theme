# تم فارسی ایزابل — AKZ (شاخه fa)

تم راست‌چین و فارسی برای پنل وب ایزابل — با تم دارک/لایت، فونت وزیرمتن، جستجوی زنده ماژول‌ها و
ریسپانسیو کامل موبایل. این شاخه فقط پکیج تم فارسی را دارد؛ نسخه انگلیسی روی شاخه
[`en`](https://github.com/akzwp/akz_issable_theme/tree/en) و اسناد مشترک + پروپوزال‌ها روی
[`main`](https://github.com/akzwp/akz_issable_theme/tree/main) هستند.

## نصب روی سرور ایزابل

```bash
# ۱) دریافت مخزن
git clone -b fa https://github.com/akzwp/akz_issable_theme.git
cd akz_issable_theme

# ۲) نصب تم فارسی + فعال‌سازی (زبان fa و تم akzfa انتخاب می‌شود)
sudo bash fa-theme/contrib/akzfa-theme/install.sh --activate

# ۳) خارج شوید و دوباره وارد پنل شوید
```

بازگردانی: `sudo bash fa-theme/contrib/akzfa-theme/uninstall.sh`

## مجوز

GPL-2.0-or-later (مطابق فریم‌ورک ایزابل) — فونت وزیرمتن: SIL OFL 1.1

## مستندات

- راهنمای کامل و توسعه: [`fa-theme/README.md`](fa-theme/README.md)
- معماری فنی: [`fa-theme/ARCHITECTURE.md`](fa-theme/ARCHITECTURE.md)
- سازگاری و چک‌لیست تست: [`fa-theme/COMPATIBILITY.md`](fa-theme/COMPATIBILITY.md)
