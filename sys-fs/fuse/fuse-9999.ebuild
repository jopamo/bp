# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit meson flag-o-matic python-single-r1 git-r3

DESCRIPTION="An interface for filesystems implemented in userspace"
HOMEPAGE="https://github.com/libfuse/libfuse"
EGIT_REPO_URI="https://github.com/libfuse/libfuse.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-util/pkgconfig
	test? (
		${PYTHON_DEPS}
		dev-python/pytest[${PYTHON_USEDEP}]
	)
		"

filter-flags -flto

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_test() {
	python3 -m pytest test || die
}

src_install() {
	meson_src_install
	rm -r "${ED%/}"/usr/share/man || die
}
