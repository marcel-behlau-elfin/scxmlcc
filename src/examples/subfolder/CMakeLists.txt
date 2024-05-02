set (CMAKE_CXX_STANDARD 17)
set( CMAKE_INCLUDE_CURRENT_DIR ON )
scxmlcc_generator( ${CMAKE_CURRENT_SOURCE_DIR}/microwave-02-cplusplus.scxml microwave_gen_src_2 )
#add_library(testlib SHARED "") # A local target is working fine!
target_sources(testlib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/testlib.cpp ${microwave_gen_src_2})
target_include_directories(testlib PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
)
