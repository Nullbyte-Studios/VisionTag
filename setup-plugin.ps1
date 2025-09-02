# Minecraft Plugin Template Setup Script
# This script will customize the plugin template with your specific plugin details

Write-Host "=== Minecraft Plugin Template Setup ===" -ForegroundColor Cyan
Write-Host "This script will help you customize the plugin template with your specific plugin details." -ForegroundColor Yellow
Write-Host ""

# Function to validate input
function Validate-Input {
    param(
        [string]$Input,
        [string]$Pattern,
        [string]$ErrorMessage
    )
    
    if (-not ($Input -match $Pattern)) {
        Write-Host $ErrorMessage -ForegroundColor Red
        return $false
    }
    return $true
}

# Function to convert string to PascalCase
function ConvertTo-PascalCase {
    param([string]$text)
    $words = $text -split '[-_\s]+'
    $pascalCase = ""
    foreach ($word in $words) {
        if ($word.Length -gt 0) {
            $pascalCase += $word.Substring(0,1).ToUpper() + $word.Substring(1).ToLower()
        }
    }
    return $pascalCase
}

# Function to convert string to lowercase with no spaces
function ConvertTo-LowerNoSpaces {
    param([string]$text)
    return $text.ToLower() -replace '[-_\s]+', ''
}

# Collect plugin information
do {
    $pluginName = Read-Host "Enter your plugin name (e.g., 'MyAwesome Plugin')"
    $valid = Validate-Input $pluginName "^[a-zA-Z0-9\s\-_]+$" "Plugin name should only contain letters, numbers, spaces, hyphens, and underscores."
} while (-not $valid)

do {
    $authorName = Read-Host "Enter author name (e.g., 'YourName')"
    $valid = Validate-Input $authorName "^[a-zA-Z0-9\s\-_]+$" "Author name should only contain letters, numbers, spaces, hyphens, and underscores."
} while (-not $valid)

do {
    $packageBase = Read-Host "Enter base package (e.g., 'com.yourname')"
    $valid = Validate-Input $packageBase "^[a-z]+(\.[a-z][a-z0-9]*)*$" "Package should be in format like 'com.yourname' (lowercase, dots allowed)."
} while (-not $valid)

do {
    $version = Read-Host "Enter initial version (default: 1.0.0)"
    if ([string]::IsNullOrWhiteSpace($version)) {
        $version = "1.0.0"
    }
    $valid = Validate-Input $version "^\d+\.\d+\.\d+$" "Version should be in format X.Y.Z (e.g., 1.0.0)."
} while (-not $valid)

# Generate derived values
$pluginNameClean = ConvertTo-PascalCase $pluginName
$pluginNameLower = ConvertTo-LowerNoSpaces $pluginName
$mainClass = $pluginNameClean
$packageName = "$packageBase.$pluginNameLower"
$commandAlias = $pluginNameLower.Substring(0, [Math]::Min($pluginNameLower.Length, 10))
$permissionPrefix = $pluginNameLower
$mavenGroupId = $packageBase
$mavenArtifactId = $pluginNameLower

# Display summary
Write-Host ""
Write-Host "=== Plugin Configuration Summary ===" -ForegroundColor Green
Write-Host "Plugin Name: $pluginName" -ForegroundColor White
Write-Host "Author: $authorName" -ForegroundColor White
Write-Host "Version: $version" -ForegroundColor White
Write-Host "Main Class: $mainClass" -ForegroundColor White
Write-Host "Package: $packageName" -ForegroundColor White
Write-Host "Command Alias: $commandAlias" -ForegroundColor White
Write-Host "Permission Prefix: $permissionPrefix" -ForegroundColor White
Write-Host "Maven Group ID: $mavenGroupId" -ForegroundColor White
Write-Host "Maven Artifact ID: $mavenArtifactId" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "Do you want to proceed with these settings? (y/N)"
if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Host "Setup cancelled." -ForegroundColor Yellow
    exit
}

Write-Host ""
Write-Host "Setting up your plugin..." -ForegroundColor Cyan

# Define replacement mappings
$replacements = @{
    '{{PLUGIN_NAME}}' = $pluginName
    '{{AUTHOR_NAME}}' = $authorName
    '{{VERSION}}' = $version
    '{{MAIN_CLASS}}' = $mainClass
    '{{PACKAGE_NAME}}' = $packageName
    '{{COMMAND_ALIAS}}' = $commandAlias
    '{{PERMISSION_PREFIX}}' = $permissionPrefix
    '{{MAVEN_GROUP_ID}}' = $mavenGroupId
    '{{MAVEN_ARTIFACT_ID}}' = $mavenArtifactId
}

# Function to replace content in files
function Replace-Content {
    param(
        [string]$FilePath,
        [hashtable]$Replacements
    )
    
    if (Test-Path $FilePath) {
        $content = Get-Content $FilePath -Raw -Encoding UTF8
        foreach ($key in $Replacements.Keys) {
            $content = $content.Replace($key, $Replacements[$key])
        }
        Set-Content $FilePath $content -Encoding UTF8
        Write-Host "Updated: $FilePath" -ForegroundColor Gray
    }
}

# Get all files to process
$filesToProcess = @(
    Get-ChildItem -Path "src" -Filter "*.java" -Recurse |
    Get-ChildItem -Path "src" -Filter "*.yml" -Recurse |
    Get-ChildItem -Path "." -Filter "pom.xml"
)

# Process each file
foreach ($file in $filesToProcess) {
    Replace-Content -FilePath $file.FullName -Replacements $replacements
}

Write-Host ""
Write-Host "Creating new directory structure..." -ForegroundColor Cyan

# Create new package directory structure
$newPackageDir = "src\main\java\" + ($packageName.Replace('.', '\'))
if (-not (Test-Path $newPackageDir)) {
    New-Item -ItemType Directory -Path $newPackageDir -Force | Out-Null
    Write-Host "Created directory: $newPackageDir" -ForegroundColor Gray
}

# Move Java files to new package structure
$oldPackageDir = "src\main\java\com\nullbyte\overseer"
if (Test-Path $oldPackageDir) {
    Write-Host "Moving files to new package structure..." -ForegroundColor Cyan
    
    # Copy all Java files to new location
    Get-ChildItem -Path $oldPackageDir -Filter "*.java" -Recurse | ForEach-Object {
        $relativePath = $_.FullName.Substring($oldPackageDir.Length + 1)
        $newPath = Join-Path $newPackageDir $relativePath
        $newDir = Split-Path $newPath -Parent
        
        if (-not (Test-Path $newDir)) {
            New-Item -ItemType Directory -Path $newDir -Force | Out-Null
        }
        
        Copy-Item $_.FullName $newPath -Force
        Write-Host "Moved: $relativePath" -ForegroundColor Gray
    }
    
    # Remove old package directory
    Remove-Item $oldPackageDir -Recurse -Force
    Write-Host "Removed old package directory" -ForegroundColor Gray
}

# Rename main class file
$oldMainFile = Join-Path $newPackageDir "Overseer.java"
$newMainFile = Join-Path $newPackageDir "$mainClass.java"
if ((Test-Path $oldMainFile) -and ($oldMainFile -ne $newMainFile)) {
    Move-Item $oldMainFile $newMainFile -Force
    Write-Host "Renamed main class file to: $mainClass.java" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=== Setup Complete! ===" -ForegroundColor Green
Write-Host "Your plugin has been successfully configured with the following details:" -ForegroundColor White
Write-Host "- Plugin Name: $pluginName" -ForegroundColor White
Write-Host "- Main Class: $packageName.$mainClass" -ForegroundColor White
Write-Host "- Command: /$commandAlias" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Build your plugin: mvn clean package" -ForegroundColor White
Write-Host "2. The compiled plugin will be in the 'target' folder" -ForegroundColor White
Write-Host "3. Copy the .jar file to your server's plugins folder" -ForegroundColor White
Write-Host "4. Start customizing your plugin code!" -ForegroundColor White
Write-Host ""
Write-Host "Happy coding! 🚀" -ForegroundColor Cyan

# Pause to keep window open
Read-Host "Press Enter to exit"