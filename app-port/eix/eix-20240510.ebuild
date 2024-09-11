# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=8c13aa0e1c7938dfdc6b786957d6a4d4f2e9681d

inherit autotools

DESCRIPTION="Search and query ebuilds"
HOMEPAGE="https://github.com/vaeth/eix/"
SRC_URI="https://github.com/vaeth/eix/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sqlite tmpfilesd"

DEPEND="
	app-var/push
	app-var/quoter
	sqlite? ( lib-core/sqlite )
"

pkg_setup() {
	local old_cache="${EROOT}/var/cache/${PN}"
	test -f "${old_cache}" && rm -f -- "${old_cache}"
}

src_prepare() {
	default
	sed -i -e "s:/:${EPREFIX}/:" tmpfiles.d/eix.conf || die

	sed -e "/eixf_source=/s:push.sh:cat \"${EPREFIX}/usr/share/push/push.sh\":" \
		-e "/eixf_source=/s:quoter_pipe.sh:cat \"${EPREFIX}/usr/share/quoter/quoter_pipe.sh\":" \
		-i src/eix-functions.sh.in || die
	sed -e "s:'\$(bindir)/eix-functions.sh':cat \\\\\"${EPREFIX}/usr/share/eix/eix-functions\\\\\":" \
		-i src/Makefile.am || die

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_with sqlite)
		--without-extra-doc
		--disable-nls
		--without-protobuf
		--with-dep-default
		--with-required-use-default
		--with-portage-rootpath="${ROOTPATH}"
		--with-eprefix-default="${EPREFIX}"
		--with-sh-shebang="${EPREFIX}/bin/sh"
		--disable-separate-binaries
		--disable-separate-tools
		--disable-debugging
		--disable-new_dialect
		--disable-optimization
		--disable-strong-optimization
		--disable-security
		--disable-nopie-security
		--disable-strong-security
		)
		econf "${myconf[@]}"
}

src_install() {
	default

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins tmpfiles.d/eix.conf
	fi
}

pkg_postinst() {
	local obs="${EROOT}/var/cache/eix.previous"
	if test -f "${obs}"; then
		ewarn "Found obsolete ${obs}, please remove it"
	fi

	if use tmpfilesd; then
		systemd-tmpfiles --create /usr/lib/tmpfiles.d/eix.conf || die
	fi
}

pkg_postrm() {
	if [ -z "${REPLACED_BY_VERSION}" ]; then
		rm -r -- "${EROOT}/var/cache/${PN}" || die
	fi
}
