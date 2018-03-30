The Nginx Lancache is an on premise caching solution initially designed for schools, but its application can be used anywhere.

The caches are designed for direct connectivity (no proxy) or transparent proxy, and there must be an onsite DNS server.

Technically you can point any host to the onsite cache, however the more selective the better, and it only caches HTTP content.
SSL is passed through as an SNI proxy only.

The cache ignores X-Accel-Expires, Expires, Cache-Control, Set-Cookie, and Vary headers. It also ignores query strings as part of
the cache key.

The cache also downloads large files at one 16MB slice at a time. Cache locking prevents the client from pulling the file at the same
time as a cache filling operation, thus reducing bandwidth utilisation. In theory, this should mean that only one instance of any file
is ever downloaded.

Some configuration within the nginx.conf file restricts caching of files over 5GB in size. This is to prevent caching of games which
are upwards of 55GB being downloaded off the Microsoft Store and filling the cache unnecessarily. This can be removed if desired.

Steps:
1. Create a linux VM (CentOS was used for this variation) with 2GB ram and 100GB disk space, and install Nginx.
2. Implement the nginx.conf configuration and change the two "forwarders" locations to an upstream DNS server that you WILL NOT use
   for the local DNS interception - eg. 8.8.8.8 / 8.8.4.4.
3. On your local DNS server, install the following Zone's:

    Apple Zones:
       appldnld.apple.com (@)
       iosapps.itunes.apple.com (@)
       osxapps.itunes.apple.com (@)

    Microsoft Zones:
       download.windowsupdate.com (@, *)
       windowsupdate.microsoft.com (@, *)
       tlu.dl.delivery.mp.microsoft.com (@, *)

    Google Chrome/ChromeOS:
       dl.google.com (@)
       gvt1.com (@)

    Adobe:
       ardownload.adobe.com (@)
       ccmdl.adobe.com (@)
       agsupdate.adobe.com (@)

    * Zone's designated "(@)" only need a root A record pointing to your on premises cache.
    * Zone's designated "(@, *)" need both a root A record and a wildcard A record pointing to your on premises cache.
