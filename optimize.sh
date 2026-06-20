#!/bin/bash
# LumiDistro Optimization Script

echo "=== Optimisation LumiDistro ==="

# Désactiver les services inutiles
echo "Désactivation des services inutiles..."
systemctl disable bluetooth
systemctl disable cups
systemctl disable avahi-daemon

# Activer zram pour la compression RAM
echo "Configuration de zram..."
echo "zram" | sudo tee -a /etc/modules-load.d/zram.conf
cat <<EOF | sudo tee /etc/modprobe.d/zram.conf
options zram num_devices=1
EOF

cat <<EOF | sudo tee /etc/systemd/system/zram.service
[Unit]
Description=ZRAM Compression
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/zramstart
ExecStop=/usr/bin/zramstop
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl enable zram

# Optimiser le noyau
echo "Optimisation du noyau..."
cat <<EOF | sudo tee /etc/sysctl.d/99-lumi.conf
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.dirty_ratio=15
vm.dirty_background_ratio=5
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

sysctl -p /etc/sysctl.d/99-lumi.conf

# Optimiser le filesystem
echo "Optimisation du filesystem..."
cat <<EOF | sudo tee /etc/fstab
tmpfs /tmp tmpfs defaults,noatime,nosuid,size=2G 0 0
tmpfs /var/tmp tmpfs defaults,noatime,nosuid,size=1G 0 0
EOF

# Nettoyage automatique
echo "Configuration du nettoyage automatique..."
cat <<EOF | sudo tee /etc/systemd/system/lumi-cleanup.service
[Unit]
Description=LumiDistro Cleanup
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/lumi-cleanup.sh

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF | sudo tee /usr/local/bin/lumi-cleanup.sh
#!/bin/bash
journalctl --vacuum-time=7d
apt-get autoremove -y
apt-get clean
rm -rf /tmp/*
rm -rf /var/tmp/*
EOF

chmod +x /usr/local/bin/lumi-cleanup.sh
systemctl enable lumi-cleanup.service

# Activer TLP pour l'économie d'énergie
echo "Activation de TLP..."
systemctl enable tlp
systemctl start tlp

echo "=== Optimisation terminée ==="
