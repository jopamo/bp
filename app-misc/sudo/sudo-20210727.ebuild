# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Allows users or groups to run commands as other users"
HOMEPAGE="https://www.sudo.ws/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/sudo-project/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=aee82efe45ccdaa9c5ddd4bf0bf7da757822713d
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
		--with-secure-path
		--with-all-insults
		--with-env-editor
		--enable-zlib=system
		--enable-tmpfiles.d=$(usex tmpfilesd "${EPREFIX}"/usr/lib/tmpfiles.d "false")
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
