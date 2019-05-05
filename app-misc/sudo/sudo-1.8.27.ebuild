# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Allows users or groups to run commands as other users"
HOMEPAGE="https://www.sudo.ws/"
SRC_URI="https://www.sudo.ws/dist/${P}.tar.gz"

LICENSE="ISC BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam"

src_configure() {
	myeconfargs=(
		--prefix="${EPREFIX}"/usr
		--libexecdir="${EPREFIX}"/usr/libexec
		--with-secure-path
		--with-all-insults
		--with-env-editor
		--enable-zlib=system
		--enable-tmpfiles.d="${EPREFIX}"/usr/lib/tmpfiles.d
		--with-rundir="${EPREFIX}"/run/sudo
		--with-vardir="${EPREFIX}"/var/db/sudo
		--without-linux-audit
		--without-opie
		--enable-openssl
		$(use_with pam)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	rm -rf "${ED}"/run "${ED}"/var/db
}
