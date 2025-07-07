# Distributed under the terms of the GNU General Public License v2
# @ECLASS: xdg.eclass
# @SUPPORTED_EAPIS: 6 7 8
# @PROVIDES: xdg-utils
# @BLURB: Provides phases for XDG-compliant packages

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_XDG_ECLASS} ]]; then
_XDG_ECLASS=1

inherit xdg-utils   # xdg-utils already inherits emoji → log_* helpers available

# Avoid dependency loop as both depend on glib-2
[[ ${CATEGORY}/${P} != lib-util/glib-2.* ]] && _XDG_DEPEND="
	app-dev/desktop-file-utils
	xgui-misc/shared-mime-info
"

case ${EAPI} in
	6|7)
		xdg_src_prepare() { xdg_environment_reset; default; }
		EXPORT_FUNCTIONS src_prepare
		DEPEND="${_XDG_DEPEND}"
		;;
	*)
		xdg_src_prepare() { die "Called xdg_src_prepare in EAPI >= 8"; }
		IDEPEND="${_XDG_DEPEND}"
		;;
esac
unset _XDG_DEPEND

# ── phase helpers ──────────────────────────────────────────────────────
xdg_pkg_preinst() {
	local f
	XDG_ECLASS_DESKTOPFILES=()
	while IFS= read -r -d '' f; do
		XDG_ECLASS_DESKTOPFILES+=( "${f}" )
	done < <(cd "${ED}" && find usr/share/applications -type f -print0 2>/dev/null)

	XDG_ECLASS_ICONFILES=()
	while IFS= read -r -d '' f; do
		XDG_ECLASS_ICONFILES+=( "${f}" )
	done < <(cd "${ED}" && find usr/share/icons -type f -print0 2>/dev/null)

	XDG_ECLASS_MIMEINFOFILES=()
	while IFS= read -r -d '' f; do
		XDG_ECLASS_MIMEINFOFILES+=( "${f}" )
	done < <(cd "${ED}" && find usr/share/mime -type f -print0 2>/dev/null)
}

_xdg_do_updates() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

# ── ebuild phase exports ───────────────────────────────────────────────
xdg_pkg_postinst() { _xdg_do_updates; }
xdg_pkg_postrm()   { _xdg_do_updates; }

fi  # _XDG_ECLASS guard

EXPORT_FUNCTIONS pkg_preinst pkg_postinst pkg_postrm
