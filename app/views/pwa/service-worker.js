const CACHE_NAME = 'agrojobs-v1';
const OFFLINE_URL = '/offline';

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll([
        '/',
        OFFLINE_URL,
        '/manifest.json',
        '/application.css',
        '/application.js'
      ]))
      .catch(err => console.error('Cache addAll error:', err))
  );
});

self.addEventListener('fetch', (event) => {
  if (event.request.mode === 'navigate') {
    event.respondWith(
      fetch(event.request)
        .catch(() => caches.match(OFFLINE_URL))
    );
  } else {
    event.respondWith(
      caches.match(event.request)
        .then((response) => response || fetch(event.request))
        .catch(err => console.error('Fetch error:', err))
    );
  }
});
