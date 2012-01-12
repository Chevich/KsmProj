@echo on
@echo  опирование проекта дл€ общего пользовани€
@echo [Ctrl+C] - выход.
@pause
copy P:\BAUSHA\ksmproj.exe X:\APPS\EXCHANGE\REAL\KsmProj.exe
X:
CD APPS\EXCHANGE\
call cmpr_ksm.bat
C:
@pause
