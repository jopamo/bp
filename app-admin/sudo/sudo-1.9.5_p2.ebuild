# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${P/_/}"

DESCRIPTION="Allows users or groups to run commands as other users"
HOMEPAGE="https://www.sudo.ws/"
SRC_URI="https://www.sudo.ws/dist/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam ssl"

DEPEND="
	lib-sys/zlib
	pam? ( lib-sys/pam )
	ssl? ( virtual/ssl )
"

src_configure() {
	myconf=(
		--prefix="${EPREFIX}"/usr
		--libexecdir="${EPREFIX}"/usr/libexec
		--with-secure-path
		--with-all-insults
		--with-env-editor
		--enable-zlib=system
		--enable-tmpfiles.d="${EPREFIX}"/usr/lib/tmpfiles.d
		--with-rundir="${EPREFIX}"/run/sudo
		--with-vardir="${EPREFIX}"/var/db/sudo
    	--with-logfac=auth
    	--enable-gcrypt
    	--with-passprompt="[sudo] password for %p: "
    	--without-linux-audit
		--without-opie
		$(use_enable ssl openssl)
		$(use_with pam)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	rm -rf "${ED}"/run "${ED}"/var/db

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/sudo.pam" sudo
	fi

	insinto etc
	insopts -m0440
    doins "${FILESDIR}/sudoers"
}
