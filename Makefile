install-snapshot:
	# Clear logs.
	rm cmd/templ/lspcmd/*.txt || true
	# Install the latest version.
	cd cmd/templ && go build -o ~/bin/templ

build-snapshot:
	goreleaser build --snapshot --rm-dist

test:
	templ generate && go test ./...

release: 
	if [ "${GITHUB_TOKEN}" == "" ]; then echo "No github token, run:"; echo "export GITHUB_TOKEN=`pass github.com/goreleaser_access_token`"; exit 1; fi
	./push-tag.sh
	goreleaser --rm-dist
