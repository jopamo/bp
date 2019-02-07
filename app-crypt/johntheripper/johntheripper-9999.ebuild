# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic toolchain-funcs git-r3

DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"

EGIT_REPO_URI="https://github.com/magnumripper/${PN}.git"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="commoncrypto cuda custom-cflags mpi opencl openmp +openssl pcap rexgen"

DEPEND="openssl? ( >=lib-dev/openssl-1.0.1:0 )
	mpi? ( virtual/mpi )
	opencl? ( virtual/opencl )
	pcap? ( lib-net/libpcap )
	lib-dev/gmp:*
	lib-sys/zlib
	app-compression/bzip2"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/src

pkg_setup() {
	if use openmp && [[ ${MERGE_TYPE} != binary ]]; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_configure() {
	use custom-cflags || strip-flags
	append-cppflags -DJOHN_SYSTEMWIDE_HOME="'\"${EPREFIX}/etc/john\"'"

	econf \
		--disable-native-march \
		--disable-native-tests \
		--with-systemwide \
		$(use_enable mpi) \
		$(use_enable opencl) \
		$(use_enable openmp) \
		$(use_enable pcap) \
		$(use_enable rexgen) \
		$(use_with commoncrypto) \
		$(use_with openssl)
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

	chmod 755 ${ED}/usr/bin/john
}
