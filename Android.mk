# !!! build with APP_STL=gnustl_static !!!
LOCAL_PATH := $(call my-dir)

#BOOST := /home/yath/sgs/ndk/boost
OPENSSL := /home/yath/sgs/ndk/openssl
#include $(OPENSSL)/Android.mk

include $(CLEAR_VARS)
LOCAL_MODULE := intl
LOCAL_SRC_FILES := intl/autosprintf.cpp
LOCAL_C_INCLUDES += $(LOCAL_PATH)/intl
LOCAL_EXPORT_C_INCLUDES += $(LOCAL_C_INCLUDES)
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
# $(call import-module,openssl)
LOCAL_MODULE    := libencfs

LOCAL_SRC_FILES += $(addprefix encfs/,readpassphrase.cpp base64.cpp \
				ConfigReader.cpp ConfigVar.cpp Context.cpp Cipher.cpp \
				CipherKey.cpp FileIO.cpp RawFileIO.cpp BlockFileIO.cpp \
				CipherFileIO.cpp MACFileIO.cpp NameIO.cpp StreamNameIO.cpp \
				BlockNameIO.cpp NullNameIO.cpp Interface.cpp MemoryPool.cpp \
				NullCipher.cpp DirNode.cpp FileNode.cpp FileUtils.cpp openssl.cpp SSL_Cipher.cpp)

MY_RLOG_COMPONENT       := libencfs

LOCAL_C_INCLUDES        += $(LOCAL_PATH) $(LOCAL_PATH)/android-include $(LOCAL_PATH)/encfs $(OPENSSL)/include /home/yath/sgs/ndk/boost
LOCAL_EXPORT_C_INCLUDES += $(LOCAL_C_INCLUDES)

LOCAL_CPPFLAGS        += -fexceptions -D__STDC_FORMAT_MACROS -DBOOST_FILESYSTEM_VERSION=2 -DOPENSSL_NO_ENGINE -DHAVE_EVP_AES -DHAVE_EVP_BF
LOCAL_EXPORT_CPPFLAGS += $(LOCAL_CPPFLAGS)

#LOCAL_SHARED_LIBRARIES := libcrypto
LOCAL_STATIC_LIBRARIES += fuse rlog intl boost_filesystem_v2 boost_serialization boost_system androidglue

include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := encfs_bin

LOCAL_SRC_FILES := $(addprefix encfs/,encfs.cpp main.cpp)

MY_RLOG_COMPONENT       := encfs

LOCAL_STATIC_LIBRARIES += libencfs fuse rlog intl androidglue boost_filesystem_v2 boost_serialization boost_system
LOCAL_LDLIBS += -L/home/yath/sgs/cmsrc/out/target/product/galaxysmtd/system/lib -lcrypto -ldl -lssl
include $(BUILD_EXECUTABLE)

$(call import-module,fuse)
$(call import-module,rlog)
$(call import-module,androidglue)
$(call import-module,boost)
