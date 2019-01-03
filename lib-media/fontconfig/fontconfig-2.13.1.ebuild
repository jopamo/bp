# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.bz2"

LICENSE="MIT"
SLOT="1.0"
KEYWORDS="amd64 arm64 x86"
IUSE="doc static-libs"

RDEPEND=">=lib-dev/expat-2.1.0-r3[${MULTILIB_USEDEP}]
	>=lib-media/freetype-2.5.3-r1[${MULTILIB_USEDEP}]
	abi_x86_32? ( !app-misc/emul-linux-x86-xlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/itstool
"
PDEPEND="!x86-winnt? ( app-eselect/eselect-fontconfig )
	fonts/liberation-fonts"

MULTILIB_CHOST_TOOLS=( /usr/bin/fc-cache$(get_exeext) )

pkg_setup() {
	DOC_CONTENTS="Please make fontconfig configuration changes using
	\`eselect fontconfig\`. Any changes made to /etc/fonts/fonts.conf will be
	overwritten. If you need to reset your configuration to upstream defaults,
	delete the directory ${EROOT}etc/fonts/conf.d/ and re-emerge fontconfig."
}

src_prepare() {
	default
	export GPERF=$(type -P true)  # avoid dependency on gperf, #631980
	sed -i -e 's/FC_GPERF_SIZE_T="unsigned int"/FC_GPERF_SIZE_T=size_t/' \
		configure.ac || die # rest of gperf dependency fix, #631920
	eautoreconf
}

multilib_src_configure() {
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

multilib_src_install() {
	default

	# avoid calling this multiple times, bug #459210
	if multilib_is_native_abi; then
		# stuff installed from build-dir
		emake -C doc DESTDIR="${D}" install-man

		insinto /etc/fonts
		doins fonts.conf
	fi
}

multilib_src_install_all() {
	einstalldocs
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

	if [[ ${ROOT} = / ]]; then
		multilib_pkg_postinst() {
			ebegin "Creating global font cache for ${ABI}"
			"${EPREFIX}"/usr/bin/${CHOST}-fc-cache -srf
			eend $?
		}

		multilib_parallel_foreach_abi multilib_pkg_postinst
		
		eselect fontconfig enable 11-lcdfilter-default.conf
		eselect fontconfig enable 10-sub-pixel-rgb.conf
		eselect fontconfig enable 60-liberation.conf
	fi
}
