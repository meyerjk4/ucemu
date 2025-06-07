install(
    TARGETS ucemu_exe
    RUNTIME COMPONENT ucemu_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
