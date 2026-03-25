# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="provides APIs to access kernel tracepoint events"
HOMEPAGE="https://kernel.org/"

SNAPSHOT=13701b5532e0c3295bf5670361692b0d0044228d
SRC_URI="https://github.com/1g4-mirror/libtraceevent/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Ddoc=false
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	qa-policy-install
}
