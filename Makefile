
NAME=git-branch-blacklist
VERSION=$(shell cat VERSION)
ARCHIVE=$(NAME)-$(VERSION).tar.gz

RPMSPECDIR := .
RPMSPEC := $(RPMSPECDIR)/$(NAME).spec


clean:
	rm -rf dist/
	rm -rf rpm-build/

sdist: clean
	mkdir dist/
	tar --transform "s|git-branch-blacklist/|$(NAME)-$(VERSION)/|" --exclude dist/* --directory ../  --exclude-vcs -czf dist/$(ARCHIVE) $(NAME)


install:
	cp -rf bin/* $(PREFIX)/usr/bin/
	cp -rf git-hooks/ $(PREFIX)/usr/share/$(NAME)/

rpmcommon: sdist
	@mkdir -p rpm-build
	@cp dist/*.gz rpm-build/

srpm5: rpmcommon
	rpmbuild --define "_topdir %(pwd)/rpm-build" \
	--define 'dist .el5' \
	--define "_builddir %{_topdir}" \
	--define "_rpmdir %{_topdir}" \
	--define "_srcrpmdir %{_topdir}" \
	--define "_specdir $(RPMSPECDIR)" \
	--define "_sourcedir %{_topdir}" \
	--define "_source_filedigest_algorithm 1" \
	--define "_binary_filedigest_algorithm 1" \
	--define "_binary_payload w9.gzdio" \
	--define "_source_payload w9.gzdio" \
	--define "_default_patch_fuzz 2" \
	-bs $(RPMSPEC)
	@echo "#############################################"
	@echo "$(NAME) SRPM is built:"
	@find rpm-build -maxdepth 2 -name '$(NAME)*src.rpm' | awk '{print "    " $$1}'
	@echo "#############################################"

srpm: rpmcommon
	rpmbuild --define "_topdir %(pwd)/rpm-build" \
	--define "_builddir %{_topdir}" \
	--define "_rpmdir %{_topdir}" \
	--define "_srcrpmdir %{_topdir}" \
	--define "_specdir $(RPMSPECDIR)" \
	--define "_sourcedir %{_topdir}" \
	-bs $(RPMSPEC)
	@echo "#############################################"
	@echo "$(NAME) SRPM is built:"
	@find rpm-build -maxdepth 2 -name $(NAME)'*src.rpm' | awk '{print "    " $$1}'
	@echo "#############################################"

rpm: rpmcommon
	rpmbuild --define "_topdir %(pwd)/rpm-build" \
	--define "_builddir %{_topdir}" \
	--define "_rpmdir %{_topdir}" \
	--define "_srcrpmdir %{_topdir}" \
	--define "_specdir $(RPMSPECDIR)" \
	--define "_sourcedir %{_topdir}" \
	-ba $(RPMSPEC)
	@echo "#############################################"
	@echo "$(NAME) RPMs are built:"
	@find rpm-build/noarch -maxdepth 2 -name $(NAME)'*.rpm' | awk '{print "    " $$1}'
	@echo "#############################################"
