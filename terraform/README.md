# Terraform AWS EC2 Builder Project

## 🧭 Overview
This Terraform configuration provisions an **AWS EC2 instance** named **`builder`** in an existing VPC.  
It automates SSH key creation, network access, and instance deployment — providing a secure environment  
for running Docker or Python applications.

---

## 🏗️ Infrastructure Components

| Resource | Description |
|-----------|-------------|
| **EC2 Instance** | Ubuntu 22.04 server instance named `builder` |
| **Security Group** | Allows inbound SSH (22) and app traffic (5001) only from your IP |
| **Key Pair** | Uses a locally generated SSH key for secure access |
| **Outputs** | Public IP, DNS name, SSH command, and Security Group ID |

---

## ⚙️ Prerequisites

Before applying this configuration, ensure you have:

1. **Terraform** ≥ 1.5 installed  
   [Install Terraform →](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

2. **AWS CLI** installed and configured  
   ```bash
   aws configure
   ```
   Set your access key, secret key, and region (`us-east-1`).

3. **AWS credentials** with sufficient permissions to create:
   - EC2 instances  
   - Key pairs  
   - Security groups  

4. Access to the existing **VPC and public subnet**:
   - VPC ID: `vpc-0b110d239f1211b4d`
   - Public Subnet ID: `subnet-0852a4e422a2ea812`

---

## 📁 Project Structure

```
terraform/
├── main.tf          # Main Terraform configuration
├── variables.tf     # Input variables
├── outputs.tf       # Outputs (IP, SSH command, SG ID, etc.)
├── providers.tf     # Provider configuration
├── .gitignore       # Files excluded from Git tracking
└── README.md        # Project documentation
```

---

## 🚀 Usage

### 1️⃣ Initialize Terraform
```bash
terraform init
```

### 2️⃣ Validate configuration
```bash
terraform validate
```

### 3️⃣ Plan infrastructure changes
```bash
terraform plan
```

### 4️⃣ Apply configuration
```bash
terraform apply
```
Type `yes` to confirm.

Terraform will:
- Generate or use your local SSH key
- Upload its public key to AWS
- Create the EC2 instance in your specified subnet
- Configure the security group
- Output connection details

---

## 🔑 Outputs

Example output:
```
instance_id = "i-012ce9b8655519d06"
public_dns = "ec2-98-80-8-101.compute-1.amazonaws.com"
public_ip = "98.80.8.101"
security_group_id = "sg-0067006ad1ce4b04f"
ssh_command = "ssh -i ./keys/builder ubuntu@98.80.8.101"
ssh_private_key_path = "./keys/builder"
```

---

## 🧑‍💻 Connecting to EC2

Use the SSH command provided in the output, for example:
```bash
ssh -i ./keys/builder ubuntu@98.80.8.101
```

---

## 🌐 Running a Test Application (optional)

You can start a simple Flask app on port 5001:
```bash
sudo apt update -y
sudo apt install -y python3 python3-pip
pip3 install flask
```

Create a file `app.py`:
```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Ubuntu EC2 on port 5001!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
```

Run it:
```bash
python3 app.py
```

Visit in your browser:  
👉 [http://<PUBLIC_IP>:5001](http://<PUBLIC_IP>:5001)

---

## 🔐 Security Notes
- Only your IP is allowed to SSH or access port 5001.  
- The private key (`./keys/builder`) is stored **locally only** and is ignored by Git.
- Never upload keys or `.tfstate` files to GitHub.

---

## 🧹 Destroying Infrastructure
To remove all created resources and avoid charges:
```bash
terraform destroy
```
Confirm with `yes`.

---

## 🧾 Author
**Olga Sorkin**  
GitHub: [github.com/olgasorkin](https://github.com/olgasorkin)

---

## 🪶 License
This project is provided for educational purposes (AWS training / Terraform practice).
