set +x +e

CURRENT_SNAPSHOT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
CURRENT_VERSION=$(echo $CURRENT_SNAPSHOT_VERSION | sed "s/-SNAPSHOT//")
NEXT_VERSION=$(echo $CURRENT_VERSION | awk -F. -v OFS=. '{$NF += 1 ; print}')

git tag "$CURRENT_VERSION" -m "Releases version $CURRENT_VERSION"
git push --tags --force

echo "Next tag $NEXT_VERSION"

mvn versions:set-property \
  -Dproperty=revision \
  -DnewVersion=$NEXT_VERSION \
  -DgenerateBackupPoms=false

git add pom.xml
git commit -m "Preparing for next release version $NEXT_VERSION"
git push origin HEAD
