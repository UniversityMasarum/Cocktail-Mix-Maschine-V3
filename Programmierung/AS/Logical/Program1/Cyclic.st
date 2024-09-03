 
PROGRAM _CYCLIC
	//fallende Flanke für TOF_IN erzeugen
	IF (cocktail_start = FALSE AND cocktail_started = FALSE) THEN
		cocktail_start := TRUE;
	END_IF
		
	// Wenn Reinigungsprogramm aktiviert ist, soll kein Cocktail gemacht werden
	IF reingigunsmodus_var = FALSE AND ERROR_DI = FALSE THEN
		//Ausgewählter Cocktail
		CASE cocktail_var OF
			wodka_cola:
				//Laufzeiten der Pumpen aus Flussraten und benötigten Mengen berechnen
				pumptime_01 :=	UINT_TO_TIME(ml_wodkacola_cola)*108;
				pumptime_02 :=	UINT_TO_TIME(ml_wodkacola_wodka)*330;
				
				//Pumpen über TOF für errechnete Laufzeit anschalten
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig2_DO:=TOF_01.Q;
				
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall3_DO:=TOF_02.Q;
				
			rumcola: 
				pumptime_01 :=	UINT_TO_TIME(ml_rumcola_cola)*108;
				pumptime_02 :=	UINT_TO_TIME(ml_rumcola_rum)*420;
				
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig2_DO:=TOF_01.Q;
				
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall2_DO:=TOF_02.Q;
				
			kirschcola:
				pumptime_01 :=	UINT_TO_TIME(ml_kirschcola_cola)*108;
				pumptime_02 :=	UINT_TO_TIME(ml_kirschcola_kirsch)*390;
					
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig2_DO:=TOF_01.Q;
					
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall5_DO:=TOF_02.Q;
				
			gruenewiese:
				pumptime_01 :=	UINT_TO_TIME(ml_gruenewiese_osaft)*118;
				pumptime_02 :=	UINT_TO_TIME(ml_gruenewiese_bc)*350;
						
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig4_DO:=TOF_01.Q;
						
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall6_DO:=TOF_02.Q;
				
			angelblue:
				pumptime_01 :=	UINT_TO_TIME(ml_angelblue_sprite)*111;
				pumptime_02 :=	UINT_TO_TIME(ml_angelblue_bc)*350;
				pumptime_03 := UINT_TO_TIME(ml_angelblue_wodka)*330;
							
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig1_DO:=TOF_01.Q;
							
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall6_DO:=TOF_02.Q;
						
				TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
				pumpeSmall3_DO:=TOF_03.Q;
				
			brassmonkey:
				pumptime_01 :=	UINT_TO_TIME(ml_brassmonkey_osaft)*118;
				pumptime_02 :=	UINT_TO_TIME(ml_brassmonkey_rum)*420;
				pumptime_03 := UINT_TO_TIME(ml_angelblue_wodka)*330;
							
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig4_DO:=TOF_01.Q;
							
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall2_DO:=TOF_02.Q;
						
				TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
				pumpeSmall3_DO:=TOF_03.Q;
				
			wodka_osaft:
				pumptime_01 :=	UINT_TO_TIME(ml_wodkaosaft_osaft)*118;
				pumptime_02 :=	UINT_TO_TIME(ml_wodkaosaft_wodka)*330;
				
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig4_DO:=TOF_01.Q;
				
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall3_DO:=TOF_02.Q;
				
			//Cocktail mit kurzer Laufzeit für Tests
			testcocktail:
				pumptime_01 :=	T#2s;
				pumptime_02 :=	T#2s;

				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig4_DO:=TOF_01.Q;
							
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall3_DO:=TOF_02.Q;
			
			kiba:
				pumptime_01 :=	UINT_TO_TIME(ml_kiba_banane)*105;
				pumptime_02 :=	UINT_TO_TIME(ml_kiba_kirsch)*390;
						
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig3_DO:=TOF_01.Q;
						
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall5_DO:=TOF_02.Q;
			
			gintonic:
				pumptime_01 :=	UINT_TO_TIME(ml_gintonic_tonic)*390;
				pumptime_02 :=	UINT_TO_TIME(ml_gintonic_gin)*300;
							
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeSmall1_DO:=TOF_01.Q;
							
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall4_DO:=TOF_02.Q;
				
			bluelagoon: 
				pumptime_01 :=	UINT_TO_TIME(ml_bluelagoon_sprite)*111;
				pumptime_02 :=	UINT_TO_TIME(ml_bluelagoon_bc)*350;
					
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig1_DO:=TOF_01.Q;
					
				TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
				pumpeSmall6_DO:=TOF_02.Q;
				
			zufallscocktail:
				//Laufzeiten der Pumpen aus Flussraten und nötigen Mengen berechnen
				pumptime_01 :=	UINT_TO_TIME(zutat_Menge_ok[1])*111;
				pumptime_02 :=	UINT_TO_TIME(zutat_Menge_ok[2])*108;
				pumptime_03 :=	UINT_TO_TIME(zutat_Menge_ok[3])*105;
				pumptime_02 :=	UINT_TO_TIME(zutat_Menge_ok[4])*118;
				pumptime_05 :=	UINT_TO_TIME(zutat_Menge_ok[5])*390;
				pumptime_06 :=	UINT_TO_TIME(zutat_Menge_ok[6])*420;
				pumptime_07 :=	UINT_TO_TIME(zutat_Menge_ok[7])*330;
				pumptime_08 :=	UINT_TO_TIME(zutat_Menge_ok[8])*300;
				pumptime_09 :=	UINT_TO_TIME(zutat_Menge_ok[9])*390;
				pumptime_10 :=	UINT_TO_TIME(zutat_Menge_ok[10])*350;
				
				//Pumpe wird nur aktiviert, wenn Komponente benötigt wird
				IF zutat_JaNein_ok[1] = TRUE THEN
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig1_DO:=TOF_01.Q;
				END_IF
				IF zutat_JaNein_ok[2] = TRUE THEN
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeBig2_DO:=TOF_02.Q;
				END_IF
				IF zutat_JaNein_ok[3] = TRUE THEN
					TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
					pumpeBig3_DO:=TOF_03.Q;
				END_IF
				IF zutat_JaNein_ok[4] = TRUE THEN
					TOF_04(IN:= cocktail_start , PT:= pumptime_04 );
					pumpeBig4_DO:=TOF_04.Q;
				END_IF
				IF zutat_JaNein_ok[5] = TRUE THEN
					TOF_05(IN:= cocktail_start , PT:= pumptime_05 );
					pumpeSmall1_DO:=TOF_05.Q;
				END_IF
				IF zutat_JaNein_ok[6] = TRUE THEN
					TOF_06(IN:= cocktail_start , PT:= pumptime_06 );
					pumpeSmall2_DO:=TOF_06.Q;
				END_IF
				IF zutat_JaNein_ok[7] = TRUE THEN
					TOF_07(IN:= cocktail_start , PT:= pumptime_07 );
					pumpeSmall3_DO:=TOF_07.Q;
				END_IF
				IF zutat_JaNein_ok[8] = TRUE THEN
					TOF_08(IN:= cocktail_start , PT:= pumptime_08 );
					pumpeSmall4_DO:=TOF_08.Q;
				END_IF
				IF zutat_JaNein_ok[9] = TRUE THEN
					TOF_09(IN:= cocktail_start , PT:= pumptime_09 );
					pumpeSmall5_DO:=TOF_09.Q;
				END_IF
				IF zutat_JaNein_ok[10] = TRUE THEN
					TOF_10(IN:= cocktail_start , PT:= pumptime_10 );
					pumpeSmall6_DO:=TOF_10.Q;
				END_IF
					
			osaft:
				pumptime_01 :=	UINT_TO_TIME(ml_osaft)*118;
									
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig4_DO:=TOF_01.Q;
			cola:
				pumptime_01 :=	UINT_TO_TIME(ml_cola)*108;
											
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig2_DO:=TOF_01.Q;
			banane:
				pumptime_01 :=	UINT_TO_TIME(ml_banane)*105;
										
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig3_DO:=TOF_01.Q;
			tonic: 
				pumptime_01 :=	UINT_TO_TIME(ml_tonic)*390;
											
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeSmall1_DO:=TOF_01.Q;
			sprite:
				pumptime_01 :=	UINT_TO_TIME(ml_sprite)*111;
											
				TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
				pumpeBig1_DO:=TOF_01.Q;

		END_CASE
	END_IF
	// IF Cocktail was chosen in the visualisation --> Cocktailchosen == True
	IF wodka_cola_var = 1 OR kirschcola_var = 1 OR testcocktail_var = 1 OR wodka_osaft_var = 1 OR gruenewiese_var = 1 OR angelblue_var = 1 OR brassmonkey_var = 1 OR kiba_var = 1 OR rumcola_var = 1 OR gintonic_var = 1 OR bluelagoon_var = 1 OR osaft_var = 1 OR cola_var = 1 OR banane_var = 1 OR tonic_var = 1 OR sprite_var = 1 OR zufallscocktail_var = 1 THEN
		cocktailChosen_var := TRUE;
	END_IF
		
	IF (cocktail_start = TRUE AND cocktail_started = FALSE) THEN
		cocktail_start := FALSE;
		cocktail_started := TRUE;
		
		// Variable, dass Cocktail beendet wurde
		cocktailFinished_var := TRUE;
	END_IF	
	
	// Setzt den Schalter zurück
	IF wodka_cola_var = TRUE THEN
		cocktail_var := wodka_cola;
		wodka_cola_var := FALSE;
		Anzahl_Cocktails [wodka_cola] := Anzahl_Cocktails [wodka_cola] + 1;
	END_IF
	IF kirschcola_var = TRUE THEN
		cocktail_var := kirschcola;
		kirschcola_var := FALSE;
		Anzahl_Cocktails [kirschcola] := Anzahl_Cocktails [kirschcola] + 1;
	END_IF
	IF testcocktail_var = TRUE THEN
		cocktail_var := testcocktail;
		testcocktail_var := FALSE;
		Anzahl_Cocktails [testcocktail] := Anzahl_Cocktails [testcocktail] + 1;
	END_IF
	IF wodka_osaft_var = TRUE THEN
		cocktail_var := wodka_osaft;
		wodka_osaft_var := FALSE;
		Anzahl_Cocktails [wodka_osaft] := Anzahl_Cocktails [wodka_osaft] + 1;
	END_IF
	IF gruenewiese_var = TRUE THEN
		cocktail_var := gruenewiese;
		gruenewiese_var := FALSE; 
		Anzahl_Cocktails [gruenewiese] := Anzahl_Cocktails [gruenewiese] + 1;
	END_IF
	IF angelblue_var = TRUE THEN
		cocktail_var := angelblue;
		angelblue_var := FALSE; 
		Anzahl_Cocktails [angelblue] := Anzahl_Cocktails [angelblue] + 1;
	END_IF
	IF brassmonkey_var = TRUE THEN
		cocktail_var := brassmonkey;
		brassmonkey_var := FALSE;
		Anzahl_Cocktails [brassmonkey] := Anzahl_Cocktails [brassmonkey] + 1;
	END_IF
	IF kiba_var = TRUE THEN
		cocktail_var := kiba;
		kiba_var := FALSE;
		Anzahl_Cocktails [kiba] := Anzahl_Cocktails [kiba] + 1;
	END_IF
	IF rumcola_var = TRUE THEN
		cocktail_var := rumcola;
		rumcola_var := FALSE;
		Anzahl_Cocktails [rumcola] := Anzahl_Cocktails [rumcola] + 1;
	END_IF									
	IF gintonic_var = TRUE THEN
		cocktail_var := gintonic;
		gintonic_var := FALSE; 
		Anzahl_Cocktails [gintonic] := Anzahl_Cocktails [gintonic] + 1;
	END_IF
	IF bluelagoon_var = TRUE THEN
		cocktail_var := bluelagoon;
		bluelagoon_var := FALSE; 
		Anzahl_Cocktails [bluelagoon] := Anzahl_Cocktails [bluelagoon] + 1;
	END_IF
	IF osaft_var = TRUE THEN
		cocktail_var := osaft;
		osaft_var := FALSE; 
		Anzahl_Cocktails [osaft] := Anzahl_Cocktails [osaft] + 1;
	END_IF
	IF cola_var = TRUE THEN
		cocktail_var := cola;
		cola_var := FALSE; 
		Anzahl_Cocktails [cola] := Anzahl_Cocktails [cola] + 1;
	END_IF
	IF banane_var = TRUE THEN
		cocktail_var := banane;
		banane_var := FALSE; 
		Anzahl_Cocktails [banane] := Anzahl_Cocktails [banane] + 1;
	END_IF
	IF tonic_var = TRUE THEN
		cocktail_var := tonic;
		tonic_var := FALSE; 
		Anzahl_Cocktails [tonic] := Anzahl_Cocktails [tonic] + 1;
	END_IF
	IF sprite_var = TRUE THEN
		cocktail_var := sprite;
		sprite_var := FALSE;
		Anzahl_Cocktails [sprite] := Anzahl_Cocktails [sprite] + 1;
	END_IF
	IF zufallscocktail_var = TRUE THEN
		cocktail_var := zufallscocktail;
		zufallscocktail_var := FALSE;
		Anzahl_Cocktails [zufallscocktail] := Anzahl_Cocktails [zufallscocktail] + 1;
	END_IF
END_PROGRAM
