
(* Frag nicht was für Saft: Einfach Orangensaft *)
FUNCTION PumpeOrangensaft 
		var_input pumpTime : UINT; end_var
		
		IF cocktailTime < pumpTime THEN
			pumpeOrangensaft_DO := TRUE;
		ELSE 
			pumpeOrangensaft_DO := FALSE;
		END_IF		
END_FUNCTION
