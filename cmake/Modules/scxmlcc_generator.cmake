# Generate statemachine from input file
# Usage:
#   filename: Name of input file
#   target: Name of target, which depends on the statemachine
function (scxmlcc_generator filename target )

   # if we didn't compile the scxmlcc, then go find it in the system
   if ( TARGET scxmlcc )
      set(SCC scxmlcc )
   else()
      find_program( SCC scxmlcc )
   endif()

   get_filename_component(ext ${filename} EXT)
   if(NOT ext STREQUAL ".scxml")
      message("skipping ${filename}")
      return()
   endif()

   get_filename_component(base ${filename} NAME_WE)
   set(output ${CMAKE_CURRENT_BINARY_DIR}/${base}.h)

   add_custom_command(
        OUTPUT ${output}
        COMMAND ${SCC} --stringevents -i ${filename}  -o ${output}
        DEPENDS ${filename}
   )

   # Append hash to avoid problems with same named input files
   string(MD5 hash ${filename})
   set(intermediateTarget "scxmlcc_${base}_${hash}")

   add_custom_target(
        ${intermediateTarget}
        DEPENDS ${output}
   )

   add_dependencies(${target} ${intermediateTarget})


endfunction()
