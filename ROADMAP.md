# نقشه راه اجرایی — از همین مخزن تا PR های آپ‌استریم

> تمام مراحل با دستور واقعی و ترتیب علمی. هر مرحله‌ای که به تصمیم نگه‌دارنده آپ‌استریم وابسته است
> مشخص شده. **commit/push فقط با تأیید خودت انجام می‌شود.**

## مرحله ۰ — وضعیت فعلی

- `main` (همین ریپو): سورس مشترک هر دو تم + پروپوزال‌ها + اسناد.
- `fa-theme/` — تم فارسی `akzfa` (راست‌چین، وزیرمتن، بیلد Tailwind، نصب‌کننده استاندارد).
- `en-theme/` — تم انگلیسی `akz` (همان معماری، LTR، فونت سیستم) — همان پکیجی که در فورک VOIZ هم هست.
- `proposals/` — سه پروپوزال برای دو ریپازیتوری آپ‌استریم.

## مرحله ۱ — پاک‌سازی و انتشار ریپو عمومی `akz_issable_theme`

1. بررسی `LICENSE` ریشه (GPL-2.0-or-later) و ایندکس‌گذاری README (انجام شد).
2. ساخت شاخه‌ها از همین سورس مشترک:

```bash
# شاخه فارسی: فقط fa-theme + README شاخه
git switch -c fa
git rm -r --cached en-theme proposals >/dev/null   # از ایندکس فقط؛ فایل‌ها در main می‌مانند
git commit -m "fa: Persian AKZ theme (akzfa) for Issabel"
git push -u origin fa

# شاخه انگلیسی: فقط en-theme + README شاخه
git switch -c en
git rm -r --cached fa-theme proposals >/dev/null
git commit -m "en: English AKZ theme (akz) for Issabel"
git push -u origin en

git switch main   # برگرد به main
```

3. در گیت‌هاب: Default branch = `main`، توضیحات ریپو، تاپیک‌ها (`issabel`, `asterisk`, `pbx`, `theme`, `persian`).
4. Releases: تگ `fa-v1.0.0` و `en-v1.0.0` + پیوست zip هر تم در Release (کاربران بدون git هم بگیرند).

## مرحله ۲ — اعتبارسنجی روی سرور آزمایشی (پیش‌نیاز هر PR)

- طبق `fa-theme/COMPATIBILITY.md`: نصب تم روی ایزابل ۴ و ۵، چک‌لیست ۱۰ مرحله‌ای، تست `uninstall.sh`.
- خروجی موردنیاز برای PR ها: اسکرین‌شات‌ها + نسخه‌های تست‌شده + نتیجه بازگردانی.

## مرحله ۳ — پیشنهاد به voipiran/VOIZ

1. **Issue اول، بعد PR:** در `voipiran/VOIZ` یک Issue باز کن و `proposals/02-voiz-upstream/PROPOSAL.md`
   را (فارسی) بگذار؛ بپرس ترجیحشان جایگزینی `vitenant` است یا تم دوم.
2. فورک رسمی `voipiran/VOIZ` → شاخه `feature/akz-ui-layer` از `main` → فقط فایل‌های لیست‌شده در
   بخش ۳ پروپوزال → draft PR با لینک Issue.
3. تا موافقت نگه‌دارنده، PR را **draft** نگه دار.

## مرحله ۴ — پیشنهاد به IssabelFoundation

1. طبق `en-theme/PUSH_GUIDE.md` و `proposals/01-issabel-framework/PROPOSAL.md`:
   فورک `IssabelFoundation/framework` → شاخه از `master` → افزودن **فقط**
   `framework/html/themes/akzfa/` (+ `contrib/` اگر گزینه ۲ را انتخاب کردند) → draft PR.
2. همان کار برای نسخه انگلیسی (`akz`) به‌صورت PR جدا.
3. اگر تم `farsi_rtl` را هدف گرفتند: `proposals/03-issabel-farsi-rtl/PROPOSAL.md` (گزینه B).

## مرحله ۵ — نگهداری مستمر

- هر تغییر UI: سورس در `contrib/*/ui/` ویرایش، `npm run build:css`، **سورس+خروجی با هم کامیت**.
- هر نسخه: تگ `fa-vX.Y.Z` / `en-vX.Y.Z` + به‌روزرسانی `version=` در `akzfa.conf` و cache-busting (`?v=`).
- همگام‌سازی دوره‌ای با آپ‌استریم‌ها (اگر `farsi_rtl` یا `tenant` یا VOIZ تغییر کرد، دیف بگیر و تطبیق بده).

## قواعد لایسنس (خلاصه)

- کد مشتق‌شده از فریم‌ورک ایزابل → GPL-2.0-or-later، سرصفحه‌ها حفظ.
- فونت وزیرمتن → OFL-1.1، متن مجوز پیوست (فروش فونت به‌تنهایی ممنوع؛ استفاده در تم آزاد).
- برندینگ «AKZ» فقط identification است، نه ادعای مالکیت ایزابل.
