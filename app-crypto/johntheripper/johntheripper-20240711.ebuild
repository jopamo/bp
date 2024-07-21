# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"

SNAPSHOT=367d6438e6bd5cfd20f3290aac479ab4f1e5fea2
SRC_URI="https://github.com/openwall/john/archive/${SNAPSHOT}.tar.gz -> john-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/john-${SNAPSHOT}"

EGIT_BRANCH="bleeding-jumbo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="opencl openmp +ssl pcap rexgen"

DEPEND="
	app-compression/bzip2
	lib-core/gmp:*
	lib-core/zlib
	pcap? ( lib-net/libpcap )
	ssl? ( virtual/ssl )
"

append-ldflags -Wl,-z,noexecstack
append-cppflags -DJOHN_SYSTEMWIDE_HOME="'\"${EPREFIX}/etc/john\"'"

src_configure() {
	local myconf=(
		$(use_enable opencl)
		$(use_enable openmp)
		$(use_enable pcap)
		$(use_enable rexgen)
		$(use_with ssl openssl)
		--disable-native-march
		--disable-native-tests
		--with-systemwide
	)
	econf "${myconf[@]}"
}

src_test() {
	emake -C src check
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
