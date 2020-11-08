# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit libtool flag-o-matic

DESCRIPTION="GNU locale utilities"
HOMEPAGE="https://www.gnu.org/software/gettext/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl openmp static-libs"

DEPEND="acl? ( sys-app/acl )
		app-compression/xz-utils
		lib-dev/libxml2"

RDEPEND="lib-dev/expat"

append-flags -lm
filter-flags -Wl,-z,defs

src_prepare() {
	default
	elibtoolize "${WORKDIR}"
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--docdir="\$(datarootdir)/doc/${PF}"
		--without-emacs
		--without-lispdir
		--with-included-glib
		--with-included-libcroco
		--with-included-libunistring
		--without-included-libxml
		--with-included-gettext
		--enable-c++
		--enable-libasprintf
		$(use_enable acl)
		--enable-nls
		--with-xz
		$(use_enable openmp)
		$(use_enable static-libs static)
	)

	local ECONF_SOURCE=${S}

	econf "${myconf[@]}"
}

src_compile() {
	default
	cd gettext-runtime
	emake -C intl
	cd ../
}

src_install() {
	default

	dosym msgfmt /usr/bin/gmsgfmt #43435
	dobin gettext-tools/misc/gettextize

	rm -f "${ED}"/usr/share/locale/locale.alias "${ED}"/usr/lib/charset.alias "${ED}"/usr/include/libintl.h
}
