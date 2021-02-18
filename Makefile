#  				GENERAL PURPOSE MAKEFILE 			#
# Author: Arturo Misino (misino.arturo@gmail.com)	#
# License: MIT License								#
# 													#
# A basic Makefile to compile a general c++ project #
# It requires another Makefile in the source folder #
# defining the SOURCES and SUBDIRS variables 		#

## OPTIONS ##
PROGRAM = Project

OBJDIR = obj/
SRCDIR = src/
BINDIR = bin/
PROGRAM := $(BINDIR)$(PROGRAM)

## PROGRAMS ##
CXX = g++
LINK  = ld

## FLAGS ##
CXX_STANDARD_FLAGS = -std=c++2a
CXX_WARNING_FLAGS = -Werror -Wextra -Wall -Wno-nonnull-compare -Wno-deprecated-copy -Wno-address-of-packed-member -Wundef -Wcast-qual -Wwrite-strings -Wimplicit-fallthrough -Wno-expansion-to-defined
CXX_FLAVOR_FLAGS = -fno-exceptions -fno-rtti -fstack-protector

INCLUDE_FLAGS = -Isrc
OPTIMIZATION_FLAGS = 
DEFINES = 

CXXFLAGS = -MMD -MP $(CXX_WARNING_FLAGS) $(OPTIMIZATION_FLAGS) $(CXX_FLAVOR_FLAGS) $(CXX_STANDARD_FLAGS) $(INCLUDE_FLAGS) $(DEFINES)

LDFLAGS = 

QUIET = @

.PHONY: all clean subdirs

# INCLUDE ALL THE FILES 
include $(SRCDIR)Makefile

## RECIPIES ##
OBJECTS = $(foreach source, $(SOURCES), $(patsubst %.cpp, %.o, $(source))) # All the objects
OBJECTS := $(foreach source, $(OBJECTS), $(OBJDIR)$(source)) # Correct Path in OBJDIR
DEPS = $(patsubst %.o, %.d, $(OBJECTS)) # Dependencies -MMD

SUBDIRS += $(BINDIR) $(OBJDIR)

all: $(PROGRAM)

$(PROGRAM): $(OBJECTS) # Linking
	@echo "$(notdir $(CURDIR)): LINK $(PROGRAM)"
	$(QUIET) $(CXX) $(LDFLAGS) -o $(PROGRAM) $(OBJECTS)

$(OBJDIR)%.o: $(SRCDIR)%.cpp | subdirs # Compiling 
	@echo "$(notdir $(CURDIR)): C++ $@"
	$(QUIET) $(CXX) $(CXXFLAGS) -o $@ -c $<

subdirs: $(SUBDIRS) # Creating all the directories
$(SUBDIRS): 
	@mkdir -p $(BINDIR)
	@mkdir -p $(OBJDIR)
	@mkdir -p $(OBJDIR)$@

clean:
	rm -rf $(OBJDIR)*

-include $(DEPS)
