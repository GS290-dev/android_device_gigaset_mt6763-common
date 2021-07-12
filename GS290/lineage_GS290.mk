#
# Copyright (C) 2019 The LineageOS Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from GS290 device
$(call inherit-product, device/gigaset/GS290-unified/device.mk)

PRODUCT_BRAND := gigaset
PRODUCT_DEVICE := GS290
PRODUCT_MANUFACTURER := Gigaset
PRODUCT_NAME := lineage_GS290
PRODUCT_MODEL := GS290

# Build info
BUILD_FINGERPRINT := "Gigaset/GS290_EEA/GS290:10/QP1A.190711.020/1597810494:user/release-keys"
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=GS290_EEA \
    PRIVATE_BUILD_DESC="full_k63v2_64_bsp-user 10 QP1A.190711.020 1597810494 release-keys"

PRODUCT_GMS_CLIENTID_BASE := android-gigaset
