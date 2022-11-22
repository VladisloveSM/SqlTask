CREATE DATABASE BankSystem
GO

USE [BankSystem]
GO

CREATE TABLE [Bank](
  [Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
  [Name] nvarchar(50) NOT NULL
) 

CREATE TABLE [City](
  [Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
  [Name] nvarchar(50) NOT NULL
)

CREATE TABLE [Branch](
	[Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
	[CityId] uniqueidentifier NOT NULL,
	[BankId] uniqueidentifier NOT NULL
)

CREATE TABLE [Status](
  [Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
  [Name] nvarchar(50) NOT NULL 
) 

CREATE TABLE [Client](
  [Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
  [Name] nvarchar(50) NOT NULL,
  [Surname] nvarchar(50) NOT NULL,
  [Birthday] date NOT NULL,
  [StatusId] uniqueidentifier NOT NULL
) 

CREATE TABLE [Account](
  [Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
  [BankId] uniqueidentifier NOT NULL,
  [ClientId] uniqueidentifier NOT NULL,
  [Amount] money NOT NULL
)

CREATE UNIQUE NONCLUSTERED INDEX UX_Account_BankClient
ON Account (BankId, ClientId);

CREATE TABLE [Card](
  [Id] uniqueidentifier PRIMARY KEY DEFAULT newid(),
  [Number] char(16) NOT NULL,
  [CVV] char(3) NOT NULL,
  [EndDate] date NOT NULL,
  [Money] money NOT NULL,
  [AccountId] uniqueidentifier NOT NULL
) 

ALTER TABLE [Client] ADD CONSTRAINT [FK_Client_Status] FOREIGN KEY([StatusId])
REFERENCES [Status]([Id])

ALTER TABLE [Branch] WITH CHECK ADD CONSTRAINT [FK_Branch_Bank] FOREIGN KEY([BankId])
REFERENCES [Bank]([Id])

ALTER TABLE [Branch] WITH CHECK ADD CONSTRAINT [FK_Branch_City] FOREIGN KEY([CityId])
REFERENCES [City]([Id])

ALTER TABLE [Card] ADD CONSTRAINT [FK_Card_Account] FOREIGN KEY([AccountId])
REFERENCES [Account]([Id])

ALTER TABLE [Account] ADD CONSTRAINT [FK_Account_Bank] FOREIGN KEY([BankId])
REFERENCES [Bank]([Id])

ALTER TABLE [Account] ADD CONSTRAINT [FK_Account_Client] FOREIGN KEY([ClientId])
REFERENCES [Client]([Id])

----- INSERT ------

INSERT INTO [Bank] ([Name]) VALUES('AlphaBank')
INSERT INTO [Bank] ([Name]) VALUES('BelarusBank')
INSERT INTO [Bank] ([Name]) VALUES('Belinvest')
INSERT INTO [Bank] ([Name]) VALUES('MTB')
INSERT INTO [Bank] ([Name]) VALUES('PriorBank')
INSERT INTO [Bank] ([Name]) VALUES('IdeaBank')

INSERT INTO [City] ([Name]) VALUES('Minsk')
INSERT INTO [City] ([Name]) VALUES('Warshava')
INSERT INTO [City] ([Name]) VALUES('Brest')
INSERT INTO [City] ([Name]) VALUES('Gomel')
INSERT INTO [City] ([Name]) VALUES('Paris')

DECLARE @idMinsk uniqueidentifier
SELECT @idMinsk = Id FROM City WHERE [Name] = 'Minsk'
DECLARE @idBrest uniqueidentifier
SELECT @idBrest = Id FROM City WHERE [Name] = 'Brest'
DECLARE @idGomel uniqueidentifier
SELECT @idGomel = Id FROM City WHERE [Name] = 'Gomel'
DECLARE @idBelarusBank uniqueidentifier
SELECT @idBelarusBank = Id FROM Bank WHERE [Name] = 'BelarusBank'
DECLARE @idAlpha uniqueidentifier
SELECT @idAlpha = Id FROM Bank WHERE [Name] = 'AlphaBank'
DECLARE @idBelinvest uniqueidentifier
SELECT @idBelinvest = Id FROM Bank WHERE [Name] = 'Belinvest'
DECLARE @idPriorBank uniqueidentifier
SELECT @idPriorBank = Id FROM Bank WHERE [Name] = 'PriorBank'

INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idMinsk, @idBelarusBank)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idMinsk, @idAlpha)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idMinsk, @idPriorBank)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idMinsk, @idBelinvest)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idBrest, @idBelarusBank)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idBrest, @idAlpha)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idGomel, @idBelinvest)
INSERT INTO [Branch]([CityId],[BankId]) VALUES (@idGomel, @idPriorBank)

INSERT INTO [Status] ([Name]) VALUES('Normal')
INSERT INTO [Status] ([Name]) VALUES('Pensioner')
INSERT INTO [Status] ([Name]) VALUES('Disable')
INSERT INTO [Status] ([Name]) VALUES('Parasite')
INSERT INTO [Status] ([Name]) VALUES('Dead')


DECLARE @idNormal uniqueidentifier
SELECT @idNormal = Id FROM [Status] WHERE [Name] = 'Normal'
DECLARE @idDisable uniqueidentifier
SELECT @idDisable = Id FROM [Status] WHERE [Name] = 'Disable'
DECLARE @idPensioner uniqueidentifier
SELECT @idPensioner = Id FROM [Status] WHERE [Name] = 'Pensioner'

INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Vladislav','Mazur', '2001-05-15', @idNormal)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Andrei','Sherb', '2002-12-14', @idNormal)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Vladimir','Poroh', '2001-09-25', @idPensioner)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Alexei','Yasen', '2002-07-15', @idDisable)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Valeria','Gurskaya', '2001-05-04', @idNormal)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Petr','Zubovich', '1989-01-01', @idDisable)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Igor','Areshko', '1991-09-09', @idPensioner)
INSERT INTO [Client] ([Name],[Surname],[Birthday],[StatusId]) VALUES('Semen','Topalov', '1999-03-19', @idPensioner)

DECLARE @idVlad uniqueidentifier
SELECT @idVlad = Id FROM [Client] WHERE [Name] = 'Vladislav'
DECLARE @idAndrei uniqueidentifier
SELECT @idAndrei = Id FROM [Client] WHERE [Name] = 'Andrei'
DECLARE @idVolodya uniqueidentifier
SELECT @idVolodya = Id FROM [Client] WHERE [Name] = 'Vladimir'
DECLARE @idIgor uniqueidentifier
SELECT @idIgor = Id FROM [Client] WHERE [Name] = 'Igor'
DECLARE @idLera uniqueidentifier
SELECT @idLera = Id FROM [Client] WHERE [Name] = 'Valeria'
DECLARE @idSema uniqueidentifier
SELECT @idSema = Id FROM [Client] WHERE [Name] = 'Semen'
DECLARE @idLesha uniqueidentifier
SELECT @idLesha = Id FROM [Client] WHERE [Name] = 'Alexei'


INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idBelinvest, @idVlad, 3200.50)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idBelarusBank, @idVlad, 0.0)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idPriorBank, @idAndrei, 10200.67)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idPriorBank, @idVolodya, 0.0)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idBelinvest, @idIgor, 1598.67)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idAlpha, @idLera, 1400.87)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idBelarusBank, @idLera, 0.0)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idPriorBank, @idLera, 0.0)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idBelinvest, @idSema, 5000)
INSERT INTO [Account] ([BankId],[ClientId],[Amount]) VALUES(@idAlpha, @idLesha, 2789.89)

GO
CREATE VIEW FullAccounts AS
SELECT Account.Id as IdAcc, Bank.Name as BankName, Client.Name as ClientName, Client.Surname as ClientSurname 
FROM Account INNER JOIN Bank ON Bank.Id = Account.BankId INNER JOIN Client ON Client.Id = Account.ClientId
GO

DECLARE @idVladAcc uniqueidentifier
SELECT @idVladAcc = [idAcc] FROM [FullAccounts] WHERE [ClientName] = 'Vladislav' and [BankName] = 'Belinvest'
DECLARE @idLeraAcc uniqueidentifier
SELECT @idLeraAcc = [idAcc] FROM [FullAccounts] WHERE [ClientName] = 'Valeria' and [BankName] = 'AlphaBank'
DECLARE @idLeshaAcc uniqueidentifier
SELECT @idLeshaAcc = [idAcc] FROM [FullAccounts] WHERE [ClientName] = 'Alexei' and [BankName] = 'AlphaBank'
DECLARE @idIgorAcc uniqueidentifier
SELECT @idIgorAcc = [idAcc] FROM [FullAccounts] WHERE [ClientName] = 'Igor' and [BankName] = 'Belinvest'
DECLARE @idSemenAcc uniqueidentifier
SELECT @idSemenAcc = [idAcc] FROM [FullAccounts] WHERE [ClientName] = 'Semen' and [BankName] = 'Belinvest'
DECLARE @idAndreiAcc uniqueidentifier
SELECT @idAndreiAcc = [idAcc] FROM [FullAccounts] WHERE [ClientName] = 'Andrei' and [BankName] = 'PriorBank'

INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('8971564389715643','142','2023-05-01',400.60,@idVladAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('6217636726376723','522','2025-09-01',1400.87,@idLeraAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('1678764378347567','370','2024-06-01',2456.66,@idLeshaAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('7863256736567235','222','2024-09-01',1598.67,@idIgorAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('1125674356756374','567','2025-01-01',3400.13,@idSemenAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('6754647689012983','666','2024-08-01',1257.89,@idAndreiAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('5675629844301254','499','2024-01-01',2650.60,@idVladAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('9992388827338273','672','2023-05-01',8467.99,@idAndreiAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('4673468365757745','609','2025-02-01',234.09,@idLeshaAcc)
INSERT INTO [Card] ([Number],[CVV],[EndDate],[Money],[AccountId])VALUES('9992388827338273','109','2025-09-01',846.37,@idSemenAcc)

--- SELECTS ---

------ 1 
SELECT DISTINCT Bank.Name FROM Bank 
	INNER JOIN Branch ON Branch.BankId = Bank.Id 
	INNER JOIN City ON City.Id = Branch.CityId 
	Where City.Name = 'Minsk'

------ 2
SELECT Client.Name AS [Name], Client.Surname AS Surname, Bank.Name AS Bank, Card.Number AS Number, Card.Money AS [Money] FROM Card
	INNER JOIN Account ON Account.Id = Card.AccountId
	INNER JOIN Bank ON Account.BankId = Bank.Id
	INNER JOIN Client ON Account.ClientId = Client.Id

------ 3
SELECT Account.Id, Bank.Name, (Account.Amount - SUM(Card.Money)) AS DIFF FROM Account
	INNER JOIN Bank ON Bank.Id = Account.BankId
	LEFT JOIN Card ON Card.AccountId = Account.Id
	GROUP BY Account.Id, Account.Amount, Bank.Name
	HAVING (Account.Amount - SUM(Card.Money)) != 0

------ 4.1 (Group By)
SELECT Status.Name as [Status], COUNT(Card.Id) as CardsAmount FROM Status 
	LEFT JOIN Client ON Status.Id = Client.StatusId
	LEFT JOIN Account ON Account.ClientId = Client.Id
	LEFT JOIN Card ON Card.AccountId = Account.Id
	LEFT JOIN Bank ON Bank.Id = Account.BankId 
	GROUP BY Status.Name

------ 4.2 
SELECT STAT.Name AS [Status], 
	(SELECT COUNT(Card.Id) AS CardsAmount FROM Status 
	LEFT JOIN Client ON Status.Id = Client.StatusId
	LEFT JOIN Account ON Account.ClientId = Client.Id
	LEFT JOIN Card ON Card.AccountId = Account.Id
	LEFT JOIN Bank ON Bank.Id = Account.BankId 
	WHERE Status.Name = STAT.Name) AS CardsAmount
	FROM STATUS AS STAT
GO
------ 5 

-- CREATE PROCEDURE
CREATE PROCEDURE AddTen
    @idStatus uniqueidentifier
AS
	IF (SELECT COUNT(Status.Id) FROM [STATUS] WHERE Status.Id = @idStatus) = 0
		PRINT 'Ststus is does not exist!'
	IF (SELECT COUNT(Status.Id) FROM Status
		INNER JOIN Client ON Client.StatusId = Status.Id
		INNER JOIN Account ON Account.ClientId = Client.Id
		WHERE Status.Id = @idStatus) = 0
		PRINT 'There is no accounts with this status'
	ELSE
	UPDATE Account SET Account.Amount = Account.Amount + 10.0 FROM Status
		INNER JOIN Client ON Client.StatusId = Status.Id
		INNER JOIN Account ON Account.ClientId = Client.Id
		WHERE Status.Id = @idStatus


-- SELECT TO CHECK, USE BEFORE AND AFTER PROCEDURE
SELECT Status.Name, Client.Name, Client.Surname, Account.Amount FROM Status
		INNER JOIN Client ON Client.StatusId = Status.Id
		INNER JOIN Account ON Account.ClientId = Client.Id
		WHERE Status.Name = 'Pensioner'

-- Execute procedure
DECLARE @idPensStatus uniqueidentifier
SELECT @idPensStatus = Id FROM [Status] WHERE [Name] = 'Pensioner'

-- Use procedure
EXEC AddTen @idPensStatus

-- SELECT TO CHECK, USE BEFORE AND AFTER PROCEDURE
SELECT Status.Name, Client.Name, Client.Surname, Account.Amount FROM Status
		INNER JOIN Client ON Client.StatusId = Status.Id
		INNER JOIN Account ON Account.ClientId = Client.Id
		WHERE Status.Name = 'Pensioner'

-------- 6

SELECT Client.Name, Client.Surname, (SUM(Account.Amount) - SUM(Card.Money)) AS Available FROM Client 
	INNER JOIN Account ON Account.ClientId = Client.Id
	INNER JOIN Card ON Card.AccountId = Account.Id
	GROUP BY Client.Name, Client.Surname
GO
-------- 7

-- CREATE PROCEDURE
CREATE PROCEDURE AddMoneyOnCard
    @idAccount uniqueidentifier,
	@idCard uniqueidentifier,
	@value money
AS
	DECLARE @availableValue money
	SELECT @availableValue = (Account.Amount - SUM (Card.Money))  FROM Account 
	INNER JOIN Card ON Card.AccountId = Account.Id
	GROUP BY Account.Id, Account.Amount
	HAVING Account.Id = @idAccount

	IF @availableValue >= @value 
		UPDATE [CARD] SET [MONEY] = [MONEY] + @value WHERE CARD.Id = @idCard  
	ELSE 
		PRINT 'Not enought money'
GO

-- SELECT TO CHECK, USE BEFORE AND AFTER PROCEDURE
SELECT Account.Id AS idAccount, Client.Name, Client.Surname, Account.Amount, Bank.Name, Card.Money FROM CARD 
	INNER JOIN ACCOUNT ON Account.Id = CARD.AccountId
	INNER JOIN Client ON Client.Id = Account.ClientId
	INNER JOIN BANK ON Bank.Id = Account.BankId
	WHERE Card.Number = '8971564389715643'

-- EXEC PROCEDURE POINT
DECLARE @idAcc uniqueidentifier
DECLARE @idBankCard uniqueidentifier

SELECT @idAcc = Account.Id FROM Client
	INNER JOIN Account ON Account.ClientId = Client.Id
	INNER JOIN Bank ON Bank.Id = Account.BankId
	WHERE Client.Name = 'Vladislav' and Bank.Name = 'Belinvest'

SELECT @idBankCard = Card.Id FROM Client
	INNER JOIN Account ON Account.ClientId = Client.Id
	INNER JOIN Bank ON Bank.Id = Account.BankId
	INNER JOIN Card ON Card.AccountId = Account.Id
	WHERE Card.Number = '8971564389715643'

EXEC AddMoneyOnCard @idAcc, @idBankCard, 40.0

-- SELECT TO CHECK, USE BEFORE AND AFTER PROCEDURE
SELECT Account.Id AS idAccount, Client.Name, Client.Surname, Account.Amount, Bank.Name, Card.Money FROM CARD 
	INNER JOIN ACCOUNT ON Account.Id = CARD.AccountId
	INNER JOIN Client ON Client.Id = Account.ClientId
	INNER JOIN BANK ON Bank.Id = Account.BankId
	WHERE Card.Number = '8971564389715643'
GO

------ 8

CREATE TRIGGER Account_Update
ON [ACCOUNT]
INSTEAD OF UPDATE
AS
DECLARE @newValue money
DECLARE @accId uniqueidentifier
SELECT @newValue = amount, @accId = Id FROM inserted
IF (SELECT SUM(Card.Money) FROM Card 
		INNER JOIN Account ON Account.Id = Card.AccountId
		GROUP BY Account.Id
		HAVING Account.Id = @accId) < @newValue
	UPDATE [ACCOUNT] SET Amount = @newValue WHERE Account.Id = @accId
ELSE
	PRINT 'Cannot set value, that greatest than sum of cards money!'

-- Update to check Trigger
UPDATE [Account] SET Amount = 0.0 WHERE Amount = 3200.50
GO

-- Second trigger
CREATE TRIGGER Card_Update
ON [CARD]
INSTEAD OF UPDATE
AS
DECLARE @idAcc uniqueidentifier
DECLARE @idCard uniqueidentifier
DECLARE @newMoney money
DECLARE @oldMoney money
DECLARE @sumMoney money
SELECT @idAcc = AccountId, @idCard = Id, @newMoney = [MONEY] FROM inserted
SELECT @sumMoney = SUM([MONEY]) FROM Card 
	INNER JOIN Account ON Card.AccountId = Account.Id
	GROUP BY Account.Id
	HAVING Account.Id = @idAcc
SELECT @oldMoney = [Money] FROM deleted
SET @sumMoney = @sumMoney - @oldMoney + @newMoney
IF (SELECT AMOUNT FROM ACCOUNT WHERE Id = @idAcc) > @sumMoney
	UPDATE [CARD] SET [MONEY] = @newMoney WHERE Id = @idCard
ELSE 
	PRINT 'Sum on cards cannot be greatest, that amount on account!'


-- Update to check trigger
UPDATE CARD SET Money = 1698.67 WHERE Number = '7863256736567235'