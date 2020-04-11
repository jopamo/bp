# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs git-r3

DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"
EGIT_REPO_URI="https://github.com/magnumripper/${PN}.git"
EGIT_BRANCH="bleeding-jumbo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="commoncrypto opencl openmp +ssl pcap rexgen"

DEPEND="
	ssl? ( virtual/ssl )
	pcap? ( lib-net/libpcap )
	lib-dev/gmp:*
	lib-sys/zlib
	app-compression/bzip2"

S=${WORKDIR}/${P}/src

append-ldflags -Wl,-z,noexecstack
append-cppflags -DJOHN_SYSTEMWIDE_HOME="'\"${EPREFIX}/etc/john\"'"

pkg_setup() {
	if use openmp && [[ ${MERGE_TYPE} != binary ]]; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_configure() {
	econf \
		--disable-native-march \
		--disable-native-tests \
		--with-systemwide \
		$(use_enable opencl) \
		$(use_enable openmp) \
		$(use_enable pcap) \
		$(use_enable rexgen) \
		$(use_with commoncrypto) \
		$(use_with ssl openssl)
}

src_test() {
	make -C src check
}

src_install() {
	dobin ../run/john
	newbin ../run/mailer john-mailer

	for s in \
		unshadow unafs undrop unique ssh2john putty2john pfx2john keepass2john keyring2john \
		zip2john gpg2john rar2john racf2john keychain2john kwallet2john pwsafe2john dmg2john \
		hccap2john base64conv truecrypt_volume2john keystore2john
	do
		dosym john /usr/bin/$s
	done

	insinto /usr/share/john
	doins ../run/*.py

	if use opencl; then
		insinto /usr/share/john/kernels
		doins ../run/kernels/*
	fi

	insinto /etc/john
	doins ../run/*.chr ../run/password.lst
	doins ../run/*.conf
}
