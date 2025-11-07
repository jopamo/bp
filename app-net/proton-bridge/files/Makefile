# Minimal Makefile for Proton Mail Bridge CLI (Desktop-Bridge)
# builds only the CLI executable from main.go

export GO111MODULE=on
export CGO_ENABLED=1

APP_NAME := proton-bridge
APP_VERSION ?= 3.21.2+git
BUILD_ENV ?= dev
BUILD_TIME := $(shell date +%FT%T%z)
REVISION := $(shell git rev-parse --short HEAD 2>/dev/null || echo unknown)

OUT_DIR := bin
OUT_BIN := $(OUT_DIR)/$(APP_NAME)

GO_LDFLAGS := $(addprefix -X github.com/ProtonMail/proton-bridge/v3/internal/constants., \
	Version=$(APP_VERSION) \
	Revision=$(REVISION) \
	BuildTime=$(BUILD_TIME) \
	BuildEnv=$(BUILD_ENV))

BUILD_FLAGS := -ldflags '$(GO_LDFLAGS)'

# Default target
.PHONY: all
all: build

.PHONY: build
build:
	@echo ">>> Building CLI binary"
	mkdir -p $(OUT_DIR)
	go build $(BUILD_FLAGS) -o $(OUT_BIN) main.go
	@echo "Built: $(OUT_BIN)"

.PHONY: test
test:
	go test -v ./...

.PHONY: install
install:
	install -Dm755 $(OUT_BIN) "$(DESTDIR)/usr/bin/$(APP_NAME)"

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)
