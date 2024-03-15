# portfile.cmake
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/yalantinglibs
    REF v0.3.0
    SHA512 43a9ead56b9b3117888c17b3c753554f6ebfdede6ddaff651ca0f674d9322b37b9168305b78c2c5fd5c8907dc4f89f36d1c38261dfe505831b04bde2ce28f5b1
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