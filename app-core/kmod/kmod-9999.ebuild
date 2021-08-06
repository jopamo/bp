# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit python-r1

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/${PN}/${PN}.git"
	inherit autotools git-r3
else
	SRC_URI="mirror://kernel/linux/utils/kernel/kmod/${P}.tar.xz"
	inherit libtool
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug lzma python static-libs +tools zlib"

RESTRICT="test"

RDEPEND="
	lzma? ( >=app-compression/xz-utils-5.0.4-r1 )
	python? ( ${PYTHON_DEPS} )
	zlib? ( >=lib-core/zlib-1.2.6 )"

DEPEND="${RDEPEND}
	lzma? ( dev-util/pkgconf )
	python? (
		dev-python/cython[${PYTHON_USEDEP}]
		dev-util/pkgconf
		)
	zlib? ( dev-util/pkgconf )"

if [[ ${PV} == 9999* ]]; then
	DEPEND="${DEPEND}
		lib-core/libxslt
		app-text/docbook-xml-dtd:4.2"
fi

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	default

	if [ ! -e configure ]; then
		touch libkmod/docs/gtk-doc.make
		eautoreconf
	else
		elibtoolize
	fi

	# Restore possibility of running --enable-static wrt #472608
	sed -i \
		-e '/--enable-static is not supported by kmod/s:as_fn_error:echo:' \
		configure || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-shared
		--with-rootlibdir="${EPREFIX}"/usr/lib
		--disable-gtk-doc
		$(use_enable debug)
		$(use_enable static-libs static)
		$(use_enable tools)
		$(use_with lzma xz)
		$(use_with zlib)
	)

	local ECONF_SOURCE="${S}"

	kmod_configure() {
		mkdir -p "${BUILD_DIR}" || die
		run_in_build_dir econf "${myconf[@]}" "$@"
	}

	BUILD_DIR="${WORKDIR}/build"
	kmod_configure --disable-python

	if use python; then
		python_foreach_impl kmod_configure --enable-python
	fi
}

src_compile() {
	emake -C "${BUILD_DIR}"

	if use python; then
		local native_builddir=${BUILD_DIR}

		python_compile() {
			emake -C "${BUILD_DIR}" -f Makefile -f - python \
				VPATH="${native_builddir}:${S}" \
				native_builddir="${native_builddir}" \
				libkmod_python_kmod_{kmod,list,module,_util}_la_LIBADD='$(PYTHON_LIBS) $(native_builddir)/libkmod/libkmod.la' \
				<<< 'python: $(pkgpyexec_LTLIBRARIES)'
		}

		python_foreach_impl python_compile
	fi
}

src_install() {
	emake -C "${BUILD_DIR}" DESTDIR="${D}" install

	if use python; then
		local native_builddir=${BUILD_DIR}

		python_install() {
			emake -C "${BUILD_DIR}" DESTDIR="${D}" \
				VPATH="${native_builddir}:${S}" \
				install-pkgpyexecLTLIBRARIES \
				install-dist_pkgpyexecPYTHON
		}

		python_foreach_impl python_install
	fi

	use static-libs || find "${ED}" -name "*.la" -delete || die

	mkdir "${ED}"/usr/sbin
	mv "${ED}"/usr/bin/kmod "${ED}"/usr/sbin/kmod

	if use tools; then
		local bincmd sbincmd
		for sbincmd in depmod insmod lsmod modinfo modprobe rmmod; do
			dosym kmod /usr/sbin/${sbincmd}
		done
	fi

	cat <<-EOF > "${T}"/usb-load-ehci-first.conf
	softdep uhci_hcd pre: ehci_hcd
	softdep ohci_hcd pre: ehci_hcd
	EOF

	insinto /lib/modprobe.d
	doins "${T}"/usb-load-ehci-first.conf #260139

	cleanup_install
}
