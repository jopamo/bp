# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic qa-policy

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"

SNAPSHOT=4dc18b9f0266aa4c425393449f36d8111287d16e
SRC_URI="https://gitlab.com/pjo/coreutil/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/coreutil-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl libcap multicall static xattr"

LIB_DEPEND="
	acl? ( app-core/acl[static-libs] )
	libcap? ( lib-core/libcap[static-libs] )
	xattr? ( app-core/attr[static-libs] )
"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs]} )"
DEPEND="
	${RDEPEND}
	static? ( ${LIB_DEPEND} )
	app-compression/xz-utils
"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Dacl=$(usex acl enabled disabled)
		-Dlibcap=$(usex libcap enabled disabled)
		-Dxattr=$(usex xattr enabled disabled)
		-Dsingle_binary=true
		-Dno_install_programs=true,false,cp,mv,who,groups,kill,su,uptime,\
basename,dirname,install,link,ln,mkdir,mkfifo,mknod,mktemp,pathchk,\
readlink,realpath,rm,rmdir,touch,unlink,stat,shred,chmod,df,truncate,\
chgrp,chown
		-Dinstall_programs=hostname
		-Dlargefile=true
		-Dstatic_executables=$(usex static true false)
		-Dversion_string=${PV}
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	qa-policy-install
}
