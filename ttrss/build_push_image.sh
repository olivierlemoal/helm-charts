set -euo pipefail

IMAGE_NAME="tt-rss"
RELEASE=$(date +%Y-%m-%d)
GIT="https://git.tt-rss.org/fox/ttrss-docker-compose"
TEMP=$(mktemp -d)

git clone "$GIT" "$TEMP"
cd "$TEMP/app"
docker build -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$(date +%Y-%m-%d) -t rg.fr-par.scw.cloud/olivierlm/tt-rss:latest .
docker push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
docker push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$(date +%Y-%m-%d)"
docker rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
docker rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$(date +%Y-%m-%d)"
rm -rf "$TEMP"
