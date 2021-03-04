set(SOURCES
	main.cpp
	Directory/ClassA.cpp
)

add_executable(${CMAKE_PROJECT_NAME} ${SOURCES})
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
					 RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)
