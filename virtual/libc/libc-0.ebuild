# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="libc implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="elibc_musl? (
			lib-core/musl[elibc_musl]
			!lib-core/glibc
)
		!elibc_musl? (
			lib-core/glibc
			!lib-core/musl[elibc_musl]
)"

# On glibc, libcrypt is a separate compatibility library. Install it after
# libc, so building its provider can already use a shell and Python.
PDEPEND="!elibc_musl? ( virtual/libcrypt )"
