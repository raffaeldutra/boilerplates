# Docker Boilerplates

For now, just a bunch of solutions to run directly from your computer using Docker.

## Containers

So far, we've the following container solutions:

* Pakcer
* Ansible
* Terraform
* Observability
  * Grafana
  * Prometheus
  * Promtail
  * Loki
* Observability with reverse proxy
  * Grafana
  * Prometheus
  * Promtail
  * Loki
  * Node Exporter
  * Traefik

## Creating htpasswd for private registry

```
docker container run \
--rm \
--entrypoint htpasswd \
httpd:2 -Bbn myuser mypassword > nginx/htpasswd # be sure to be in the right directory
```

## Observability with reverse proxy

In this project, all accesses will be allowed only via Traefik.

All services ports are disabled, it only will be available via Traefik (proxy).

### Services address

To access the services, use the following addresses in your browser:

* grafana.localhost
* prometheus.localhost
* cadvisor.localhost
* traefik.localhost