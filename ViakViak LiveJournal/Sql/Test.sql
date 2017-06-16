-- Test

IF Object_ID(N'dbo.Entity') IS NOT NULL
	DROP TABLE dbo.Entity
GO
IF Object_ID(N'dbo.CollectionItem') IS NOT NULL
	DROP TABLE dbo.CollectionItem
GO
-- Drop indexes
IF OBJECT_ID('IX_CollectionItem') IS NOT NULL
	DROP PROCEDURE dbo.IX_CollectionItem
GO
-- Drop stored procedures..
IF OBJECT_ID('spAddItem') IS NOT NULL
	DROP PROCEDURE dbo.spAddItem
GO
IF OBJECT_ID('spAddTranslation') IS NOT NULL
	DROP PROCEDURE dbo.spAddTranslation
GO
IF OBJECT_ID('IsTypeOf') IS NOT NULL
	DROP FUNCTION dbo.IsTypeOf
GO
CREATE TABLE dbo.Entity (
	EntityID int IDENTITY(1,1) NOT NULL,
	TypeID int NOT NULL, -- EntityID of type
	CreatedOn datetime2(7) default(getdate()),
	CreatedByID int NULL,
	ModifiedOn datetime2(7) NULL,
	ModifiedByID int NULL,
	LanguageID int NULL, -- EntityID of language
	Translation nvarchar(max) NULL,
	Translation2 nvarchar(max) NULL,
	Translation3 nvarchar(max) NULL,
	Translation4 nvarchar(max) NULL,
	Int1 integer NULL,
	Int2 integer NULL,
	Int3 integer NULL,
	Int4 integer NULL,
	dt1 datetime2(7) NULL,
	dt2 datetime2(7) NULL,
	money1 money NULL,
	money2 money NULL

	CONSTRAINT PK_Entity PRIMARY KEY CLUSTERED (
		EntityID ASC,
		TypeID ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE dbo.CollectionItem (
	CollectionItemID int NOT NULL identity(1, 1), -- collection item primary key
	CollectionID int NOT NULL, -- collection EntityID
	CollectionTypeID int NOT NULL, -- collection type EntityID
	ItemID int NULL, -- item EntityID
	ItemTypeID int NULL, -- item type EntityID
	OrderIndex int default(0),
	CreatedOn datetime2(7) default(getdate()),
	CreatedByID int NULL

	CONSTRAINT PK_CollectionItem PRIMARY KEY CLUSTERED (
		CollectionItemID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_CollectionItem ON dbo.CollectionItem(CollectionID, ItemID) INCLUDE(CollectionTypeID, ItemTypeID);
GO

-- Stored Procedures

CREATE PROCEDURE spAddItem
	@collectionID int, -- entity id of collection
	@itemID int, -- entity id of item
	@collectionTypeID int = NULL, -- optional entity id of the collection type
	@itemTypeID int = NULL, -- optional entity id of item type
	@orderIndex int = NULL -- optional order index of new item
AS
	begin
	SET NOCOUNT ON;

	DECLARE @orderIndexMax int = 0;

	if @collectionTypeID IS NULL
		SELECT @collectionTypeID = TypeID FROM dbo.Entity WHERE EntityID = @collectionID;
	if @itemTypeID IS NULL
		SELECT @itemTypeID = TypeID FROM dbo.Entity WHERE EntityID = @itemID;
	if @collectionTypeID = 5 -- List
		begin
		SELECT @orderIndexMax = MAX(OrderIndex) FROM dbo.CollectionItem WHERE CollectionID = @collectionID;
		if @orderIndex IS NULL OR @orderIndex < 0 OR @orderIndex > @orderIndexMax -- add..
			SET @orderIndex = @orderIndexMax;
		else -- reorder the end of the list..
			UPDATE dbo.CollectionItem SET OrderIndex = OrderIndex + 1 WHERE CollectionID = @collectionID AND OrderIndex > @orderIndex;
		end
	INSERT INTO dbo.CollectionItem(CollectionID, CollectionTypeID, ItemID, ItemTypeID, OrderIndex)
		VALUES(@collectionID, @collectionTypeID, @itemID, @itemTypeID, @orderIndex);
	return 0;
	end
GO

/*
	Adds translation of the same type as the specified existing item
	Returns Collection ID or negative incorrect argument number
*/
CREATE PROCEDURE spAddTranslation
	@translationOfID int,
	@translationLanguageID int,
	@translation nvarchar(max)
AS
	begin
	DECLARE @translationTypeID int = 4;
	DECLARE @itemTypeID int;
	DECLARE @collectionID int;
	DECLARE @newItemID int;

	SET NOCOUNT ON;

	if @translationOfID IS NULL OR @translationOfID <= 0
		return -1;
	if @translationLanguageID IS NULL OR @translationLanguageID <= 0
		return -2;
	if @translation IS NULL OR LEN(@translation) <= 0
		return -3;

	SELECT	@collectionID = CollectionID, @itemTypeID = ItemTypeID
	FROM	dbo.CollectionItem
	WHERE	ItemID = @translationOfID AND
			CollectionTypeID = @translationTypeID;

	if @itemTypeID IS NULL
		SELECT @itemTypeID = TypeID FROM dbo.Entity WHERE EntityID = @translationOfID;

	if @collectionID IS NULL
		begin
		INSERT INTO dbo.Entity(TypeID) VALUES(@translationTypeID);
		SET @collectionID = @@IDENTITY;

		exec spAddItem @collectionID, @translationOfID, @translationTypeID, @itemTypeID;
		end

	INSERT INTO dbo.Entity(TypeID, LanguageID, Translation) VALUES (@itemTypeID, @translationLanguageID, @translation);
	SET @newItemID = @@IDENTITY;

	exec spAddItem @collectionID, @newItemID, @translationTypeID, @itemTypeID;
	return @collectionID;
	end
GO

/*	-- Tests:
	SELECT 5, 3, dbo.IsTypeOf(5, 3);
	SELECT 5, 1, dbo.IsTypeOf(5, 1);
	SELECT NULL, 1, dbo.IsTypeOf(NULL, 1);
	SELECT 1001, 2, dbo.IsTypeOf(1001, 2);
*/
CREATE FUNCTION IsTypeOf(
	@entityID as int,
	@typeID as int
) returns bit as
	begin
	if @entityID IS NULL OR @typeID IS NULL
		return 0;
	if @typeID = 1
		return 1;

	DECLARE @entityTypeID as int = NULL;

	while 1=1
		begin
		SELECT @entityTypeID = TypeID FROM dbo.Entity WHERE EntityID = @entityID;
		if @entityTypeID IS NULL OR @entityTypeID < @typeID
			return 0;

		if @entityTypeID = @typeID
			return 1;
		SET @entityID = @entityTypeID;
		end
	
	return 0;
	end
GO

SET IDENTITY_INSERT dbo.Entity ON
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (1, 1, N'Type');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (2, 1, N'Language');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (3, 1, N'Collection'); -- collection of items
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (4, 3, N'Translation');-- collection of translations
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (5, 3, N'List');-- ordered collection

INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (101, 1, N'Article');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (102, 1, N'Label');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (103, 1, N'Word');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (104, 1, N'Component');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (105, 104, N'Root');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (106, 104, N'Prefix');
---- Languages
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (1001, 2, N'English');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (1002, 2, N'Russian');
---- Bundle types
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (10001, 3, N'ArticleLabel');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (10002, 3, N'ArticleWord');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (10003, 3, N'ComponentWord');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (10004, 3, N'RootWord');
INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (10005, 3, N'PrefixWord');

INSERT INTO dbo.Entity (EntityID, TypeID, Translation) VALUES (10000, 2, N'System');

SET IDENTITY_INSERT dbo.Entity OFF
GO

-- Translations
exec dbo.spAddTranslation 1, 1002, N'Тип'; -- Type in Russian
exec dbo.spAddTranslation 2, 1002, N'Язык'; -- Language in Russian
exec dbo.spAddTranslation 3, 1002, N'Коллекция'; -- Collection in Russian
exec dbo.spAddTranslation 4, 1002, N'Перевод'; -- Translation in Russian
exec dbo.spAddTranslation 101, 1002, N'Статья'; -- Article in Russian
exec dbo.spAddTranslation 102, 1002, N'Метка'; -- Label in Russian
exec dbo.spAddTranslation 102, 1002, N'Ярлык'; -- Label in Russian
exec dbo.spAddTranslation 103, 1002, N'Слово'; -- Word in Russian
exec dbo.spAddTranslation 104, 1002, N'Компонента'; -- Component in Russian
exec dbo.spAddTranslation 105, 1002, N'Корень'; -- Root in Russian
exec dbo.spAddTranslation 106, 1002, N'Приставка'; -- Prefix in Russian
exec dbo.spAddTranslation 106, 1002, N'Префих'; -- Prefix in Russian
exec dbo.spAddTranslation 1001, 1002, N'Английский'; -- English in Russian
exec dbo.spAddTranslation 1002, 1002, N'Русский'; -- Russian in Russian
GO
