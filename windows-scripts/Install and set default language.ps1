<#
  Author      : Cristian Schmitt Nieto (adapted from Stefan Dingemanse)
  Source      : https://www.stefandingemanse.com/2022/08/27/install-language-packs-on-windows-10-11-the-easy-way
#>

#description: Install selected Windows language packs and optionally set the default UI language.
#execution mode: IndividualWithRestart
#tags: CSN, Windows Script, Golden Image, Language Packs

<#variables:
{
  "LanguagePacks": {
    "Description": "Select one or more language packs to install.",
    "DisplayName": "Language packs to install",
    "IsRequired": true,
    "OptionsSet": [
      { "Label": "Arabic (Saudi Arabia)",               "Value": "ar-SA"     },
      { "Label": "Bulgarian (Bulgaria)",                "Value": "bg-BG"     },
      { "Label": "Chinese (Simplified, China)",         "Value": "zh-CN"     },
      { "Label": "Chinese (Traditional, Taiwan)",       "Value": "zh-TW"     },
      { "Label": "Croatian (Croatia)",                  "Value": "hr-HR"     },
      { "Label": "Czech (Czech Republic)",              "Value": "cs-CZ"     },
      { "Label": "Danish (Denmark)",                    "Value": "da-DK"     },
      { "Label": "Dutch (Netherlands)",                 "Value": "nl-NL"     },
      { "Label": "English (United States)",             "Value": "en-US"     },
      { "Label": "English (United Kingdom)",            "Value": "en-GB"     },
      { "Label": "English (Australia)",                 "Value": "en-AU"     },
      { "Label": "Estonian (Estonia)",                  "Value": "et-EE"     },
      { "Label": "Finnish (Finland)",                   "Value": "fi-FI"     },
      { "Label": "French (Canada)",                     "Value": "fr-CA"     },
      { "Label": "French (France)",                     "Value": "fr-FR"     },
      { "Label": "German (Germany)",                    "Value": "de-DE"     },
      { "Label": "Greek (Greece)",                      "Value": "el-GR"     },
      { "Label": "Hebrew (Israel)",                     "Value": "he-IL"     },
      { "Label": "Hungarian (Hungary)",                 "Value": "hu-HU"     },
      { "Label": "Indonesian (Indonesia)",              "Value": "id-ID"     },
      { "Label": "Italian (Italy)",                     "Value": "it-IT"     },
      { "Label": "Japanese (Japan)",                    "Value": "ja-JP"     },
      { "Label": "Korean (Korea)",                      "Value": "ko-KR"     },
      { "Label": "Latvian (Latvia)",                    "Value": "lv-LV"     },
      { "Label": "Lithuanian (Lithuania)",              "Value": "lt-LT"     },
      { "Label": "Norwegian, Bokmål (Norway)",          "Value": "nb-NO"     },
      { "Label": "Polish (Poland)",                     "Value": "pl-PL"     },
      { "Label": "Portuguese (Brazil)",                 "Value": "pt-BR"     },
      { "Label": "Portuguese (Portugal)",               "Value": "pt-PT"     },
      { "Label": "Romanian (Romania)",                  "Value": "ro-RO"     },
      { "Label": "Russian (Russia)",                    "Value": "ru-RU"     },
      { "Label": "Serbian (Latin, Serbia)",             "Value": "sr-Latn-RS"},
      { "Label": "Slovak (Slovakia)",                   "Value": "sk-SK"     },
      { "Label": "Slovenian (Slovenia)",                "Value": "sl-SI"     },
      { "Label": "Spanish (Mexico)",                    "Value": "es-MX"     },
      { "Label": "Spanish (Spain)",                     "Value": "es-ES"     },
      { "Label": "Swedish (Sweden)",                    "Value": "sv-SE"     },
      { "Label": "Thai (Thailand)",                     "Value": "th-TH"     },
      { "Label": "Turkish (Turkey)",                    "Value": "tr-TR"     },
      { "Label": "Ukrainian (Ukraine)",                 "Value": "uk-UA"     }
    ]
  },
  "DefaultLanguage": {
    "Description": "Optional: set one of the installed packs as the default UI language.",
    "DisplayName": "Default UI language",
    "IsRequired": false,
    "OptionsSet": [
      { "Label": "None",                            "Value": ""         },
      { "Label": "Arabic (Saudi Arabia)",           "Value": "ar-SA"    },
      { "Label": "Bulgarian (Bulgaria)",            "Value": "bg-BG"    },
      { "Label": "Chinese (Simplified, China)",     "Value": "zh-CN"    },
      { "Label": "Chinese (Traditional, Taiwan)",   "Value": "zh-TW"    },
      { "Label": "Croatian (Croatia)",              "Value": "hr-HR"    },
      { "Label": "Czech (Czech Republic)",          "Value": "cs-CZ"    },
      { "Label": "Danish (Denmark)",                "Value": "da-DK"    },
      { "Label": "Dutch (Netherlands)",             "Value": "nl-NL"    },
      { "Label": "English (United States)",         "Value": "en-US"    },
      { "Label": "English (United Kingdom)",        "Value": "en-GB"    },
      { "Label": "English (Australia)",             "Value": "en-AU"    },
      { "Label": "Estonian (Estonia)",              "Value": "et-EE"    },
      { "Label": "Finnish (Finland)",               "Value": "fi-FI"    },
      { "Label": "French (Canada)",                 "Value": "fr-CA"    },
      { "Label": "French (France)",                 "Value": "fr-FR"    },
      { "Label": "German (Germany)",                "Value": "de-DE"    },
      { "Label": "Greek (Greece)",                  "Value": "el-GR"    },
      { "Label": "Hebrew (Israel)",                 "Value": "he-IL"    },
      { "Label": "Hungarian (Hungary)",             "Value": "hu-HU"    },
      { "Label": "Indonesian (Indonesia)",          "Value": "id-ID"    },
      { "Label": "Italian (Italy)",                 "Value": "it-IT"    },
      { "Label": "Japanese (Japan)",                "Value": "ja-JP"    },
      { "Label": "Korean (Korea)",                  "Value": "ko-KR"    },
      { "Label": "Latvian (Latvia)",                "Value": "lv-LV"    },
      { "Label": "Lithuanian (Lithuania)",          "Value": "lt-LT"    },
      { "Label": "Norwegian, Bokmål (Norway)",      "Value": "nb-NO"    },
      { "Label": "Polish (Poland)",                 "Value": "pl-PL"    },
      { "Label": "Portuguese (Brazil)",             "Value": "pt-BR"    },
      { "Label": "Portuguese (Portugal)",           "Value": "pt-PT"    },
      { "Label": "Romanian (Romania)",              "Value": "ro-RO"    },
      { "Label": "Russian (Russia)",                "Value": "ru-RU"    },
      { "Label": "Serbian (Latin, Serbia)",         "Value": "sr-Latn-RS"},
      { "Label": "Slovak (Slovakia)",               "Value": "sk-SK"    },
      { "Label": "Slovenian (Slovenia)",            "Value": "sl-SI"    },
      { "Label": "Spanish (Mexico)",                "Value": "es-MX"    },
      { "Label": "Spanish (Spain)",                 "Value": "es-ES"    },
      { "Label": "Swedish (Sweden)",                "Value": "sv-SE"    },
      { "Label": "Thai (Thailand)",                 "Value": "th-TH"    },
      { "Label": "Turkish (Turkey)",                "Value": "tr-TR"    },
      { "Label": "Ukrainian (Ukraine)",             "Value": "uk-UA"    }
    ]
  }
}
#>

param(
  [Parameter(Mandatory)]
  [string[]]$LanguagePacks,

  [Parameter(Mandatory=$false)]
  [string]$DefaultLanguage
)

# --- Obtain OS version ---
$osInfo = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
$version = $osInfo.DisplayVersion

if ($version -eq '24H2') {
    Write-Host "Detected Windows 11 24H2 – applying 24H2-specific logic..."

    Write-Host "Starting language pack installation..."
    # Disable conflicting tasks
    if (Get-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation" -ErrorAction SilentlyContinue) {
        Disable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
    }
    if (Get-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" -ErrorAction SilentlyContinue) {
        Disable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
    }

    $installed = (Get-InstalledLanguage).LanguageId

    foreach ($lang in $LanguagePacks) {
        if ($installed -contains $lang) {
            Write-Host "Language pack '$lang' already installed."
        }
        else {
            for ($i = 1; $i -le 5; $i++) {
                try {
                    Write-Host "Installing language pack '$lang' (attempt $i)..."
                    Install-Language -Language $lang -ErrorAction Stop
                    Write-Host "Installed '$lang'."
                    break
                }
                catch {
                    Write-Host "Attempt $i failed: $($_.Exception.Message)"
                    Start-Sleep -Seconds 2
                }
            }
        }
    }

    if ($DefaultLanguage) {
        if ($LanguagePacks -contains $DefaultLanguage) {
            Write-Host "Setting default UI language to '$DefaultLanguage'..."
            Set-SystemPreferredUILanguage -Language $DefaultLanguage
            Set-WinSystemLocale       -SystemLocale  $DefaultLanguage
            Set-Culture               -CultureInfo   $DefaultLanguage
            Set-WinUILanguageOverride -Language      $DefaultLanguage

            # Also add keyboard layouts for the chosen language
            $userList = New-WinUserLanguageList -Language $DefaultLanguage
            $existing = Get-WinUserLanguageList
            foreach ($u in $existing) { $userList.Add($u.LanguageTag) }
            Set-WinUserLanguageList -LanguageList $userList -Force

            Write-Host "Default UI language set to '$DefaultLanguage'."
        }
        else {
            Write-Warning "DefaultLanguage '$DefaultLanguage' not in install list; skipping."
        }
    }

    # Re-enable tasks
    Enable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
    Enable-ScheduledTask -TaskName "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"

    Write-Host "Language pack installation complete on 24H2."
}
else {
    Write-Host "Detected OS version '$version' – applying original logic..."

    Write-Host "Starting language pack installation..."
    # Disable cleanup task to avoid conflicts
    if (Get-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup" -ErrorAction SilentlyContinue) {
        Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"
        Write-Host "Disabled Pre-staged app cleanup task."
    }

    $installed = (Get-InstalledLanguage).LanguageId

    foreach ($lang in $LanguagePacks) {
        if ($installed -contains $lang) {
            Write-Host "Language pack '$lang' already installed."
        }
        else {
            Write-Host "Installing language pack '$lang'..."
            Install-Language -Language $lang -ErrorAction Stop
            Write-Host "Installed '$lang'."
        }
    }

    if ($DefaultLanguage) {
        if ($LanguagePacks -contains $DefaultLanguage) {
            Write-Host "Setting default UI language to '$DefaultLanguage'..."
            Set-SystemPreferredUILanguage -Language $DefaultLanguage
            Set-WinSystemLocale       -SystemLocale  $DefaultLanguage
            Set-Culture               -CultureInfo   $DefaultLanguage
            Set-WinUILanguageOverride -Language      $DefaultLanguage
            Write-Host "Default UI language set to '$DefaultLanguage'."
        }
        else {
            Write-Warning "DefaultLanguage '$DefaultLanguage' not in install list; skipping."
        }
    }

    Write-Host "Language pack installation complete on version '$version'."
}