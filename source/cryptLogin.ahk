#singleInstance force
#persistent
#include *i <Lib_1>
#include <crypt>

gui,add,text,section,User: 
gui,add,edit,vuser ys
gui,add,text,xm section,Pass: 
gui,add,edit,vpass password ys
gui,add,button,gsubmit,Encrypt Credentials
gui,show,,Encrypt Login
return

submit:
gui,submit
cr:=encryptLogin(user,pass)
clipboard:="user:=""" . cr.user . """`npass:=""" . cr.pass . """"

guiClose:
exitApp
