# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="VTE provides a virtual terminal widget for GTK applications."
HOMEPAGE="https://github.com/GNOME/vte"
SNAPSHOT=def4afdecb68ea320a72d1d13bcf9f6620f747d2
SRC_URI="https://github.com/GNOME/vte/archive/${SNAPSHOT}.tar.gz -> vte-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vte-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/fast_float
	app-dev/simdutf
	app-dev/fmt
	xgui-lib/gtk3
	xgui-lib/gtk4
"

src_prepare() {
	default

	# musl lacks W_EXITCODE, add a compat macro and ensure headers exist
	if use elibc_musl; then
		local f="src/widget.cc"

		# ensure file exists before editing
		[[ -f ${f} ]] || die "missing ${f}"

		# add includes if missing
		grep -q '^#include <signal.h>' "${f}" || sed -i '1i #include <signal.h>' "${f}" || die
		grep -q '^#include <sys/wait.h>' "${f}" || sed -i '1i #include <sys/wait.h>' "${f}" || die

		# add W_EXITCODE compat macro if missing
		if ! grep -q '^#define W_EXITCODE' "${f}"; then
			sed -i '1i #ifndef W_EXITCODE\n#define W_EXITCODE(ret, sig) (((ret) << 8) | (sig))\n#endif' "${f}" || die
		fi
	fi
}

src_configure() {
	filter-flags -flto*

	local emesonargs=(
		-Da11y=false
		-Dfribidi=false
		-Dvapi=false
		-Ddocs=false
		-Dgir=false
		-Dsixel=false
		-Dicu=false
		-Dgnutls=true
		-Dglade=true
		-Dgtk3=false
		)
		meson_src_configure
}
