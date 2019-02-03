IMAGE := qmk-ubuntu
FIRMWARE := qmk_firmware
FIRMWARE_REPO := git@github.com:yowcow/qmk_firmware.git
BUILD := .build

DOCKER_RUN_OPT := \
	-v `pwd`/$(FIRMWARE):/$(FIRMWARE):rw \
	-v `pwd`/$(BUILD):/$(FIRMWARE)/$(BUILD):rw \
	-w /$(FIRMWARE)

ARTIFACT := redox_rev1_yowcow.hex
TARGET := redox:yowcow

all: $(ARTIFACT)

setup:
	$(MAKE) -j 2 docker-build $(FIRMWARE)

docker-build:
	docker build -t $(IMAGE) .

$(FIRMWARE):
	git clone -o $@ $(FIRMWARE_REPO)

$(BUILD):
	mkdir -p $@

$(ARTIFACT):
	docker run --rm -it $(DOCKER_RUN_OPT) $(IMAGE) sh -c 'make $(TARGET)' && cp $(BUILD)/$(ARTIFACT) .

clean:
	rm -rf $(ARTIFACT) $(BUILD)

realclean: clean
	docker rmi $(IMAGE)
	#rm -rf $(FIRMWARE)

debug: $(BUILD)
	docker run --rm -it $(DOCKER_RUN_OPT) $(IMAGE) bash

.PHONY: all setup docker-build clean realclean debug
