# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR_VERSION="2.5.5"

inherit autotools dot-a

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="https://github.com/seccomp/libseccomp"
SNAPSHOT=4b0bf5064cae3b4eac88020b31ce0ef43da0e3f9
SRC_URI="https://github.com/seccomp/libseccomp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libseccomp-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="virtual/linux-sources"
BDEPEND="app-dev/gperf"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf
	sed -i -e "s/0.0.0/${MAJOR_VERSION}/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
