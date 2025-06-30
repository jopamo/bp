# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="an android OTA payload dumper"
HOMEPAGE="https://github.com/ssut/payload-dumper-go"

SNAPSHOT=a51234eaead276ff3d8b8c4c439c51c7f46a96a8
SRC_URI="https://github.com/ssut/payload-dumper-go/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-tex/go-md2man"

RESTRICT+=" test"

src_compile() {
	go build || die
}

src_install() {
	go-md2man -in README.md -out payload-dumper-go.1 ||	die "Unable to create man page"
	dobin payload-dumper-go
	doman payload-dumper-go.1
}

src_test() {
	emake test
}
