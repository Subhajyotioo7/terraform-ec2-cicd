import subprocess

def run_command(cmd):
    print(f"Running: {' '.join(cmd)}")
    result = subprocess.run(cmd, capture_output=True, text=True)
    print(result.stdout)
    if result.returncode != 0:
        print("ERROR:", result.stderr)
        raise SystemExit(1)
    return result.stdout

# Initialize Terraform
run_command(["terraform", "init"])

# Preview changes
run_command(["terraform", "plan"])


# Apply changes (auto-approve skips manual yes/no prompt)
run_command(["terraform", "apply", "-auto-approve"])

print("EC2 instance created successfully via Terraform!")