# portfile.cmake
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alibaba/yalantinglibs
    REF v0.3.2
    SHA512 05515e4ad167051a4ac794a95b71a0a603aeddf649f25b63acc57887ee3d71db1dc2ce7eb79a74b2d57a03cab15cf4e60bcb3f608bc4edeae6768ab7fd4b7e4e
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