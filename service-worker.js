importScripts('https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js');

self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

if (workbox) {
  workbox.precaching.precacheAndRoute([
    '/assets/css/style.css',
    '/assets/js/main.js',
    '/assets/images/1-w.png',
    '/assets/images/2-w.png',
    '/assets/images/all-countries-county.png',
    '/assets/images/debragrace.png',
    '/assets/images/manifest-icon-192.png',
    '/assets/images/manifest-icon-512.png',
    '/assets/images/oshomo.jpg',
    '/assets/images/oshomo-logo.png',
    '/assets/images/resume-bg.jpg',
    { url: '/', revision: '383676' },
  ]);
  workbox.routing.registerRoute(/\.(?:png|jpg|jpeg|svg)$/, new workbox.strategies.CacheFirst({
    "cacheName": "images",
    plugins: [new workbox.expiration.Plugin({maxAgeSeconds: 2592000, purgeOnQuotaError: false})]
  }), 'GET');
  workbox.routing.registerRoute(/^https?.*/, new workbox.strategies.NetworkFirst({
    "cacheName": "offlineCache",
    plugins: [new workbox.expiration.Plugin({maxEntries: 200, purgeOnQuotaError: false})]
  }), 'GET');
}
