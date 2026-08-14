# Distributed under the terms of the GNU General Public License v2

inherit git-r3

DESCRIPTION="Perl script to check for commonly used bash features not defined by POSIX"
HOMEPAGE="https://packages.debian.org/devscripts https://salsa.debian.org/debian/devscripts"
EGIT_REPO_URI="https://salsa.debian.org/debian/devscripts"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-lang/perl"

S="${S}/scripts"

src_prepare() {
	default

	sed "s@###VERSION###@${PV}@" -i checkbashisms.pl || die
}

src_compile() { :; }

src_test() {
	perl -c checkbashisms.pl || die
	perl checkbashisms.pl --version >/dev/null || die

	local clean_script="${T}/checkbashisms-clean.sh"
	local bashism_script="${T}/checkbashisms-bashism.sh"

	cat > "${clean_script}" <<-EOF
		#!/bin/sh
		printf '%s\n' clean
	EOF
	cat > "${bashism_script}" <<-EOF
		#!/bin/sh
		echo -e bashism
	EOF

	perl checkbashisms.pl "${clean_script}" || die
	if perl checkbashisms.pl "${bashism_script}"; then
		die "checkbashisms failed to detect an echo -e bashism"
	fi
}

src_install() {
	newbin ${PN}.pl ${PN}
	doman ${PN}.1
}
