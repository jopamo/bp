# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="maint-$(ver_cut 1-2)"



DESCRIPTION="Larry Wall's Practical Extraction and Report Language"
HOMEPAGE="https://www.perl.org/"
SNAPSHOT=46977a16be5c4752a072588cf7e941f88f2b7e84
SRC_URI="https://github.com/Perl/perl5/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/perl5-${SNAPSHOT}

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug gdbm"

DEPEND="
	gdbm? ( lib-core/gdbm )
	app-compression/bzip2
	lib-core/zlib
"

PDEPEND="
	app-tex/docbook-sgml-dtd
	app-util/man-db
	app-core/help2man
	app-tex/docbook-xsl-stylesheets
"

src_prepare() {
	if [[ ${CBUILD} != ${CHOST} ]]; then
		einfo "Unpacking perl-cross-${_cross}.tar.gz.noauto..."
		tar --strip-components=1 -C "${S}" \
			-zxf "${DISTDIR}/perl-cross-${_cross}.tar.gz.noauto" || die
		sed -Ei 's/\^(clang version)/^Alpine \1/' \
			"${S}/cnf/configure_tool.sh" || die
	fi

	# Make sources writable for patching
	chmod +w "${S}"/*.c 2>/dev/null

	default

	# Remove bundled zlib/bzip2 sources and references
	rm -rf cpan/Compress-Raw-Zlib/zlib-src
	rm -rf cpan/Compress-Raw-Bzip2/bzip2-src
	sed -i '/\(bzip2\|zlib\)-src/d' MANIFEST || die
}

src_configure() {
	_privlib=/usr/share/perl5/core_perl
	_archlib=/usr/lib/perl5/core_perl

	local common_args=(
		-Dprefix="${EPREFIX}"/usr
		-Dcccdlflags='-fPIC'
		-Dccdlflags='-rdynamic'
		-Dprivlib="${_privlib}"
		-Darchlib="${_archlib}"
		-Dvendorprefix="${EPREFIX}"/usr
		-Dvendorlib="${EPREFIX}"/usr/share/perl5/vendor_perl
		-Dvendorarch="${EPREFIX}"/usr/lib/perl5/vendor_perl
		-Dsiteprefix="${EPREFIX}"/usr/local
		-Dsitelib="${EPREFIX}"/usr/local/share/perl5/site_perl
		-Dsitearch="${EPREFIX}"/usr/local/lib/perl5/site_perl
		-Dlocincpth=' '
		-Duselargefiles
		-Dusethreads
		-Duseshrplib
		-Dd_semctl_semun
		-Dman1dir="${EPREFIX}"/usr/share/man/man1
		-Dman3dir="${EPREFIX}"/usr/share/man/man3
		-Dinstallman1dir="${EPREFIX}"/usr/share/man/man1
		-Dinstallman3dir="${EPREFIX}"/usr/share/man/man3
		-Dman1ext='1'
		-Dman3ext='3pm'
		-Dcf_by='1g4'
		-Ud_csh
		-Ud_fpos64_t
		-Ud_off64_t
		-Duse64bitint
	)

	if [[ ${CBUILD} != ${CHOST} ]]; then
		./configure \
			--build="${CBUILD}" \
			--target="${CHOST}" \
			--host-has\ perl_lc_all_uses_name_value_pairs=no \
			--host-has\ perl_lc_all_separator=yes \
			--host-set\ perl_lc_all_separator='";"' \
			--host-has\ perl_lc_all_category_positions_init=yes \
			--host-set\ perl_lc_all_category_positions_init='{0,1,2,3,4,5}' \
			-Ud_perl_lc_all_uses_name_value_pairs \
			-Dd_perl_lc_all_separator \
			-Dperl_lc_all_separator='";"' \
			-Dd_perl_lc_all_category_positions_init \
			-Dperl_lc_all_category_positions_init='{ 0, 1, 2, 3, 4, 5 }' \
			"${common_args[@]}" || die "configure failed"
	else
		./Configure \
			-des \
			-Doptimize="${CFLAGS}" \
			"${common_args[@]}" || die "Configure failed"
	fi
}

src_compile() {
	export BUILD_ZLIB=0
	export BUILD_BZIP2=0
	export BZIP2_LIB="${ESYSROOT}/usr/lib"
	export BZIP2_INCLUDE="${ESYSROOT}/usr/include"

	# language runtime flags
	export CFLAGS="${CFLAGS//-Os/-O2}"
	if [[ ${CBUILD} != ${CHOST} ]]; then
		export CFLAGS="${CFLAGS} -D_GNU_SOURCE"
		export HOSTCFLAGS="${HOSTCFLAGS} -D_GNU_SOURCE"
	else
		export CFLAGS="${CFLAGS} -flto=auto"
	fi

	emake libperl.so
	emake
}

src_test() {
	export CI=true
	export LC_ALL=C
	export HARNESS_OPTIONS="j${JOBS:-9}"
	export PERL_TEST_HARNESS_ASAP=1
	emake test_harness_notty
}

src_install() {
	emake DESTDIR="${D}" install.perl

	# Remove global flto in Config_heavy.pl
	sed -i -e "s| -flto=auto||g" \
		"${D}/usr/lib/perl5/core_perl/Config_heavy.pl" || die

	# Fail if anything lands in /usr/local
	if [[ -n $(find "${D}/usr/local" -type f) ]]; then
		die "files found under /usr/local"
	fi

	if [[ -f "${D}${_archlib}/miniperl" ]]; then
		dobin "${D}${_archlib}/miniperl"
	fi
}
