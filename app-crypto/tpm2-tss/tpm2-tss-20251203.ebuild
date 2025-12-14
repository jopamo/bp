# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic doins

DESCRIPTION="OSS implementation of the TCG TPM2 Software Stack (TSS2)"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tss"
SNAPSHOT=95957ebf145fc6cbc6d9604570494d6e50329709
SRC_URI="https://github.com/tpm2-software/tpm2-tss/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tpm2-tss-${SNAPSHOT}"

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
		--with-sysusersdir
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
	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		u tss - "TPM2 Software Stack user" /var/lib/tpm2-tss
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
	chown -R tss:tss /var/lib/tpm2-tss
}
