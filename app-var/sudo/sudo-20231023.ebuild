# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Allows users or groups to run commands as other users"
HOMEPAGE="https://www.sudo.ws/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/sudo-project/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=bf722e18b7b0abf26a1be3ba1aadd33a6a69da57
	SRC_URI="https://github.com/sudo-project/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="ISC BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam ssl tmpfilesd"

DEPEND="
	lib-core/zlib
	pam? ( lib-core/pam )
	ssl? ( virtual/ssl )
"

src_configure() {
	myconf=(
		--prefix="${EPREFIX}"/usr
		--libexecdir="${EPREFIX}"/usr/libexec
		--enable-tmpfiles.d=$(usex tmpfilesd "${EPREFIX}"/usr/lib/tmpfiles.d "false")
		--enable-zlib=system
		--with-all-insults
		--with-env-editor
		--with-rundir="${EPREFIX}"/run/sudo
		--with-secure-path
		--with-vardir="${EPREFIX}"/var/db/sudo
		--without-opie
    	--enable-gcrypt
    	--with-logfac=auth
    	--with-passprompt="[sudo] password for %p: "
    	--without-linux-audit
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
