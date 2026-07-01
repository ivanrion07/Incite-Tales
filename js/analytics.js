/*
 * analytics.js — Incitetales
 * Google Analytics initialization (shared across all pages)
 *
 * Usage: <script src="/js/analytics.js"></script>
 * (place in <head> BEFORE any other scripts)
 */
(function() {
  var GA_ID = 'G-43DB1SDT7Z';

  var script = document.createElement('script');
  script.async = true;
  script.src = 'https://www.googletagmanager.com/gtag/js?id=' + GA_ID;
  document.head.appendChild(script);

  window.dataLayer = window.dataLayer || [];
  function gtag() { dataLayer.push(arguments); }
  window.gtag = gtag;
  gtag('js', new Date());
  gtag('config', GA_ID);
})();
