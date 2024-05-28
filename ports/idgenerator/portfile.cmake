# portfile.cmake
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yitter/IdGenerator
    REF v1.3.3
    SHA512 0f3128a669605612af3a2532a91c4ad9fd94887d6073dd0b2d76172bf14ca4a403de3f2a0384228415cce2f211f98d2165df94f33a8d93b89cbf6960cc517230
    HEAD_REF master
)


vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/C/source
    PREFER_NINJA
)

vcpkg_build_cmake()

file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/libYitIdHelper.so DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/yitidgenc.so DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/idgen/libidgen.so DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(GLOB HEADER_FILES "${SOURCE_PATH}/C/source/idgen/*.h")
foreach(FILE ${HEADER_FILES})
    file(COPY ${FILE} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
endforeach()
file(COPY ${SOURCE_PATH}/C/source/YitIdHelper.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)


file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/libYitIdHelper.so DESTINATION ${CURRENT_PACKAGES_DIR}/lib/debug)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/yitidgenc.so DESTINATION ${CURRENT_PACKAGES_DIR}/lib/debug)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/idgen/libidgen.so DESTINATION ${CURRENT_PACKAGES_DIR}/lib/debug)
file(GLOB HEADER_FILES "${SOURCE_PATH}/C/source/idgen/*.h")
foreach(FILE ${HEADER_FILES})
    file(COPY ${FILE} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/include)
endforeach()
file(COPY ${SOURCE_PATH}/C/source/YitIdHelper.h DESTINATION ${CURRENT_PACKAGES_DIR}/debug/include)