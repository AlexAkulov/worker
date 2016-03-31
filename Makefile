VERSION := $(shell git describe --always --tags --abbrev=0 | tail -c +2)
RELEASE := $(shell git describe --always --tags | awk -F- '{ if ($$2) dot="."} END { printf "1%s%s%s%s\n",dot,$$2,dot,$$3}')
PIP_VERSION := $(shell git describe --always --tags | tail -c +2 | awk -F- '{ if ($$2) printf "%s.dev%s_%s\n",$$1,$$2,$$3; else print $$1 }')

VENDOR := "SKB Kontur"
URL := "https://github.com/moira-alert"
LICENSE := "GPLv3"

build:
	echo $(PIP_VERSION) > version.txt

clean:
	rm -rf build dist moira_worker.egg-info
