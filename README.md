
Booksonic Air - Sherlock
========
[![release-github-shield]][booksonic-air-link]
[![downloads-air-shield]][booksonic-air-link]
[![issues-air-shield]](issues)
[![License-air][license-shield]](LICENSE.md)
[![reddit-shield]][reddit-link]
[![twitter-shield]][twitter-link]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee-link]


**OBS:** This version is very early BETA, you probably want [Booksonic Air](https://github.com/popeen/Booksonic-Air) for now


What is Booksonic?
-----------------

Booksonic is an award-winning open-source platform for accessing the audibooks you own wherever you are.
At the moment the platform consists of

 - **[Booksonic Air - Sherlock](https://github.com/popeen/Booksonic-Air-Sherlock)** - A server for streaming your audiobooks. It is the third iteration of Booksonic servers. Based on Airsonic-Advanced.
 - **[Booksonic Android App](https://github.com/popeen/Booksonic-App)** - An android app for connection to Booksonic servers. Based on DSub
 
**Extra tools**
 - **[Booksonic ODM2Meta](https://github.com/popeen/Booksonic-Export-Booksonic-Metadata-from-ODM-Files)** - A script for quickly converting your ODM files to metadata that can be used by Booksonic. In the future this will not be needed as Booksonic will soon support ODM files natively.
 - **[Bulk convert UTF8](https://github.com/popeen/Booksonic-Bulk-convert-to-UTF8)** - A script for bulk conversion of meta files to UTF-8
 - **[Booksonic Library Editor](https://github.com/galacticat/booksonic-library-editor)** - A third party Library editor
 - **[Download Librivox top 100](https://github.com/popeen/Download-Librivox-Top-100)** - A script for downloading the most popular audiobooks from Librivox

While there is no iOS app available (yet) Booksonic fully supports the Subsonic API so you will be able to use it with any app that supports that, you will miss out on some Booksonic specific features but  you will be able to listen without problem.

More information about the project can be found at [booksonic.org](https://booksonic.org)

What is Booksonic Air?
-----------------
First of all, credit where credit is due, Booksonic Air is not built from scratch, instead it is building on top of the amazing work done by a lot of other people. In the current iteration Booksonic Air is built on top of [Airsonic-Advanced](https://github.com/airsonic-advanced/airsonic-advanced), previous versions of the Booksonic servers have also been based on [Airsonic](https://github.com/airsonic/airsonic) and [Subsonic](https://subsonic.org).

Now then, Booksonic Air is a server for hosting the audiobooks you own and reach them from wherever you are. Perfect for those boring bus rides!

It is designed to handle very large collections (hundreds of gigabytes). Although optimized for MP3 streaming, it works for any audio format that can stream over HTTP, for instance AAC and OGG. By using transcoder plug-ins, Booksonic supports on-the-fly conversion and streaming of virtually any audio format.

If you have constrained bandwidth, you may set an upper limit for the bitrate of the streams. Booksonic will then automatically resample to a suitable bitrate.

Booksonic runs on most platforms, including Windows, Mac, Linux and Unix variants.

![Screenshot](contrib/assets/screenshot.png)


Usage
-----

All Booksonic downloads can be found at
https://booksonic.org/download

Pull requests
---------
All pull requests are welcome to any of the Booksonic projects

Community
---------
If you have any questions or ideas, come visit us at [/r/booksonic](https://reddit.com/r/booksonic) over on Reddit

[booksonic-air-link]: https://github.com/popeen/Booksonic-Air
[booksonic-app-link]: https://github.com/popeen/Booksonic-App

[release-github-shield]: https://img.shields.io/badge/released-github-green.svg
[googleplay-shield]: https://img.shields.io/badge/released-google%20play-green.svg
[googleplay-link]: https://play.google.com/store/apps/details?id=github.popeen.dsub

[googleplaydownloads-shield]: https://img.shields.io/badge/google%20play%20downloads-10.000%2B-blue.svg
[downloads-air-shield]: https://img.shields.io/github/downloads/popeen/booksonic-air/total

[issues-shield]: https://img.shields.io/github/issues-raw/popeen/Booksonic-App.svg
[issues-air-shield]: https://img.shields.io/github/issues-raw/popeen/Booksonic-Air.svg

[license-shield]: https://img.shields.io/github/license/popeen/Booksonic-App.svg
[license-air-shield]: https://img.shields.io/github/license/popeen/Booksonic-Air.svg

[reddit-shield]: https://img.shields.io/reddit/subreddit-subscribers/booksonic?style=social
[reddit-link]: https://reddit.com/r/booksonic

[twitter-shield]: https://img.shields.io/twitter/follow/popeencom?style=social
[twitter-link]: https://twitter.com/popeencom

[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg
[buymeacoffee-link]: https://www.buymeacoffee.com/popeen
