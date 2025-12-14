checks=(
    LocalUseCheck
    GlobalUseCheck
    IuseCheck
    RequiredUseCheck
    ProfilesCheck
    RepoManifestHashCheck
    VariableScopeCheck
    VariableOrderCheck
    DependencyCheck
    MetadataVarCheck
)

for check in "${checks[@]}"; do
    pkgcheck scan -c "$check"
done
