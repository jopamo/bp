# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_NAME=gettext
DIST_AUTHOR=PVANDRY

inherit perl-module flag-o-matic

DESCRIPTION="A Perl module for accessing the GNU locale utilities"
S="${WORKDIR}/${PN}-${PV}"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro
