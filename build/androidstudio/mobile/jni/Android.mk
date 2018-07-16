LOCAL_PATH := $(call my-dir)
# Recursive wildcards, as per: https://stackoverflow.com/a/18258352/9110986
rwildcard   = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

include $(CLEAR_VARS)

LOCAL_MODULE    := static_library
LOCAL_SRC_FILES := $(call rwildcard, $(LOCAL_PATH)/../../../../src/library/static/, *.cpp)
LOCAL_CPPFLAGS  := -std=c++11 -DSHARED_LIB

include $(BUILD_STATIC_LIBRARY)
include $(CLEAR_VARS)

LOCAL_MODULE    := shared_library
LOCAL_SRC_FILES := $(call rwildcard, $(LOCAL_PATH)/../../../../src/library/shared/, *.cpp)
LOCAL_CPPFLAGS  := -std=c++11

include $(BUILD_SHARED_LIBRARY)
include $(CLEAR_VARS)

LOCAL_MODULE           := project
LOCAL_SRC_FILES        := $(call rwildcard, $(LOCAL_PATH)/../../../../src/project/, *.cpp)
LOCAL_LDLIBS           := -llog -landroid
LOCAL_CPPFLAGS         := -std=c++11
LOCAL_C_INCLUDES       := $(LOCAL_PATH)/../../../../src/
LOCAL_STATIC_LIBRARIES := static_library android_native_app_glue
LOCAL_SHARED_LIBRARIES := shared_library

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
