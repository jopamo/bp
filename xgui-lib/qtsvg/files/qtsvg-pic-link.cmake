# Preserve Qt's PIC code generation during LTO without disabling PIE linkage.
list(TRANSFORM CMAKE_CXX_LINK_OPTIONS_PIE REPLACE "^-fPIE$" "-fPIC")
