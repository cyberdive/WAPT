#!/bin/sh

set -ex
if [ -d BUILD ]; then
    echo "removing BUILD directory"
    find BUILD -delete
fi
if [ -d RPMS ]; then
    echo "remove RPMS build directory"
    find RPMS -delete
fi
if [ -d BUILDROOT ]; then
    echo "remove BUILDROOT build directory"
    find BUILDROOT -delete
fi

mkdir -p BUILD RPMS
rm -rf $PWD/builddir
VERSION=$(python get_version.py ../waptserver_config.py)
QA_SKIP_BUILD_ROOT=1 rpmbuild -bb --define "_version $VERSION" --buildroot $PWD/builddir -v waptserver.spec 1>&2
#rm -rf $PWD/builddir
rm -f tis-waptserver*.rpm
cp RPMS/*/tis-waptserver*.rpm .
echo tis-waptserver*.rpm
