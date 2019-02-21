REM for debugging, enable output
REM @echo off

set /a num=0

for /f "delims=" %%a in ('identify -format "%%w\n" %1') do @set width=%%a
for /f "delims=" %%a in ('identify -format "%%h\n" %1') do @set height=%%a
for %%a in (%1) do @set /a num+=1

set /a cols=%3/%width%
set /a rows=%3/%height%

set /a rowsMax=(%num% + %cols% - 1) / %cols%

echo %rowsMax%

if %num% LSS %cols% set cols=%num%
if %rowsMax% LSS %rows% set rows=%rowsMax%

set /a whd=%width%/2
set /a hhd=%height%/2
set /a wsd=%width%/4
set /a hsd=%height%/4

set ext=""

if not "%4" == "-noscale" (
	mkdir +hd
	mkdir +hd2
	montage -background transparent %1 -geometry %whd%x%hhd%^>+0+0 -tile %cols%x%rows% "+hd/%2.png"
	montage -background transparent %1 -geometry %wsd%x%hsd%^>+0+0 -tile %cols%x%rows% %2.png
	set ext="+hd2/"
)

montage -background transparent %1 -geometry %width%x%height%^>+0+0 -tile %cols%x%rows% %ext%%2.png
