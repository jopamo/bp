# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson qa-policy

DESCRIPTION="Search and query ebuilds"
HOMEPAGE="https://github.com/1g4linux/coreq/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4linux/coreq"
	inherit git-r3
else
	SNAPSHOT=37832269366c74d1dc9039130f48787d5950a44c
	SRC_URI="https://github.com/1g4linux/coreq/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sqlite"

RDEPEND="
	sqlite? ( lib-core/sqlite )
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use sqlite)
	)

	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}

pkg_setup() {
	local old_cache="${EROOT%/}/var/cache/coreq"
	test -f "${old_cache}" && rm -f -- "${old_cache}"
}

pkg_postinst() {
	local obs="${EROOT}/var/cache/coreq.previous"
	if test -f "${obs}"; then
		ewarn "Found obsolete ${obs}, please remove it"
	fi

	local cache_dir="${EROOT%/}/var/cache/coreq"

	mkdir -p -- "${cache_dir}" || die
	chmod 0775 "${cache_dir}" || die
	if ! chown -R corepkg:corepkg "${cache_dir}" 2>/dev/null ; then
		ewarn "Unable to set owner/group on ${cache_dir}; ensure it is writable by corepkg."
	fi
}

pkg_postrm() {
	if [ -z "${REPLACED_BY_VERSION}" ]; then
		rm -r -- "${EROOT%/}/var/cache/coreq" || die
	fi
}
