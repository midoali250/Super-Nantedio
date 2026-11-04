# Desktop frontend architecture decision

## Decision

The default desktop frontend for new packaged games is Python with Pygame/SDL, following the existing Super Mario World desktop application. Emulator cores are native libraries (normally C/C++) connected through a well-defined interface. Electron is not the default frontend.

Use PyInstaller for desktop packaging. The Linux distribution target is AppImage; Windows uses a portable EXE; macOS uses an app bundle packaged for distribution. Maintain independent versions and update metadata for each game and operating system.

## Scope and limitations

This decision applies to desktop, not the Android frontend. It does not imply that the experimental branch currently has a working multisystem frontend or packager. Integrating cores, ROM loading, controls, audio, saves, updater and packaging still requires implementation and platform-specific tests.

A different technology should be introduced only with explicit approval or a demonstrated technical need, preserving game behavior and release compatibility where possible.
