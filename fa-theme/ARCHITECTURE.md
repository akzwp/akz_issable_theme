# معماری تم AKZ فارسی (akzfa)

> این سند معماری فنی تم را توضیح می‌دهد. برای نصب، `README.md` را بخوانید.

## ۱) منشأ کد (Provenance)

| لایه | منشأ | مجوز |
|---|---|---|
| قالب‌ها و `themesetup.php` | Issabel Foundation `framework` (تم `tenant` → فارسی‌سازی voipiran → بازطراحی AKZ) | GPL-2.0-or-later (سرصفحه‌های فایل حفظ شده) |
| لایه بازطراحی UI (CSS/JS) | کار اختصاصی AKZ روی شاخه `test2` مخزن `akzwp/VOIZ` | GPL-2.0-or-later (مطابق کل اثر مشتق‌شده) |
| فونت وزیرمتن (۸ وزن woff2) | [rastikerdar/vazirmatn](https://github.com/rastikerdar/vazirmatn) | SIL OFL 1.1 (`contrib/akzfa-theme/LICENSES/Vazirmatn/`) |
| Bootstrap/Neon/GSAP و بقیه کتابخانه‌های قدیمی | همان دارایی‌های موجود فریم‌ورک ایزابل | سرصفحه‌های خود فایل‌ها |

تم روی سرور **مستقل** است و هیچ فایلی از نصب موجود ایزابل را بازنویسی نمی‌کند؛ فقط پوشه جدید
`/var/www/html/themes/akzfa` اضافه می‌شود و (در صورت `--activate`) دو کلید `theme` و `language`
در `settings.db` تغییر می‌کنند. نصب‌کننده مقدار قبلی را برای بازگردانی ذخیره می‌کند.

## ۲) نقشه فایل‌ها

```
framework/html/themes/akzfa/        ← تم زمان اجرا (کپی مستقیم به /var/www/html/themes/akzfa)
├── themesetup.php                  ← هوک رسمی ایزابل؛ آیکون‌ها/متغیرهای Smarty + خواندن /etc/akzfa.conf
├── _common/*.tpl                   ← مارک‌آپ پوسته: index, login, popup, _menu, _shortcut, help, listcsv
├── css/
│   ├── bootstrap-rtl.min.css       ← Bootstrap راست‌چین (موجود در منشأ)
│   ├── neon-core-rtl.css …         ← پوسته قدیمی Neon (پایه)
│   └── akzfa-tailwind.css          ← لایه بازطراحی؛ «آخرِ آخر» لود می‌شود و ظاهر نهایی را تعیین می‌کند
├── js/
│   ├── akzfa-ui.js                 ← سوییچ دارک/لایت (localStorage)، دراور موبایل، جستجوی ماژول‌ها، مودال‌ها
│   └── akzfa-embedded.js           ← استایل‌دهی صفحات هم‌مبدأ embed شده (فقط ظاهری)
├── fonts/vazirmatn/*.woff2         ← ۸ وزن وزیرمتن، لوکال، بدون CDN
├── images/, phone/                 ← دارایی‌ها + صفحه تلفن تحت وب
└── akzfa.conf                      ← برندینگ (name/version/footer)؛ نصب اختیاری به /etc/akzfa.conf
```

## ۳) جریان بارگذاری (چرا این تم با هسته ایزابل سازگار است)

1. ایزابل بر اساس مقدار `theme` در `settings.db` پوشه `/var/www/html/themes/<name>` را انتخاب می‌کند.
2. `themesetup.php` تم فراخوانی می‌شود (هوک استاندارد؛ بدون تغییر در هسته).
3. `_common/index.tpl` ابتدا `data-theme` را **قبل از رندر** از `localStorage` می‌خواند (بدون فلش تم اشتباه).
4. CSS های پایه (Bootstrap-RTL، Neon) لود می‌شوند، سپس `{$HEADER}` و `$HEADER_MODULES` (ماژول‌ها) و
   **در انتها** `css/akzfa-tailwind.css` — چون آخرین stylesheet است، بدون `!important` و بدون دست‌کاری
   فایل‌های ماژول‌ها، ظاهر نهایی را تعیین می‌کند.
5. تقویم جلالی و ارقام فارسی با همان کتابخانه‌های موجود ایزابل/ویز کار می‌کنند.

نکته سازگاری: `preflight` در Tailwind غیرفعال شده (`corePlugins.preflight:false`) تا ویجت‌های قدیمی
ایزابل نشکنند. کلاس‌های تولیدی با پیشوند `tw-` تولید می‌شوند تا با کلاس‌های هسته تداخل نکنند.

## ۴) لایه بازطراحی — سورس و بیلد

- سورس: `contrib/akzfa-theme/ui/*.css` — نقطه ورود `akzfa-theme.css` (توکن‌ها → پوسته → کامپوننت → ماژول‌ها → embed).
- بیلد: `cd contrib/akzfa-theme && npm ci --ignore-scripts && npm run build:css`
  خروجی: `framework/html/themes/akzfa/css/akzfa-tailwind.css` (مینیفای‌شده، همراه سورس کامیت می‌شود؛ سرور به Node نیاز ندارد).
- متغیرهای رنگ با پیشوند `--akzfa-` در `:root` و `[data-theme="light"|"dark"]` تعریف شده‌اند.
- ابزار چک خودکار (`tools/check-ui.cjs`) در مخزن منشأ (`akzwp/VOIZ` شاخه `test2`) نگهداری می‌شود؛ این پکیج فقط خروجی کامپایل‌شده را توزیع می‌کند.

## ۵) تفاوت‌های عمدی با تم `vitenant` مخزن VOIZ

| مورد | در VOIZ (vitenant) | در این پکیج |
|---|---|---|
| نام پوشه تم | `vitenant` | `akzfa` |
| فایل‌های CSS/JS | `voiz-ui.js`, `voiz-tailwind.css`, … | `akzfa-ui.js`, `akzfa-tailwind.css`, … |
| کلید localStorage | `voiz-theme` | `akzfa-theme` |
| متغیرهای CSS | `--voiz-*` | `--akzfa-*` |
| برندینگ | VOIPIRAN + AKZ | فقط AKZ (`akzfa.conf` مستقل) |
| وابستگی `/etc/voiz.conf` | اجباری (`parse_ini_file` بدون گارد) | گارد `file_exists` + نسخه پیش‌فرض |
| فایل‌های زائد | `.swp`، `*000*` | حذف شده |

رفتار بصری و منطقی تم با نسخه ۷.۱.x شاخه `test2` یکسان است.
