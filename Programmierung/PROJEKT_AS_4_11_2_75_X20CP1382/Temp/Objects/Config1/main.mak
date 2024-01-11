SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\MATLAB\R2023a\bin;C:\Program Files\Git\cmd;C:\Users\Simon\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\Simon\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\BRAutomation\AS412\bin-de\4.12;C:\BRAutomation\AS412\bin-de\4.11;C:\BRAutomation\AS412\bin-de\4.10;C:\BRAutomation\AS412\bin-de\4.9;C:\BRAutomation\AS412\bin-de\4.8;C:\BRAutomation\AS412\bin-de\4.7;C:\BRAutomation\AS412\bin-de\4.6;C:\BRAutomation\AS412\bin-de\4.5;C:\BRAutomation\AS412\bin-de\4.4;C:\BRAutomation\AS412\bin-de\4.3;C:\BRAutomation\AS412\bin-de\4.2;C:\BRAutomation\AS412\bin-de\4.1;C:\BRAutomation\AS412\bin-de\4.0;C:\BRAutomation\AS412\bin-de
export AS_BUILD_MODE := BuildAndTransfer
export AS_VERSION := 4.12.2.93
export AS_WORKINGVERSION := 4.12
export AS_COMPANY_NAME :=  
export AS_USER_NAME := Simon
export AS_PATH := C:/BRAutomation/AS412
export AS_BIN_PATH := C:/BRAutomation/AS412/bin-de
export AS_PROJECT_PATH := C:/Users/Simon/OneDrive/Dokumente/CocktailMaschine/Cocktail-Mix-Maschine-V3/Programmierung/PROJEKT_AS_4_11_2_75_X20CP1382
export AS_PROJECT_NAME := X20CP1382
export AS_SYSTEM_PATH := C:/BRAutomation/AS/System
export AS_VC_PATH := C:/BRAutomation/AS412/AS/VC
export AS_TEMP_PATH := C:/Users/Simon/OneDrive/Dokumente/CocktailMaschine/Cocktail-Mix-Maschine-V3/Programmierung/PROJEKT_AS_4_11_2_75_X20CP1382/Temp
export AS_CONFIGURATION := Config1
export AS_BINARIES_PATH := C:/Users/Simon/OneDrive/Dokumente/CocktailMaschine/Cocktail-Mix-Maschine-V3/Programmierung/PROJEKT_AS_4_11_2_75_X20CP1382/Binaries
export AS_GNU_INST_PATH := C:/BRAutomation/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := C:/BRAutomation/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BRAutomation/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := C:/BRAutomation/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_INSTALL_PATH := C:/BRAutomation/AS412
export WIN32_AS_PATH := "C:\BRAutomation\AS412"
export WIN32_AS_BIN_PATH := "C:\BRAutomation\AS412\bin-de"
export WIN32_AS_PROJECT_PATH := "C:\Users\Simon\OneDrive\Dokumente\CocktailMaschine\Cocktail-Mix-Maschine-V3\Programmierung\PROJEKT_AS_4_11_2_75_X20CP1382"
export WIN32_AS_SYSTEM_PATH := "C:\BRAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BRAutomation\AS412\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\Users\Simon\OneDrive\Dokumente\CocktailMaschine\Cocktail-Mix-Maschine-V3\Programmierung\PROJEKT_AS_4_11_2_75_X20CP1382\Temp"
export WIN32_AS_BINARIES_PATH := "C:\Users\Simon\OneDrive\Dokumente\CocktailMaschine\Cocktail-Mix-Maschine-V3\Programmierung\PROJEKT_AS_4_11_2_75_X20CP1382\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BRAutomation\AS412\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "C:\BRAutomation\AS412\AS\GnuInst\V4.1.2\bin"
export WIN32_AS_INSTALL_PATH := "C:\BRAutomation\AS412"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/4.9/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/X20CP1382.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'BuildAndTransfer'   

