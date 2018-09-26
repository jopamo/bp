# Distributed under the terms of the GNU General Public License v2

EAPI=6

GENTOO_DEPEND_ON_PERL=no

inherit perl-module systemd flag-o-matic

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://github.com/OpenPrinting/cups-filters.git"
else
	SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.xz"
fi

DESCRIPTION="Cups filters"
HOMEPAGE="https://wiki.linuxfoundation.org/openprinting/cups-filters"
KEYWORDS="amd64 arm64 x86"
LICENSE="MIT GPL-2"
SLOT="0"
IUSE="dbus +foomatic ipp_autosetup jpeg ldap pclm pdf perl png +postscript static-libs test tiff zeroconf"

RDEPEND="
	>=app-text/poppler-0.32:=[cxx,jpeg?,lcms,tiff?,utils]
	>=app-text/qpdf-3.0.2:=
	lib-dev/glib:2
	lib-media/fontconfig
	lib-media/freetype:2
	lib-media/lcms:2
	>=lib-print/cups-1.7.3
	!<=lib-print/cups-1.5.9999
	sys-devel/bc
	lib-sys/zlib
	dbus? ( sys-app/dbus )
	foomatic? ( !lib-print/foomatic-filters )
	jpeg? ( lib-media/libjpeg-turbo )
	ldap? ( net-nds/openldap )
	pclm? ( >=app-text/qpdf-7.0_beta1 )
	pdf? ( app-text/mupdf )
	perl? ( dev-lang/perl:= )
	png? ( lib-media/libpng:0= )
	postscript? ( >=app-text/ghostscript-gpl-9.09[cups] )
	tiff? ( lib-media/tiff:0 )
	zeroconf? ( lib-net/avahi[dbus] )
"
DEPEND="${RDEPEND}
	test? ( fonts/dejavu )
"

src_prepare() {
	default
	[[ "${PV}" == "9999" ]] && eautoreconf

	# Bug #626800
	append-cxxflags -std=c++11
}

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--enable-imagefilters
		--localstatedir="${EPREFIX}"/var
		--with-browseremoteprotocols=DNSSD,CUPS
		--with-cups-rundir="${EPREFIX}"/run/cups
		--with-fontdir="fonts/conf.avail"
		--with-pdftops=pdftops
		--with-rcdir=no
		--without-php
		$(use_enable dbus)
		$(use_enable foomatic)
		$(use_enable ipp_autosetup auto-setup-driverless)
		$(use_enable ldap)
		$(use_enable pclm)
		$(use_enable pdf mutool)
		$(use_enable postscript ghostscript)
		$(use_enable postscript ijs)
		$(use_enable static-libs static)
		$(use_enable zeroconf avahi)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_configure
		perl-module_src_compile
		popd > /dev/null
	fi
}

src_install() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_install
		perl_delete_localpod
		popd > /dev/null
	fi

	if use postscript; then
		# workaround: some printer drivers still require pstoraster and pstopxl, bug #383831
		dosym gstoraster /usr/libexec/cups/filter/pstoraster
		dosym gstopxl /usr/libexec/cups/filter/pstopxl
	fi

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die

	systemd_dounit "${S}/utils/cups-browsed.service"
}

src_test() {
	emake check
}

pkg_postinst() {
	if ! use foomatic ; then
		ewarn "You are disabling the foomatic code in cups-filters. Please do that ONLY if absolutely."
		ewarn "necessary. lib-print/foomatic-filters as replacement is deprecated and unmaintained."
	fi
}
