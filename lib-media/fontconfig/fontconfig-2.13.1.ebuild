# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.bz2"

LICENSE="MIT"
SLOT="1.0"
KEYWORDS="amd64 arm64"
IUSE="doc static-libs"

RDEPEND=">=lib-dev/expat-2.1.0-r3
	>=lib-media/freetype-2.5.3-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/itstool
"
PDEPEND="app-eselect/eselect-fontconfig
	fonts/liberation-fonts"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local addfonts
	use prefix && [[ -d /usr/share/fonts ]] && addfonts=",/usr/share/fonts"

	local myeconfargs=(
		$(use_enable static-libs static)
		--disable-docs
		--localstatedir="${EPREFIX}"/var
		--with-default-fonts="${EPREFIX}"/usr/share/fonts
		--with-add-fonts="${EPREFIX}/usr/local/share/fonts${addfonts}"
		--with-templatedir="${EPREFIX}"/etc/fonts/conf.avail
	)

	ECONF_SOURCE="${S}" \
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	insinto /etc/fonts
	doins fonts.conf

	find "${ED}" -name "*.la" -delete || die

	# fc-lang directory contains language coverage datafiles
	# which are needed to test the coverage of fonts.
	insinto /usr/share/fc-lang
	doins fc-lang/*.orth

	dodoc doc/fontconfig-user.{txt,pdf}

	if [[ -e ${ED}usr/share/doc/fontconfig/ ]];  then
		mv "${ED}"usr/share/doc/fontconfig/* "${ED}"/usr/share/doc/${P} || die
		rm -rf "${ED}"usr/share/doc/fontconfig
	fi

	rm -rf "${ED}"var/cache/
	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf we force update it ...
	echo 'CONFIG_PROTECT_MASK="/etc/fonts/fonts.conf"' > "${T}"/37fontconfig
	doenvd "${T}"/37fontconfig

	# As of fontconfig 2.7, everything sticks their noses in here.
	dodir /etc/sandbox.d
	echo 'SANDBOX_PREDICT="/var/cache/fontconfig"' > "${ED}"/etc/sandbox.d/37fontconfig
}

pkg_preinst() {
	ebegin "Syncing fontconfig configuration to system"
	if [[ -e ${EROOT}/etc/fonts/conf.d ]]; then
		for file in "${EROOT}"/etc/fonts/conf.avail/*; do
			f=${file##*/}
			if [[ -L ${EROOT}/etc/fonts/conf.d/${f} ]]; then
				[[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
					&& ln -sf ../conf.avail/"${f}" "${ED}"etc/fonts/conf.d/ &>/dev/null
			else
				[[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
					&& rm "${ED}"etc/fonts/conf.d/"${f}" &>/dev/null
			fi
		done
	fi
	eend $?
}

pkg_postinst() {
	einfo "Cleaning broken symlinks in "${EROOT}"etc/fonts/conf.d/"
	find -L "${EROOT}"etc/fonts/conf.d/ -type l -delete

	ebegin "Creating global font cache for ${ABI}"
	"${EPREFIX}"/usr/bin/${CHOST}-fc-cache -srf

	eselect fontconfig enable 11-lcdfilter-default.conf
	eselect fontconfig enable 10-sub-pixel-rgb.conf
	eselect fontconfig enable 60-liberation.conf
	eselect fontconfig enable 70-no-bitmaps.conf
}
