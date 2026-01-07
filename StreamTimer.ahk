#Requires AutoHotkey v2.0
#SingleInstance Force

ProcessSetPriority "High"
DllCall("winmm\timeBeginPeriod", "UInt", 1)

MyGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
MyGui.BackColor := "000000"
MyGui.MarginX := 10
MyGui.MarginY := 5
MyGui.SetFont("s40 w700", "Consolas") 

TimerText := MyGui.Add("Text", "c00FF00 Center w220", "0.000")

GuiX := A_ScreenWidth - 250
GuiY := 20
MyGui.Show("x" . GuiX . " y" . GuiY . " NoActivate")

StartTime := A_TickCount
MaxTime := 10000 

SetTimer UpdateTimer, 10

UpdateTimer() {
    global StartTime, MaxTime
    
    ElapsedTime := A_TickCount - StartTime
    LoopTime := Mod(ElapsedTime, MaxTime)
    
    sec := Floor(LoopTime / 1000)
    ms := Mod(LoopTime, 1000)
    
    TimeStr := Format("{:d}.{:03}", sec, ms)
    
    try {
        TimerText.Value := TimeStr
    }
}

Esc:: {
    DllCall("winmm\timeEndPeriod", "UInt", 1)
    ExitApp
}