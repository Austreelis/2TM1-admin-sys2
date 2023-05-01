## Analyse DNS

1. Besoins client:
  - Résolution DNS complète, indépendante d'un fournisseur.
  - Zone DNS privée.
  - Zone DNS public.
2. Besoins techniques:
  - Un serveur résolveur récursif.
  - Un serveur SOA public.
  - Un serveur SOA interne.
3. Architecture:
  Nous avons choisis de mettre le résolveur en DMZ car ???.
  
  Le SOA privé doit être dans l'intranet afin de ne pas être accessible depuis
  l'internet public. Il sera mis en *trusted zone* car ???.

  Le SOA public sera lui en DMZ. Ce SOA n'a pas besoin de communiquer avec des
  systèmes dans l'intranet, et le mettre en DMZ permet d'éviter que des
  services de l'intranet soient accessibles depuis l'internet public.

  Pour permette aux services dans la *trusted zone* et les terminaux des
  employés (VLans de l'atelier et des bureaux) d'accéder au résolveur et au
  SOA public, nous installons un forwarder dans la *trusted zone*. Il permettra
  de rediriger vers le SOA privé ou le résolveur en fonction de la requête d'un
  utilisateur depuis l'intranet.
  
  ```
                                  [DMZ]---------------------+
                                  |                         |
  [Internet]                      | (Resolver) (Public SOA) |
    o                             |     o          o        |
    |                             |    /          /         |
    '-o Router o---o Firewall o---|---*----------'          |
                      o    o      +-------------------------+
                     /      \
      [Intranet]-----------------------------------------+
      |            /          \                          |
      |           /           [Employees workstations]   |
      |          /            |         ...          |   |
      |          |            +----------------------+   |
      | [Servers]-------------------+                    |
      | |        |                  |                    |
      | |        *------.           |                    |
      | |        |       \          |                    |
      | |        o        o         |                    |
      | | (Forwarder) (Private SOA) |                    |
      | |                           |                    |
      | +---------------------------+                    |
      |                                                  |
      +--------------------------------------------------+
  ```

4. Technologies
  - SOA, résolveur et forwarder DNS: `bind`:
    - Permet d'assumer tout les rôles dont nous avons besoin, permettant
      d'unifier les configurations.
    - Est Open-Source, permettant de tirer partit et de participer à
      l'écosystème libre et collaboratif.
    - Supporte DNSSEC (que nous considérons nécessaire), IPv6 et TSIG. Ces
      dernières features

  - name server: bind
  - domain name registrar: Gandhi

## Analyse web

1. besoins client
  - site dynamique portail de gestion uniquement depuis l'intra uniquement
  - site dynamique de b2b accessible partout
  - site statique vitrine
  - database
2. besoins techiques
  - 1 server web avec php (EPR)
  - 1 server web avec php (B2B)
  - 1 server web statique
  - 1 server db MySQL
  - Accès à la DB pour les serveur web avec PHP
  - Un nom sous le ND `woodytoys.be` pour l'EPR
    (e.g. `admin.intra.woodytoys.be`)
  - Un nom sous le ND `woodytoys.be` pour le B2B (e.g. `b2b.woodytoys.be`)
  - Un nom sous le ND `woodytoys.be` pour la vitrine (e.g. `www.woodytoys.be`)
4. stack
  - HTTP server: nginx
  - DB: MySQL pcq c'est dans le CdC
  - Web framework: PHP

## Analyse mail

1. besoins client
  - redirection de `contact@woodytoys.be` vers l'email de la secrétaire.
  - redirection de `b2b@woodytoys.be` vers l'email de chaque employé.
  - un adresse mail nominative pour tout le monde.
  - pouvoir consulter son courrier depuis un client en local
  - pouvoir consulter ses mail depuis l'extérieur
2. besoins techniques
  - server mail
  - 

# Questions

- Est-ce qu'on doit conteneuriser les sites entre conteneurs
- C'est quoi les implication de mettre la DB en DMZ ou dans l'intranet ?
  - On peut décomposer la DMZ en "interne" et "externe", mais sinon le + simple
    c'est juste de la mettre en trusted zone.

# TODO

Parler des différents VLans: atelier, bureaux, trusted zone, DNS...


