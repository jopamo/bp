# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils git-r3

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="https://savannah.gnu.org/projects/config"

EGIT_REPO_URI="https://git.savannah.gnu.org/git/config.git"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"

maint_pkg_create() {
	cd "${S}"

	local ver=$(gawk '{ gsub(/-/, "", $1); print $1; exit }' ChangeLog)
	[[ ${#ver} != 8 ]] && die "invalid version '${ver}'"

	local tar="${T}/gnuconfig-${ver}.tar.bz2"
	tar -jcf ${tar} ./* || die "creating tar failed"
	einfo "Packaged tar now available:"
	einfo "$(du -b ${tar})"
}

src_prepare() {
	use elibc_uclibc && sed -i 's:linux-gnu:linux-uclibc:' testsuite/config-guess.data #180637
}

src_compile() { :;}

src_test() {
	emake check
}

src_install() {
	insinto /usr/share/${PN}
	doins config.{sub,guess} || die
	fperms +x /usr/share/${PN}/config.{sub,guess}
	dodoc ChangeLog
}
