# Distributed under the terms of the GNU General Public License v2

inherit go-module

DESCRIPTION="Proton Mail Bridge application (CLI only)"
HOMEPAGE="https://github.com/ProtonMail/proton-bridge"
SNAPSHOT=389da9b66e5f883c8ca1d761b26aa4c3a5717f35
SRC_URI="https://github.com/ProtonMail/proton-bridge/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-tex/go-md2man
"

PATCHES=(
	"${FILESDIR}/${PN}-no-gui-nolibsecret-nofido.patch"
)

src_prepare() {
	default

	cd "${S}/utils" || die
	./credits.sh bridge || die
}

src_compile() {
	emake BUILD_TAGS="nolibsecret nofido" build-nogui
}

src_install() {
	go-md2man -in README.md -out ${PN}.1 || die "Unable to create man page"

	newbin bridge proton-bridge
	doman ${PN}.1
}
