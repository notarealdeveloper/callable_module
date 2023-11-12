PKG := callable_module
VER := $(shell grep '^version' pyproject.toml | grep -Eo '([0-9\.])+')
TAR := dist/$(PKG)-$(VER).tar.gz

build: $(TAR)

version:
	@echo $(VER)

$(TAR):
	python -m build

install: build
	pip install $(TAR)

develop:
	pip install -e .

check:
	pytest tests/

uninstall:
	pip uninstall $(PKG)

clean:
	rm -rfv dist build/ src/*.egg-info

push-test:
	python -m twine upload --repository testpypi dist/*

pull-test:
	pip install -i https://test.pypi.org/simple/ $(PKG)

push-prod:
	python -m twine upload dist/*

pull-prod:
	pip install $(PKG)

