curl -sSfLO "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-static-x86_64.AppImage"
curl -sSfLO "https://github.com/linuxdeploy/linuxdeploy-plugin-gtk/raw/master/linuxdeploy-plugin-gtk.sh"
chmod a+x linuxdeploy*
 
mkdir -p AppDir/usr/bin
cp DrMario64 AppDir/usr/bin/
cp -r assets/ AppDir/usr/bin/
cp .github/linux/{DrMario64.desktop,DrMario64.png} AppDir/

./linuxdeploy-static-x86_64.AppImage --appimage-extract
mv squashfs-root/ deploy
ARCH=x86_64 ./deploy/AppRun --appdir=AppDir/ -d AppDir/DrMario64.desktop -i AppDir/DrMario64.png -e AppDir/usr/bin/DrMario64 --plugin gtk
sed -i 's/exec/#exec/g' AppDir/AppRun
echo 'cd "$this_dir"/usr/bin/' >> AppDir/AppRun
echo './DrMario64' >> AppDir/AppRun
ARCH=x86_64 ./deploy/usr/bin/linuxdeploy-plugin-appimage --appdir=AppDir
