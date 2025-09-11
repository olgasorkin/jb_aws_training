# AWS Resource Dashboard (Flask + Boto3)

This is a simple web dashboard built with **Flask** and **Boto3** that connects to your AWS account and displays:

- EC2 instances
- VPCs
- Load Balancers (ELBv2)
- AMIs (owned by your account)

---

## 🚀 Features

- Lists running EC2 instances with public IP, instance type, and state
- Displays VPC IDs and CIDR blocks
- Lists Load Balancer names and DNS names
- Lists AMI IDs and names
- Uses AWS credentials via environment variables or `.env` file
- Lightweight and runs locally via Flask

---

## 🧰 Requirements

- Python 3.7+
- pip

Install dependencies:

```bash
pip install flask boto3 python-dotenv
```

---

## ⚙️ Environment Setup

You must provide AWS credentials to the app. You can do this in two ways:

### ✅ Option 1: Use Environment Variables

Set these in your Command Prompt or PowerShell:

```cmd
set AWS_ACCESS_KEY_ID=your-access-key
set AWS_SECRET_ACCESS_KEY=your-secret-key
```

### ✅ Option 2: Use `.env` file (Recommended for local dev)

Create a `.env` file in the root of the project:

```dotenv
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
```

The app will automatically load these using `python-dotenv`.

---

## 🧪 Running the App

From your project folder:

```bash
python main.py
```

Then open your browser and go to:

```
http://localhost:5001/
```

You will see a web page showing your AWS resources.

---

## 📝 Project Structure

```
project-folder/
│
├── main.py           # Flask app
├── .env              # (optional) AWS credentials
└── README.md         # This file
```

---

## 🛡️ Security Warning

⚠️ **Never commit your AWS credentials to GitHub!**

- Use `.gitignore` to exclude `.env` files
- Use IAM roles and limited-access users in production

---

## 📦 License

MIT License
