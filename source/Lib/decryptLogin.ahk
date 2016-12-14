decryptLogin(user,pass){
    wmi:=comObjGet("winmgmts:")
    
    wI:=wmi.ExecQuery("Select * from Win32_BaseBoard")._NewEnum
    while(wI[t])
        bsn:=t.SerialNumber
    
    userD:=Crypt.Encrypt.StrDecrypt(user,bsn,7,6)
    passD:=Crypt.Encrypt.StrDecrypt(pass,bsn,7,6)
    return {user: userD,pass: passD}
}