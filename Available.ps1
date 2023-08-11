# Import the required modules
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class KeyboardActivitySimulator
{
    [DllImport("user32.dll")]
    private static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);

    public static void SimulateKeyPress()
    {
        const int KEYEVENTF_KEYUP = 0x0002;
        const byte VK_SHIFT = 0x10;

        keybd_event(VK_SHIFT, 0, 0, UIntPtr.Zero); // Press SHIFT key
        keybd_event(VK_SHIFT, 0, KEYEVENTF_KEYUP, UIntPtr.Zero); // Release SHIFT key
    }
}
"@

# Function to simulate keyboard activity at regular intervals
function SimulateKeyboardActivity {
    while ($true) {
        [KeyboardActivitySimulator]::SimulateKeyPress()
        Start-Sleep -Seconds 30 # Adjust the interval as per your preference
    }
}

# Start simulating keyboard activity
SimulateKeyboardActivity
