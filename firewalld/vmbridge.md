= Bridge with masquerading for VMs

I have an internal bridge named `labnet_bridge`. This will be set to the `internal` zone of firewalld.
The network of this adapter will be 10.44.44.0/24. The external zone (hooked up to the interwebz, adapter eth0) will be called `public`.

Make sure stuff like `ebtables` is installed correctly. It might not be on Archlinux.
Also make sure `ip_forwarding` is enabled in the kernel.

First, we configure the zone to include the adapter

`firewall-cmd --change-interface=labnet_bridge --zone=internal`

Now, we define the sources of this zone:

`firewall-cmd --zone=internal --add-source=10.44.44.0/24`

IMPORTANT: Masquerading of packets!

We cannot use the integrated masquerading option of firewalld and instead have to use a direct rule:

`firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eth0 -j MASQUERADE`

If stuff works as expected, save the configuration:

`firewall-cmd --runtime-to-permanent`

