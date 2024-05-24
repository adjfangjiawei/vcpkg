vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/libphonenumber
    REF "v${VERSION}"
    SHA512 81ba804e6dcda97a458b9ece4917b350350c87c2dc190263c389470beb6c5521ef16ca6a0ecd82c46a1bc118f9a392ff3ede1219301b7306610c8d60cdcd16b4
    HEAD_REF master
    PATCHES 
        fix-re2-identifiers.patch
        fix-icui18n-lib-name.patch
        fix-find-protobuf.patch
        re2-2023-07-01-compat.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/cpp"
    OPTIONS
        -DREGENERATE_METADATA=ON
        -DUSE_RE2=ON
        -DBUILD_GEOCODER=ON
        -DUSE_PROTOBUF_LITE=ON
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_TESTING=OFF)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
