ifeq ($(PACKAGE_SET),dom0)
    RPM_SPEC_FILES := \
        anti-evil-maid/anti-evil-maid.spec \
        tpm-extra/tpm-extra.spec \
        trousers-changer/trousers-changer.spec
endif

SOURCE_COPY_IN := $(RPM_SPEC_FILES)

$(RPM_SPEC_FILES): SPEC=$(notdir $@)
$(RPM_SPEC_FILES): PACKAGE=$(basename $(SPEC))
$(RPM_SPEC_FILES): SOURCE_ARCHIVE_NAME=$(PACKAGE)-$(shell cat $(CHROOT_DIR)$(DIST_SRC)/version).tar.gz
$(RPM_SPEC_FILES):
	# Create the archive for specific Qubes packages
	[[ -e $(CHROOT_DIR)$(DIST_SRC)/$(PACKAGE)/$(SOURCE_ARCHIVE_NAME) ]] \
		|| $(BUILDER_DIR)/scripts/create-archive $(CHROOT_DIR)/$(DIST_SRC)/$(PACKAGE) $(SOURCE_ARCHIVE_NAME)

NO_ARCHIVE = 1

dist-package-build: RPM_SOURCE_DIR=$(dir $(DIST_SRC)/$(PACKAGE))
