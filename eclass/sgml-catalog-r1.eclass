# Distributed under the terms of the GNU General Public License v2

# @ECLASS: sgml-catalog-r1.eclass
# @MAINTAINER:
# 1g4 Project <1g4@example.org>
# @SUPPORTED_EAPIS: 7
# @BLURB: Functions for installing SGML catalogs

case ${EAPI} in
	7) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_SGML_CATALOG_R1_ECLASS} ]]; then
_SGML_CATALOG_R1_ECLASS=1

inherit emoji

if [[ ${CATEGORY}/${PN} != app-tex/sgml-common ]]; then
	RDEPEND=">=app-tex/sgml-common-0.6.3-r7"
fi

# @FUNCTION: sgml-catalog-r1_update_catalog
# @DESCRIPTION:
# Regenerate /etc/sgml/catalog to include all installed catalogs.
sgml-catalog-r1_update_catalog() {
	local shopt_save=$(shopt -p nullglob)
	shopt -s nullglob
	local cats=( "${EROOT}"/etc/sgml/*.cat )
	${shopt_save}

	if [[ ${#cats[@]} -gt 0 ]]; then
		log_info "Updating ${EROOT}/etc/sgml/catalog"
		printf 'CATALOG "%s"\n' "${cats[@]#${ROOT}}" > "${T}/catalog" &&
		mv "${T}/catalog" "${EROOT}/etc/sgml/catalog" || log_err "Failed to update catalog"
		log_ok "SGML catalog updated"
	else
		log_info "Removing ${EROOT}/etc/sgml/catalog"
		rm -f "${EROOT}/etc/sgml/catalog"
		rmdir "${EROOT}/etc/sgml" &>/dev/null || :
		log_ok "SGML catalog removed"
	fi
}

# @FUNCTION: sgml-catalog-r1_update_env
# @DESCRIPTION:
# Remove obsolete environment files. They can break tools such as asciidoc.
sgml-catalog-r1_update_env() {
	rm -f "${EROOT}/etc/env.d/93sgmltools-lite" "${EROOT}/etc/sgml/sgml.env" "${EROOT}/etc/sgml/sgml.cenv"
}

sgml-catalog-r1_pkg_postinst() {
	sgml-catalog-r1_update_catalog
	sgml-catalog-r1_update_env
}

sgml-catalog-r1_pkg_postrm() {
	sgml-catalog-r1_update_catalog
	sgml-catalog-r1_update_env
}

fi

EXPORT_FUNCTIONS pkg_postinst pkg_postrm
