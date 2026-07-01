/*
 * shared.js — Incitetales
 * Common UI utilities shared across pages:
 *   - Scroll-reveal animation (IntersectionObserver)
 *   - Nav scroll shadow
 *
 * Usage: <script src="/js/shared.js"></script>
 * (place at end of <body>)
 */
(function() {
  // ── Scroll Reveal ──
  if ('IntersectionObserver' in window) {
    var observer = new IntersectionObserver(function(entries) {
      entries.forEach(function(e) {
        if (e.isIntersecting) {
          e.target.classList.add('visible');
          observer.unobserve(e.target);
        }
      });
    }, { threshold: 0.06 });
    document.querySelectorAll('.reveal').forEach(function(el) {
      observer.observe(el);
    });
  } else {
    document.querySelectorAll('.reveal').forEach(function(el) {
      el.classList.add('visible');
    });
  }

  // ── Nav Scroll Shadow ──
  var nav = document.querySelector('nav');
  if (nav) {
    window.addEventListener('scroll', function() {
      nav.style.boxShadow = window.scrollY > 40
        ? '0 2px 20px rgba(28,24,20,0.08)'
        : 'none';
    });
  }
})();
