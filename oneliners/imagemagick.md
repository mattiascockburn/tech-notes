= imagemagick

== scale down a bunch of images in parallel

```
find . -iname '*.ARW' | xargs -IFOOBAR -t -P4 sh -c 'convert -define jpeg:extent=500KB -resize 50% FOOBAR ../scaled/$(basename FOOBAR)_scaled.jpg'
```
