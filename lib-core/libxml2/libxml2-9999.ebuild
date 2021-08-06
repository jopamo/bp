# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit python-r1 autotools git-r3 flag-o-matic

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="debug icu ipv6 lzma readline static-libs"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	>=lib-core/zlib-1.2.8-r1:=
	icu? ( >=lib-dev/icu-51.2-r1:= )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1:= )
	${PYTHON_DEPS}
	readline? ( lib-core/readline:= )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconf
"

PATCHES=(
	"${FILESDIR}"/${PN}-2.7.1-catalog_path.patch
	"${FILESDIR}"/${PN}-9999-python-ABIFLAG.patch
)

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eprefixify catalog.c xmlcatalog.c runtest.c xmllint.c
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--with-html-subdir=${PF}/html \
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
