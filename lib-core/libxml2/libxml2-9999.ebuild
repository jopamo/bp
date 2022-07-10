# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1 autotools flag-o-matic

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=c9925454fd384a17c8c03d358c6778a552e9287b
	SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="2"

IUSE="debug icu ipv6 lzma readline static-libs"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	lib-core/zlib
	icu? ( lib-dev/icu )
	lzma? ( app-compression/xz-utils )
	readline? ( lib-core/readline )
	${PYTHON_DEPS}
"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eprefixify catalog.c xmlcatalog.c runtest.c xmllint.c
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-html-subdir=${PF}/html
		$(use_with debug run-debug)
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
