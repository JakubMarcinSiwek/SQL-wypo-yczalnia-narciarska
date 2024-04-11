--procedura 1
ALTER TABLE SprzetKlienta ADD (ROZMIAR VARCHAR2(20));

Select * from SprzetKlienta;

exec ADD_SKI_SIZE;

CREATE OR REPLACE PROCEDURE ADD_SKI_SIZE
AS
CURSOR c_ski_data IS
SELECT IdSprzetu, DlugoscNarty
FROM SprzetKlienta;
v_ski_data c_ski_data%ROWTYPE;
BEGIN
FOR v_ski_data IN c_ski_data
LOOP
IF v_ski_data.DlugoscNarty > 190 THEN
UPDATE SprzetKlienta
SET Rozmiar = 'duza'
WHERE IdSprzetu = v_ski_data.IdSprzetu;
ELSIF v_ski_data.DlugoscNarty >= 150 THEN
UPDATE SprzetKlienta
SET Rozmiar = 'srednia'
WHERE IdSprzetu = v_ski_data.IdSprzetu;
ELSE
UPDATE SprzetKlienta
SET Rozmiar = 'mala'
WHERE IdSprzetu = v_ski_data.IdSprzetu;
END IF;
END LOOP;
END;

--procedura 2
CREATE OR REPLACE PROCEDURE stworz_pracownika (p_IDOsoby IN Osoba.IdOsoby%TYPE)
AS 
BEGIN
  INSERT INTO Pracownik (DataZatrudnienia, IdPracownik)
  VALUES (SYSDATE, p_IDOsoby);
END;
exec stworz_pracownika (29);

--wyzwalacz 1
CREATE OR REPLACE TRIGGER limit_cena_cennik
BEFORE INSERT ON Cennik
FOR EACH ROW
BEGIN
  IF :NEW.Cena > 150 THEN
    raise_application_error(-20000, 'Cena nie mo¿e byæ wiêksza ni¿ 150');
  ELSE
    dbms_output.put_line('Dodano pozycjê do cennika');
  END IF;
END;

--Insert Into Cennik Values(6,'miesieczne wypozyczenie',190);

--wyzwalacz 2
CREATE OR REPLACE TRIGGER block_adding_equipment_of_company_szpak
BEFORE INSERT ON SPRZETDOWYPOZYCZENIA
FOR EACH ROW
DECLARE
  company_name VARCHAR2(30);
BEGIN
  SELECT NAZWA INTO company_name
  FROM FIRMY
  WHERE ID_FIRMY = :NEW.ID_FIRMY;

  IF company_name = 'szpak' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nie mo¿na dodawaæ sprzêtu firmy szpak');
  END IF;
END;