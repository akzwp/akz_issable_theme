/** Build-time only; preserve the framework's existing widgets. */
module.exports = {
  content: ['./ui/**/*.css', '../../framework/html/themes/akzfa/_common/*.tpl', '../../framework/html/themes/akzfa/js/akzfa-*.js'],
  prefix: 'tw-',
  corePlugins: { preflight: false },
  theme: { extend: { fontFamily: { sans: ['Vazirmatn', 'Tahoma', 'sans-serif'] }, colors: { surface: 'var(--akzfa-surface)', ink: 'var(--akzfa-text)', brand: 'var(--akzfa-primary)' } } },
  plugins: []
};
