# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gawk-$(ver_cut 1-2)-stable"
SNAPSHOT=16ba2113002eedad16b944cac3439eb309648144

inherit flag-o-matic qa-policy

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="https://www.gnu.org/software/gawk/gawk.html"

SRC_URI="https://github.com/1g4-mirror/gawk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="mpfr readline"

DEPEND="
	lib-core/gmp
	mpfr? ( lib-core/mpfr )
	readline? ( lib-core/readline )
"

src_prepare() {
	default

	# `stopme` is a debugger-only helper that is not exposed in normal builds.
	sed -i \
		-e '/^[[:space:]]*stopme()$/s/^/# /' \
		test/elemnew4.awk || die

	if use elibc_musl; then
		# musl emits different strerror text for ECHILD.
		sed -i \
			-e 's/No child processes/No child process/' \
			test/testext.ok || die

		# Keep the locale-format test deterministic without glibc locale data.
		sed -i \
			-e '/^commas:/{n;s/GAWKLOCALE=en_US\.UTF-8/GAWKLOCALE=C/;}' \
			test/Makefile.in || die

		cat > test/clos1way6.ok <<-'EOF' || die
		gawk: clos1way6.awk:5: warning: fflush: cannot flush: two-way pipe `cat - 1>&2; sleep 2' has closed write end
		Bad file descriptor
		test1
		EOF

		cat > test/commas.ok <<-'EOF' || die
		123456789
		123456789.000000
		EOF
	fi
}

src_configure() {
	filter-flags -Wl,-z,defs

	qa-policy-configure

	export ac_cv_libsigsegv=no

	local myconf=(
		$(use_with mpfr)
		--disable-nls
		$(use_with readline)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto usr/include/awk
	doins *.h || die

	rm "${ED}"/usr/include/awk/config.h || die

	dosym -r /usr/bin/gawk /usr/bin/awk

	qa-policy-install
}

src_test() {
	PAGER=cat emake check
}
