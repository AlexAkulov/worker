VERSION := $(shell git describe --always --tags --abbrev=0 | tail -c +2)
RELEASE := $(shell git describe --always --tags | awk -F- '{ if ($$2) dot="."} END { printf "1%s%s%s%s\n",dot,$$2,dot,$$3}')
PIP_VERSION := $(shell git describe --always --tags | tail -c +2 | awk -F- '{ if ($$2) printf "%s.dev%s-%s\n",$$1,$$2,$$3; else print $$1 }')

VENDOR := "SKB Kontur"
URL := "https://github.com/moira-alert"
LICENSE := "GPLv3"

version:
	echo $(PIP_VERSION) > version.txt

prepare:
	pip install -r requirements.txt
	pip install coverage

test: prepare
	cd tests && coverage run --source="../moira/" --omit="../moira/graphite/*,../moira/metrics/*" /usr/bin/trial functional cache expression

pip: version
	python setup.py sdist

clean:
	rm -rf build dist moira_worker.egg-info tests/_trial_temp

rpm: version
	fpm -t rpm \
		-s "python" \
		--description "Moira Worker" \
		--vendor $(VENDOR) \
		--url $(URL) \
		--license $(LICENSE) \
		--name "moira-worker" \
		--version "$(VERSION)" \
		--iteration "$(RELEASE)" \
		--before-install "./pkg/preinst" \
		--after-install "./pkg/postinst" \
		--no-python-dependencies \
		-p build \
		setup.py