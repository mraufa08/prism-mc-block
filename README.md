# 🔒 Minecraft Blocker Based on Battery Status (Prism Launcher + PowerShell)

This project was created to help limit the usage of Minecraft (via Prism Launcher) **based on your laptop’s battery condition**. It's especially useful for students or users who want to discipline themselves from playing when not charging or before the battery is fully charged.

---

## 🧠 How It Works

This PowerShell script automatically monitors the Prism Launcher process and:

- ❌ **Blocks** Minecraft if your laptop is **not charging**, and displays a warning:  
  `"Your Laptop isn't charged"`
- ❌ **Blocks** Minecraft if charging but battery is **less than 95%**, silently without warning.
- ✅ **Allows** you to play if battery is **charging AND ≥ 95%**, with a friendly message:  
  `"You're about to play Minecraft"`
- 🔁 If you're already playing, unplugging the charger **won't interrupt your game**.
- 🪫 No files are deleted, renamed, or permanently blocked — it's all controlled through logic.

---

## 🚀 Step-by-Step Instructions

---

## 🔧 Langkah Pertama: Install PrismLauncher dan Minecraft

### 📦 1. Install Prism Launcher

➡️ **Cara Otomatis (melalui winget):**

```powershell
winget install --exact PrismLauncher.PrismLauncher
