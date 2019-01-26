# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal eutils flag-o-matic toolchain-funcs multilib multiprocessing git-r3

DESCRIPTION="Larry Wall's Practical Extraction and Report Language"

EGIT_REPO_URI="https://github.com/Perl/perl5.git"
HOMEPAGE="https://www.perl.org/"
EGIT_BRANCH="maint-5.28"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"

KEYWORDS="amd64 arm64 x86"

IUSE="debug doc gdbm"

RDEPEND="
	gdbm? ( >=lib-sys/gdbm-1.8.3 )
	app-compression/bzip2
	lib-sys/zlib
"
DEPEND="${RDEPEND}
	!prefix? ( elibc_FreeBSD? ( sys-freebsd/freebsd-mk-defs ) )
"

PDEPEND="=app-text/docbook-sgml-dtd-4.1-r3
		=app-text/docbook-sgml-dtd-4.3-r2
		=app-text/docbook-sgml-dtd-4.4
		=app-text/docbook-sgml-dtd-4.5
		sys-app/man-db
		sys-app/help2man
		app-text/po4a
		app-text/docbook-xsl-stylesheets
"

src_prepare() {
	if use gdbm; then
		sed -i "s:INC => .*:INC => \"-I${EROOT}usr/include/gdbm\":g" \
			ext/NDBM_File/Makefile.PL || die
	fi

	# Use errno.h from prefix rather than from host system, bug #645804
	if use prefix && ! use prefix-guest; then
		sed -i "/my..sysroot/s:'':'${EPREFIX}':" ext/Errno/Errno_pm.PL || die
	fi
	default
	multilib_copy_sources
}

myconf() {
	# the myconf array is declared in src_configure
	myconf=( "${myconf[@]}" "$@" )
}

src_configure() {
	declare -a myconf

	export LC_ALL="C"
	[[ ${COLUMNS:-1} -ge 1 ]] || unset COLUMNS # bug #394091

	# xlocale.h is going away in glibc-2.26, so it's counterproductive
	# if we use it and include it in CORE/perl.h ... Perl builds just
	# fine with glibc and locale.h only.
	# However, the darwin prefix people have no locale.h ...
	use elibc_glibc && myconf -Ui_xlocale

	# This flag makes compiling crash in interesting ways
	filter-flags "-malign-double"

	export BUILD_BZIP2=0
	export BZIP2_INCLUDE=${EROOT}/usr/include
	export BZIP2_LIB=${EROOT}/usr/$(get_libdir)

	export BUILD_ZLIB=False
	export ZLIB_INCLUDE=${EROOT}/usr/include
	export ZLIB_LIB=${EROOT}/usr/$(get_libdir)

	# allow either gdbm to provide ndbm (in <gdbm/ndbm.h>) or db1
	myndbm='U'
	mygdbm='U'
	mydb='U'
	if use gdbm ; then
		mygdbm='D'
	fi

	myconf "-${myndbm}i_ndbm" "-${mygdbm}i_gdbm" "-${mydb}i_db"

	if use debug ; then
		append-cflags "-g"
		myconf -DDEBUGGING
	elif [[ ${CFLAGS} == *-g* ]] ; then
		myconf -DDEBUGGING=-g
	else
		myconf -DDEBUGGING=none
	fi

	# Autodiscover all old version directories, some of them will even be newer
	# if you downgrade
	if [[ -z ${PERL_OLDVERSEN} ]]; then
		PERL_OLDVERSEN="$(
			find "${EROOT%/}${PRIV_BASE}" "${EROOT%/}${SITE_BASE}" "${EROOT%/}${VENDOR_BASE}" \
				   -maxdepth 1 -mindepth 1 -type d -regex '.*/5[.][0-9]+[.][0-9]+$' \
				   -printf "%f "  2>/dev/null )"
	fi
	# Fixup versions, removing self match, fixing order and dupes
	PERL_OLDVERSEN="$(
		echo "${PERL_OLDVERSEN}"           |\
			tr " " "\n" 				   |\
			grep -vF "${DIST_VERSION%-RC}" |\
			sort -u -nr -t'.' -k1,1 -k2,2 -k3,3
	)"

	# Prefix: the host system needs not to follow Gentoo multilib stuff, and in
	# Prefix itself we don't do multilib either, so make sure perl can find
	# something compatible.
	if use prefix ; then
		# Set a hook to check for each detected library whether it actually works.
		export libscheck="
			( echo 'main(){}' > '${T}'/conftest.c &&
			  $(tc-getCC) -o '${T}'/conftest '${T}'/conftest.c -l\$thislib >/dev/null 2>/dev/null
			) || xxx=/dev/null"

		# Use all host paths that might contain useful stuff, the hook above will filter out bad choices.
		local paths="/lib/*-linux-gnu /usr/lib/*-linux-gnu /lib64 /lib/64 /usr/lib64 /usr/lib/64 /lib32 /usr/lib32 /lib /usr/lib"
		myconf "-Dlibpth=${EPREFIX}/$(get_libdir) ${EPREFIX}/usr/$(get_libdir) ${paths}"
	elif [[ $(get_libdir) != "lib" ]] ; then
		# We need to use " and not ', as the written config.sh use ' ...
		myconf "-Dlibpth=/usr/$(get_libdir)"
	fi

	# don't try building ODBM, bug #354453
	disabled_extensions="ODBM_File"

	if ! use gdbm ; then
		# workaround for bug #157774: don't try building GDBM related stuff with USE="-gdbm"
		disabled_extensions="${disabled_extensions} GDBM_File NDBM_File"
	fi

	myconf -Dnoextensions="${disabled_extensions}"

	[[ "${PV##*.}" == "9999" ]] && myconf -Dusedevel -Uversiononly

	[[ -n "${EXTRA_ECONF}" ]] && ewarn During Perl build, EXTRA_ECONF=${EXTRA_ECONF}
	# allow fiddling via EXTRA_ECONF, bug 558070
	eval "local -a EXTRA_ECONF=(${EXTRA_ECONF})"

	myconf \
		-Duseshrplib \
		-Darchname="${myarch}" \
		-Dcc="$(tc-getCC)" \
		-Doptimize="${CFLAGS}" \
		-Dldflags="${LDFLAGS}" \
		-Dprefix="${EPREFIX}"'/usr' \
		-Dsiteprefix="${EPREFIX}"'/usr' \
		-Dvendorprefix="${EPREFIX}"'/usr' \
		-Dscriptdir="${EPREFIX}"'/usr/bin' \
		-Dprivlib="${EPREFIX}"/usr/$(get_libdir)/perl5 \
		-Darchlib="${EPREFIX}"/usr/$(get_libdir)/perl5 \
		-Dsitelib="${EPREFIX}"/usr/$(get_libdir)/perl5 \
		-Dsitearch="${EPREFIX}"/usr/$(get_libdir)/perl5 \
		-Dvendorlib="${EPREFIX}"/usr/$(get_libdir)/perl5 \
		-Dvendorarch="${EPREFIX}"/usr/$(get_libdir)/perl5 \
		-Dman1dir="${EPREFIX}"/usr/share/man/man1 \
		-Dman3dir="${EPREFIX}"/usr/share/man/man3 \
		-Dsiteman1dir="${EPREFIX}"/usr/share/man/man1 \
		-Dsiteman3dir="${EPREFIX}"/usr/share/man/man3 \
		-Dvendorman1dir="${EPREFIX}"/usr/share/man/man1 \
		-Dvendorman3dir="${EPREFIX}"/usr/share/man/man3 \
		-Dman1ext='1' \
		-Dman3ext='3pm' \
		-Dlocincpth="${EPREFIX}"'/usr/include ' \
		-Dglibpth="${EPREFIX}/usr/$(get_libdir)"' ' \
		-Duselargefiles \
		-Dd_semctl_semun \
		-Dmyhostname='localhost' \
		-Dperladmin='root@localhost' \
		-Ud_csh \
		-Dsh="${EPREFIX}"/usr/bin/sh \
		-Dtargetsh="${EPREFIX}"/usr/bin/sh \
		-Uusenm \
		-Dusethreads \
		"${myconf[@]}" \
		"${EXTRA_ECONF[@]}"

		sh Configure \
			-des \
			-Dinstallprefix="${EPREFIX}"'/usr' \
			-Dinstallusrbinperl='n' \
			"${myconf[@]}" \
			|| die "Unable to configure"
}

src_test() {
	if [[ ${EUID} == 0 ]] ; then
		ewarn "Test fails with a sandbox error (#328793) if run as root. Skipping tests..."
		return 0
	fi
	use elibc_uclibc && export MAKEOPTS+=" -j1"
	TEST_JOBS="$(makeopts_jobs)" make test_harness || die "test failed"
}

src_install() {
	local i
	local coredir="${EPREFIX}/"/usr/$(get_libdir)/perl5/CORE
	emake DESTDIR="${D}" install

	rm -f "${ED}/usr/bin/perl5*"

	rm -rf "${ED}"/usr/share/man/man3 || die "Unable to remove module man pages"

	# This removes ${D} from Config.pm
	for i in $(find "${D}" -iname "Config.pm" ) ; do
		einfo "Removing ${D} from ${i}..."
		sed -i -e "s:${D}::" "${i}" || die "Sed failed"
	done

	[[ -d ${ED}/usr/local ]] && rm -r "${ED}"/usr/local

	rm -rf "${ED}"/usr/share/man
}
