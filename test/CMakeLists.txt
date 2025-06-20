# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(ucemuTests LANGUAGES CXX)

# ---- Dependencies ----

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(ucemu_test source/ucemu_test.cpp)
target_link_libraries(
    ucemu_test PRIVATE
    ucemu_lib
    Catch2::Catch2WithMain
)
target_compile_features(ucemu_test PRIVATE cxx_std_20)

catch_discover_tests(ucemu_test)

# ---- End-of-file commands ----

add_folders(Test)
