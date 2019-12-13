# This is a GNU Makefile.

# It can be used to compile an OpenCL program with
# the Altera SDK for OpenCL.


# You must configure ALTERAOCLSDKROOT to point the root directory of the Altera SDK for OpenCL
# software installation.
# See http://www.altera.com/literature/hb/opencl-sdk/aocl_getting_started.pdf 
# for more information on installing and configuring the Altera SDK for OpenCL.


TARGET := darwin-xl


# Directories.
HOST_DIR := host
TARGET_DIR := ./
#INC_DIRS := ./ ./common/inc
#LIB_DIRS := ./common/lib:/opt/glibc-2.14/lib
INC_DIRS := ./
LIB_DIRS := 

# All include files.
INC_FILES := $(foreach D,$(INC_DIRS),$(wildcard $D/*.h))

# Source files.
SRCS := $(wildcard ./*.cpp)

# Libraries.
LIBS := 

# Compiler.
CC := g++ 


# Compilation flags
#ifeq ($(DEBUG),1)
CXXFLAGS += -g  -std=c++11 
#endif

# Make it all!
all : $(TARGET_DIR)/$(TARGET)

# Host executable target.
$(TARGET_DIR)/$(TARGET) : Makefile $(SRCS) $(INC_FILES)
	@[ -d $(TARGET_DIR) ] || mkdir $(TARGET_DIR)
	$(ECHO)$(CC) $(CXXFLAGS) -fPIC $(foreach D,$(INC_DIRS),-I$D) \
			$(SRCS) \
			$(foreach D,$(LIB_DIRS),-L$D) \
			$(foreach L,$(LIBS),-l$L) -lpthread \
			-o $(TARGET_DIR)/$(TARGET)

# Standard make targets
clean :
	$(ECHO)rm -f $(TARGET_DIR)/$(TARGET)

.PHONY : all clean

