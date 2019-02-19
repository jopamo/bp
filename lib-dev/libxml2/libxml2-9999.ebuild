# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit libtool flag-o-matic python-r1 autotools prefix

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"
IUSE="debug icu ipv6 lzma readline static-libs"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GNOME/${PN}.git"
	S="${WORKDIR}/${PF}"
else
	SRC_URI="https://github.com/GNOME/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

RDEPEND="
	>=lib-sys/zlib-1.2.8-r1:=
	icu? ( >=lib-dev/icu-51.2-r1:= )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1:= )
	${PYTHON_DEPS}
	readline? ( lib-sys/readline:= )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconfig
"

S="${WORKDIR}/${PN}-${PV%_rc*}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.7.1-catalog_path.patch
	"${FILESDIR}"/${PN}-9999-python-ABIFLAG.patch
)

src_prepare() {
	default
	eprefixify catalog.c xmlcatalog.c runtest.c xmllint.c
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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
		ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" install
}

src_install_all() {
	rm -rf "${ED}"/usr/share/doc
	find "${ED}" -name "*.la" -delete || die
}

pkg_postinst() {
	if [[ "${ROOT}" != "/" ]]; then
		elog "Skipping XML catalog creation for stage building (bug #208887)."
	else
		CATALOG="${EROOT}etc/xml/catalog"

		if [[ ! -e ${CATALOG} ]]; then
			[[ -d "${EROOT}etc/xml" ]] || mkdir -p "${EROOT}etc/xml"
			"${EPREFIX}"/usr/bin/xmlcatalog --create > "${CATALOG}"
			einfo "Created XML catalog in ${CATALOG}"
		fi
	fi
}
