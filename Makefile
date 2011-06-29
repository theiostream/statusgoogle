GO_EASY_ON_ME=1
include theos/makefiles/common.mk

TWEAK_NAME = StatusGoogle
StatusGoogle_FILES = StatusGoogleController.xm
StatusGoogle_INSTALL_PATH = /System/Library/WeeAppPlugins/StatusGoogle.bundle/
StatusGoogle_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)cp -r Resources/* $(THEOS_STAGING_DIR)/System/Library/WeeAppPlugins/StatusGoogle.bundle/$(ECHO_END)
	$(ECHO_NOTHING)mv $(THEOS_STAGING_DIR)/System/Library/WeeAppPlugins/StatusGoogle.bundle/StatusGoogle.dylib $(THEOS_STAGING_DIR)/System/Library/WeeAppPlugins/StatusGoogle.bundle/StatusGoogle$(ECHO_END)

