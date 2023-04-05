#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/Multiverse-io/build_pipeline"
TOOL_NAME="build_pipeline"
TOOL_TEST="bp --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if build_pipeline is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/releases/download/v${version}/bp"

	echo "* Downloading $TOOL_NAME release $version..."
	echo "Logging about to download with curl with args:"
	echo "${curl_opts[@]}"
	echo "$filename"
	echo "$url"

	#echo "Logging: calling curl an ugly way for debugging purposes!"
	#curl -fsSL -o /Users/bernersiscool/.asdf/downloads/build_pipeline/0.0.8/bp -C - https://github.com/Multiverse-io/build_pipeline/releases/download/v0.0.8/bp || fail "NOOOO!"
	#echo "Exiting on purpose! ARGHH!"
	#exit 1
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"

	echo "Logging: looking at downloaded file"
	ls "$filename"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bp"

	echo "Logging: install_version 3rd arg"
	echo $3
	echo "Logging: install_version_args"
	echo $@
	#echo "Logging: install_path $install_path"
	#ls $install_path

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

		echo "Logging: install_path/tool_cmd $install_path/$tool_cmd"
		ls $install_path/$tool_cmd
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
