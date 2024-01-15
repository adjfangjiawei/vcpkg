# portfile.cmake
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/yalantinglibs
    REF v0.2.8
    SHA512 29346926a8dd2bd5cd6ab59712a8634e829f52bbcf2f7c0a5a958309eeb6a6f39067c40962d68ec97be982552c5a9e8529c6aad097fdd8a08a5403a32e73f3a6
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
	    -DBUILD_EXAMPLES=OFF 
		-DBUILD_BENCHMARK=OFF 
		-DBUILD_UNIT_TESTS=OFF 
		-DENABLE_SSL=ON 
		-DENABLE_PMR=ON 
		-DENABLE_IO_URING=ON 
		-DENABLE_FILE_IO_URING=ON 
		-DENABLE_STRUCT_PACK_UNPORTABLE_TYPE=ON 
		-DENABLE_STRUCT_PACK_OPTIMIZE=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)