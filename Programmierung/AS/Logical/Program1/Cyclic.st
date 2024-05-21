 
PROGRAM _CYCLIC
	//code, um die Pumpenansteuerung mittels TONs zu testen
	(*
	p1 - 500ml/min
	p2 - 550ml/min (Cola braucht es ca 
	p3 - 550ml/min
	p4 - 500ml/min

	p6 - 140ml/min
	p7 - 150ml/min
	p1 - 140ml/min
	p1 - 150ml/min
	
	pumpeBig1_DO 	sprite
	pumpeBig2_DO 	cola
	pumpeBig3_DO 	banane
	pumpeBig4_DO 	osaft
	pumpeSmall1_DO 	tonic
	pumpeSmall2_DO 	rum
	pumpeSmall3_DO 	wodka
	pumpeSmall4_DO 	gin
	pumpeSmall5_DO 	kirsch
	pumpeSmall6_DO 	blue curacao
	
	*)
	// Aus der Visualisierung
	IF counterCocktailmixer_var = 1 OR counterCocktailmixer_var = 2 THEN
			cocktail_started := FALSE;
		END_IF
	
		IF (cocktail_start = FALSE AND cocktail_started = FALSE) THEN
			cocktail_start := TRUE;
		END_IF
		
	// Wenn Reinigungsprogramm aktiviert ist, soll kein Cocktail gemacht werden
		IF reingigunsmodus_var = FALSE AND ERROR_DI = FALSE THEN
			CASE cocktail_var OF
				wodka_cola:
				
					pumptime_01 :=	(ml_wodkacola_cola*144);
					pumptime_02 :=	(ml_wodkacola_wodka*400);
				
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig2_DO:=TOF_01.Q;
				
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall3_DO:=TOF_02.Q;
				
				rumcola: 
				
					pumptime_01 :=	(ml_rumcola_cola*144);
					pumptime_02 :=	(ml_rumcola_rum*400);
				
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig2_DO:=TOF_01.Q;
				
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall2_DO:=TOF_02.Q;
				
				kirschcola:
					pumptime_01 :=	(ml_kirschcola_cola*144);
					pumptime_02 :=	(ml_kirschcola_kirsch*400);
					
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig2_DO:=TOF_01.Q;
					
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall5_DO:=TOF_02.Q;
				
				gruenewiese:
					pumptime_01 :=	(ml_gruenewiese_osaft*144);
					pumptime_02 :=	(ml_gruenewiese_bc*400);
						
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
						
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall6_DO:=TOF_02.Q;
				
				angelblue:
					pumptime_01 :=	(ml_angelblue_sprite*144);
					pumptime_02 :=	(ml_angelblue_bc*400);
					pumptime_03 := (ml_angelblue_wodka*400);
							
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig1_DO:=TOF_01.Q;
							
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall6_DO:=TOF_02.Q;
						
					TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
					pumpeSmall3_DO:=TOF_03.Q;
				
				brassmonkey:
					pumptime_01 :=	(ml_brassmonkey_osaft*144);
					pumptime_02 :=	(ml_brassmonkey_wodka*400);
					pumptime_03 := (ml_brassmonkey_rum*400);
							
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
							
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall3_DO:=TOF_02.Q;
						
					TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
					pumpeSmall2_DO:=TOF_03.Q;
				
				wodka_osaft:
					pumptime_01 :=	(ml_wodkaosaft_osaft*144);
					pumptime_02 :=	(ml_wodkaosaft_wodka*400);
				
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
				
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall3_DO:=TOF_02.Q;
			
				testcocktail:
					pumptime_01 :=	T#2s;
					pumptime_02 :=	T#2s;

					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
							
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall3_DO:=TOF_02.Q;
			
				kiba:
					pumptime_01 :=	(ml_kiba_banane*144);
					pumptime_02 :=	(ml_kiba_kirsch*400);
						
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig3_DO:=TOF_01.Q;
						
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall5_DO:=TOF_02.Q;
			
				gintonic:
					pumptime_01 :=	(ml_gintonic_tonic*400);
					pumptime_02 :=	(ml_gintonic_gin*400);
							
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeSmall1_DO:=TOF_01.Q;
							
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall4_DO:=TOF_02.Q;
				
				bluelagoon: 
					
					pumptime_01 :=	(ml_bluelagoon_sprite*144);
					pumptime_02 :=	(ml_bluelagoon_bc*400);
					
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig1_DO:=TOF_01.Q;
					
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall6_DO:=TOF_02.Q;
				
				
				
				osaft:
					pumptime_01 :=	(ml_osaft*144);
									
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
				cola:
					pumptime_01 :=	(ml_cola*144);
										
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig2_DO:=TOF_01.Q;
				banane:
					pumptime_01 :=	(ml_banane*144);
										
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig3_DO:=TOF_01.Q;
				tonic: 
					pumptime_01 :=	(ml_tonic*400);
											
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeSmall1_DO:=TOF_01.Q;
				sprite:
					pumptime_01 :=	(ml_sprite*144);
											
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig1_DO:=TOF_01.Q;
			END_CASE
		END_IF
		// IF Cocktail was chosen in the visualisation --> Cocktailchosen == True
		IF wodka_cola_var = 1 OR kirschcola_var = 1 OR testcocktail_var = 1 OR wodka_osaft_var = 1 OR gruenewiese_var = 1 OR angelblue_var = 1 OR brassmonkey_var = 1 OR kiba_var = 1 OR rumcola_var = 1 OR gintonic_var = 1 OR bluelagoon_var = 1 OR osaft_var = 1 OR cola_var = 1 OR banane_var = 1 OR tonic_var = 1 OR sprite_var = 1 THEN
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
	
END_PROGRAM


(*
	CASE pump OF
		
		1: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe1_DO:=TOF_01.Q;
		2: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe2_DO:=TOF_01.Q;
		3: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe3_DO:=TOF_01.Q;
		4: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe4_DO:=TOF_01.Q;
		5: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe5_DO:=TOF_01.Q;
		6: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe6_DO:=TOF_01.Q;
		7: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe7_DO:=TOF_01.Q;
		8: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe8_DO:=TOF_01.Q;
		9: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe9_DO:=TOF_01.Q;
		10: 
			TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
			pumpe10_DO:=TOF_01.Q;
	END_CASE
	*)
