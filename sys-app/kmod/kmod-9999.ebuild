# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit multilib python-r1

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/${PN}/${PN}.git"
	inherit autotools git-r3
	KEYWORDS="amd64 arm64"
else
	SRC_URI="mirror://kernel/linux/utils/kernel/kmod/${P}.tar.xz"
	inherit libtool
fi

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug doc lzma python static-libs +tools zlib"

RESTRICT="test"

RDEPEND="!sys-app/module-init-tools
	!sys-app/modutils
	!<sys-app/openrc-0.13.8
	!<sys-app/systemd-216-r3
	lzma? ( >=app-compression/xz-utils-5.0.4-r1 )
	python? ( ${PYTHON_DEPS} )
	zlib? ( >=lib-sys/zlib-1.2.6 )" #427130
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	lzma? ( dev-util/pkgconfig )
	python? (
		dev-python/cython[${PYTHON_USEDEP}]
		dev-util/pkgconfig
		)
	zlib? ( dev-util/pkgconfig )"
if [[ ${PV} == 9999* ]]; then
	DEPEND="${DEPEND}
		lib-dev/libxslt"
fi

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	default

	if [ ! -e configure ]; then
		if use doc; then
			gtkdocize --copy --docdir libkmod/docs || die
		else
			touch libkmod/docs/gtk-doc.make
		fi
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
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-shared
		--with-rootlibdir="${EPREFIX}"/usr/$(get_libdir)
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
		run_in_build_dir econf "${myeconfargs[@]}" "$@"
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
}
