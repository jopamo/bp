# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit systemd toolchain-funcs git-r3 flag-o-matic

DESCRIPTION="Device mapper target autoconfig"
HOMEPAGE="http://christophe.varoqui.free.fr/"
EGIT_REPO_URI="https://github.com/openSUSE/multipath-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"


RDEPEND="
	lib-dev/json-c:=
	lib-dev/libaio
	lib-dev/userspace-rcu:=
	>=sys-fs/lvm2-2.02.45
	lib-sys/readline:=
	systemd? ( sys-app/systemd )
"

DEPEND="${RDEPEND}"

CONFIG_CHECK="~DM_MULTIPATH"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-0.7.5-respect-flags.patch
	"${FILESDIR}"/${PN}-0.8.3-no-gziped-docs.patch
)

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

get_systemd_pv() {
	use systemd && \
		$(tc-getPKG_CONFIG) --modversion systemd
}

src_compile() {
	# LIBDM_API_FLUSH involves grepping files in /usr/include,
	# so force the test to go the way we want #411337.
	emake \
		CC="$(tc-getCC)" \
		LIBDM_API_FLUSH=1 SYSTEMD="$(get_systemd_pv)"
}

src_install() {
	dodir /sbin /usr/share/man/man{5,8}
	emake \
		DESTDIR="${D}" \
		RUN=run \
		SYSTEMD=$(get_systemd_pv) \
		unitdir="$(systemd_get_systemunitdir)" \
		libudevdir='${prefix}'/"$(get_udevdir)" \
		pkgconfdir='${prefix}'/usr/'${LIB}'/pkgconfig \
		install
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "If you need multipath on your system, you must"
		elog "add 'multipath' into your boot runlevel!"
	fi
}
