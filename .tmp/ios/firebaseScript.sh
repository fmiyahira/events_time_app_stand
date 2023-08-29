if [ "$CONFIGURATION" == "Debug-dev" ] || [ "$CONFIGURATION" == "Release-dev" ]; then
  cp Runner/dev/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-hom" ] || [ "$CONFIGURATION" == "Release-hom" ]; then
  cp Runner/hom/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-prd" ] || [ "$CONFIGURATION" == "Release-prd" ]; then
  cp Runner/prd/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi