#RequireAdmin
Opt("sendkeydelay", 15)
Opt("sendkeydowndelay", 15)
Opt("MouseClickdelay", 15)
Global $size = WinGetClientSize("Borderlands")
load()
Func load()
	;if Ini not found then
	If Not FileExists(StringTrimRight(@ScriptName, 4) & ".ini") Then

		;Create Default Storage to write INI.
		Local $AmmoStorage[8][2] = _
				[ _
				["Laser", "1340"], _
				["Grenades", "10"], _
				["Pistol", "900"], _
				["Assault", "1260"], _
				["Shotgun", "220"], _
				["SMG", "1620"], _
				["Sniper", "132"], _
				["Launcher", "33"]]


		;Writes INI from Storage
		$writeerror = IniWriteSection(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", $AmmoStorage, 0)
		IniWrite(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "ReplenishAmmo", "{numpad2}")

		;Informs the user of the result.
		If $writeerror = False Then
			MsgBox(0, StringTrimRight(@ScriptName, 4), "Could not write INI. You need Admin permissions to write to " & @ScriptDir)
			Exit
		EndIf
		MsgBox(0, StringTrimRight(@ScriptName, 4), "Could not find " & @ScriptDir & StringTrimRight(@ScriptName, 4) & ".ini. Loading Default Ammo.")

		;Reruns this function, loading the default Ammo.
		load()

	Else
		;if Ini was found then
		;Loads the Ammo stored in your INI.
		Global $LaserAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Laser", "1340")
		Global $GrenadesAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Grenades", "10")
		Global $PistolAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Pistol", "900")
		Global $AssaultAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Assault", "1260")
		Global $ShotgunAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Shotgun", "220")
		Global $SMGAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "SMG", "1620")
		Global $SniperAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Sniper", "132")
		Global $LauncherAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Ammo", "Launcher", "33")
		Global $ReplenishAmmo = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "ReplenishAmmo", "{numpad2}")
		Global $AmmoPurchased[8] = [ _
				Ceiling($AssaultAmmo / 54), _
				Ceiling($LaserAmmo / 69), _
				Ceiling($PistolAmmo / 54), _
				Ceiling($LauncherAmmo / 12), _
				Ceiling($ShotgunAmmo / 24), _
				Ceiling($SMGAmmo / 72), _
				Ceiling($SniperAmmo / 18), _
				Ceiling($GrenadesAmmo / 3)]
		HotKeySet($ReplenishAmmo, "ReplenishAmmo")

	EndIf
EndFunc   ;==>load
While 1
	Sleep(200)
WEnd
Func ReplenishAmmo()
	HotKeySet($ReplenishAmmo)
	Send("e")
	Sleep(1000)
	For $i = 0 To 7
		Send("{enter " & $AmmoPurchased[$i] & "}{down}")
	Next
	Sleep(100)
	Send("{esc}")
	HotKeySet($ReplenishAmmo, "ReplenishAmmo")
EndFunc   ;==>ReplenishAmmo



