#singleInstance force
#persistent
#include *i <Lib_1>
#include <IEObj>
#include <crypt>

loginURL:="https://autohotkey.com/boards/ucp.php?mode=login"
notificationsURL:="https://autohotkey.com/boards/ucp.php?i=ucp_notifications"

; credentials (use cryptLogin.ahk)
user:=
pass:=

; gui
gui,add,edit,vnotes r10 w400 readonly

wb:=new IEObj
wb.init()
wb.navToUrl(loginURL)
;wb.wb.visible:=1

; login
cr:=decryptLogin(user,pass)
try {
    wb.wb.document.getElementById("username").value:=cr.user
    wb.wb.document.getElementById("password").value:=cr.pass
    wb.wb.document.getElementsByClassName("button1")[0].click()
    wb.waitLoad()
}catch{
    cr:=""
    msgbox,,Error,There was a problem logging in.
    exitApp
}
cr:=""
;msgbox,,Login,Log in then press OK to continue.
;wb.wb.visible:=0
setTimer,checkNotifications,10000
return

checkNotifications:
note:=""
wb.navToUrl(notificationsURL)
try{
    notifList:=wb.wb.document.getElementsByClassName("topiclist cplist two-columns")[0].getElementsByTagName("li") ; notification list
    loop % notifList.length
    {
        noteInfo:=noteReason:=noteTimestamp:=""
        isNew:=notifList[a_index-1].getElementsByTagName("input")[0].getAttribute("disabled",2) ; check for disabled checkbox
        if(isNew)
            continue
        noteInfo:=notifList[a_index-1].getElementsByTagName("p")[0].innerText ; notification header
        noteTimestamp:=notifList[a_index-1].getElementsByTagName("p")[1].innerText
        if(inStr(noteInfo,"Topic approval")||inStr(noteInfo,"Post reported")){ ; check for mod post, correctly return timestamp and reason
            noteReason:=noteTimestamp
            noteTimestamp:=notifList[a_index-1].getElementsByTagName("p")[2].innerText
        }            
        note.=noteInfo . "`n" . (noteReason?noteReason . "`n":"") . noteTimestamp . "`n`n`n"
    }
}
catch
    msgbox error
guiControl,,notes,% note
return

f1::gui,show,,AHK Forums Notifications
