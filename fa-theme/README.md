# تم فارسی ایزابل — AKZ (akzfa)

تم راست‌چین و فارسی، حرفه‌ای و مدرن برای پنل وب **ایزابل (Issabel)** — با تم دارک/لایت، فونت وزیرمتن،
جستجوی زنده ماژول‌ها، ریسپانسیو کامل موبایل، و سازگاری با هسته ایزابل (بدون بازنویسی فایل‌های هسته).

- زبان: **فارسی (fa) — RTL**
- سازگاری: ایزابل ۴/۵ (CentOS 7) با تم استاندارد `tenant` موجود
- مجوز: GPL-2.0-or-later (مطابق فریم‌ورک ایزابل) — فونت وزیرمتن: SIL OFL 1.1

---

## نصب روی سرور ایزابل (توصیه‌شده)

> پیش‌نیاز: نصب موجود ایزابل با چیدمان استاندارد `/var/www/html` و `/var/www/db/settings.db` و وجود تم `tenant`.

```bash
# ۱) دریافت مخزن
git clone https://github.com/akzwp/akz_issable_theme.git
cd akz_issable_theme

# ۲) نصب تم فارسی + فعال‌سازی (زبان fa و تم akzfa انتخاب می‌شود)
sudo bash fa-theme/contrib/akzfa-theme/install.sh --activate

# ۳) خارج شوید و دوباره وارد پنل شوید (Sign out / Sign in)
```

نصب بدون تغییر انتخاب فعلی (فقط کپی فایل‌ها):

```bash
sudo bash fa-theme/contrib/akzfa-theme/install.sh
```

بازگردانی تم و زبان قبلی:

```bash
sudo bash fa-theme/contrib/akzfa-theme/uninstall.sh
```

نصب‌کننده:
- فقط پوشه `/var/www/html/themes/akzfa` را می‌سازد؛ **هیچ فایل هسته‌ای بازنویسی نمی‌شود**.
- قبل از تغییر `theme`/`language` در `settings.db`، مقدار قبلی را در `/var/lib/issabel/akzfa-theme` ذخیره می‌کند.
- قفل نصب همزمان (`flock`)، استیجینگ اتمیک و بازگردانی خودکار در صورت خطا دارد.
- تنظیمات تلفنی، شبکه، دسترسی‌ها و ماژول‌های شخص ثالث را تغییر نمی‌دهد.

## نصب دستی (بدون اسکریپت)

```bash
sudo cp -a fa-theme/framework/html/themes/akzfa /var/www/html/themes/
sudo chown -R asterisk:asterisk /var/www/html/themes/akzfa
# سپس تم را از settings.db انتخاب کنید:
sqlite3 /var/www/db/settings.db "UPDATE settings SET value='akzfa' WHERE key='theme'; UPDATE settings SET value='fa' WHERE key='language';"
```

## توسعه و بازساخت CSS

روی سیستم توسعه (نه سرور):

```bash
cd fa-theme/contrib/akzfa-theme
npm ci --ignore-scripts
npm run build:css     # خروجی: ../../framework/html/themes/akzfa/css/akzfa-tailwind.css
```

سورس CSS در `ui/` است و نقطه ورود `ui/akzfa-theme.css`؛ خروجی کامپایل‌شده همراه سورس کامیت می‌شود
و سرور به Node.js نیازی ندارد. Preflight تیلویند عمداً خاموش است تا ویجت‌های قدیمی ایزابل نشکنند.

## شاخه‌بندی این مخزن

| شاخه | محتوا | مخاطب |
|---|---|---|
| `fa` | همین پکیج — تم فارسی AKZ (`akzfa`) | کاربران ایرانی ایزابل |
| `en` | نسخه انگلیسی/LTR (`akz`) — بدون فونت اختصاصی، با فونت سیستم | کاربران بین‌المللی |
| `main` | ایندکس، اسناد مشترک و پروپوزال‌ها | همه |

هر دو شاخه از یک معماری مشترک ساخته شده‌اند (بخش معماری را ببینید) و روی **یک** مخزن عمومی نگهداری می‌شوند.

## وضعیت تست

CSS توزیع‌شده کامپایل شده است؛ با این حال **تست مرورگر و نصب روی سرور واقعی** باید پیش از استفاده
عملیاتی روی یک سرور آزمایشی انجام شود (چک‌لیست در `COMPATIBILITY.md`).

## مجوزها و پیوست‌ها

- کد تم: GPL-2.0-or-later — `contrib/akzfa-theme/LICENSES/GPL-2.0-or-later.txt`
- سرصفحه‌های کپی‌رایت فریم‌ورک ایزابل و کتابخانه‌های قدیمی داخل فایل‌ها حفظ شده‌اند.
- فونت وزیرمتن: SIL OFL 1.1 — `contrib/akzfa-theme/LICENSES/Vazirmatn/OFL-1.1.txt`
- «AKZ» نام identification این رابط کاربری است، نه ادعای مالکیت فریم‌ورک ایزابل.
