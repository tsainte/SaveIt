fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios first_things_first
```
fastlane ios first_things_first
```
create the apps at the provisioning portal and handle the certificates
### ios provisioning
```
fastlane ios provisioning
```
Runs match for all the type available
### ios build
```
fastlane ios build
```
Build it all
### ios test
```
fastlane ios test
```

### ios metrics
```
fastlane ios metrics
```
Runs some metrics for ensure code quality

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
