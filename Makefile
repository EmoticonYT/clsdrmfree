ARCHS = arm64
GO_EASY_ON_ME = 1
DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ClassicLockScreen

# Added c++ to the libraries list to ensure the standard library is linked
ClassicLockScreen_LIBRARIES = MobileGestalt z c++

ClassicLockScreen_FILES = iOS9.xm iOS10.xm $(wildcard *.mm) $(wildcard *.m)
ClassicLockScreen_FRAMEWORKS = UIKit QuartzCore CoreGraphics MediaPlayer AudioToolbox Accelerate IOKit
ClassicLockScreen_PRIVATE_FRAMEWORKS = ManagedConfiguration MediaRemote MediaPlayerUI

# Added -x objective-c++ to ensure the compiler handles C++ headers correctly
ClassicLockScreen_CFLAGS = -fobjc-arc -x objective-c++ -include dlfcn.h -include ./DRM.pch

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += classiclockscreensettings

include $(THEOS_MAKE_PATH)/aggregate.mk
