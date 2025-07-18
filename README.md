# 🔒 Minecraft Blocker Based on Battery Status (PrismLauncher + PowerShell)

This project helps limit the usage of Minecraft (through Prism Launcher) **based on your laptop’s battery status**. It is especially useful for students or users who want to discipline themselves by reducing Gameplay with this method

---

## 🧠 How It Works

This PowerShell script automatically monitors the Prism Launcher process and:
- ❌ **Not Working** if you are using PC with power always connected. This method only works if you use laptop
  
- ❌ **Blocks** Minecraft if the laptop is **not charging**

- ❌ **Blocks** Minecraft if charging but the **battery is below 95%**

- ✅ **Allows** gameplay if the laptop is **charging AND the battery is ≥ 95%**

- 🔁 If Minecraft is already running, **unplugging the charger won't stop the game**.

- 🪫 No files are deleted, renamed, or permanently blocked — everything is controlled logically.

---

## 🚀 Step-by-Step Guide
<br />

## 🔧 Step One: Install Prism Launcher and Minecraft

### 📦 1. Install Prism Launcher

➡️ **Automatic Method (via Winget):**
1️⃣ Open Command Prompt as Admin
2️⃣ Copy this code
```powershell
winget install --exact PrismLauncher.PrismLauncher 
```

➡️ **Direct Method**
Download directly from the official website https://prismlauncher.org/download/windows/
<br /><br />
### 📦 2. Install Minecraft Inside Prism Launcher
Once Prism Launcher is successfully opened:
- Choose the Minecraft Version you want to use
- Click **"Add instance"**.
- Select your desired Minecraft Version
- Complete the configuration as usual (login, skin, etc.)

<br /><br /><br />
## 🔐 Step Two: Create the Blocker Script and Task Scheduler
### 📂 3. Create a Folder for the Script
- You can create a folder in a place you desired, **but always remember the directories of the Folder you made**
  ```
  C:\"desired directory and folder"\
  ```
- For me, it is recommended to save the script inside the PrismLauncher folder, here are the location:
  ```
  %localappdata%\Programs\PrismLauncher
  ```

### 🐚 4. Create the Powershell `.ps1` File
- Create a powershell file, whether you can use vscode, or even notepad to make it.
- Paste this script to your file
  ```powershell
  # Nama proses PrismLauncher
  $processName = "prismlauncher"

  while ($true) {
    Start-Sleep -Seconds 5

    # Cek apakah PrismLauncher sedang jalan
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        $battery = Get-WmiObject -Class Win32_Battery
        $chargingStatus = $battery.BatteryStatus
        $chargePercentage = $battery.EstimatedChargeRemaining

        # Tidak charging -> stop
        if (($chargingStatus -eq 1) -or ($chargingStatus -eq 3)) {
            Stop-Process -Name $processName -Force
        }

        # Charging tapi < 95%  
        elseif ($chargePercentage -lt 95) {
            Stop-Process -Name $processName -Force
        }

        # Charging dan >= 95% 
        elseif ($chargePercentage -ge 95) {
            Start-Sleep -Seconds 2 # beri jeda 2 detik untuk open prismlauncher
        }
      } 
    } 
  ```
- Save file - with your desired filename.ps1 - in your desired folder
  ```
  C:\"desired directory and folder"\filename.ps1
  ```
- For me, I would save in PrismLauncher directory with the name `hehe.ps1`
  ```
  %localappdata%\Programs\PrismLauncher\hehe.ps1
  ```

### 🚫 5. Now, it is the time to make the blocker using Task Scheduler
To run the powershell script - you made - automatically when you log in to Windows: 

  1️⃣ Open **Task Scheduler** by
  - press Start Menu, search for "Task Scheduler"
  - press Win + R, type **taskschd.msc**

  2️⃣ Click on **File > Create Task** in the top left corner
  <br />
  <br />
  3️⃣ Now, you will see on **General** tab
  - Name: `Your desired task's name`, I would use `Minecraft` as the name
  - Check on **only when user is loggen on**
  - Check on **run with highest privileges**
    
4️⃣ Go to **Triggers** tab
  - Click on **New**
  - Begin the task: **At log on**

  5️⃣ Go to **Actions** tab
  - Click on New
  - Action: **Start a program**
  - Program/script: `powershell.exe`
  - Add arguments:
    ```powershell
    -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\"desired directory and folder"\filename.ps1"
    ```
6️⃣ Go to **Conditions** Tab <br /> Uncheck all of it
<br />
<br />
7️⃣ Go to **Settings** Tab <br /> Uncheck all, except ✅Allow task to be run on Demand
<br />
<br />
8️⃣ Click **OK**, and The blocker is ready

---
## 📥 Download `.ps1` File
- You can either copy the code from the steps that I explain above, or download here
[Download File](minecraft.ps1)
- Click on Download Button
- Save on your desired folder, make sure to **Remember it**

---
## 📝 Additional Notes
- The script will not stop Minecraft if you are already playing and then unplug the charger.

- Prism Launcher **is not permanently blocked** — everything is controlled logically through battery status.

- You can stop the script by opening **Task Manager > PowerShell > End Task.**

- Make sure Prism Launcher still uses the process name `prismlauncher`. If it changes, update the script accordingly.




  
