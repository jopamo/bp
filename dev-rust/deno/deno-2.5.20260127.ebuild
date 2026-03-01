# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1-2)"

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"

SNAPSHOT=8533c169419c6c92069cb5981a73ee9c36d19798
SRC_URI="https://github.com/denoland/deno/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

export BINDGEN_EXTRA_CLANG_ARGS="-include sys/socket.h -include netinet/in.h -include stdio.h"

src_prepare() {
	use elibc_musl && export V8_FROM_SOURCE=1
	default
	eapply "${FILESDIR}"/build_fixes.patch
}

src_install() {
	dobin target/release/"${PN}"
}
