^+x::  ; Ctrl+Shift+X is the hotkey
    ; Save the original clipboard contents
    originalClipboard := ClipboardAll

    ; Copy selected text to the clipboard and wait for the clipboard to contain data
    Send, ^c
    ClipWait, 1

    if (ErrorLevel) {
        MsgBox, Failed to copy text to clipboard.
        return
    }

    ; Prepare the payload
    clipboardData := Clipboard
    payload := "{""question"": """ clipboardData """}"

    ; Send the payload to the server
    httpRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    httpRequest.Open("POST", "http://address:123/translate", false)  ; Change `address` to the actual address
    httpRequest.setRequestHeader("Content-Type", "application/json")
    httpRequest.Send(payload)
    httpRequest.WaitForResponse()
    responseText := httpRequest.ResponseText

    ; Assuming server response is in the form of {"answer": "translated text"}
    responseObj := JSON.Parse(responseText)
    translatedText := responseObj.answer

    ; Paste the translated text
    Clipboard := translatedText
    Send, ^v

    ; Restore the original clipboard contents
    Clipboard := originalClipboard
return
