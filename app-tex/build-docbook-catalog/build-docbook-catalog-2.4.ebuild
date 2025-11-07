# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE="https://docbook.org/"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/util-linux
	lib-core/libxml2
"

src_prepare() {
	# Copy the upstream script into WORKDIR so we patch it in place
	cp "${FILESDIR}/build-docbook-catalog" "${S}/build-docbook-catalog" || die "failed to copy build-docbook-catalog"
	# Adjust destination from sbin to bin
	sed -i 's|$(PREFIX)/sbin|$(PREFIX)/bin|' "${S}/build-docbook-catalog" || die
	# Ensure correct shebang prefix
	sed -i -e "1s@#!@#!${EPREFIX}@" "${S}/build-docbook-catalog" || die
	# Patch EPREFIX variable inside script
	sed -i -e "/^EPREFIX=/s:=.*:='${EPREFIX}':" "${S}/build-docbook-catalog" || die
	# If util-linux is not present, enable long getopt
	has_version app-core/util-linux || sed -i -e '/^GETOPT=/s/getopt/& -long/' "${S}/build-docbook-catalog" || die

	default
}

src_configure() {
	# nothing to configure
	:
}

src_install() {
	# install the script
	exeinto /usr/bin
	doexe "${S}/build-docbook-catalog" build-docbook-catalog
}

pkg_postinst() {
	build-docbook-catalog || die "Failed to regenerate docbook catalog."
}
