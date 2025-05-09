@rem drive_aliases.bat - Ilya Akkuzin <gr3yknigh1@gmail.com>
@rem
@rem This is alias commands which you should place inside `%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`. Lookup these locations you can via this commands: `shell:startup` and `shell:common startup` in "Run" program (which you can open with Win+x key-combination).
@rem
@rem ref: <https://www.softwareok.com/?seite=faq-Beginners&faq=104>.

@echo off

@rem "Private Code" drive.
subst P: %USERPROFILE%\Documents\Code
