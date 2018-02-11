all: build

build:
	swift build

release:
	swift build --configuration release

update:
	swift package update

test:
	swift test

docs:
	swift package generate-xcodeproj

clean:
	swift package clean

.PHONY: build release update test docs clean
