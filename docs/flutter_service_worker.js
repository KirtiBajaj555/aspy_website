'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/images/logo.png": "695eddabbfe665c5fcdb1e2e89ba4ffe",
"assets/assets/images/item6.png": "ce6130225fe6c499f8ad8f1f5bcf251d",
"assets/assets/images/item3.png": "dece3ae7847a067525a0af0d56355067",
"assets/assets/images/news1.png": "7253dd86a392c2540c9325ee72e61a9a",
"assets/assets/images/item1.png": "c1cee21df3fddac98f360611c463ae95",
"assets/assets/images/news5.png": "d72e4f30b2bfef9835c2a5d97e9d65e5",
"assets/assets/images/earth2.png": "d1ec339fdaf3951af4aaf019967a2d05",
"assets/assets/images/Frame%252029.png": "0e277eb32869dc19f81e0bfb836602ca",
"assets/assets/images/40450.jpg": "700ac970d0572b828376a3c669580c59",
"assets/assets/images/item2.png": "47442c384a19bd7f32ed47274d7cab33",
"assets/assets/images/horizontal.png": "64b73942c69bc1c6dc84abc03fc2a985",
"assets/assets/images/news2.png": "426b29913d87e749b99e5efdc23745c9",
"assets/assets/images/Logo3.png": "aef19c2870b427b9d65c3d82d19327f6",
"assets/assets/images/Logo1.png": "a3a7e3d1581ac64004fb231efb66301a",
"assets/assets/images/item5.png": "70122749e49c6e864435d9745ed55804",
"assets/assets/images/item4.png": "51b166124673d5ae050f78a9964b6261",
"assets/assets/images/Frame%252027.png": "c338cbed6cdbf0173d50776fcaa82ab1",
"assets/assets/images/news4.png": "faf66427ab90fe2cfe38dc63adf294b9",
"assets/assets/images/Logo2.png": "81c4aa3ad1195a1925f82f9fce4c1d96",
"assets/assets/images/Logo4.png": "8d6cd6b1cba1519d763b59be9a4da9d6",
"assets/assets/images/news3.png": "b52029202f91e794fb9066f90c1a3b9e",
"assets/assets/images/businessman-shows-his-finger-up.jpg": "aa0bba81f0c88b4efc843f42c8caeb42",
"assets/assets/fonts/ClashDisplay-Medium.ttf": "f801579df950a76a4dfe1c1b515e8087",
"assets/assets/fonts/ClashDisplay-Semibold.ttf": "5c7adedf6a7a336edba5d31d1c866262",
"assets/assets/fonts/ClashDisplay-Extralight.ttf": "dd3e06aa66a97208f785bc496d487cd1",
"assets/assets/fonts/ClashDisplay-Bold.ttf": "845b81eb8251429424eadff3ad713e4a",
"assets/assets/fonts/ClashDisplay-Regular.ttf": "8281d40c682b0a4910c77b5b90598bab",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "f1126486ccebd15d203af7169b536fc2",
"assets/AssetManifest.bin.json": "156dc685fac0e5f4dec470c23027f6a2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "2719b23473e66c057f522769bd97d0c5",
"assets/AssetManifest.bin": "d461db8b5abb9ba9bfca278dbb3dc3b9",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/FontManifest.json": "0da154f57c19e8a2d4829a5467f30b9b",
"assets/AssetManifest.json": "ede18781f0c29c0fc1685e6e8dcc2224",
"flutter_bootstrap.js": "81afd05da016029b4f6d64b944f88314",
"manifest.json": "8e66e1314dbabf0aa13062137d7bf013",
"index.html": "0a6aa94d0c10707093aeb724e85e6322",
"/": "0a6aa94d0c10707093aeb724e85e6322",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "93767f0328c60cec60333b65a846eabc",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"favicon.png": "7ef652edc3af9786ab55f52d9ed9350b",
"version.json": "e997570ce7386ea2c3ec62a2c4cff498"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
