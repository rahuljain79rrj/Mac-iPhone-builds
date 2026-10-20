# Step Logger

A small iPhone app.  You type in a number of steps and it writes them to Apple Health.

## Get the IPA

1. Push to GitHub.  The "Build IPA" workflow runs on a macOS runner.
2. Open the run under the Actions tab and download the `StepLogger-ipa` artifact.  Unzip it to get `StepLogger.ipa`.

## Install from Windows

1. Install iTunes (the Apple website version, not the Microsoft Store one) and Sideloadly.
2. Connect the iPhone by cable and tap Trust.
3. Drag `StepLogger.ipa` into Sideloadly, enter your Apple ID and click Start.
4. On the iPhone, go to Settings > General > VPN & Device Management and trust your Apple ID.
5. Open the app, enter steps and tap Add to Health.  Allow the Steps permission when asked.

A free Apple ID install expires after 7 days and must be repeated.  Health data already saved stays in Health.

## Notes

- Entries show in Health under the source "Step Logger".  If the iPhone also counts steps itself, Health may avoid double counting by preferring one source.  Reorder sources in Health > Browse > Activity > Steps > Data Sources & Access.
- HealthKit support with free Apple IDs depends on Sideloadly keeping the entitlement.  If the permission prompt never appears, the entitlement was dropped and a paid developer account is the fix.
