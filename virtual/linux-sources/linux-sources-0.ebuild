# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Kernel virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="kernel-bin"

RDEPEND="kernel-bin? (
			app-kernel/kernel-bin
			!virtual/linux-sources
)
		!kernel-bin? (
			app-kernel/linux-headers
)"
