# Distributed under the terms of the GNU General Public License v2

inherit meson git-r3 qa-policy

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
EGIT_REPO_URI="https://github.com/jopamo/musl-bsd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="!lib-core/glibc"

PATCHES=(
	"${FILESDIR}"/0001-usrmerge-runtime-install-dirs.patch
)

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
