mkdir build
mkdir build/Contents
mkdir build/Contents/MacOS

cp ../a.out build/Contents/MacOS/cse441

pkgbuild --analyze --root ./build 'Info.plist'

#######cp Info.plist build/Content/

#pkgbuild --root ./build                      \
#         --component-plist 'Info.plist'      \
#         --identifier "edu.csusb.cse441"     \
#         --version "1.0"                     \
#         --install-location "/Applications"  \
#         'cse441.pkg'
