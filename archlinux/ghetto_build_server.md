Ghetto AUR package builder, Docker flavour
==========================================

The Problem
-----------

So i was fed up with building shit from the AUR on my notebooks on a daily basis
and looked for a cheap and easy 'solution' for the problem.

Docker Docker Docker
--------------------

So i looked around the interwebz and found https://github.com/archimg/archlinux-pkgbuilder-docker
This is nice, but i want to build shit from the AUR, so i forked it and cobbled something together
at https://github.com/mattiasgiese/archlinux-pkgbuilder-docker
This image provides `pacaur`, which is a rather nice AUR helper which helps automate most of the
stuff regarding AUR packages. So, the first run went something like this. I logged into an idling
shabby vServer and built the image:

```
mkdir /data/archlinux-build # path with heaps of storage
mkdir ~/git; cd ~/git
git clone git@github.com:mattiasgiese/archlinux-pkgbuilder-docker.git
cd archlinux-pkgbuilder-docker
docker build --no-cache --build-arg MIRROR_URL='http://kickass-archlinux-mirror.sexy/archlinux/$repo/os/$arch' -t pacaur:latest .
```

Now i had the basic image which can be used for building. Sweet as!

Whatcha building?
-----------------

I went ahead and got a list of foreign packages installed on my system:

```
pacman -Qm | cut -d' ' -f1 > aur_packages.txt
scp aur_packages.txt superserver.rocks:
```

Now the awesome sauce was only a bash loop away!

```
for pkg in $(cat ~/aur_packages.txt); do
  echo Building $pkg in 2 seconds; sleep 2
  docker run -ti --rm -v /data/archlinux-build/:/build pacaur:latest $pkg
done
```

So far so good, this kinda works but really sucks as well. There is no automation, no logging, no
reporting, no package signing. And, worst of all, no publishing.

Creating a simple repo
----------------------

Now i needed to create an actual repository in order to test stuff. I just hardlinked all the
packages scattered in the `pacaur` cache directory in one place and `repo-add` did the magic:

```
docker run -ti --rm -v /data/archlinux-build/:/build --entrypoint /bin/bash pacaur:latest -c 'mkdir -p /build/published; find /build/.cache/pacaur/ -iname '*pkg*xz' -exec ln -v '{}' /build/published 2>/dev/null \; ; cd /build/published/; repo-add -n aur.db.tar.xz *pkg*xz'
```

Serving the good stuff
----------------------

So i needed a webserver to host that stuff. Why not simply build a docker image based on Arch? ^^
Here ya go: https://github.com/mattiasgiese/docker-archlinux-caddy

I simply place the release binary in the / of the image and that's it. There is also a minimal
example Dockerfile.reposerver with a Caddyfile.


