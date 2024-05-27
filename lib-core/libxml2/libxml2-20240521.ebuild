# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1 autotools flag-o-matic prefix

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

SNAPSHOT=e349709ae7e07a2183304ccc9352b6ac86f62a18
SRC_URI="https://gitlab.gnome.org/GNOME/libxml2/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="2"
#KEYWORDS="amd64 arm64"

IUSE="icu ipv6 lzma readline static-libs"

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
		$(use_enable ipv6)
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
