THEOS_DEVICE_IP=192.168.1.105

include theos/makefiles/common.mk

BUNDLE_NAME = StatusGoogle
StatusGoogle_FILES = StatusGoogleController.m
StatusGoogle_INSTALL_PATH = /Library/WeeLoader/Plugins
StatusGoogle_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"