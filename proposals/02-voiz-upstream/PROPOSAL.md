# Proposal: Replace/redesign the VOIZ `vitenant` theme with the AKZ UI layer (v7)

> **Prepared for:** voipiran/VOIZ (upstream)
> **Prepared by:** AKZ (akzwp) — <https://akzwp.com>
> **Basis:** branch `test2` of the `akzwp/VOIZ` fork (10–31 commits ahead of `voipiran/VOIZ@main`).
> **Scope:** presentation layer only — no PHP logic, no telephony configuration, no database changes.

---

## 1. خلاصه

تم `vitenant` (پوسته فارسی راست‌چین VOIZ) با یک **لایه بازطراحی کامل UI** جایگزین می‌شود:

- فونت **وزیرمتن** (۸ وزن، لوکال، بدون CDN) و راست‌چین کامل با جزیره‌های LTR هوشمند (مسیرها، اعداد).
- تم **دارک/لایت** با CSS Variables و سوییچ بدون فلش (خواندن `data-theme` قبل از رندر).
- سایدبار ریسپانسیو با **جستجوی زنده ماژول‌ها**، دراور موبایل، دسترس‌پذیری (aria-label ها).
- جدول‌ها، فرم‌ها، مودال‌ها، نوتیفیکیشن‌ها و تقویم جلالی بازطراحی‌شده و هم‌تراز.
- **هیچ فایل PHP یا منطقی دست‌نخورده** — همه تغییرات در CSS / JS رابط کاربری / مارک‌آپ قالب‌هاست.

## 2. معماری (چرا این روش امن است)

لایه بازطراحی **آخرِ همه** stylesheet ها لود می‌شود و فقط ظاهر را بازنویسی می‌کند:

| فایل | نقش |
|---|---|
| `css/voiz-tailwind.css` (بیلد Tailwind از `ui/*.css`) | کل سیستم طراحی: توکن‌ها، سایدبار، فرم‌ها، جدول‌ها، مودال‌ها، ریسپانسیو |
| `ui/embedded.css` | بازطراحی صفحات embed (Asternic، FOP2، flexigrid، DataTables) فقط در همان قاب |
| `js/voiz-ui.js` | سوییچ تم (localStorage)، دراور، جستجو، مودال‌ها، مهار تولتیپ‌ها |
| `_common/*.tpl` | فقط مارک‌آپ (تاپ‌بار، لاگین، متادیتا) |

- Tailwind فقط ابزار بیلد است؛ `preflight` خاموش تا ویجت‌های قدیمی نشکنند؛ خروجی با پیشوند `tw-`.
- فایل‌های PHP هسته، `install.sh` منطق نصب ماژول‌ها، و تنظیمات تلفنی تغییر نمی‌کنند.
- قالب‌های `dashboard`/`monitoring` به **مارک‌آپ اصلی ایزابل** برگردانده شده‌اند و استایل فقط از CSS
  اعمال می‌شود — یعنی آپدیت‌های آینده ماژول‌ها را نمی‌شکند.

## 3. فهرست تغییرات نسبت به `voipiran/VOIZ@main`

- `theme/vitenant/`: CSS/JS جدید (`voiz-ui.css`→`voiz-tailwind.css`، `voiz-ui.js`، `voiz-embedded.js`)،
  فونت وزیرمتن، مارک‌آپ جدید `_common/*.tpl`، بازگردانی قالب‌های dashboard/monitoring به اصل.
- `ui/` (جدید): سورس قابل ویرایش لایه UI + `tailwind.config.cjs` + `package.json` (بیلد لوکال).
- `tools/check-ui.cjs` (جدید): چک‌های خودکار بیلد/کنتراست/DOM با jsdom.
- `issabelmodules/modules/…`: فقط قالب‌های ظاهری (cdrreport، hardware_detector، pbxadmin، voizhelps).
- `theme/pbxconfig/footer_content.php`، `webphone/vp_template.php`: استایل/مارک‌آپ.
- گزارش کامل: `VOIZ-UI-REPORT.md` (فارسی) — ۱۶ مشکل UI/UX رفع‌شده، فهرست دقیق.

## 4. اعتبارسنجی (شفاف)

- چک‌های خودکار `npm run check:ui` پاس هستند.
- **تست مرورگر واقعی/نصب روی سرور ایزابل واقعی توسط نگه‌دارنده باید تکرار شود**؛ پیش از merge،
  اسکرین‌شات و نسخه‌های تست‌شده ارائه می‌شود.

## 5. گزینه‌های پیشنهادی برای نگه‌دارنده VOIZ

1. **جایگزینی کامل تم `vitenant`** با این لایه (توصیه‌شده — کاربران با `install.sh` موجود به‌روزرسانی می‌شوند).
2. افزودن به‌عنوان تم دوم (مثلاً `vitenant-akz`) برای انتقال تدریجی.
3. برداشتن بخش‌هایی (فونت، سورس `ui/`، ابزارها) به‌صورت انتخابی — هر جزء مستقل قابل قبول است.

نکته لایسنس: VOIZ با MIT منتشر می‌شود؛ فایل‌های مشتق‌شده از فریم‌ورک ایزابل GPL-2.0-or-later
می‌مانند و سرصفحه‌های آن‌ها حفظ شده است. فونت وزیرمتن OFL-1.1 است و متن مجوزش پیوست می‌شود.
