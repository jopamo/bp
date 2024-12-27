# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic doins user

DESCRIPTION="OSS implementation of the TCG TPM2 Software Stack (TSS2)"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tss"

SNAPSHOT=7375e2731b3f005e8961fe22192506e27a635806
SRC_URI="https://github.com/tpm2-software/tpm2-tss/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la"

src_prepare() {
	filter-flags -fno-semantic-interposition

	sed -i 's/git describe --tags --always --dirty > VERSION/echo "${PV}" > VERSION/' bootstrap
	./bootstrap
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--localstatedir=/var
		--disable-tcti-libtpms
		--disable-tcti-spi-ltt2go
		--disable-tcti-spi-ftdi
		--disable-tcti-i2c-ftdi
		--disable-defaultflags
		--disable-weakcrypto
		--with-runstatedir=/run
		--without-sysusersdir
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	rm -rf "${ED}"/var/run
	rm -rf "${ED}"/run
	rm -rf "${ED}"/var/lib

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}

pkg_postinst() {
	enewgroup tss -1
	enewuser tss -1 -1 /var/lib/tpm2-tss tss

	systemd-tmpfiles --create
}
