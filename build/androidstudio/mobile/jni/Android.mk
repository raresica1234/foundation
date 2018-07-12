LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Recursive wildcards, as per: https://stackoverflow.com/a/18258352/9110986
rwildcard        = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
SRC_FILES       := $(call rwildcard, $(LOCAL_PATH)/../../../../src/project/, *.cpp)
#SRC_FILES       += $(LOCAL_PATH)/../../../../src/project/android_native_app_glue.c

LOCAL_MODULE    := project
LOCAL_SRC_FILES := $(SRC_FILES)
LOCAL_LDLIBS    := -llog -landroid
LOCAL_CPPFLAGS  := -std=c++11
LOCAL_STATIC_LIBRARIES := android_native_app_glue

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
