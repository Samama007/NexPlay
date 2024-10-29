'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "cbbf2d72151bd61121984e8553ff7152",
"assets/AssetManifest.bin.json": "8b95a5b320739558567ea9755efa49fd",
"assets/AssetManifest.json": "946d3eeb57ba2f9e5da702f3e4bb690a",
"assets/assets/animations/intro2.json": "cb6932ff49de9beab915f26b19be2025",
"assets/assets/animations/intro3.json": "05b89a6f6cac5062e42d32aebdc2e1e8",
"assets/assets/animations/purchased.json": "06363136e1a81639b8ae12789528088c",
"assets/assets/animations/thank-you.json": "4931b5798912ce2371f226be550885db",
"assets/assets/fonts/ProzaLibre-Bold.ttf": "953361970da56397a839f4a9387a4ca1",
"assets/assets/fonts/ProzaLibre-BoldItalic.ttf": "ced1cd3237e8e85b6536e931d7bc92b9",
"assets/assets/fonts/ProzaLibre-ExtraBold.ttf": "dbeecc7af35b16dc9afb8ead573356b9",
"assets/assets/fonts/ProzaLibre-ExtraBoldItalic.ttf": "adcd43e4e7a32acdf2763a412b851a3a",
"assets/assets/fonts/ProzaLibre-Italic.ttf": "41585d159c9b3f59605d1e20e214524f",
"assets/assets/fonts/ProzaLibre-Medium.ttf": "a20824b74a7d82881698c5bd0cd6e50b",
"assets/assets/fonts/ProzaLibre-MediumItalic.ttf": "807231e263f36d748958e40d39fcf8d8",
"assets/assets/fonts/ProzaLibre-Regular.ttf": "7168641c0371ebb5dafbc86468d23999",
"assets/assets/fonts/ProzaLibre-SemiBold.ttf": "ff83f9f61a7215eeb095cf1bc19b8c65",
"assets/assets/fonts/ProzaLibre-SemiBoldItalic.ttf": "e82ef0b563b63149d64861f030f26e4e",
"assets/assets/images/dev.png": "ea1a398e842dda726efe86a9225ca85d",
"assets/assets/images/ff.jpg": "1c002049fbc0b5fdfe7b8cd4e233aabb",
"assets/assets/images/logo.png": "6b66ec23a73aef5f3733aed7fba04d0f",
"assets/assets/images/profile.png": "7c0afbe769d91a8cc15b228cffe64445",
"assets/assets/images/ss1.png": "173774ebf4a9cffa8b4643e735ae9512",
"assets/assets/images/ss2.png": "6e693a89d29f9c043e800d6dd90243fa",
"assets/assets/images/ss3.png": "7ce019ecf6799edb11d2f536f2ed897e",
"assets/assets/images/ss4.png": "6df74d8c611f11428625729a6939fd49",
"assets/assets/svg/empty.svg": "5bb26737156daea9af1045dfa2ab6cc1",
"assets/assets/svg/intro1.svg": "0022348eea51ddf2d77cb59eb0d97894",
"assets/assets/svg/no_game.svg": "b540258299e47748377b8e3922c448b8",
"assets/FontManifest.json": "c888e7d2bee8a70988ca244190f22f92",
"assets/fonts/MaterialIcons-Regular.otf": "7b2dcda80b27e992d8b39bc0a9b06730",
"assets/NOTICES": "717c02621ca24d83128da71fc8a26f6d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "1c59a135ee7099994b932540acbcb61f",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "09923b22ce8a6fc5371759cb9f127ecb",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5cd42286b625fed18cefca810b518053",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0f1f31286ea873d09d0589ca342c6793",
"assets/packages/language_picker/assets/fonts/Roboto/Roboto-Regular.ttf": "8a36205bd9b83e03af0591a004bc97f4",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "0da2828d6be5321f4b523b60f70159b3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b45e2890852ed1362b650f9181f6d020",
"/": "b45e2890852ed1362b650f9181f6d020",
"main.dart.js": "5cd938c3bd731463bcace896f8146567",
"manifest.json": "66cc8740ad091f3045cba2b4228fa69f",
"version.json": "1569cb06233d5b5e7c29d70d7633f2e0"};
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
