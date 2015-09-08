MANIFEST_URL:="https://github.com/zenotec/repo.git"
DEFAULT_BRANCH:=daisy

CURRDIR:=$(shell pwd)
SCRATCHDIR:="/scratch/$(USER)/ZenHome/yocto"

ifeq ($(TOPDIR),)
TOPDIR:=$(shell pwd)
endif

ifeq ($(BRANCH),)
BRANCH:=$(DEFAULT_BRANCH)
endif

.PHONY: none
none:
	$(ECHO) "################################################################################"
	$(ECHO) "#"
	$(ECHO) "# Please specify one of the following targets: "
	$(ECHO) "#      all - Build all following targets"
	$(ECHO) "#     BBBC - Beaglebone Black Rev C"
	$(ECHO) "#      RPI - Raspberry Pi"
	$(ECHO) "#       VM - Virtual Machine image (Virtualbox)"
	$(ECHO) "#"
	$(ECHO) "################################################################################"

###############################################################################
.PHONY: all
all: BBBC RPI VM

.PHONY: distclean-all
distclean-all: distclean-BBBC distclean-RPI distclean-VM

###############################################################################
.PHONY: BBBC
BBBC:
	$(MAKE) MACHINE=beaglebone TARGET=zeno-image all-sub

.PHONY: distclean-BBBC
distclean-BBBC:
	$(MAKE) MACHINE=beaglebone distclean-sub

###############################################################################
.PHONY: VM
VM:
	$(MAKE) MACHINE=genericx86 TARGET=zeno-image all-sub

.PHONY: distclean-VM
distclean-VM:
	$(MAKE) MACHINE=genericx86 distclean-sub

###############################################################################
.PHONY: RPI
RPI:
	$(MAKE) MACHINE=raspberrypi TARGET=zeno-image all-sub

.PHONY: distclean-RPI
distclean-RPI:
	$(MAKE) MACHINE=raspberrypi distclean-sub


###############################################################################
.PHONY: all-sub
all-sub: \
	$(TOPDIR)/$(BRANCH)/setup.stamp \
	$(TOPDIR)/$(BRANCH)/checkout.stamp \
	$(TOPDIR)/$(BRANCH)/sync.stamp \
	$(TOPDIR)/$(BRANCH)/build-$(MACHINE)/config.stamp \
	$(TOPDIR)/$(BRANCH)/build.stamp

###############################################################################
.PHONY: distclean-sub
distclean-sub:
	$(RM) -rf $(SCRATCHDIR)/$(BRANCH)/build-$(MACHINE)
	$(RM) -rf $(TOPDIR)/$(BRANCH)/build-$(MACHINE)


###############################################################################
$(TOPDIR)/$(BRANCH)/setup.stamp:
	$(ECHO) "Setting up environment for building Yocto for: $(*)"
	$(MKDIR) -p $(TOPDIR)/$(BRANCH)
	$(TOUCH) $(TOPDIR)/$(BRANCH)/setup.stamp

###############################################################################
$(TOPDIR)/$(BRANCH)/checkout.stamp:
	$(ECHO) "Checking out Yocto for: $(*)"
	set -e; \
		$(CD) $(TOPDIR)/$(BRANCH); \
		$(REPO) init -u $(MANIFEST_URL) -b master -m ZenHome/$(BRANCH).xml
	$(TOUCH) $(TOPDIR)/$(BRANCH)/checkout.stamp

###############################################################################
$(TOPDIR)/$(BRANCH)/sync.stamp:
	$(ECHO) "Checking out Yocto for: $(*)"
	set -e; \
		$(CD) $(TOPDIR)/$(BRANCH); \
		$(REPO) sync
	$(TOUCH) $(TOPDIR)/$(BRANCH)/sync.stamp

###############################################################################
$(TOPDIR)/$(BRANCH)/build-$(MACHINE)/config.stamp:
	$(ECHO) "Configuring Yocto for: $(*)"
	export MACHINE=$(MACHINE)
	$(CD) $(TOPDIR)/$(BRANCH) && ./meta-zenotec/setup-env.sh $(MACHINE)
	$(CD) $(CURRDIR)
	set -e; \
		$(CD) $(TOPDIR)/$(BRANCH)/build-$(MACHINE); \
		$(MKDIR) -p $(SCRATCHDIR)/$(BRANCH)/build-$(MACHINE)/tmp; \
		$(LN) -sf $(SCRATCHDIR)/$(BRANCH)/build-$(MACHINE)/tmp tmp
	$(TOUCH) $(TOPDIR)/$(BRANCH)/build-$(MACHINE)/config.stamp

###############################################################################
$(TOPDIR)/$(BRANCH)/build.stamp:
	$(ECHO) "Building Yocto for: $(*)"
	./build.sh $(BRANCH) $(MACHINE) $(TARGET)




###############################################################################
# TOOL DEFINITIONS
###############################################################################
ECHO:=@/bin/echo
MKDIR:=$(QUIET)/bin/mkdir
CD:=$(QUIET)cd
LN:=$(QUIET)/bin/ln
CP:=$(QUIET)/bin/cp
RM:=$(QUIET)/bin/rm
TOUCH:=$(QUIET)/usr/bin/touch
GIT:=$(QUIET)/usr/bin/git
REPO:=$(QUIET)$(CURRDIR)/repo