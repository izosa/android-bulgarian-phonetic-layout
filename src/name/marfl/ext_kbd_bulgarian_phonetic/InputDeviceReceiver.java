package name.marfl.ext_kbd_bulgarian_phonetic;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

// The system only reads the receiver's meta-data to find the keyboard layouts.
public class InputDeviceReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
    }
}
