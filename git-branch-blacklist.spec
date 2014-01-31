%{!?CODE_VERSION: %global CODE_VERSION %(cat VERSION)}


Name:           git-branch-blacklist
Version:        %{CODE_VERSION}
Release:        1%{?dist}
Group:          Development/Tools
Summary:        Git branch blacklisting tools

License:        GPLv3+
URL:            https://github.com/ashcrow/git-branch-blacklist
Source0:        %{name}-%{version}.tar.gz

Requires:       git
BuildArch:      noarch

%description
Git branch blacklisting tools for use over the SSH transport.

%prep
%setup -q


%build
make


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}/
mkdir -p $RPM_BUILD_ROOT/%{_datarootdir}/%{name}/
PREFIX=$RPM_BUILD_ROOT %make_install


%files
%defattr(-, root, root, -)
%doc README.md
%{_bindir}/git-branch-blacklist
%{_bindir}/git-branch-blacklist-install
%{_datarootdir}/%{name}/git-hooks/pre-receive



%changelog
* Fri Jan 31 2014 Steve Milner <stevem@gnulinux.net> - 0.1.0-1
- Initial spec file.
