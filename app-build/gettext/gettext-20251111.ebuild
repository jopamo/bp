# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit libtool flag-o-matic

DESCRIPTION="GNU locale utilities"
HOMEPAGE="https://www.gnu.org/software/gettext/"
SNAPSHOT=637b208fbe13f1c306f19d4f31c21fec7e9986d2
SRC_URI="https://github.com/1g4-mirror/gettext/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="acl keep-la openmp static-libs"

DEPEND="acl? ( app-core/acl )
		app-compression/xz-utils
		lib-core/libxml2"

RDEPEND="lib-core/expat"

src_prepare() {
	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die

	if [[ -d gnulib/.git ]]; then
		git -C gnulib reset --hard 6fd6098 || die
	else
		die "BROOT:/usr/share/gnulib is not a git checkout, cannot reset"
	fi

	echo "${PV}" > .tarball-version || die
	
	touch gettext-tools/tree-sitter.cfg

	./autogen.sh || die

	append-flags -lm
	filter-flags -Wl,-z,defs -flto*

	default
	elibtoolize "${WORKDIR}"
}

src_configure() {
	local myconf=(
		$(use_enable acl)
		$(use_enable openmp)
		$(use_enable static-libs static)
		--enable-c++
		--enable-libasprintf
		--enable-nls
		--with-included-gettext
		--with-included-glib
		--with-included-libcroco
		--with-included-libunistring
		--with-xz
		--without-emacs
		--without-included-libxml
		--without-lispdir
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
    emake DESTDIR="${ED}" install

    dosym -r /usr/bin/msgfmt /usr/bin/gmsgfmt
    dobin gettext-tools/misc/gettextize

    rm -f "${ED}/usr/share/locale/locale.alias" \
          "${ED}/usr/lib/charset.alias" \
          "${ED}/usr/include/libintl.h"

	mkdir -p "${ED}/usr/share/gettext-${PV}" || die
    cp -rp "${ED}"/usr/share/gettext/* "${ED}/usr/share/gettext-${PV}"/ || die
    rm -rf "${ED}/usr/share/gettext"
    mv "${ED}/usr/share/gettext-${PV}" "${ED}/usr/share/gettext" || die
    dosym -r /usr/share/gettext /usr/share/gettext-"${PV}"
    rm "${ED}/usr/share/gettext/its/gtkbuilder.its" || die

	dodir /usr/share/aclocal
    for x in build-to-host gettext host-cpu-c-abi iconv lib-ld lib-link lib-prefix nls po progtest ; do
		dosym -r /usr/share/gettext/m4/${x}.m4 /usr/share/aclocal/${x}.m4
	done

	cleanup_install
	dedup_symlink "${ED}"
}



