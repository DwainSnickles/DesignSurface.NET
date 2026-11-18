param(
    [Parameter(Mandatory = $true)][string]$FrameworkDir,
    [Parameter(Mandatory = $true)][string]$NetDir,
    [string]$NuGetDir = "",
    [string]$NuGetExe = "nuget",
    [string]$OutDir = "artifacts",
    [string]$Version = ""
)

$ErrorActionPreference = 'Stop'

if (-not $NuGetDir) { $NuGetDir = Split-Path -Parent $MyInvocation.MyCommand.Path }

$tempRoot = if ($env:RUNNER_TEMP) { $env:RUNNER_TEMP } else { [IO.Path]::GetTempPath() }
$stage = Join-Path $tempRoot "nuget-stage"
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

function Stage-Framework {
    param([string]$Id)
    New-Item -ItemType Directory -Force -Path "$stage\$Id\lib\net48", "$stage\$Id\lib\net8.0-windows7.0" | Out-Null
}

Stage-Framework GraphicObjects
Copy-Item "$FrameworkDir\GraphicObjects\bin\GraphicObjects.dll", "$FrameworkDir\GraphicObjects\bin\GraphicObjects.xml" "$stage\GraphicObjects\lib\net48\"
Copy-Item "$NetDir\GraphicObjects\bin\Release\net8.0-windows\GraphicObjects.dll" "$stage\GraphicObjects\lib\net8.0-windows7.0\"

Stage-Framework GraphicsSurface
Copy-Item "$FrameworkDir\GraphicsSurface\bin\GraphicsSurface.dll", "$FrameworkDir\GraphicsSurface\bin\GraphicsSurface.xml" "$stage\GraphicsSurface\lib\net48\"
Copy-Item "$NetDir\GraphicsSurface\bin\Release\net8.0-windows\GraphicsSurface.dll" "$stage\GraphicsSurface\lib\net8.0-windows7.0\"

Copy-Item "$NuGetDir\readme-*.md" $stage

foreach ($id in 'GraphicObjects', 'GraphicsSurface') {
    $nuspecPath = Join-Path $stage "$id.nuspec"
    $content = Get-Content (Join-Path $NuGetDir "$id.nuspec") -Raw
    if ($Version) {
        $content = $content -replace '<version>[^<]+</version>', "<version>$Version</version>"
        $content = $content -replace '(<dependency id="GraphicObjects" version=")[^"]+(")', "`${1}$Version`${2}"
    }
    Set-Content -Path $nuspecPath -Value $content -NoNewline

    & $NuGetExe pack $nuspecPath -BasePath $stage -OutputDirectory $OutDir
    if ($LASTEXITCODE -ne 0) { throw "nuget pack failed for $id" }
}

Get-ChildItem $OutDir -Filter *.nupkg | ForEach-Object { Write-Host "Packed: $($_.FullName)" }
