Name: radeon-profile
Url: https://github.com/marazmista/radeon-profile
License: GPLv2+
Group: System/Monitoring
AutoReqProv: on
Version: 1
Release: 2%{?dist}
Summary: Application to read current clocks of ATi Radeon cards (xf86-video-ati and fglrx).
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-build

%if 0%{?suse_version}
BuildRequires: libqt5-qtbase-devel
Requires: libqt5-qtbase
%else
BuildRequires: qt5-qtbase-devel
Requires: qt5-qtbase
%endif

BuildRequires: make
BuildRequires: gcc-c++
BuildRequires: libXrandr-devel

Requires: libXrandr

Recommends: sensors
Recommends: xdriinfo
Recommends: glxinfo

%description
App for display info about radeon card

%prep
%setup -q

%build
CFLAGS="%{optflags}"
CXXFLAGS="%{optflags}"
mkdir -p build
cd build
qmake-qt5 ../radeon-profile
make

%install
install -Dm755 "build/radeon-profile" "%{buildroot}%{_bindir}/radeon-profile"
install -Dm644 "radeon-profile/extra/radeon-profile.png" "%{buildroot}%{_datadir}/pixmaps/radeon-profile.png"
install -Dm644 "radeon-profile/extra/radeon-profile.desktop" "%{buildroot}%{_datadir}/applications/radeon-profile.desktop"

%post -p /sbin/ldconfig  
   
%postun -p /sbin/ldconfig  

%files
%{_bindir}/radeon-profile
%{_datadir}/pixmaps/radeon-profile.png
%{_datadir}/applications/radeon-profile.desktop

%changelog
* Fri Jan 29 2016 danysan95@gmail.com
- Port of OBS package to other Arch / Debian / Ubuntu

* Sun Oct 27 2013 pontostroy@gmail.com
- initial Open Build Service package

* Sat Mar 2 2013 marazmista@gmail.com
-Initial commit
