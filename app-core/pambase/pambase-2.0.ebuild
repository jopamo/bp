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

	for x in chage chfn chsh login passwd runuser runuser-l sshd su sudo system-auth system-local-login system-remote-login ; do
		doins ${x}
	done
}
