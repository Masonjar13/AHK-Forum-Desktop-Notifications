encryptLogin(user,pass){
    wmi:=comObjGet("winmgmts:")
    
    wI:=wmi.ExecQuery("Select * from Win32_BaseBoard")._NewEnum
    while(wI[t])
        bsn:=t.SerialNumber
    
    userE:=Crypt.Encrypt.StrEncrypt(user,bsn,7,6)
    passE:=Crypt.Encrypt.StrEncrypt(pass,bsn,7,6)
    return {user: userE,pass: passE}
}