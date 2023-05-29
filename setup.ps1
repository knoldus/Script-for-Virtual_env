# Fetching the OS type like windows
if ($env:OS -eq "Windows_NT") {
    $osType = "Windows"
    Write-Host "Wow, Your system is a $osType system"
}
else {
    $osType = $(uname -s)
    Write-Host "This script is created for Windows OS only not for others and your current OS is $osType."
    exit 1
}

# check the virtual Env is installed or not
$venvInstalled = $null
try {
    $venvInstalled = (python -c "import venv; print('installed')").Trim()
}
catch {
    $venvInstalled = $null
}

Write-Host "Wow, You have already installed virtual-env: $venvInstalled"

# This will install the virtual env if not install
if (-not $venvInstalled) {
    try {
        python -m pip install virtualenv
        Write-Host "Installation has been done"
    }
    catch {
        Write-Host "Failed to install venv"
        exit 1
    }
}


# taking input from the user like he want to create another env or use old one
$useExistingEnv = Read-Host "Do you want to use an existing environment? [y/n]: "

if ($useExistingEnv.ToLower() -eq "y") {
# Enter the existing Env name
    $existingEnvName = Read-Host "Enter the name of the existing environment: "
}
else {
# enter the new env name
    $newEnvName = Read-Host "Enter the name for your new environment: "
    
    # Create a new virtual environment
    try {
        python -m venv $newEnvName
        Write-Host "New environment '$newEnvName' has been created"
        
        $existingEnvName = $newEnvName
    }
    catch {
        Write-Host "Failed to create a new environment"
        exit 1
    }
}

# This will activate the the virtual environment
$activateScript = "$existingEnvName\Scripts\Activate.ps1"
try {
    . $activateScript
    Write-Host "Activation has been done"
}
catch {
    Write-Host "Failed to activate the virtual environment"
    exit 1
}

# You can install the required packages from requirements.txt
try {
    pip install -r requirements.txt
    Write-Host "Packages have been installed from requirements.txt"
}
catch {
    Write-Host "Failed to install packages from requirements.txt"
    exit 1
}
