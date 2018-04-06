# Save it
SaveIt is a quick alternative to have a look into your balances from the major banks in the UK on your iPhone and/or your Apple Watch. This has been done by using Open Banking APIs.

🚀*At this moment the project is just an experiment and it is working, with ___limitations___, with Monzo and Starling developer accounts only. I do have plans to integrate with Revolut, Lloyds and HSBC if possible in the future.*

To run the project:
- `sudo gem install bundler`
- `bundle install`
- `pod install`
- Rename `configuration_example.plist` file to `configuration.plist`
- Add your secrets and tokens from [Monzo](https://developers.monzo.com/) and [Starling](https://developer.starlingbank.com/) to `configuration.plist`

For the branching strategy the project uses `git flow` and for CI it will use a `Jenkins` pipeline together with `fastlane`.
