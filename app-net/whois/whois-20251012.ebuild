# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_P=${P/-/_}
DESCRIPTION="Improved Whois Client"
HOMEPAGE="https://salsa.debian.org/md/whois"
SNAPSHOT=64c3426493e145e1fad33a37247e924b0539e4dd
SRC_URI="https://salsa.debian.org/md/whois/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-core/libxcrypt
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	sed -i -e '/ENABLE_NLS/s:define:undef:' config.h || die

	sed -i -e '/^all:/s/ pos//' \
		-e '/^install:/s/ install-pos//' Makefile || die
}

src_configure() { :; } # expected no-op

src_compile() {
	export HAVE_ICONV=1
	export HAVE_XCRYPT=1

	tc-export CC

	emake CFLAGS="${CFLAGS} ${CPPFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install

	insinto /etc
	doins whois.conf
}
