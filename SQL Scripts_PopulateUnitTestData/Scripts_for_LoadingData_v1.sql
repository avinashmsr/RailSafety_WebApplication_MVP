select * from public.wspd_app_train

INSERT INTO PUBLIC.wspd_app_train 
	VALUES(1,22691,'XYZ Express','XYZ Express train from X to destination Y') 
INSERT INTO PUBLIC.wspd_app_train 
	VALUES(2,12301,'ABC Freight','ABC Freight train from A to destination B') 

select * from public.wspd_app_rake

INSERT INTO public.wspd_app_rake
	VALUES (1, 1, 'rake for XYZ express 22691', 'Active', 1);
INSERT INTO public.wspd_app_rake
	VALUES (2, 2, 'rake for XYZ express 22691', 'Active', 1);
INSERT INTO public.wspd_app_rake
	VALUES (3, 3, 'rake for XYZ express 22691', 'Active', 1);
INSERT INTO public.wspd_app_rake
	VALUES (4, 4, 'rake for XYZ express 22691', 'Active', 1);
	
INSERT INTO public.wspd_app_rake
	VALUES (5, 1, 'rake for ABC Freight 12301', 'Active', 2);
INSERT INTO public.wspd_app_rake
	VALUES (6, 2, 'rake for ABC Freight 12301', 'Active', 2);
INSERT INTO public.wspd_app_rake
	VALUES (7, 3, 'rake for ABC Freight 12301', 'Active', 2);
INSERT INTO public.wspd_app_rake
	VALUES (8, 4, 'rake for ABC Freight 12301', 'Active', 2);
INSERT INTO public.wspd_app_rake
	VALUES (9, 5, 'rake for ABC Freight 12301', 'Active', 2);
INSERT INTO public.wspd_app_rake
	VALUES (10, 6, 'rake for ABC Freight 12301', 'Active', 2);
	
select * from public.wspd_app_coach
	
INSERT INTO public.wspd_app_coach
	VALUES (1, 14116, 'LMACCN', 'AC-I Class', 'Coach A5 of XYZ Exp',1,'A5',1);
INSERT INTO public.wspd_app_coach
	VALUES (2, 14117, 'LMACCN', 'AC-I Class', 'Coach A4 of XYZ Exp',2,'A4',1);
INSERT INTO public.wspd_app_coach
	VALUES (3, 14118, 'LMACCN', 'AC-I Class', 'Coach A3 of XYZ Exp',3,'A3',1);
	
INSERT INTO public.wspd_app_coach
	VALUES (4, 14116, 'LMACCN', 'AC-I Class', 'Coach A5 of XYZ Exp',1,'A5',2);
INSERT INTO public.wspd_app_coach
	VALUES (5, 14117, 'LMACCN', 'AC-I Class', 'Coach A4 of XYZ Exp',2,'A4',2);
INSERT INTO public.wspd_app_coach
	VALUES (6, 14118, 'LMACCN', 'AC-I Class', 'Coach A3 of XYZ Exp',3,'A3',2);
	
select * from public.wspd_app_faulttable

INSERT INTO public.wspd_app_faulttable
	VALUES (1, current_timestamp, 1, 123, 1,1,72);
INSERT INTO public.wspd_app_faulttable
	VALUES (2, current_timestamp, 3, 456, 1,1,72);
INSERT INTO public.wspd_app_faulttable
	VALUES (3, current_timestamp, 6, 789, 2,1,72);

