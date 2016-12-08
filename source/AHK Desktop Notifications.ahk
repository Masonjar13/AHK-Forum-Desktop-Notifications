#singleInstance force
#persistent
#include *i <Lib_1>
#include <IEObj>
loginURL:="https://autohotkey.com/boards/ucp.php?mode=login"
notificationsURL:="https://autohotkey.com/boards/ucp.php?i=ucp_notifications"

; gui
gui,add,edit,vnotes r10 w400 readonly

wb:=new IEObj
wb.init()
wb.navToUrl(loginURL)
wb.wb.visible:=1
msgbox,,Login,Log in then press OK to continue.
wb.wb.visible:=0
setTimer,checkNotifications,10000
return

checkNotifications:
note:=""
wb.navToUrl(notificationsURL)
try{
    notifList:=wb.wb.document.getElementsByClassName("topiclist cplist two-columns")[0].getElementsByTagName("li")
    loop % notifList.length
    {
        isNew:=notifList[a_index-1].getElementsByTagName("input")[0].getAttribute("disabled",2)
        if(isNew)
            continue
        noteInfo:=notifList[a_index-1].getElementsByTagName("p")[0].innerText
        noteTimestamp:=notifList[a_index-1].getElementsByTagName("p")[1].innerText
        note.=noteInfo . "`n" . noteTimestamp . "`n`n`n"
    }
}
catch
    msgbox error
guiControl,,notes,% note
return

f1::gui,show,,AHK Forums Notifications
