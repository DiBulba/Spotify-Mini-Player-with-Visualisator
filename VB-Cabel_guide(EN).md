# Virtual Audio Cable Setup Guide for Minimal Spotify Visualizer

## Overview

This guide will help you set up the Minimal Spotify Visualizer to respond **only to Spotify music** using VB-Audio Virtual Cable, while keeping system sounds separate.

## What You Need

1. **VB-Audio Virtual Cable** (free) - [Download here](https://vb-audio.com/Cable/index.htm)
2. **Rainmeter** - [Download here](https://www.rainmeter.net/)
3. **EarTrumpet** (recommended, free) - [Download here](https://www.microsoft.com/en-us/p/eartrumpet/9nblggh516ft)
4. **Minimal Spotify Visualizer** - Already installed with this skin

## Step-by-Step Setup

### Step 1: Install VB-Audio Virtual Cable

1. Download and install VB-Audio Virtual Cable
2. Restart your PC (required for installation)
3. You should now see:
   - **CABLE Input** - Where audio goes IN (Spotify sends audio here)
   - **CABLE Output** - Where audio goes OUT (you listen from here)

### Step 2: Route Spotify to Virtual Cable using EarTrumpet

1. **Find the sound mixer icon in Windows system tray** (speaker icon at the bottom right)

<img width="130" height="70" alt="image" src="https://github.com/user-attachments/assets/3af914b8-d9c9-4cbe-ac8d-4316c57abae4" />


2. **Right-click on the speaker icon** and select **"EarTrumpet Volume mixer"**

<img width="261" height="218" alt="image" src="https://github.com/user-attachments/assets/a249a643-3647-493b-9830-177dd9cb2994" />


3. **The EarTrumpet volume mixer window will open**

4. **Find Spotify in the list of applications** and **right-click on it**

5. **In the context menu, select the option to choose output device**

  <img width="720" height="404" alt="image" src="https://github.com/user-attachments/assets/f35be5e3-1501-4422-9bc3-4e765680c4cd" />


7. **Select "CABLE Input (VB-Audio Virtual Cable)"** from the list of available devices

Now Spotify audio only goes to Virtual Cable, not to your main speakers!

### Step 3: Set Virtual Cable Output to Your Speakers

1. Right-click speaker icon in taskbar → **Sound settings**
2. Scroll down → **Advanced** → **Volume mixer**
3. Find **CABLE Output** 
4. Set it to output to your speakers or headphones
5. (Optional) You can enable "Listen to this device" if you want to hear Spotify through your microphone

### Step 4: Configure Visualizer to Listen to Virtual Cable Input

1. Load or refresh the **Settings** skin in Rainmeter
2. Scroll down to **— Audio Devices** section
3. Click **"Refresh list"** button (if devices don't show)
4. You should see something like:
   - CABLE Input (VB-Audio Virtual Cable)
   - CABLE Output (VB-Audio Virtual Cable)
   - Realtek Audio (or your main sound card)
5. **Click on "CABLE Input"** - it should turn green

### Step 5: Test It Works

1. Play music in Spotify
2. The visualizer should react **only to Spotify music**
3. Open YouTube or a game
4. The visualizer should **NOT react** to those sounds ✅

If it's not working:
- Make sure CABLE Input is selected (green button)
- Make sure Spotify is set to output to CABLE Input via EarTrumpet
- Restart the visualizer skin (right-click → Refresh)

## Troubleshooting

### "Device not found" error
- Click **"Refresh list"** button in Settings
- Make sure VB-Cable is installed and working

### Visualizer still reacts to all sounds
- Check that Spotify output is set to CABLE Input via EarTrumpet
- Make sure you selected the right cable in Settings
- Try clicking "Use default" then selecting CABLE Input again

### Spotify audio is silent
- Check that CABLE Output is set as your playback device
- Or enable "Listen to this device" on CABLE Output to hear through mic

### EarTrumpet doesn't show Spotify
- Make sure Spotify is actually playing
- Close and reopen EarTrumpet
- Restart Rainmeter

## Optional: Advanced Setup

### Listen to Your Microphone Too

If you want visualizer to react to both Spotify AND your microphone:

1. In Windows Sound Settings
2. Find your microphone device
3. Go to properties → **"Listen"** tab
4. Enable "Listen to this device"
5. Set output to **CABLE Output**

Now the visualizer will hear both Spotify and your voice!

### Switch Back to Default

To use visualizer with all system sounds again:

1. In Settings skin, click **"Use default"**
2. This removes any custom device selection
3. Visualizer will react to all system audio

## Need Help?

If something doesn't work:
1. Check Rainmeter log (right-click Rainmeter → Log)
2. Make sure all device names match exactly
3. Try refreshing the skin (F5 or right-click → Refresh)
4. Restart Rainmeter completely

Enjoy your Spotify visualizer! 🎵
