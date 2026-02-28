# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=bcd6710b301a8d8632828cd5c43319e947a6091f

inherit meson

DESCRIPTION="Search and query ebuilds"
HOMEPAGE="https://github.com/1g4linux/coreq/"
SRC_URI="https://github.com/1g4linux/coreq/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/coreq-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sqlite"

DEPEND="
	sqlite? ( lib-core/sqlite )
"

pkg_setup() {
	local old_cache="${EROOT}/var/cache/coreq"
	test -f "${old_cache}" && rm -f -- "${old_cache}"
}

pkg_postinst() {
	local obs="${EROOT}/var/cache/coreq.previous"
	if test -f "${obs}"; then
		ewarn "Found obsolete ${obs}, please remove it"
	fi

	mkdir -p /var/cache/coreq
    chmod 0775 /var/cache/coreq
    chown -R corepkg /var/cache/coreq
}

pkg_postrm() {
	if [ -z "${REPLACED_BY_VERSION}" ]; then
		rm -r -- "${EROOT}/var/cache/coreq" || die
	fi
}
