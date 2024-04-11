IF @DlugoscNarty > 190
BEGIN
SET @Rozmiar = 'duza';
END;
ELSE IF @DlugoscNarty >= 150
BEGIN
SET @Rozmiar = 'srednia';
END;
ELSE
BEGIN
SET @Rozmiar = 'mala';
END;
UPDATE SprzetKlienta
SET Rozmiar = @Rozmiar
WHERE IdSprzetu = @IdSprzetu;
FETCH NEXT FROM c_ski_data INTO @IdSprzetu, @DlugoscNarty;
END;
CLOSE c_ski_data;
DEALLOCATE c_ski_data;
END;


-- procedura 2

exec ZmienNapracownika (29);


CREATE PROCEDURE ZmienNaPracownika (@IDOsoby INT)
AS
BEGIN
    DECLARE @DataZatrudnienia DATE = GETDATE();

    INSERT INTO Pracownik (DataZatrudnienia, IdPracownik)
    SELECT @DataZatrudnienia, IdOsoby
    FROM Osoba
    WHERE IdOsoby = @IDOsoby;

    DELETE FROM Osoba
    WHERE IdOsoby = @IDOsoby;
END

-- trigger 1

CREATE TRIGGER limit_cena_cennik
ON Cennik
FOR INSERT
AS
BEGIN
IF EXISTS (SELECT * FROM inserted WHERE Cena > 150)
BEGIN
RAISERROR ('Cena nie mo¿e byæ wiêksza ni¿ 150', 16, 1);
ROLLBACK TRANSACTION;
END
ELSE
BEGIN
PRINT 'Dodano pozycjê do cennika';
END
END;

--Insert Into Cennik Values(6,'miesieczne wypozyczenie',190);

--trigger 2
CREATE TRIGGER sprawdzenie_wypozyczenia
BEFORE INSERT ON SprzetKlienta
FOR EACH ROW
BEGIN
DECLARE @idKlient INT;
SET @idKlient = (SELECT IdKlient FROM SprzetKlienta WHERE IdSprzetu = NEW.IdSprzetu);

IF (@idKlient IS NOT NULL) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sprzêt jest ju¿ wypo¿yczony!';
END IF;
END;
