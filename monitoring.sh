#!/bin/bash
sudo apt install curl -y
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

# Распаковка архивов 
tar xzvf node_exporter-*.t*gz
tar xzvf prometheus-*.t*gz

# Добавляем пользователей
sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus
sudo useradd --no-create-home --shell /bin/false node_exporter

# Установка node_exporter

# Копируем файлы в /usr/local
sudo cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin
sudo chown node_exporter: /usr/local/bin/node_exporter

# Создаём службу node exporter

sudo cp /home/user/nodeexporter-service.txt /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter
sudo systemctl enable node_exporter


# Установка prometheus

# Создаём папки и копируем файлы
sudo mkdir {/etc/,/var/lib/}prometheus
sudo cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin
sudo cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/
sudo chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/


# Настраиваем сервис
sudo cp /home/user/prom.txt /etc/systemd/system/prometheus.service


# Конфиг prometheus
sudo cp /home/user/prometheus.yml /etc/prometheus/prometheus.yml

# Запускаем сервис Prometheus
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus
sudo systemctl enable prometheus

# Установка из пакета
sudo apt install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_10.0.3_amd64.deb
sudo dpkg -i grafana_10.0.3_amd64.deb

# Запуск
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
