# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

RTM_NAME="NSS_${PV//./_}_RTM"
# Rev of https://git.fedorahosted.org/cgit/nss-pem.git
PEM_GIT_REV="429b0222759d8ad8e6dcd29e62875ae3efd69116"
PEM_P="${PN}-pem-20160329"

DESCRIPTION="Mozilla's Network Security Services library that implements PKI support"
HOMEPAGE="http://www.mozilla.org/projects/security/pki/nss/"
SRC_URI="https://archive.mozilla.org/pub/security/nss/releases/${RTM_NAME}/src/${P}.tar.gz
	cacert? ( https://dev.gentoo.org/~axs/distfiles/${PN}-cacert-class1-class3.patch )
	nss-pem? ( https://dev.gentoo.org/~polynomial-c/${PEM_P}.tar.xz )"

LICENSE="|| ( MPL-2.0 GPL-2 LGPL-2.1 )"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="cacert +nss-pem static-libs"

DEPEND="dev-util/pkgconf
		lib-dev/nspr
		>=lib-sys/sqlite-3.8.2
		>=lib-sys/zlib-1.2.8-r1"

RESTRICT="test"

S="${WORKDIR}/${P}/${PN}"

PATCHES=(
	"${FILESDIR}/${PN}-3.32-gentoo-fixups.patch"
	"${FILESDIR}/${PN}-3.21-gentoo-fixup-warnings.patch"
)

src_unpack() {
	unpack ${A}
	if use nss-pem ; then
		mv "${PN}"/lib/ckfw/pem/ "${S}"/lib/ckfw/ || die
	fi
}

src_prepare() {
	if use nss-pem ; then
		PATCHES+=(
			"${FILESDIR}/${PN}-3.21-enable-pem.patch"
		)
	fi
	if use cacert ; then #521462
		PATCHES+=(
			"${DISTDIR}/${PN}-cacert-class1-class3.patch"
		)
	fi

	default

	pushd coreconf >/dev/null || die
	# hack nspr paths
	echo 'INCLUDES += -I$(DIST)/include/dbm' \
		>> headers.mk || die "failed to append include"

	# modify install path
	sed -e '/CORE_DEPTH/s:SOURCE_PREFIX.*$:SOURCE_PREFIX = $(CORE_DEPTH)/dist:' \
		-i source.mk || die

	# Respect LDFLAGS
	sed -i -e 's/\$(MKSHLIB) -o/\$(MKSHLIB) \$(LDFLAGS) -o/g' rules.mk
	popd >/dev/null || die

	# Fix pkgconfig file for Prefix
	sed -i -e "/^PREFIX =/s:= /usr:= ${EPREFIX}/usr:" \
		config/Makefile || die

	# use host shlibsign if need be #436216
	if tc-is-cross-compiler ; then
		sed -i \
			-e 's:"${2}"/shlibsign:shlibsign:' \
			cmd/shlibsign/sign.sh || die
	fi

	# dirty hack
	sed -i -e "/CRYPTOLIB/s:\$(SOFTOKEN_LIB_DIR):../freebl/\$(OBJDIR):" \
		lib/ssl/config.mk || die
	sed -i -e "/CRYPTOLIB/s:\$(SOFTOKEN_LIB_DIR):../../lib/freebl/\$(OBJDIR):" \
		cmd/platlibs.mk || die
}

nssarch() {
	# Most of the arches are the same as $ARCH
	local t=${1:-${CHOST}}
	case ${t} in
		aarch64*)echo "aarch64";;
		x86_64*) echo "x86_64";;
		*)       tc-arch ${t};;
	esac
}

nssbits() {
	local cc cppflags="${1}CPPFLAGS" cflags="${1}CFLAGS"
	if [[ ${1} == BUILD_ ]]; then
		cc=$(tc-getBUILD_CC)
	else
		cc=$(tc-getCC)
	fi
	echo > "${T}"/test.c || die
	${cc} ${!cppflags} ${!cflags} -c "${T}"/test.c -o "${T}/${1}test.o" || die
	case $(file "${T}/${1}test.o") in
		*64-bit*|*x86_64*) echo USE_64=1;;
		*) die "Failed to detect whether ${cc} is working.";;
	esac
}

src_compile() {
	# use ABI to determine bit'ness, or fallback if unset
	local buildbits mybits
	case "${ABI}" in
		*64) mybits="USE_64=1";;
		${DEFAULT_ABI})
			einfo "Running compilation test to determine bit'ness"
			mybits=$(nssbits)
			;;
	esac
	# bitness of host may differ from target
	if tc-is-cross-compiler; then
		buildbits=$(nssbits BUILD_)
	fi

	local makeargs=(
		CC="$(tc-getCC)"
		AR="$(tc-getAR) rc \$@"
		RANLIB="$(tc-getRANLIB)"
		OPTIMIZER=
		${mybits}
	)

	# Take care of nspr settings #436216
	local myCPPFLAGS="${CPPFLAGS} $($(tc-getPKG_CONFIG) nspr --cflags)"
	unset NSPR_INCLUDE_DIR

	# Do not let `uname` be used.
	makeargs+=(
			OS_TARGET=Linux
			OS_RELEASE=5.1
			OS_TEST="$(nssarch)"
	)

	export NSS_ENABLE_WERROR=0 #567158
	export BUILD_OPT=1
	export NSS_USE_SYSTEM_SQLITE=1
	export NSDISTMODE=copy
	export NSS_ENABLE_ECC=1
	export FREEBL_NO_DEPEND=1
	export ASFLAGS=""

	local d

	# Build the host tools first.
	LDFLAGS="${BUILD_LDFLAGS}" \
	XCFLAGS="${BUILD_CFLAGS}" \
	NSPR_LIB_DIR="${T}/fakedir" \
	emake -j1 -C coreconf \
		CC="$(tc-getBUILD_CC)" \
		${buildbits:-${mybits}}
	makeargs+=( NSINSTALL="${PWD}/$(find -type f -name nsinstall)" )

	# Then build the target tools.
	for d in . lib/dbm ; do
		CPPFLAGS="${myCPPFLAGS}" \
		XCFLAGS="${CFLAGS} ${CPPFLAGS}" \
		NSPR_LIB_DIR="${T}/fakedir" \
		emake -j1 "${makeargs[@]}" -C ${d}
	done
}

# Altering these 3 libraries breaks the CHK verification.
# All of the following cause it to break:
# - stripping
# - prelink
# - ELF signing
# http://www.mozilla.org/projects/security/pki/nss/tech-notes/tn6.html
# Either we have to NOT strip them, or we have to forcibly resign after
# stripping.
#local_libdir="lib"
#export STRIP_MASK="
#	*/${local_libdir}/libfreebl3.so*
#	*/${local_libdir}/libnssdbm3.so*
#	*/${local_libdir}/libsoftokn3.so*"

export NSS_CHK_SIGN_LIBS="freebl3 nssdbm3 softokn3"

generate_chk() {
	local shlibsign="$1"
	local libdir="$2"
	einfo "Resigning core NSS libraries for FIPS validation"
	shift 2
	local i
	for i in ${NSS_CHK_SIGN_LIBS} ; do
		local libname=lib${i}.so
		local chkname=lib${i}.chk
		"${shlibsign}" \
			-i "${libdir}"/${libname} \
			-o "${libdir}"/${chkname}.tmp \
		&& mv -f \
			"${libdir}"/${chkname}.tmp \
			"${libdir}"/${chkname} \
		|| die "Failed to sign ${libname}"
	done
}

cleanup_chk() {
	local libdir="$1"
	shift 1
	local i
	for i in ${NSS_CHK_SIGN_LIBS} ; do
		local libfname="${libdir}/lib${i}.so"
		# If the major version has changed, then we have old chk files.
		[ ! -f "${libfname}" -a -f "${libfname}.chk" ] \
			&& rm -f "${libfname}.chk"
	done
}

src_install() {
	pushd dist >/dev/null || die

	dodir /usr/lib
	cp -rL */lib/* "${ED%/}"/usr/lib || die "copying shared libs failed"
	local i
	for i in crmf freebl nssb nssckfw ; do
		cp -L */lib/lib${i}.a "${ED%/}"/usr/lib || die "copying libs failed"
	done

	# Install nss-config and pkgconfig file
	dodir /usr/bin
	cp -L */bin/nss-config "${ED%/}"/usr/bin || die
	dodir /usr/lib/pkgconfig
	cp -L */lib/pkgconfig/nss.pc "${ED%/}"/usr/lib/pkgconfig || die

	# create an nss-softokn.pc from nss.pc for libfreebl and some private headers
	# bug 517266
	sed 	-e 's#Libs:#Libs: -lfreebl#' \
		-e 's#Cflags:#Cflags: -I${includedir}/private#' \
		*/lib/pkgconfig/nss.pc >"${ED%/}"/usr/lib/pkgconfig/nss-softokn.pc \
		|| die "could not create nss-softokn.pc"

	# all the include files
	insinto /usr/include/nss
	doins public/nss/*.{h,api}
	insinto /usr/include/nss/private
	doins private/nss/{blapi,alghmac}.h

	popd >/dev/null || die

	# Prelink breaks the CHK files. We don't have any reliable way to run
	# shlibsign after prelink.
	dodir /etc/prelink.conf.d
	printf -- "-b ${EPREFIX}/usr/lib/lib%s.so\n" ${NSS_CHK_SIGN_LIBS} \
		> "${ED%/}"/etc/prelink.conf.d/nss.conf

	use static-libs || find "${ED}" -name '*.a' -delete
}

pkg_postinst() {
		# We must re-sign the libraries AFTER they are stripped.
		local shlibsign="${EROOT}/usr/bin/shlibsign"
		# See if we can execute it (cross-compiling & such). #436216
		"${shlibsign}" -h >&/dev/null
		if [[ $? -gt 1 ]] ; then
			shlibsign="shlibsign"
		fi
		generate_chk "${shlibsign}" "${EROOT}"/usr/lib

}

pkg_postrm() {
		cleanup_chk "${EROOT}"/usr/lib
}
