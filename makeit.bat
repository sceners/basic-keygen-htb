set file=keygen
\masm32\bin\rc /v %file%.rc
\masm32\bin\ml /c /coff /Cp %file%.asm
\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /LIBPATH:\masm32\lib %file%.obj %file%.res
del *.obj
del *.res
%file%.exe