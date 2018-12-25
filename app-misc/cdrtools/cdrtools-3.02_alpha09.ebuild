# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit fcaps multilib toolchain-funcs flag-o-matic gnuconfig

MY_P="${P/_alpha/a}"

DESCRIPTION="A set of tools for CD/DVD reading and recording, including cdrecord"
HOMEPAGE="https://sourceforge.net/projects/cdrtools/"
SRC_URI="mirror://sourceforge/${PN}/$([[ -z ${PV/*_alpha*} ]] && echo 'alpha')/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 CDDL-Schily"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="acl caps nls unicode"

RDEPEND="acl? ( sys-app/acl )
	caps? ( lib-sys/libcap )
	nls? ( sys-devel/gettext )
	!app-misc/cdrkit"
DEPEND="${RDEPEND}
	x11/makedepend
	nls? ( >=sys-devel/gettext-0.18.1.1 )"

S=${WORKDIR}/${P/_alpha[0-9][0-9]}

FILECAPS=(
	cap_sys_resource,cap_dac_override,cap_sys_admin,cap_sys_nice,cap_net_bind_service,cap_ipc_lock,cap_sys_rawio+ep usr/bin/cdrecord --
	cap_dac_override,cap_sys_admin,cap_sys_nice,cap_net_bind_service,cap_sys_rawio+ep usr/bin/cdda2wav --
	cap_dac_override,cap_sys_admin,cap_net_bind_service,cap_sys_rawio+ep usr/bin/readcd
)

src_prepare() {
	default

	gnuconfig_update

	# This fixes a clash with clone() on uclibc.  Upstream isn't
	# going to include this so let's try to carry it forward.
	# Contact me if it needs updating.  Bug #486782.
	# Anthony G. Basile <blueness@gentoo.org>.
	use elibc_uclibc && epatch "${FILESDIR}"/${PN}-fix-clone-uclibc.patch

	# Remove profiled make files.
	find -name '*_p.mk' -delete || die "delete *_p.mk"

	# Adjusting hardcoded paths.
	sed -i -e "s|opt/schily|usr|" \
		$(find ./ -type f -name \*.[0-9ch] -exec grep -l 'opt/schily' '{}' '+') \
		|| die "sed opt/schily"

	sed -i -e "s|\(^INSDIR=\t\tshare/doc/\)|\1${PF}/|" \
		$(find ./ -type f -exec grep -l '^INSDIR.\+doc' '{}' '+') \
		|| die "sed doc"

	# Respect libdir.
	sed -i -e "s|\(^INSDIR=\t\t\)lib|\1$(get_libdir)|" \
		$(find ./ -type f -exec grep -l '^INSDIR.\+lib\(/siconv\)\?$' '{}' '+') \
		|| die "sed multilib"

	# Do not install static libraries.
	sed -i -e "s|include\t\t.*rules.lib||" \
		$(find ./ -type f -exec grep -l '^include.\+rules\.lib' '{}' '+') \
		|| die "sed rules"

	# Enable verbose build.
	sed -i -e '/@echo.*==>.*;/s:@echo[^;]*;:&set -x;:' \
		RULES/*.rul RULES/rules.prg RULES/rules.inc \
		|| die "sed verbose rules"

	# Respect CC/CXX variables.
	cd "${S}"/RULES || die
	local tcCC=$(tc-getCC)
	local tcCXX=$(tc-getCXX)
	sed -i -e "/cc-config.sh/s|\$(C_ARCH:%64=%) \$(CCOM_DEF)|${tcCC} ${tcCC}|" \
		rules1.top || die "sed rules1.top"
	sed -i -e "/^CC_COM_DEF=/s|gcc|${tcCC}|" \
		-e "/^CC++_COM_DEF=/s|g++|${tcCXX}|" \
		-e "/COPTOPT=/s|-O||" \
		-e 's|$(GCCOPTOPT)||' \
		cc-gcc.rul || die "sed cc-gcc.rul"
	sed -i -e "s|^#\(CONFFLAGS +=\).*|\1\t-cc=${tcCC}|" \
		rules.cnf || die "sed rules.cnf"
}

ac_cv_sizeof() {
	cat <<-EOF >"${T}"/test.c
	#include <inttypes.h>
	#include <stddef.h>
	#include <stdint.h>
	#include <sys/types.h>
	int main () {
		static int test_array [1 - 2 * !((sizeof(TYPE)) == LEN)];
		test_array [0] = 0;
		return test_array [0];
	}
	EOF

	local i=1
	while [[ ${i} -lt 20 ]] ; do
		if ${CC} ${CPPFLAGS} ${CFLAGS} -c "${T}"/test.c -o /dev/null -DTYPE="$1" -DLEN=$i 2>/dev/null; then
			echo ${i}
			return 0
		fi
		: $(( i += 1 ))
	done
	return 1
}

src_configure() {
	use acl || export ac_cv_header_sys_acl_h="no"
	use caps || export ac_cv_lib_cap_cap_get_proc="no"
	export ac_cv_header_pulse_pulseaudio_h="no"

	# skip obsolete configure script
	if tc-is-cross-compiler ; then
		# Cache known values for targets. #486680

		tc-export CC
		local var val t types=(
			char "short int" int "long int" "long long"
			"unsigned char" "unsigned short int" "unsigned int"
			"unsigned long int" "unsigned long long"
			float double "long double" size_t ssize_t ptrdiff_t
			mode_t uid_t gid_t pid_t dev_t time_t wchar_t
			"char *" "unsigned char *"
		)
		for t in "${types[@]}" ; do
			var="ac_cv_sizeof_${t// /_}"
			var=${var//[*]/p}
			val=$(ac_cv_sizeof "${t}") || die "could not compute ${t}"
			export "${var}=${val}"
			einfo "Computing sizeof(${t}) as ${val}"
		done
		# We don't have these types.
		export ac_cv_sizeof___int64=0
		export ac_cv_sizeof_unsigned___int64=0
		export ac_cv_sizeof_major_t=${ac_cv_sizeof_dev_t}
		export ac_cv_sizeof_minor_t=${ac_cv_sizeof_dev_t}
		export ac_cv_sizeof_wchar=${ac_cv_sizeof_wchar_t}

		export ac_cv_type_prototypes="yes"
		export ac_cv_func_mlock{,all}="yes"
		export ac_cv_func_{e,f,g}cvt=$(usex elibc_glibc)
		export ac_cv_func_dtoa_r="no"
		export ac_cv_func_sys_siglist{,_def}="no"
		export ac_cv_func_printf_{j,ll}="yes"
		export ac_cv_realloc_null="yes"
		export ac_cv_no_user_malloc="no"
		export ac_cv_var_timezone="yes"
		export ac_cv_var___progname{,_full}="yes"
		export ac_cv_fnmatch_igncase="yes"
		export ac_cv_file__dev_{fd_{0,1,2},null,std{err,in,out},tty,zero}="yes"
		export ac_cv_file__usr_src_linux_include="no"

			export ac_cv_func_bsd_{g,s}etpgrp="no"
			export ac_cv_hard_symlinks="yes"
			export ac_cv_link_nofollow="yes"
			export ac_cv_access_e_ok="no"

			export ac_cv_dev_minor_noncontig="yes"
			case ${ac_cv_sizeof_long_int} in
			4) export ac_cv_dev_minor_bits="32";;
			8) export ac_cv_dev_minor_bits="44";;
			esac

			cat <<-EOF >"${T}"/test.c
			struct {
				char start[6];
				unsigned char x1:4;
				unsigned char x2:4;
				char end[5];
			} a = {
				.start = {'S', 't', 'A', 'r', 'T', '_'},
				.x1 = 5,
				.x2 = 4,
				.end = {'_', 'e', 'N', 'd', 'X'},
			};
			EOF
			${CC} ${CPPFLAGS} ${CFLAGS} -c "${T}"/test.c -o "${T}"/test.o
			if grep -q 'StArT_E_eNdX' "${T}"/test.o ; then
				export ac_cv_c_bitfields_htol="no"
			elif grep -q 'StArT_T_eNdX' "${T}"/test.o ; then
				export ac_cv_c_bitfields_htol="yes"
			fi
	fi
}

src_compile() {
	if use unicode; then
		local flags="$(test-flags -finput-charset=ISO-8859-1 -fexec-charset=UTF-8)"
		if [[ -n ${flags} ]]; then
			append-flags ${flags}
		else
			ewarn "Your compiler does not support the options required to build"
			ewarn "cdrtools with unicode in USE. unicode flag will be ignored."
		fi
	fi

	strip-flags -flto

	# If not built with -j1, "sometimes" cdda2wav will not be built.
	emake -j1 CPPOPTX="${CPPFLAGS} -fPIC" COPTX="${CFLAGS} -fPIC" C++OPTX="${CXXFLAGS} -fPIC" \
		LDOPTX="${LDFLAGS} -fPIC" GMAKE_NOWARN="true"
}

src_install() {
	emake CPPOPTX="${CPPFLAGS}" COPTX="${CFLAGS}" C++OPTX="${CXXFLAGS}" \
		LDOPTX="${LDFLAGS}" GMAKE_NOWARN="true" install

	# These symlinks are for compat with cdrkit.
	dosym schily /usr/include/scsilib
	dosym ../scg /usr/include/schily/scg

	rm -rvf "${ED}"/usr/share/man/man5 || die
}

pkg_postinst() {
	fcaps_pkg_postinst
}
