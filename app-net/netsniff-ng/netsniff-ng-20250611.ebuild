# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic autotools

DESCRIPTION="A Swiss army knife for your daily Linux network plumbing"
HOMEPAGE="http://www.aircrack-ng.org"

SNAPSHOT=1af7ae33e3e8178ab5c649c3a52838d4375c4228
SRC_URI="https://github.com/netsniff-ng/netsniff-ng/archive/${SNAPSHOT}.tar.gz -> netsniff-ng-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/netsniff-ng-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug geoip zlib"

src_prepare() {
	default

	# force mausezahn to respect CFLAGS
	sed -e '/CFLAGS/s:=:+=:' -i Extra || die
	sed -e 's/ -O2//' -i mausezahn/Makefile || die

	# do not compress man pages by default
	sed \
		-e '/gzip/s@\$(Q).*$@$(Q)cp $(1).8 $(1)/$(1).8@' \
		-e 's@\.8\.gz@.8@' \
		-i Template || die
}

src_configure() {
	local myconfargs=(
		--prefix="${EPREFIX}/usr"
		--sysconfdir="${EPREFIX}/etc"
		$(usex debug --enable-debug '')
		$(usex geoip '' --disable-geoip)
		$(usex zlib '' --disable-zlib)
	)
	# not an autoconf generated configure
	./configure "${myconfargs[@]}" || die
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" CCACHE="" Q=
}

src_install() {
	emake PREFIX="${ED}/usr" ETCDIR="${ED}/etc" install

	dodoc AUTHORS README REPORTING-BUGS
}
