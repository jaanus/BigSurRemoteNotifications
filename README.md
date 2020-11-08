# Big Sur - remote notifications test

Registering for remote notifications appears to be broken for me in Big Sur in development mode. This is a small example project of a macOS app registering for remote notifications. This exact code works as expected on Catalina in both development and production configurations. On Big Sur, it works as expected with production configuration. In development configuration, it does not work correctly - the notification registration callbacks are not called.

[Blog post.](https://jaanus.com/big-sur-remote-notifications/)
