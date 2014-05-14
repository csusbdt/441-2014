APP=cse441
ACTOOL=/Applications/Xcode.app/Contents/Developer/usr/bin/actool

cse441.pkg : 
	mkdir -p build/${APP}.app/Contents/MacOS
	cp ../a.out build/${APP}.app/Contents/MacOS/
	$ACTOOL  --compile ../working Assets.car
	pkgbuild --analyze                              \
		 --root ./build/${APP}.app              \
		 'build/${APP}.app/Contents/Info.plist'
	pkgbuild --root ./build                                            \
		 --component-plist 'build/${APP}.app/Contents/Info.plist'  \
		 --identifier "edu.csusb.cse441"                           \
		 --version "1.0"                                           \
		 --install-location "/Applications"                        \
		 '${APP}.pkg'

clean :
	rm -rf build ${APP}.pkg

