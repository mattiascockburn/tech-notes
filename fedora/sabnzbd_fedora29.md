= Install sabnzbd on Fedora 29 x86_64

Mostly ripped from https://sabnzbd.org/wiki/installation/install-fedora-centos-rhel
Please be aware that you should run the following commands in the context of root.

== Repositories

We need to add at least RPM Fusion NONFREE in order to obtain unrar:

```
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-29.noarch.rpm
```

== Prereqs Install

```
dnf install -y par2cmdline python-yenc python-cheetah unrar git unzip p7zip
```

Install SABYenc (https://sabnzbd.org/wiki/installation/sabyenc.html)

```
pip install --upgrade pip
pip install sabyenc --upgrade
```

== Obtain sabnzbd

```
cd /opt
git clone https://github.com/sabnzbd/sabnzbd
cd sabnzbd
git checkout master
```

== System configuration

=== Create a service user

```
useradd usenet
chown -R usenet:usenet /opt/sabnzbd
```

=== systemd Unit

```
cat >/etc/systemd/system/sabnzbd.service <<EOF
#
# Systemd unit file for SABnzbd
#

[Unit]
Description=SABnzbd Daemon

[Service]
Type=forking
User=usenet
Group=usenet
ExecStart=/usr/bin/python /opt/sabnzbd/SABnzbd.py --daemon --config-file=/opt/sabnzbd/sabnzbd_config.ini -s 0.0.0.0
GuessMainPID=no

[Install]
WantedBy=multi-user.target
EOF
systemctl dameon-reload
systemctl enable sabnzbd
systemctl start sabnzbd
```

```
cat >/etc/firewalld/services/sabnzbd.xml <<EOF
<service>
  <short>sabnzbd</short>
  <description>SabNZBd Download Service</description>
  <port protocol="tcp" port="8080"/>
</service>
EOF
firewall-cmd --reload
firewall-cmd --add-service=sabnzbd
firewall-cmd --runtime-to-permanent
```


