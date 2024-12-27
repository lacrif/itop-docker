# Image Docker pour Combodo iTop

[![Docker Pulls](https://img.shields.io/docker/pulls/lacrif/itop?logo=docker&link=https%3A%2F%2Fhub.docker.com%2Frepository%2Fdocker%2Flacrif%2Fitop)](https://hub.docker.com/repository/docker/lacrif/itop)
[![Docker Stars](https://img.shields.io/docker/stars/lacrif/itop?logo=docker&link=https%3A%2F%2Fhub.docker.com%2Frepository%2Fdocker%2Flacrif%2Fitop)](https://hub.docker.com/repository/docker/lacrif/itop)
[![GitHub forks](https://img.shields.io/github/forks/lacrif/itop-docker?link=https%3A%2F%2Fgithub.com%2Flacrif%2Fitop-docker)](https://github.com/lacrif/itop-docker)
[![GitHub Repo stars](https://img.shields.io/github/stars/lacrif/itop-docker?link=https%3A%2F%2Fgithub.com%2Flacrif%2Fitop-docker)](https://github.com/lacrif/itop-docker)

L'image de base Docker est [ubuntu/apache2](https://hub.docker.com/r/ubuntu/apache2)

## Installation

Pour démarrer l'installation, Lancer la commande suivante :
```shell
sudo make compose-up
```
Puis se rendre sur l'url [http://localhost/](http://localhost/) ou [https://localhost/](https://localhost/)

## Ajouter des certificats

### ``/etc/apache2/ssl``

Ajouter un volume permet d'activer HTTPS pour l'interface web Le volume doit contenir deux fichiers "ssl.crt" et "ssl.key" préparés pour les connexions SSL Apache2.

Veuillez suivre la [documentation](https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html) officielle d'Apache2 pour obtenir plus de détails sur la création de fichiers de certificat.

## License

[LICENCE](LICENCE)

## Author

[lacrif](https://github.com/lacrif)
