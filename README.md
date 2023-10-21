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

## Creating htpasswd for private registry

```
docker container run \
--rm \
--entrypoint htpasswd \
httpd:2 -Bbn myuser mypassword > nginx/htpasswd # be sure to be in the right directory
```