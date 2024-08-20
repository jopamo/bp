# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=fa3b914457773d5a0bb02b382862dafd1c4c357e

inherit autotools

DESCRIPTION="Git is a fast, scalable, distributed revision control system"
HOMEPAGE="http://www.git-scm.com/"

SRC_URI="https://github.com/git/git/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+curl static-libs perl gitweb"

DEPEND="
	app-build/gettext
	app-net/curl
	lib-core/libpcre2
	lib-core/expat
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-libpcre2
		--with-curl
		--with-expat
		--without-openssl
		--without-tcltk
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	rm -f "${ED}"/usr/bin/git-{cvsserver,shell}
	rm -f "${ED}"/usr/libexec/git-core/git-{shell,cvs*,http-push,http-fetch,imap-send,daemon,http-backend}

	for i in git-receive-pack git-upload-archive git-upload-pack ; do
		rm "${ED}"/usr/bin/$i
		dosym -r /usr/bin/git /usr/bin/$i
	done

	use static-libs || find "${ED}" -name "*.a" -delete || die
	use perl || rm -rf "${ED}"/usr/share/perl5 || die
	use gitweb || rm -rf "${ED}"/usr/share/gitweb || die

	insopts -m 0644
	insinto /etc
	doins "${FILESDIR}"/gitconfig
}
