; Hotkey to trigger the script
#x::
    ; Save the current clipboard content
    ClipSaved := ClipboardAll

    ; Copy the selected text
    Send, ^c
    ClipWait, 1

    ; Prepare the payload
    payload := "{\"question\": """ . Clipboard . """}"

    ; Send the POST request
    url := "http://addres:123/translate"
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("POST", url, False)
    whr.SetRequestHeader("Content-Type", "application/json")
    whr.Send(payload)

    ; Get the response
    response := whr.ResponseText

    ; Restore the original clipboard content
    Clipboard := ClipSaved

    ; Paste the response
    Send, ^v
Return
