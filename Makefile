TARGET := iphone:clang:latest:14.4
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TikTokURL

TikTokURL_FILES = Tweak.xm
TikTokURL_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
