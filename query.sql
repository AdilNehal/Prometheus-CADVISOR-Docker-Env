======================================================
df -hT
Filesystem     Type      Size  Used Avail Use% Mounted on
tmpfs          tmpfs     1.6G  3.5M  1.6G   1% /run
/dev/sda2      ext4      294G  124G  156G  45% /
tmpfs          tmpfs     7.8G  144K  7.8G   1% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
efivarfs       efivarfs  128M  9.6K  128M   1% /sys/firmware/efi/efivars
/dev/sda1      vfat      511M  6.1M  505M   2% /boot/efi
tmpfs          tmpfs     1.6G   84K  1.6G   1% /run/user/128
tmpfs          tmpfs     1.6G   72K  1.6G   1% /run/user/1000
=======================================================

-- root filesystem is mounted on /dev/sda2, which is an ext4 filesystem. This is the filesystem you likely want to monitor for disk pressure.

100 - ((node_filesystem_free_bytes{device="/dev/sda2", job="node"} / node_filesystem_size_bytes{device="/dev/sda2", job="node"}) * 100)

-- CPU usage

(1 - rate(node_cpu_seconds_total{job="node", mode="idle"}[5m])) * 100

-- overall memory usage

node_memory_MemTotal_bytes{job="node"} - (node_memory_MemFree_bytes{job="node"} + node_memory_Buffers_bytes{job="node"} + node_memory_Cached_bytes{job="node"})


