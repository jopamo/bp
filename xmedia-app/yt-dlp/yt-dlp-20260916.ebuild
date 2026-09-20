# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"
DISTUTILS_USE_PEP517=hatchling
EJS_VERSION=0.8.0

inherit distutils-r1

DESCRIPTION="a command-line program to download videos from YouTube.com and a few more sites"
HOMEPAGE="https://github.com/yt-dlp/yt-dlp"

SNAPSHOT=c7fb478d21e9e59524befbe23f7801bb267fb880
SRC_URI="https://github.com/yt-dlp/yt-dlp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/yt-dlp-${SNAPSHOT}"

LICENSE="unlicense"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND+="
	>=app-server/nodejs-22
	=xmedia-app/yt-dlp-ejs-${EJS_VERSION}[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# Lockstep updates the snapshot, but does not resolve optional Python extras.
	python_setup
	"${EPYTHON}" - "${EJS_VERSION}" <<'PY' || die "Update the EJS runtime dependency to match upstream"
import sys
import tomllib

with open("pyproject.toml", "rb") as f:
    extras = tomllib.load(f)["project"]["optional-dependencies"]["default"]
if f"yt-dlp-ejs=={sys.argv[1]}" not in extras:
    raise SystemExit("yt-dlp's EJS requirement changed")
PY

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	# compatibility symlink
	dosym -r /usr/bin/yt-dlp /usr/bin/youtube-dl

	# default config
	cat > "${T}/yt-dlp.conf" <<'EOF'
--no-js-runtimes
--js-runtimes node:/usr/bin/node
EOF

	insinto /etc
	doins "${T}/yt-dlp.conf"
}
