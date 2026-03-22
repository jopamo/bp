# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson qa-policy

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
SNAPSHOT=ab62557bb1af8450db37d329e1354537010ac285
SRC_URI="https://github.com/jopamo/musl-bsd/archive/${SNAPSHOT}.tar.gz -> musl-bsd-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/musl-bsd-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="!lib-core/glibc"

src_configure() {
	qa-policy-configure
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
