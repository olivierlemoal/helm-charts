set -euo pipefail

IMAGE_NAME="postgresql-backup"
RELEASE=$(date +%Y-%m-%d)

buildah build -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest docker/
buildah push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
buildah push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE"
buildah rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE"
buildah rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
