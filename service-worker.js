importScripts('https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js');

self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

if (workbox) {
  workbox.precaching.precacheAndRoute([
    '/css/tufte.css',
    '/css/print.css',
    '/assets/img/badge.png',
    '/assets/img/oshomo.jpg',
    '/assets/img/manifest-icon-192.png',
    '/assets/img/manifest-icon-512.png',
    {url: '/', revision: '361245aa-c072-407f-aa37-6b09a5fce2cf'},
  ]);
  workbox.routing.registerRoute(/\.(?:png|jpg|jpeg|svg)$/, new workbox.strategies.CacheFirst({
    "cacheName": "images",
    plugins: [new workbox.expiration.Plugin({maxAgeSeconds: 2592000, purgeOnQuotaError: false})]
  }), 'GET');
}
