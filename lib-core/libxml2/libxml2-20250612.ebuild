# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1 autotools flag-o-matic prefix

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"
SNAPSHOT=a3992815b3d4caa4a6709406ca085c9f93856809
SRC_URI="https://gitlab.gnome.org/GNOME/libxml2/-/archive/${SNAPSHOT}/libxml2-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/libxml2-${SNAPSHOT}

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="icu lzma readline static-libs"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	lib-core/zlib
	icu? ( lib-dev/icu )
	lzma? ( app-compression/xz-utils )
	readline? ( lib-core/readline )
	${PYTHON_DEPS}
"

src_prepare() {
	filter-flags -Wl,-z,defs

	default
	eprefixify catalog.c xmlcatalog.c runtest.c xmllint.c
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_with icu)
		$(use_with lzma)
		$(use_enable static-libs static)
		$(use_with readline)
		$(use_with readline history)
		--with-python=${ROOT%/}${PYTHON}
	)
		ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install

	cleanup_install

	use static-libs || find "${ED}" -name '*.a' -delete
	dosym -r /usr/lib/libxml2.so /usr/lib/libxml2.so.2
}

pkg_postinst() {
	if [[ "${ROOT}"/ != "/" ]]; then
		elog "Skipping XML catalog creation for stage building."
	else
		CATALOG="${EROOT}"/etc/xml/catalog

		if [[ ! -e ${CATALOG} ]]; then
			[[ -d "${EROOT}"/etc/xml ]] || mkdir -p "${EROOT}"/etc/xml
			"${EPREFIX}"/usr/bin/xmlcatalog --create > "${CATALOG}"
			einfo "Created XML catalog in ${CATALOG}"

		else
			einfo "XML catalog already exists."
		fi
	fi
}
