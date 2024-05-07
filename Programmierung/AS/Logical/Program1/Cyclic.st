
PROGRAM _CYCLIC
	//code, um die Pumpenansteuerung mittels TONs zu testen
	(*
	p1 - 500ml/min
	p2 - 550ml/min (Cola braucht es ca 
	p3 - 550ml/min
	p4 - 500ml/min
	p1 - 500ml/min 
	p6 - 140ml/min
	p7 - 150ml/min
	p1 - 140ml/min
	p1 - 150ml/min
	*)
	// Aus der Visualisierung
	
	
	
	
		IF counterCocktailmixer_var = 1 OR counterCocktailmixer_var = 2 THEN
			cocktail_started := FALSE;
		END_IF
	
		IF (cocktail_start = FALSE AND cocktail_started = FALSE) THEN
			cocktail_start := TRUE;
		END_IF
		
	// Wenn Reinigungsprogramm aktiviert ist, soll kein Cocktail gemacht werden
		IF reingigunsmodus_var = FALSE THEN
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
			
				gentleben:
					pumptime_01 :=	(ml_gentleben_osaft*144);
					pumptime_02 :=	(ml_gentleben_wodka*400);
					pumptime_03 := (ml_gentleben_tq*400);
					pumptime_04 := (ml_gentleben_gin*400);
							
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
							
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall3_DO:=TOF_02.Q;
						
					TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
					pumpeSmall1_DO:=TOF_03.Q;
				
					TOF_04(IN:= cocktail_start , PT:= pumptime_04 );
					pumpeSmall4_DO:=TOF_04.Q;
				
				kiba:
					pumptime_01 :=	(ml_kiba_banane*144);
					pumptime_02 :=	(ml_kiba_kirsch*400);
					
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig3_DO:=TOF_01.Q;
					
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall5_DO:=TOF_02.Q;
			
				bich:
					pumptime_01 :=	(ml_bich_osaft*144);
					pumptime_02 :=	(ml_bich_kirsch*400);
					pumptime_03 := (ml_bich_tq*400);
							
					TOF_01(IN:= cocktail_start , PT:= pumptime_01 );
					pumpeBig4_DO:=TOF_01.Q;
							
					TOF_02(IN:= cocktail_start , PT:= pumptime_02 );
					pumpeSmall5_DO:=TOF_02.Q;
						
					TOF_03(IN:= cocktail_start , PT:= pumptime_03 );
					pumpeSmall6_DO:=TOF_03.Q;

			END_CASE
		END_IF
		// IF Cocktail was chosen in the visualisation --> Cocktailchosen == True
		IF wodka_cola_var = 1 OR kirschcola_var = 1 OR gentleben_var = 1 OR wodka_osaft_var = 1 OR gruenewiese_var = 1 OR angelblue_var = 1 OR brassmonkey_var = 1 OR kiba_var = 1 OR rumcola_var = 1 OR bich_var = 1 THEN
			cocktailChosen_var := TRUE;
		END_IF
		
		IF (cocktail_start = TRUE AND cocktail_started = FALSE) THEN
			cocktail_start := FALSE;
			cocktail_started := TRUE;
		
		// Variable, dass Cocktail beendet wurde
			cocktailFinished_var := TRUE;
		END_IF	
	
	IF wodka_cola_var = TRUE THEN
		cocktail_var := wodka_cola;
	END_IF	
	IF kirschcola_var = TRUE THEN
		cocktail_var := kirschcola;
	END_IF
	IF gentleben_var = TRUE THEN
		cocktail_var := gentleben;
	END_IF
	IF wodka_osaft_var = TRUE THEN
		cocktail_var := wodka_osaft;
	END_IF
	IF gruenewiese_var = TRUE THEN
		cocktail_var := gruenewiese;
	END_IF
	IF angelblue_var = TRUE THEN
		cocktail_var := angelblue;
	END_IF
	IF brassmonkey_var = TRUE THEN
		cocktail_var := brassmonkey;
	END_IF
	IF kiba_var = TRUE THEN
		cocktail_var := kiba;
	END_IF
	IF rumcola_var = TRUE THEN
		cocktail_var := rumcola;
	END_IF									
	IF bich_var = TRUE THEN
		cocktail_var := bich;
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
