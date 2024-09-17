# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="PAM base configuration files"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="yescrypt"

S=${WORKDIR}

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/
	default
}

src_compile() { :; }

src_test() { :; }

src_install() {
	use yescrypt && sed -i 's/sha512/yescrypt/g' system-auth

	insinto /etc/pam.d
	insopts -m0644

	for x in login other su sudo system-auth system-login system-local-login system-remote-login system-services  ; do
		doins ${x}
	done

	newins pam-common chfn
	newins pam-common chsh
	newins pam-runuser runuser
	newins pam-runuser runuser-l
	newins su su-l
}
