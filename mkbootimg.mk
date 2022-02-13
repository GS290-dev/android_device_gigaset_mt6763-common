# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(INTERNAL_BOOTIMAGE_FILES) $(BOARD_AVB_BOOT_KEY_PATH) $(BOARD_GKI_SIGNING_KEY_PATH) $(BOOTIMAGE_EXTRA_DEPS) $(BOARD_PREBUILT_VBMETAIMAGE) $(INSTALLED_KERNEL_TARGET)
	$(call pretty,"Target boot image: $@")
	$(MKBOOTIMG) --kernel $(call bootimage-to-kernel,$@) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) \
		$(INTERNAL_MKBOOTIMG_GKI_SINGING_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(call assert-max-image-size,$@,$(call get-hash-image-max-size,$(call get-bootimage-partition-size,$@,boot)))
	$(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(call get-bootimage-partition-size,$@,boot) \
		--partition_name boot $(INTERNAL_AVB_BOOT_SIGNING_ARGS) \
		$(BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS)
	$(hide) $(AVBTOOL) append_vbmeta_image --image $@ --partition_size $(BOARD_BOOTIMAGE_PARTITION_SIZE) --vbmeta_image $(BOARD_PREBUILT_VBMETAIMAGE)

$(INSTALLED_RECOVERYIMAGE_TARGET): $(recoveryimage-deps) $(RECOVERYIMAGE_EXTRA_DEPS) $(BOARD_PREBUILT_VBMETAIMAGE) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RECOVERY_KERNEL)
	$(MKBOOTIMG) --kernel $(strip $(recovery_kernel)) $(INTERNAL_RECOVERYIMAGE_ARGS) \
		$(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(INTERNAL_MKBOOTIMG_GKI_SINGING_ARGS) \
		$(BOARD_RECOVERY_MKBOOTIMG_ARGS) --output $@
	$(call assert-max-image-size,$@,$(call get-hash-image-max-size,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE)))
	$(AVBTOOL) add_hash_footer --image $@ --partition_size $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) --partition_name recovery $(INTERNAL_AVB_RECOVERY_SIGNING_ARGS) $(BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS)
	$(hide) $(AVBTOOL) append_vbmeta_image --image $@ --partition_size $(BOARD_BOOTIMAGE_PARTITION_SIZE) --vbmeta_image $(BOARD_PREBUILT_VBMETAIMAGE)
