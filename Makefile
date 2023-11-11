export ARCHS = arm64 armv7 armv7s arm64e
ifeq ($(THEOS_PACKAGE_SCHEME),roothide)
export ARCHS = arm64 arm64e
endif
export TARGET = iphone:latest:9.0
INSTALL_TARGET_PROCESSES = SpringBoard
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FLEXing
$(TWEAK_NAME)_GENERATOR = internal
$(TWEAK_NAME)_FILES = Tweak.xm SpringBoard.xm
$(TWEAK_NAME)_CFLAGS += -fobjc-arc -w

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

# For printing variables from the makefile
print-%  : ; @echo $* = $($*)

# The SUBPROJECTS feature bundles both projects into
# one package. We want two separate packages.
#
# SUBPROJECTS += libflex
# include $(THEOS_MAKE_PATH)/aggregate.mk
