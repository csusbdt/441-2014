APP=cse441
#ACTOOL=/Applications/Xcode.app/Contents/Developer/usr/bin/actool
#	$ACTOOL  --compile ../working Assets.car

#		 --component-plist 'Info.plist'                            \
#	cp Info.plist build/${APP}.app/Contents/

cse441.pkg : 
	mkdir -p build/${APP}.app/Contents/MacOS
	mkdir -p build/${APP}.app/Contents/Resources
	cp Info.plist build/${APP}.app/Contents/
	cp ../working/a.out build/${APP}.app/Contents/MacOS/
	cp -r ../working/* build/${APP}.app/Contents/Resources/
	rm build/${APP}.app/Contents/Resources/a.out
	pkgbuild --root ./build                                            \
		 --identifier "edu.csusb.cse441"                           \
		 --version "1.0"                                           \
		 --install-location "/Applications"                        \
		 '${APP}.pkg'


#plist :
#	pkgbuild --analyze                              \
#		 --root ./build/${APP}.app              \
#		Info.plist
#
#		 'build/${APP}.app/Contents/Info.plist'

clean :
	rm -rf build ${APP}.pkg

