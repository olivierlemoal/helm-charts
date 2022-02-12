set -euo pipefail

IMAGE_NAME="rss-bridge"
RELEASE=$(date +%Y-%m-%d)
GIT="https://github.com/rss-bridge/rss-bridge/"
TEMP=$(mktemp -d)

git clone --depth 1 "$GIT" "$TEMP"
#wget https://raw.githubusercontent.com/RSS-Bridge/rss-bridge/e95aac6c79f19fa4feda8303fcc69f43c7972503/bridges/TwitterBridge.php -O $TEMP/bridges/TwitterBridge.php
buildah build -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE -t rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest $TEMP
buildah push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
buildah push "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE"
buildah rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:$RELEASE"
buildah rmi "rg.fr-par.scw.cloud/olivierlm/$IMAGE_NAME:latest"
rm -rf "$TEMP"
