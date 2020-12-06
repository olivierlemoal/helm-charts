set -oue
cd docker/
docker build -t rg.fr-par.scw.cloud/olivierlm/postgresql-backup:$(date +%Y-%m-%d) -t rg.fr-par.scw.cloud/olivierlm/postgresql-backup:latest .
docker push "rg.fr-par.scw.cloud/olivierlm/postgresql-backup:latest"
docker push "rg.fr-par.scw.cloud/olivierlm/postgresql-backup:$(date +%Y-%m-%d)"
