# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="PAM base configuration files"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:PAM"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="cracklib debug minimal mktemp +nullok securetty systemd"

RESTRICT="binchecks"

MIN_PAM_REQ=1.1.3

RDEPEND="
	cracklib? ( lib-sys/pam[cracklib] )
	systemd? ( sys-app/systemd[pam] )
"
DEPEND="
	app-compression/xz-utils
	app-portage/portage-utils
"

pkg_setup() {
	local stcnt=0

	use systemd && stcnt=$((stcnt+1))
}

src_compile() {
	local implementation linux_pam_version
	if has_version lib-sys/pam; then
		implementation=linux-pam
		local ver_str=$(qatom $(best_version lib-sys/pam) | cut -d ' ' -f 3)
		linux_pam_version=$(printf "0x%02x%02x%02x" ${ver_str//\./ })
	elif has_version lib-sys/openpam; then
		implementation=openpam
	else
		die "PAM implementation not identified"
	fi

	use_var() {
		local varname=$(echo "$1" | tr '[:lower:]' '[:upper:]')
		local usename=${2-$(echo "$1" | tr '[:upper:]' '[:lower:]')}
		local varvalue=$(usex ${usename})
		echo "${varname}=${varvalue}"
	}

	emake \
		GIT=true \
		$(use_var debug) \
		$(use_var cracklib) \
		$(use_var systemd) \
		$(use_var nullok) \
		$(use_var mktemp) \
		$(use_var securetty) \
		$(use_var minimal) \
		IMPLEMENTATION=${implementation} \
		LINUX_PAM_VERSION=${linux_pam_version}
}

src_test() { :; }

src_install() {
	emake GIT=true DESTDIR="${ED}" install
}
