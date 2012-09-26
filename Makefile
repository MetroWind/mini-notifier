all: mininotifier

mininotifier: clean
	xcodebuild -project "Mini Notifier.xcodeproj" -configuration Release
	rm -vrf "Mini Notifier.app"
	mv -v "build/Release/Mini Notifier.app" ./
	echo '#!/bin/sh'"\nexec \"$(shell pwd)/Mini Notifier.app/Contents/MacOS/Mini Notifier\"" '"$$@"' > notify.sh
	chmod +x notify.sh

clean:
	rm -rfv build
