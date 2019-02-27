# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic libtool

MY_P=pkg-config-${PV}

if [[ ${PV} == *9999* ]]; then
	# 1.12 is only needed for tests due to some am__check_pre / LOG_DRIVER
	# weirdness with "/bin/bash /bin/sh" in arguments chain with >=1.13
	WANT_AUTOMAKE=1.12
	EGIT_REPO_URI="https://anongit.freedesktop.org/git/pkg-config.git"
	EGIT_CHECKOUT_DIR=${WORKDIR}/${MY_P}
	inherit autotools git-r3
else
	KEYWORDS="amd64 arm64"
	SRC_URI="https://pkgconfig.freedesktop.org/releases/${MY_P}.tar.gz"
fi

DESCRIPTION="Package config system that manages compile/link flags"
HOMEPAGE="https://pkgconfig.freedesktop.org/wiki/"

LICENSE="GPL-2"
SLOT="0"
IUSE="elibc_FreeBSD elibc_glibc hardened internal-glib"

RDEPEND="!internal-glib? ( >=lib-dev/glib-2.34.3 )
	!dev-util/pkgconf[pkg-config]
	!dev-util/pkg-config-lite
	!dev-util/pkgconfig-openbsd[pkg-config]
	sys-devel/gettext"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "s|^prefix=/usr\$|prefix=${EPREFIX}/usr|" check/simple.pc || die #434320

	eapply_user

	if [[ ${PV} == *9999* ]]; then
		eautoreconf
	else
		elibtoolize # Required for FreeMiNT wrt #333429
	fi

	if [[ ${CHOST} == *-solaris* ]] ; then
		# fix standards conflicts
		sed -i -e 's/\(_XOPEN_SOURCE\(_EXTENDED\)\?\|__EXTENSIONS__\)/  \1_DISABLED/' \
			glib/configure || die
		sed -i -e '/#define\s\+_POSIX_SOURCE/d' \
			glib/glib/giounix.c || die
	fi
}

src_configure() {
	local myconf

	if use internal-glib; then
		myconf+=' --with-internal-glib'
		# non-glibc platforms use GNU libiconv, but configure needs to
		# know about that not to get confused when it finds something
		# outside the prefix too
		if use prefix && use !elibc_glibc ; then
			myconf+=" --with-libiconv=gnu"
			# add the libdir for libtool, otherwise it'll make love with system
			# installed libiconv
			append-ldflags "-L${EPREFIX}/usr/lib64"
		fi
	else
		if ! has_version --host-root dev-util/pkgconfig; then
			export GLIB_CFLAGS="-I${EPREFIX}/usr/include/glib-2.0 -I${EPREFIX}/usr/lib64/glib-2.0/include"
			export GLIB_LIBS="-lglib-2.0"
		fi
	fi

	[[ ${PV} == *9999* ]] && myconf+=' --enable-maintainer-mode'

	ECONF_SOURCE=${S} \
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--with-system-include-path="${EPREFIX}"/usr/include \
		--with-system-library-path="${EPREFIX}"/usr/lib64 \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	if use prefix; then
		# Add an explicit reference to $EPREFIX to PKG_CONFIG_PATH to
		# simplify cross-prefix builds
		echo "PKG_CONFIG_PATH=${EPREFIX}/usr/lib64/pkgconfig:${EPREFIX}/usr/share/pkgconfig" >> "${T}"/99${PN}
		doenvd "${T}"/99${PN}
	fi
}
