# tail

**tail** will output (stdout) the last part of a text file. Most useful when perusing long text
files and we only need to see the current updates.

| Switch | Action |
|-----|--------|
| -c | Output last denoted in kilobytes |
| -n | Output n number of lines from eof |
| -f | Follow - output data as the file grows |
| -q | No headers, only file content |

A useful switch option for tail is **-f**. The -f switch is really useful for real-time
troubleshooting of logs. A good example is when a user has issues with remote login. Using
the -f option, piping the output of VPN logs into grep, then the filtering user id is allowed
to watch login attempts from the troubled user. It turned out auth credentials were
garbled.

Upon further inspection, they had changed the encryption protocol of the RAS client.
Something that could have taken a long time to figure out by asking questions and walking
a user through client config. settings step by step.
Using tail with the -f switch to watch wpa supplicant logs as wifi is connected to a new AP.

```
[root@centosLocal Documents]# tail -f /var/log/wpa_supplicant.log-20161222
wlp0su: CTRL-EVENT-DISCONNECTED bssid=ee:ee:ee:12:34:56 reason=3
locally_generated=1
dbus: wpas_dbus_bss_signal_prop_changed: Unknown Property value 7
wlp0su: SME: Trying to authenticate with ff:ff:ff:78:90:12 (SSID='WiFi12345'
freq=5180 MHz)
wlp0su: Trying to associate with ff:ff:ff:78:90:12 (SSID='WiFi12345' freq=5180 MHz)
wlp0su: Associated with ff:ff:ff:78:90:12
wlp0su: WPA: Key negotiation completed with ff:ff:ff:78:90:12 [PTK=CCMP GTK=CCMP]
wlp0su: CTRL-EVENT-CONNECTED - Connection to ff:ff:ff:78:90:12 completed [id=0
id_str=]
```

When a Wifi connection fails, it could assist in troubleshooting issues in real-time.
