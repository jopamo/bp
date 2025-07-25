# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Utility for reading, writing, erasing and verifying flash ROM chips"
HOMEPAGE="https://flashrom.org/Flashrom"
SNAPSHOT=4e1d9ad9538fd8b7e37b300c6570259220a7f809
SRC_URI="https://github.com/flashrom/flashrom/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/flashrom-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE_PROGRAMMERS="+internal	+linux-mtd +linux-spi"
IUSE="${IUSE_PROGRAMMERS} internal-dmi test tools"

RESTRICT="!test? ( test )"

src_prepare() {
	default
	if use elibc_musl ; then
		# skip failing test #908539
		sed -i -e 's/-DCONFIG_LINUX_MTD=1/-UCONFIG_LINUX_MTD/' \
			meson.build || die
	fi

	# enable warnings
	sed -i \
		-e 's:^warning_flags = \[:warning_flags = \[ '"'-Wall'"' \]\nno = \[:' \
		meson.build || die
}

src_configure() {
	local programmers="$(printf '%s,' $(for flag in ${IUSE_PROGRAMMERS//+/}; do usev ${flag}; done))"
	programmers="${programmers%,}"
	programmers="${programmers//-/_}"
	local emesonargs=(
		-Dclassic_cli="enabled"
		-Dprogrammer="${programmers}"
		$(meson_feature test tests)
		$(meson_feature tools ich_descriptors_tool)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	# Upstream requires libflashrom.a to be present at build time because the classic CLI
	# executable uses internal symbols from that library. Therefore, we let it be built
	# but keep it out of the installed tree.
	find "${ED}" -name '*.a' -delete || die

	if use tools; then
		dobin "${BUILD_DIR}"/util/ich_descriptors_tool/ich_descriptors_tool
	fi
}
