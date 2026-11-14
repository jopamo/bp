# Preserve PIC code generation during LTO without disabling PIE linkage.
list(TRANSFORM CMAKE_CXX_LINK_OPTIONS_PIE REPLACE "^-fPIE$" "-fPIC")

function(qttools_test_tools)
    foreach(test IN ITEMS
            tst_generatedOutput tst_validateQdocOutputFiles tst_tdiag
            tst_lcheck tst_lconvert tst_lrelease tst_ltext2id tst_lupdate
            tst_qtattributionsscanner tst_objcnamemangler)
        if(TARGET ${test})
            # Keep Qt's installed library paths, but test the tools from this build.
            file(GENERATE OUTPUT "$<TARGET_FILE_DIR:${test}>/qt.conf" CONTENT
"[Config]
MergeQtConf=true
[Paths]
Binaries=${PROJECT_BINARY_DIR}/${INSTALL_BINDIR}
LibraryExecutables=${PROJECT_BINARY_DIR}/${INSTALL_LIBEXECDIR}
")
        endif()
    endforeach()
endfunction()

cmake_language(DEFER CALL qttools_test_tools)
