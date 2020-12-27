$(call inherit-product, build/target/product/embedded.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

PRODUCT_DEVICE := GS290
PRODUCT_NAME := omni_GS290
PRODUCT_BRAND := gigaset
PRODUCT_MODEL := GS290
PRODUCT_MANUFACTURER := Gigaset
