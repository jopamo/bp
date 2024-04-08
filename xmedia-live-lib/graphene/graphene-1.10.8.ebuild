# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils meson python-any-r1

DESCRIPTION="A thin layer of types for graphic libraries"
HOMEPAGE="https://ebassi.github.io/graphene/"
SRC_URI="https://github.com/ebassi/graphene/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~mips ppc ppc64 ~riscv sparc x86"
