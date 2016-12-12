Name: radeon-profile
Url: https://github.com/marazmista/radeon-profile
License: GPL-2.0
Group: System/Monitoring
AutoReqProv: on
Version: 1
Release: 2%{?dist}
Summary: App for display info about radeon card
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-build

%if 0%{?rhel}
BuildRequires: libjpeg-turbo-devel qt-devel
Requires: qt4 sensors xdriinfo glxinfo
%else
Suggests: sensors xdriinfo glxinfo

%if 0%{?suse_version}
BuildRequires: libqt5-qtbase-devel libqt5-linguist
Requires: libqt5-qtbase

%if 0%{?suse_version} >= 1140
BuildRequires:  update-desktop-files
%endif

%else 
BuildRequires: qt5-qtbase-devel qt5-linguist
Requires: qt5-qtbase
%endif

%endif

BuildRequires: make gcc-c++ libXrandr-devel

Requires: libXrandr

%description
Application to read current clocks of ATi Radeon cards (xf86-video-ati and fglrx).


%prep
%setup -q


%build
cd radeon-profile
# https://en.opensuse.org/openSUSE:Build_system_recipes#qmake
qmake-qt5 radeon-profile.pro QMAKE_CFLAGS+="%optflags" QMAKE_CXXFLAGS+="%optflags" QMAKE_STRIP="/bin/true" || qmake-qt4 radeon-profile.pro QMAKE_CFLAGS+="%optflags" QMAKE_CXXFLAGS+="%optflags" QMAKE_STRIP="/bin/true"
lrelease-qt5 radeon-profile.pro || lrelease-qt4 radeon-profile.pro
make


%install
cd radeon-profile
install -Dm755 "radeon-profile" "%{buildroot}%{_bindir}/radeon-profile"
install -Dm644 "extra/radeon-profile.png" "%{buildroot}%{_datadir}/pixmaps/radeon-profile.png"
install -Dm644 "extra/radeon-profile.desktop" "%{buildroot}%{_datadir}/applications/radeon-profile.desktop"
cd translations
for t in $(ls *.qm); do install -Dm644 "$t" "%{buildroot}%{_datadir}/radeon-profile/$t"; done


%if 0%{?suse_version} >= 1140
%post
%desktop_database_post
%endif


%if 0%{?suse_version} >= 1140
%postun
%desktop_database_postun
%endif


%files
%{_bindir}/radeon-profile
%{_datadir}/pixmaps/radeon-profile.png
%{_datadir}/applications/radeon-profile.desktop
%{_datadir}/radeon-profile


%changelog
* Fri Jan 29 2016 danysan95@gmail.com
- Port of OBS package to other Arch / Debian / Ubuntu

* Sun Oct 27 2013 pontostroy@gmail.com
- initial Open Build Service package

* Sat Mar 2 2013 marazmista@gmail.com
-Initial commit
