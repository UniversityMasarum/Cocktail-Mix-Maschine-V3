	// IF D11 equals ON -> Power on 10V 
	// 32000 = 14,6V
	// 10V = 

	//directionTreadmillleft := 25000;
	//directionTreadmillright := 25000;
	//speedTreadmill := -30000;
PROGRAM _CYCLIC
	
	speedTreadmill_var := 30000;
	CASE currentStation_var OF
		stationBecherspender_var:
			IF inductiveSensorBecherentnahme_DI = TRUE THEN
				directionThreadmillleft_DO := 0;
				Becherspender_DO := TRUE;
				counterBecherspender_var := counterBecherspender_var + 1;
			
				IF counterBecherspender_var > 1000 THEN
					directionTreadmillright_DO := 25000;
					Becherspender_DO := FALSE;
					currentStation_var := currentStation_var + 1;
				END_IF
			END_IF
					
		stationEismaschine_var:
			IF inductiveSensorEisstation_DI = TRUE THEN
				directionTreadmillright_DO := 0;
				eisspenderAktivieren_DO := TRUE;
				counterBecherspender_var := 0;
				counterEisstation_var := counterEisstation_var + 1;
				
				IF counterEisstation_var > 1000 THEN
					directionTreadmillright_DO := 25000;
					eisspenderAktivieren_DO := FALSE;
					currentStation_var := currentStation_var + 1;
				END_IF
			END_IF
				
		stationZitronenspender_var:
			IF inductiveSensorZitronenspende_DI = TRUE THEN
				directionTreadmillright_DO := 0;
				counterBecherspender_var := 0;
				zitronenspenderAktivieren_DO := TRUE;
				counterZitronenspender_var := counterZitronenspender_var + 1;
				
				IF counterZitronenspender_var > 1000 THEN
					directionTreadmillright_DO := 25000;
					zitronenspenderAktivieren_DO := FALSE;
					currentStation_var := currentStation_var + 1;
				END_IF
			END_IF
									
		stationCocktailmixer_var:
			IF inductiveSensorCocktailmixer_DI = TRUE THEN
				directionTreadmillright_DO := 0;
				counterBecherspender_var := 0;
				zitronenspenderAktivieren_DO := TRUE;
				counterCocktailmixer_var := counterCocktailmixer_var + 1;

				IF counterCocktailmixer_var > 1000 THEN
						directionTreadmillright_DO := 25000;
						zitronenspenderAktivieren_DO := FALSE;
						currentStation_var := currentStation_var + 1;
				END_IF
			END_IF								
												
		stationBecherentnahme_var:
			directionTreadmillright_DO := 0;
			counterCocktailmixer_var := 0;
													
			IF buttonAusgabe_DI = TRUE THEN
				directionThreadmillleft_DO := 25000;	
				currentStation_var := 0;
			END_IF
	END_CASE

END_PROGRAM
