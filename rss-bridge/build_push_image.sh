set -euo pipefail

IMAGE_NAME="rss-bridge"
RELEASE=$(date +%Y-%m-%d)
GIT="https://github.com/RSS-Bridge/rss-bridge/"
TEMP=$(mktemp -d)

git clone "$GIT" "$TEMP"
cd "$TEMP"
docker build -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest $TEMP
docker push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
docker push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE"
docker rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE"
docker rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
rm -rf "$TEMP"
