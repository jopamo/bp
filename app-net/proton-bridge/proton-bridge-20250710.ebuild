# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Proton Mail Bridge application (CLI only)"
HOMEPAGE="https://github.com/ProtonMail/proton-bridge"
SNAPSHOT=c32c431640026b25609b1926a3d6380c7f4f15da
SRC_URI="https://github.com/ProtonMail/proton-bridge/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-tex/go-md2man
"
DEPEND="
	app-crypto/libsecret
"
RESTRICT="test network-sandbox"

src_prepare() {
	default

	cd "${S}/utils" || die
	./credits.sh bridge || die
	cd "${S}" || die
}

src_compile() {
	# go-module/go-env provide sane GOPATH/GOMODCACHE/GOCACHE
	go build -v -o proton-bridge ./cmd/Desktop-Bridge || die
}

src_install() {
	go-md2man -in README.md -out ${PN}.1 || die "Unable to create man page"
	dobin proton-bridge
	doman ${PN}.1
}
