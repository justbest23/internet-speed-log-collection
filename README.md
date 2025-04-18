# 📊 internet-speed-logs

This repo contains lightweight shell scripts that log your internet speed over time using:

- `fast-cli` (powered by Fast.com)
- Ookla's official `speedtest` CLI

Test results are stored in both raw `.log` format and structured `.csv` for analysis.

---

## 📁 Folder Structure

```
internet-speed-logs/
├── combined/
│   └── internet_speeds.csv
├── logs/
│   ├── fast_raw.log
│   └── speedtest_raw.log
├── run_fast.sh
└── run_speedtest.sh
```

---

## 🪟 Windows Setup & Usage

These instructions allow you to run the scripts on a Windows machine using Git Bash.

### ✅ One-Line Setup (Recommended)

1. Open **PowerShell as Administrator**
2. Run:

```powershell
irm https://raw.githubusercontent.com/justbest23/internet-speed-log-collection/main/setup.ps1 | iex
```

This will:
- Install [Chocolatey](https://chocolatey.org/)
- Install:
  - Git for Windows (includes Git Bash)
  - Node.js + npm
  - Ookla Speedtest CLI
- Globally install `fast-cli` using npm

### ▶️ Running the Scripts

1. Right-click in the folder and choose **“Git Bash Here”**
2. Run the scripts:

```bash
bash run_fast.sh
bash run_speedtest.sh
```

### 📄 Where Logs and Results Are Stored

- Raw output:
  - `logs/fast_raw.log`
  - `logs/speedtest_raw.log`
- Combined CSV output (for charts, analysis, etc):
  - `combined/internet_speeds.csv`

> ⚠️ If you see permission errors, make sure Git Bash has write access, or run it as Administrator.

---

## 🐧 Linux Setup & Usage

### 📦 Install Requirements

#### Debian/Ubuntu:
```bash
sudo apt update && sudo apt install -y nodejs npm curl
curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
sudo apt install speedtest
sudo npm install -g fast-cli
```

#### Fedora/RHEL:
```bash
sudo dnf install -y nodejs npm curl
curl -s https://install.speedtest.net/app/cli/install.rpm.sh | sudo bash
sudo dnf install speedtest
sudo npm install -g fast-cli
```

### ▶️ Running the Scripts

```bash
chmod +x run_fast.sh run_speedtest.sh
./run_fast.sh
./run_speedtest.sh
```

### 📄 Where Logs and Results Are Stored

- Raw logs:
  - `logs/fast_raw.log`
  - `logs/speedtest_raw.log`
- Combined structured data:
  - `combined/internet_speeds.csv`

---

## ⏱ Automating with Cron (Linux/macOS)

To automate the speed tests on a schedule, you can use `cron`.

### ✍️ Example Crontab Entry

To run `run_fast.sh` every 15 minutes:

```bash
*/15 * * * * /path/to/internet-speed-logs/run_fast.sh
```

To edit your crontab:
```bash
crontab -e
```

🧠 Tip: Use this to generate cron expressions:  
👉 [Crontab.guru](https://crontab.guru/)

---

## 🗓 Automating with Windows Task Scheduler

You can use **Windows Task Scheduler** to run the scripts periodically.

### 🧰 Steps

1. Open **Task Scheduler**
2. Click **Create Basic Task**
3. Set a name like `Run Fast Speed Test`
4. Choose your trigger (e.g. every 30 minutes)
5. Action: **Start a program**
6. Program/script:
   ```
   "C:\Program Files\Git\bin\bash.exe"
   ```
7. Add arguments (example):
   ```
   -c "cd C:/path/to/internet-speed-logs && ./run_fast.sh"
   ```

🧠 Tip: You can also use `.bat` files to simplify this.

---

## 🔒 Permissions Note

- Ensure the user running the script has **write access** to the `logs/` and `combined/` folders.
- Scripts will **append** to all log/CSV files. Rotate or back them up if needed.

---

## 🤝 Contributing

Got a log visualiser or extra script to add? PRs welcome!

---

## 📜 License

MIT License — free to use, adapt, and share.
