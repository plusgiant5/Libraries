; if you dont trust the exe you can compile the ahk file yourself here

if !FileExist("workspace")
{
    MsgBox, Put this file one folder above your exploit's workspace folder then run it again (your exploit folder)
    ExitApp
}

if !FileExist("workspace/Replayability+_AHK")
{
    FileCreateDir, workspace/Replayability+_AHK
    MsgBox, AHK folder has been added to workspace
}

if !FileExist("workspace/Replayability+_AHK/Request")
{
    writefile := FileOpen("workspace/Replayability+_AHK/Request", "w")
    writefile.Write()
    writefile.Close()
    MsgBox, Request file has been added to AHK folder
}

#Persistent
    SetTimer, MainLoop, -1
    SetTimer, SuccessMessage, -1
return

MainLoop:
    Loop
    {
        readfile := FileOpen("workspace/Replayability+_AHK/Request", "r")
        rawdata := readfile.Read()
        if (rawdata != "")
        {
            for i,v in StrSplit(rawdata, ",")
            {
                if (v == "u")
                    Send, {WheelUp 1}
                if (v == "d")
                    Send, {WheelDown 1}
            }
            writefile := FileOpen("workspace/Replayability+_AHK/Request", "w")
            writefile.Write()
            writefile.Close()
        }
        readfile.Close()
        sleep, 1000/144
    }
return
SuccessMessage:
    MsgBox, AHK connection is running
return
