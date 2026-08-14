# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic autotools qa-policy

DESCRIPTION="Cups filters"
HOMEPAGE="https://github.com/OpenPrinting/cups-filters"
SNAPSHOT=82acfaf1e1515555d570638875b819a213095b50
SRC_URI="https://github.com/OpenPrinting/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="foomatic"

DEPEND="
	lib-print/cups
	lib-print/libppd
	lib-print/libcupsfilters
"

src_prepare() {
	default
	append-flags "-fpermissive -std=gnu17"
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-imagefilters
		--enable-driverless
		--enable-poppler
		--localstatedir="${EPREFIX}"/var
		--with-fontdir="fonts/conf.avail"
		# These are just probed for the path. Always enable them.
		--with-gs-path="${EPREFIX}"/usr/bin/gs
		--with-mutool-path="${EPREFIX}"/usr/bin/mutool

		$(use_enable foomatic)
	)

	qa-policy-configure
	CONFIG_SHELL="${BROOT}"/bin/bash econf "${myeconfargs[@]}"
}

src_install() {
	# Upstream install rules are not parallel-safe: multiple install targets race
	# on creating usr/{bin,libexec/cups/*,share/*} and fail on EEXIST.
	emake -j1 DESTDIR="${ED}" install || die
	qa-policy-install
}
