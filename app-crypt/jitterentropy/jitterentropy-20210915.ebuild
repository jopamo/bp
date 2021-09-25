# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Hardware RNG based on CPU timing jitter"
HOMEPAGE="https://github.com/smuellerDD/jitterentropy-library"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/smuellerDD/jitterentropy-rngd.git"
	inherit git-r3
else
	SNAPSHOT=22e0f9b8b9220f2d4e7ed7ac671c43a1561b7dce
	SRC_URI="https://github.com/smuellerDD/jitterentropy-rngd/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-rngd-${SNAPSHOT}
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

PATCHES=( "${FILESDIR}"/${PN}-do-not-strip-and-compress.patch )

replace-flags -O2 -O0
replace-flags -O3 -O0
replace-flags -Os -O0

src_install() {
	emake PREFIX="${EPREFIX}/usr" \
		  LIBDIR="lib" \
		  DESTDIR="${D}" install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	else
		rm -rf "${ED}"/usr/lib/systemd || die
	fi
}
