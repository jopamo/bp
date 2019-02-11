# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal libtool toolchain-funcs flag-o-matic

BASEVERSION="0.19.8.1"
MY_P="gettext-${BASEVERSION}"
SNAPSHOT="20180703"

DESCRIPTION="GNU locale utilities"
HOMEPAGE="https://www.gnu.org/software/gettext/"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz
		https://1g4.org/files/gettext-${SNAPSHOT}.patch.tar.xz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="acl openmp static-libs"

DEPEND="acl? ( sys-app/acl )
		lib-dev/libxml2"

RDEPEND="lib-dev/expat"

MULTILIB_WRAPPED_HEADERS=(
	# only installed for native ABI
	/usr/include/gettext-po.h
)

filter-flags -flto

src_prepare() {
	eapply "${WORKDIR}"/gettext-20180703.patch
	default
	elibtoolize "${WORKDIR}"
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		# switches common to runtime and top-level
		--cache-file="${BUILD_DIR}"/config.cache
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
	if ! multilib_is_native_abi ; then
		# for non-native ABIs, we build runtime only
		ECONF_SOURCE+=/gettext-runtime
	fi

	econf "${myconf[@]}"
}

multilib_src_compile() {
	default
	cd gettext-runtime
	emake -C intl
	cd ../
}

multilib_src_install() {
	default

	if multilib_is_native_abi ; then
		dosym msgfmt /usr/bin/gmsgfmt #43435
		dobin gettext-tools/misc/gettextize
	fi

	cp -r "${ED}"/{lib,lib64,bin,sbin} "${ED}"/usr/
	rm -rf "${ED}"/{lib,lib64,bin,sbin}
}

multilib_src_install_all() {
	rm -f "${ED}"/usr/share/locale/locale.alias "${ED}"/usr/lib/charset.alias "${ED}"/usr/include/libintl.h "${ED}"/usr/share/doc/${PF}/*.html
	rm -rf "${ED}"/usr/share/doc/${PF}/{csharpdoc,examples,javadoc2,javadoc1}
}
