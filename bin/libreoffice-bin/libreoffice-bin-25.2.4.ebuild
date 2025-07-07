# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg prefix unpacker

BASE_SRC_URI="https://download.documentfoundation.org/libreoffice/stable/${PV}/deb"

DESCRIPTION="A full office productivity suite. Binary package"
HOMEPAGE="https://www.libreoffice.org"
SRC_URI_AMD64="
	${BASE_SRC_URI}/x86_64/LibreOffice_${PV}_Linux_x86-64_deb.tar.gz
"
SRC_URI="
	amd64? ( ${SRC_URI_AMD64} )
"
S="${WORKDIR}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

IUSE="java offlinehelp python"

DEPEND="
	app-crypto/mit-krb5
	lib-core/libxml2
	bin/openjdk11
"

LANGUAGES_HELP=(
	en:en-US
)
LANGUAGES=(
	${LANGUAGES_HELP[@]}
)

handle_lang() {
	local lang helppack langpack

	for lang in ${LANGUAGES_HELP[@]}; do
		SRC_URI+=" l10n_${lang%:*}? (
			offlinehelp? (
				${BASE_SRC_URI}/x86_64/LibreOffice_${PV}_Linux_x86-64_deb_helppack_${lang#*:}.tar.gz
			)
		)"
	done
	for lang in ${LANGUAGES[@]}; do
		if [[ ${lang%:*} != en ]]; then
			SRC_URI+=" l10n_${lang%:*}? (
				${BASE_SRC_URI}/x86_64/LibreOffice_${PV}_Linux_x86-64_deb_langpack_${lang#*:}.tar.gz
			)"
		fi
		IUSE+=" l10n_${lang%:*}"
	done
}
handle_lang

RESTRICT="test strip"

QA_PREBUILT="opt/* usr/*"

src_unpack() {
	default

	BINPKG_BASE=$(find "${WORKDIR}" -mindepth 1 -maxdepth 1 -name 'LibreOffice_*_deb' -type d -print || die)
	BINPKG_BASE="${BINPKG_BASE##${WORKDIR}}"
	[[ -z ${BINPKG_BASE} ]] && die "Failed to detect binary package directory!"

	# We don't package Firebird anymore
	rm "${WORKDIR}"/${BINPKG_BASE}/DEBS/libobasis${PV%*.*}-firebird*_amd64.deb || die

	# The GNOME and KDE integration .debs are a mix of both:
	# 1) VCLs (GUI backends), and
	# 2) Actual DE integration (which needs KF5 and so on)
	#
	# For now, we always install the GTK one, and don't install the Qt
	# one (as it's Qt5-based).
	#
	# KDE integration itself also requires KF5 as of 25.2.0, so we choose not to use it.
	# Can revisit when it's KF6-based.
	rm "${WORKDIR}"/${BINPKG_BASE}/DEBS/libobasis${PV%*.*}-kde-integration*_amd64.deb || die

	# Bundled Python is used (3.10 as of 25.2.0), so no need for system dependency.
	if ! use python ; then
		rm "${WORKDIR}"/${BINPKG_BASE}/DEBS/libobasis${PV%*.*}-python-script-provider*_amd64.deb || die
	fi

	# The downloaded .deb has a DEBS/ directory with e.g. libreoffice25.2_25.2.0.3-3_amd64.deb
	# and many other .debs for each component.
	readarray -t -d '' debs < <(find "${WORKDIR}" -name '*.deb' -type f -print0 || die)

	local deb
	for deb in "${debs[@]}" ; do
		unpack_deb "${deb}"
	done
}

src_prepare() {
	default

	cat <<-EOF > "${T}"/50-${PN} || die
	SEARCH_DIRS_MASK="@GENTOO_PORTAGE_EPREFIX@/opt/libreoffice${PV%*.*}"
	EOF
	eprefixify "${T}"/50-${PN}
}

src_install() {
	dodir /usr /opt
	mv "${S}"/usr/local/* "${S}"/usr || die
	cp -aR "${S}"/opt/* "${ED}"/opt/ || die
	cp -aR "${S}"/usr/* "${ED}"/usr/ || die
	rmdir "${ED}"/usr/local || die
	rm "${ED}/usr/share/mime/packages/libreoffice$(ver_cut 1-2).xml"
	rm "${ED}/opt/libreoffice$(ver_cut 1-2)/program/libavmediagst.so"
	cp "${ED}/usr/share/icons/hicolor/scalable/apps/libreoffice$(ver_cut 1-2)-main.svg" "${ED}/usr/share/icons/hicolor/scalable/apps/libreoffice-main.svg"

	# convenience wrapper
    cat <<'EOF' > "${T}/${PN}"
    #!/bin/sh
    JAVA_HOME=/opt/openjdk11
    PATH="$JAVA_HOME/bin:$PATH"
    exec /usr/bin/libreofficeLIBO_PLACEHOLDER "$@"
EOF

# replace placeholder with the correct major.minor (e.g. 25.2)
sed -i "s/LIBO_PLACEHOLDER/${PV%*.*}/" "${T}/${PN}" || die
dobin "${T}/${PN}"

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild
	doins "${T}/50-${PN}"
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
    xdg_icon_cache_update
}
