**Photos House NAS**

Photos House NAS is a Flutter-based application that transforms your Wi-Fi router’s FTP server into a personal cloud solution for photo backup. It automatically syncs images from your phone’s camera folder to a home NAS setup — no subscriptions, no external cloud dependencies.

![alt text](img.png)

**Key Features->**

Automatic upload of photos from the phone's camera directory to an FTP server
Detects newly added or deleted images and reflects changes on the FTP server
Built using Flutter for cross-platform support and clean UI
Uses standard FTP protocol — compatible with most consumer Wi-Fi routers
Lightweight and works entirely on your local network

**FTP Integration (via Dart)**

This project uses a Dart-based FTP client to manage uploads, deletions, and directory listings directly within the app.
![alttest](./code.jpg)

**#How It Works**

Your home router must support FTP server functionality (usually available under storage or USB settings).
The app monitors the device's camera folder for new or deleted images.
When a new photo is taken or deleted:
It uploads new images to the FTP server
It deletes corresponding images from the server when they are removed locally
The app maintains a live directory map to keep the phone and NAS in sync

**Current Limitations**

Previewing images stored on the FTP server via Flutter’s NetworkImage widget does not work, due to lack of native FTP image rendering support
Temporary workaround could involve:
Downloading images locally before previewing
Running a lightweight proxy that exposes FTP files over HTTP for image access

## ISSUES
Unable to preview ftp images using flutter's network image plugin inside the app.
