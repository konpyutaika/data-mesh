pushd .


REPOSITORY=konpyutaika/data-mesh/terraform-modules
SOURCE="$(git config --get remote.origin.url)"
REVISION="$(git branch --show-current)/$(git rev-parse HEAD)"

flux push artifact \
    oci://ghcr.io/${REPOSITORY}/$3:$TAG \
	--path="$2" \
	--source=$SOURCE \
	--revision=$REVISION

flux tag artifact \
    oci://ghcr.io/${REPOSITORY}/$3:$TAG \
    --tag latest

flux tag artifact \
    oci://ghcr.io/${REPOSITORY}/$3:$TAG \
    --tag $1

rm -rf $tmp_dir

popd