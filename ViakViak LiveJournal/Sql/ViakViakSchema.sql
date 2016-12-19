-- ViakViak Schema
-- C:\Users\vroyt\Documents\SQL Server Management Studio\ViakViakSchema.sql

-- Drop foreign keys..
IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleLabel_Label]'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleLabel DROP CONSTRAINT [FK_ArticleLabel_Label]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleLabel_Article]'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleLabel DROP CONSTRAINT [FK_ArticleLabel_Article]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleWord_Word]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[ArticleWord] DROP CONSTRAINT [FK_ArticleWord_Word]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleWord_Article]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[ArticleWord] DROP CONSTRAINT [FK_ArticleWord_Article]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_Root_Language]'), 'IsConstraint') = 1
	ALTER TABLE dbo.[Root] DROP CONSTRAINT [FK_Root_Language]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_Word_Root]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[Word] DROP CONSTRAINT [FK_Word_Root]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_Word_Language]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[Word] DROP CONSTRAINT [FK_Word_Language]
GO

-- Drop tables..
/****** Object:  Table dbo.Article    Script Date: 9/5/2016 6:20:20 PM ******/
IF OBJECT_ID(N'dbo.Article', N'U') IS NOT NULL
	DROP TABLE dbo.Article
GO

/****** Object:  Table dbo.ArticleLabel    Script Date: 9/5/2016 7:03:55 PM ******/
IF OBJECT_ID(N'dbo.ArticleLabel', N'U') IS NOT NULL
	DROP TABLE dbo.ArticleLabel
GO

/****** Object:  Table dbo.[Root]    Script Date: 9/5/2016 6:53:21 PM ******/
IF OBJECT_ID(N'dbo.Article', N'U') IS NOT NULL
	DROP TABLE dbo.[Root]
GO

/****** Object:  Table [dbo].[ArticleWord]    Script Date: 9/5/2016 7:09:18 PM ******/
IF OBJECT_ID(N'dbo.ArticleWord', N'U') IS NOT NULL
	DROP TABLE [dbo].[ArticleWord]
GO

/****** Object:  Table [dbo].[Label]    Script Date: 9/5/2016 7:12:58 PM ******/
IF OBJECT_ID(N'dbo.Label', N'U') IS NOT NULL
	DROP TABLE [dbo].[Label]
GO

/****** Object:  Table dbo.[Language]    Script Date: 9/5/2016 6:51:52 PM ******/
IF OBJECT_ID(N'dbo.Language', N'U') IS NOT NULL
	DROP TABLE dbo.[Language]
GO

/****** Object:  Table dbo.[Root]    Script Date: 9/5/2016 6:53:21 PM ******/
IF OBJECT_ID(N'dbo.Root', N'U') IS NOT NULL
	DROP TABLE [dbo].[Root]
GO
/****** Object:  Table [dbo].[Word]    Script Date: 9/5/2016 7:14:14 PM ******/
IF OBJECT_ID(N'dbo.Word', N'U') IS NOT NULL
	DROP TABLE [dbo].[Word]
GO

-- Drop stored procedures..
IF OBJECT_ID('spAddArticle', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spAddArticle]	
GO

-- Create tables..
/****** Object:  Table dbo.Article    Script Date: 9/5/2016 6:20:20 PM ******/
CREATE TABLE dbo.Article(
	[ArticleID] [int] IDENTITY(1,1) NOT NULL,
	LiveJournalID [int] NULL,
	Title [nvarchar](256) NULL,
	Content [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table dbo.ArticleLabel    Script Date: 9/5/2016 7:03:55 PM ******/
CREATE TABLE dbo.ArticleLabel(
	[ArticleLabelID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NOT NULL,
	[LabelID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_ArticleLabel] PRIMARY KEY CLUSTERED 
(
	[ArticleLabelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ArticleWord]    Script Date: 9/5/2016 7:09:18 PM ******/
CREATE TABLE [dbo].[ArticleWord](
	[ArticleWordID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NOT NULL,
	[WordID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_ArticleWord] PRIMARY KEY CLUSTERED 
(
	[ArticleWordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Label]    Script Date: 9/5/2016 7:12:58 PM ******/
CREATE TABLE [dbo].[Label](
	[LabelID] [int] IDENTITY(1,1) NOT NULL,
	LabelName [nvarchar](50) NOT NULL,
	LanguageID [int] NULL DEFAULT 1,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Label] PRIMARY KEY CLUSTERED 
(
	[LabelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table dbo.[Language]    Script Date: 9/5/2016 6:51:52 PM ******/
CREATE TABLE dbo.[Language](
	LanguageID [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	LanguageID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table dbo.[Root]    Script Date: 9/5/2016 6:53:21 PM ******/
CREATE TABLE dbo.[Root](
	[RootID] [int] IDENTITY(1,1) NOT NULL,
	[RootName] [nvarchar](12) NULL,
	LanguageID [int] NULL DEFAULT 1,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Root] PRIMARY KEY CLUSTERED 
(
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Word]    Script Date: 9/5/2016 7:14:14 PM ******/
CREATE TABLE [dbo].[Word](
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[WordName] [nvarchar](128) NOT NULL,
	LanguageID [int] NULL DEFAULT 1,
	[RootID] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Word] PRIMARY KEY CLUSTERED 
(
	[WordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Create foreign keys..
ALTER TABLE dbo.ArticleLabel  WITH CHECK ADD  CONSTRAINT [FK_ArticleLabel_Article] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleLabel CHECK CONSTRAINT [FK_ArticleLabel_Article]
GO

ALTER TABLE dbo.ArticleLabel  WITH CHECK ADD  CONSTRAINT [FK_ArticleLabel_Label] FOREIGN KEY([LabelID])
REFERENCES [dbo].[Label] ([LabelID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleLabel CHECK CONSTRAINT [FK_ArticleLabel_Label]
GO

ALTER TABLE [dbo].[ArticleWord]  WITH CHECK ADD  CONSTRAINT [FK_ArticleWord_Article] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleWord] CHECK CONSTRAINT [FK_ArticleWord_Article]
GO

ALTER TABLE [dbo].[ArticleWord]  WITH CHECK ADD  CONSTRAINT [FK_ArticleWord_Word] FOREIGN KEY([WordID])
REFERENCES [dbo].[Word] ([WordID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleWord] CHECK CONSTRAINT [FK_ArticleWord_Word]
GO

ALTER TABLE dbo.[Root]  WITH CHECK ADD  CONSTRAINT [FK_Root_Language] FOREIGN KEY(LanguageID)
REFERENCES [dbo].[Language] (LanguageID)
GO
ALTER TABLE dbo.[Root] CHECK CONSTRAINT [FK_Root_Language]
GO

ALTER TABLE [dbo].[Word]  WITH CHECK ADD  CONSTRAINT [FK_Word_Language] FOREIGN KEY(LanguageID)
REFERENCES [dbo].[Language] (LanguageID)
GO
ALTER TABLE [dbo].[Word] CHECK CONSTRAINT [FK_Word_Language]
GO

ALTER TABLE [dbo].[Word]  WITH CHECK ADD  CONSTRAINT [FK_Word_Root] FOREIGN KEY([RootID])
REFERENCES [dbo].[Root] ([RootID])
GO
ALTER TABLE [dbo].[Word] CHECK CONSTRAINT [FK_Word_Root]
GO

-- stored procedures
-- =============================================
-- Author:		ViakViak
-- Create date: 11/12/2016
-- Description:	Adds Article data
-- =============================================
CREATE PROCEDURE spAddArticle 
	@liveJournalID int, 
	@title nvarchar(1024) = NULL,
	@labels nvarchar(2048) = NULL, -- comma separated labels
	@content nvarchar(max) = NULL
AS
begin
DECLARE @articleID int;
DECLARE @posStart int = 1;
DECLARE @posStop int = 0;
DECLARE @length int;
DECLARE @lbl nvarchar(128);
DECLARE @labelID int;

SET NOCOUNT ON;

SELECT @articleID = ArticleID FROM dbo.Article WHERE LiveJournalID = @liveJournalID;
if @articleID IS NULL
	begin
	INSERT INTO dbo.Article(LiveJournalID, Title, Content) VALUES (@liveJournalID, @title, @content);
	SET @articleID = @@IDENTITY;
	end
else if @content IS NOT NULL
	UPDATE dbo.Article SET Content = @content WHERE ArticleID = @articleID;

if @labels IS NOT NULL
	begin -- labels..
	DELETE FROM dbo.ArticleLabel WHERE ArticleID = @articleID;

	SET @labels = LTRIM(RTRIM(@labels));
	SET @length = LEN(@labels);
	while @posStop < @length
		begin
		SET @posStop = CHARINDEX(N',', @labels, @posStart);
		if @posStop = 0 -- not found
			SET @posStop = @length + 1;-- end of line
		SET @lbl = LTRIM(RTRIM(SUBSTRING(@labels, @posStart, @posStop - @posStart)));
		if LEN(@lbl) > 0
			begin
			SELECT @labelID = LabelID FROM dbo.Label WHERE LabelName = @lbl;
			if @labelID IS NOT NULL
				INSERT INTO dbo.ArticleLabel(ArticleID, LabelID) VALUES (@articleID, @labelID);
			end
		SET @posStart = @posStop + 1;
		end
	end
end
GO

-- data..
INSERT INTO dbo.[Language](LanguageName, [Description]) VALUES (N'Russian', NULL); -- 1
INSERT INTO dbo.[Language](LanguageName, [Description]) VALUES (N'English', NULL); -- 2

INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'english', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'livejournal', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'usa', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'welcome', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Англия', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'бог', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Вашкевич', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Венеция', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'время', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'вяк', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'геральдика', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'государство', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'деньги', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'долг', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'еда', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'закон', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'имя', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Изобретение', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'история', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'книга', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'компания', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'материя', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'мера', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'мнение', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'музыка', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'общество', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'оружие', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'перевод', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'переход', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'программа', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'свобода', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'символ', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'слова', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'смерть', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'спорт', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'тело', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'технология', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'титул', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'торговля', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'шутка', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'эзотерика', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'экономика', 1, NULL);

-- <lj-cut>
-- INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (, N'');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (41271, N'Что в имени твоем: Трамп');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40970, N'Что в имени твоем: Волга');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40952, N'Self-Interest and Ignorance');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40640, N'Что в имени твоем: Цуцик');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40280, N'Что в имени твоем: Двигать');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39939, N'Что в имени твоем: Плюс');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39863, N'Прямой перевод: Advise - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39647, N'Переход Р - Л');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39200, N'Что в имени твоем: Свет');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39064, N'Что в имени твоем: Пешка');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (38894, N'Что в имени твоем: Пехота');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (38489, N'Что в имени твоем: Путин');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (38363, N'Что в имени твоем: Челси');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37986, N'Переход Г - Ж');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37656, N'Прямой перевод: Grill - direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37588, N'Вымышленный "Братан" Алексея Николаевича Толстого');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37275, N'Переход Д - Ж');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36922, N'Что в имени твоем: Дорога');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36629, N'Переход Г - Р (грассирование)');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36515, N'Прямой перевод: Water - direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36138, N'Что в имени твоем: Суворов');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (35913, N'Что в имени твоем: Шалава');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (35667, N'Что в имени твоем: Шмокодявка');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (35512, N'Прямой перевод: Severe Weather - direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34907, N'Что в имени твоем: Бетон');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34907, N'Что в имени твоем: Пирог');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34642, N'Переход: С - Ш (шепелявость)');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34476, N'Переход: Т - Ф');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34092, N'Что в имени твоем: Раз, два, три, четыре, пять, шесть, семь, восемь, девять, десять');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33794, N'Что в имени твоем: Буратино');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33634, N'Переход "звонкий-глухой"');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33360, N'Переход Г - Х');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33253, N'Что в имени твоем: Курок');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32945, N'Что в имени твоем: Колобок');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32662, N'Что в имени твоем: Сковорода');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32311, N'Что в имени твоем: Музыка');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32225, N'What is in the name: Commerce - что в имени твоем');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31981, N'What is in the name: Vagina - что в имени твоем');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31712, N'Что в имени твоем: Свастика');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31341, N'What is in the name: Evening - что в имени твоем');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31060, N'What is in the name: Chocolate. Шоколад - что в имени твоем?');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30779, N'Прямой перевод: ...bourg - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30472, N'Прямой перевод: Teacher - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30351, N'Прямой перевод: Domestic - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30099, N'Что в имени твоем: Час');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29842, N'Что в имени твоем: Рана');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29617, N'Прямой перевод: Preach - Direct Translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29208, N'Переход: Ч - К');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29146, N'Прямой перевод: Path - Direct Translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28792, N'Прямой перевод: Pain - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28551, N'Прямой перeвод: Fellow - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28236, N'Прямой перевод: Bagel - direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28015, N'Прямой перевод: Given - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (27831, N'Прямой перевод: Hotel - direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (27526, N'Что в имени твоем: Времена года');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (27188, N'Что в имени твоем: Зима');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26993, N'Что в имени твоем: Совет');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26844, N'Прямой перевод: Tired - direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26397, N'Что в имени твоем: София');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26247, N'Что в имени твоем: Омар Хайам');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25986, N'Что в имени твоем: Бог');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25640, N'Что бы это значило: игра Футбол');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25435, N'Что в имени твоем: Пчела');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25093, N'Что в имени твоем: Червонный');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25067, N'Прямой перевод: Tennis - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24622, N'Прямой перевод: Volume - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24427, N'Brexit');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24284, N'Что в имени твоем: Неделя');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24060, N'Прямой перевод: Шабат (суббота)');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (23609, N'Палиндром: Йохан...');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (23421, N'Прямой перевод: Cross - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (23071, N'Прямой перевод Spark - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (22974, N'Прямой перевод: Love - Direct Translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (22632, N'Прямой перевод: Knowledge - Direct Translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (22501, N'О незаметной пропаганде бестианства. About quiet bestuality propaganda.');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (21973, N'Испанский скульптор, который владеет искусством мять камни');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (21395, N'Прямой перевод: Cattle');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (21101, N'Чтобы это значило: Учеба');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (20807, N'What is in the name: Don''t tread on me!');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (20627, N'Прямой перевод: Cost (затраты, расходы)');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (20390, N'Прямой перевод: Smart (Умный)');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19999, N'Прямой перевод: Patent (Патент)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19758, N'Что в имени твоем: цвета (colors)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19706, N'Прямой перевод: Profit (выгода)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19264, N'Прямой перевод: Revenue');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18993, N'Что в имени твоем: Глаз');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18821, N'Прямой перевод: Court	');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18520, N'Прямой перевод: Quarters (Квартира)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18274, N'Что в имени твоем: Knight');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17957, N'Что в имени твоем: Birth (рождение)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17884, N'Что в имени твоем: Рыцарь');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17527, N'Прямой перевод: Sovereign');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17282, N'Модель данных для chispa1707');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17149, N'Модель данных для chispa1707');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (16646, N'Прямой перевод: Book');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (16618, N'Свобода человека. Источник и предназначение.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (16161, N'Что в имени твоем: Персона');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15943, N'Что в имени твоем: Иберия, Европа');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15747, N'Мои словокопания: Цель, Метод и Ограничения.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15463, N'Прямой перевод: Alert');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15207, N'Прямой перевод: Rent');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (14782, N'Что в имени твоем: Держава');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (14410, N'Прямой перевод: Exit');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (14254, N'Что в имени твоем: Столица');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13982, N'Что в имени твоем: Карл Маркс, Фридрих Энгельс, Владимир Ленин');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13811, N'Что в имени твоем: Бердыш');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13513, N'Что в имени твоем: Книга');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13147, N'Что в имени твоем: Князь');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (12976, N'Что в имени твоем: Яхве, Иегова');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (12662, N'Прямой перевод: Silver - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (12290, N'System Admin');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11820, N'Что в имени твоем: Великий');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11544, N'Что в имени твоем: Единорог');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11518, N'Символ Единорога в истории');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11024, N'Что в имени твоем: Аллах');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10847, N'Что в имени твоем: Закон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10602, N'Что в имени твоем: Грифон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10325, N'Что в имени твоем: Ходжа Нассреддин');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10052, N'Что в имени твоем: Царь');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9953, N'Сарацины. Этимология');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9497, N'Что в имени твоем: Государство');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9423, N'Что в имени твоем: Зомби');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9103, N'Что в имени твоем? Cotton (хлопок)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (8744, N'Что в имени твоем: Золотой Телец.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (8418, N'Что в имени твоем: Масса');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (8020, N'Что в имени твоем: Барак Обама');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7709, N'Проект Самуила Кругляка «Получение электроэнергии из атмосферы»');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7468, N'Hardware. Что в имени?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7192, N'Software. Что в имени?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7077, N'Этому ученому удалось разгадать тайну, которую скрывают картины эпохи Возрождения');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6866, N'Слово: Этруски');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6579, N'Этруски — изгнанники');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6257, N'Переговоры о разделе б/Украины: накал противостояния');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6059, N'Понтовое ружье (The punt gun)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (5751, N'Об этимологии слова Болван');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (5574, N'Книга: Грэм Лоури. Как Венецианский вирус инфицировал и победил Англию');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (5147, N'Кому принадлежит земля в Англии?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4890, N'Книга: Дэвид Гребер. Долг: первые 5000 лет истории');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4769, N'Немножко про ОЛЬДЕНБУРГОВ, для справки...');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4423, N'Греческий язык - это Русский!');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4131, N'Человеческий мир');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4070, N'Книга: С. Г. КОРДОНСКИЙ. Сословная структура постсоветской России.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (3799, N'Мир до волны. Ч. 1. Родные Пенаты.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (3490, N'Биобетон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (3208, N'Как погибла Тартария? Часть 1.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2940, N'Развалины античной Америки');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2740, N'post');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2508, N'Повинность');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2143, N'Йер');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2029, N'Люцифер. Что в имени?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (1718, N'Программирование как контракт с дьяволом');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (1499, N'Звездный след катастрофы.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (1249, N'Стамбик ПОДСЫПАЛИ. А что заставило его ПОДСЫПАТЬ ?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (800, N'Николай Николаевич Вашкевич');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (765, N'Вяк, вяк');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (369, N'Добро пожаловать в LiveJournal');
GO

/*
<a href="http://viakviak.livejournal.com/.html" target="_blank"></a>
<a href="" target="_blank"></a>

exec spAddArticle , N'', N'', N'
<span viak="word">
</span>
';
GO

*/

exec spAddArticle 17957, N'Что в имени твоем: Birth(англ:рождение)', N'вяк, слова, экономика', N'
<span viak="word">Birth(англ:рождение)
БРТ - борт(хранилище, туловище) обрат брат(из своего"помета") брать(присваивать выброшенное) берет  brought(принес) Britain Bart(Бартоломео) Буратино буряты
ТРБ - тюрбан торба бурт(хранилище) треб[овать] труба теребить утроба tribe(племя) трибуна трибунал теребить отребье(отбросы общества) турбина(выбрасывающая) тарабарщина(выброс слов)
БРф - burf(рвота)
фРБ - Forbes
БРд - Борода дробь брод(в смысле выхода из реки) обряд(выход к гостям) bread(хлеб-выход из печи) бардачок бордель бурда(суп из отходов)
дРБ - дробь(часть выстрела, вылет из ружья) дреб[едень] дряб(лый)
вРТ - вертеть(уход/возврат) ворота(выход) virtue(высоко-моральные выступления) virtual(выдумка) [пре]врат[ить]
ТРв - трава(выросшее растение) отрава тревога(выданный сигнал, чувство) travel(выезд)
вРф - верфь(для отплытия кораблей)
фРв - форватер(для выплыва) forward(вперед отсюда)
вРв - ворвань(жир) воровать(присваивать)
вРД - выродок вред(опасное выделение) вурдалак word(высказанное слово) weird(странный, выродок) вердикт(высказывание властелина) Вердан
дРв - дерево(выросшее, растение)
пРТ - против[ник](враждебный выходец) пират(враждебный выходец из моря) порт(для отплытия кораблей) opportunity(подарок судьбы) part(часть)
ТРп - торопить(ускорять выход) терпение(ждать выход) труп(отход) troops(боевые части) терапия тропа
пРф - проффессия(умение делать, находить продукты) парафин(восковое выделение) proof(доказательство по найденному выделению?)
пРв - пров[орство] provi[de](обеспечивать продуктами) prov[ision](провизия)
вРп - warp(коробить)
пРд - продукт перед(направление выхода) парад(выход) пердеть(выпускать газы) pardon(отпустить)
дРп - drop(капля - вытекшая частица воды) драп[ать](убегать)
</span><span viak="summary">
Создается впечатление, что основной смысл корня БРТ: свойство, часть конструкции, продукт существования, выделение или направление выхода из емкости, также действия по их утилизации или присвоения.
</span><span viak="description">     
борт - хранилище, туловище
обрат - выделение назад
</span>
';
GO

exec spAddArticle 18274, N'Что в имени твоем: Knight(англ:рыцарь,кнехт)', N'вяк, история, слова, титул', N'
<span viak="word">Knight(англ:рыцарь,кнехт)

КНГ - книга king(англ:король) Конго
ГНК - гинеколог гонка gunk(англ:дрянь)
КНк - conquest конк(уренция)
гНГ - гонг гангре(на)
ЧНГ - Чинг(из) (Пе)ченеги Чинг(ачгук)
ГНч - гончая гончар
хНГ - ханыга
</span><span viak="summary">
Выглядит так, что первоначальное значение слова Knight было "ничто, нет"(герм:nichts;англ:nothing,naught,nought,no,not,nix), "из грязи", "незнатного происхождения".
</span><span viak="description">
conquest - покорение, опускание в грязь
gunk - дрянь, грязь
king(англ:король) - Чингизид, потомок Чингиз-хана
гангре(на) - грязь тела
гинеколог - копание в человеческой грязи
гонка - пачкающее занятие
гончая - быстрая, поэтому грязная
гончар - работает с глиной, грязью
книга - чтиво королей
конк(уренция) - conquest(англ:покорение)+rent(англ:плата), уронить оплату в грязь.
(Пе)ченеги - грязный народ
ханыга - грязный оборванец
Чинг(ачгук) - Чингизид, король индейцев
Чинг(из) - знаменитый выходец "из грязи"
Слово <i>Knight</i> обычно переводится как "Рыцарь", что не совсем точно.
</span><span viak="reference">
Определения Кнехт из Вики: батрак, безземельный крестьянин, наемный пехотинец незнатного происхождения, крепостной, тумба.
</span><span viak="description">
Таким образом в одном ряду с King (Чинг) и "Queen" (Чин - без "г" на конце) становится другой Чинг самомого низшего "чина", "из грязи" - Knight.

В Русской истории кроме одного очень известного Чинга (Чингиз-хана) скрывается также и другой Чинг - [Пе]ченеги. Где же обитал этот народ? Если принять во внимание, что рядом с Россией, была также и П-руссия, то похоже, что народ Пе-ченеги приходил на "Русь" из П-руссии. Сравни также со словами Поморье (рядом с морем), Прибалтика (рядом с Балтикой).

Корень КНГ-ГНК имеет смысловое значение "грязь", "ничто".
Чин - ничё, ничьё. Возможо "чин" - это ранжирование народа (в отличии от нобелей).
</span><span viak="reference">Из Вики:

Кнехт (морской термин) (чаще мн. Кнехты, устар. кнек; от нидерл. knecht) — парная тумба с общим основанием на палубе судна или на причале для крепления тросов.
Кнехт (крепостной) (от нем. Knecht) — крепостной в средневековой Германии.
Кнехт (от нем. Knecht) — наемный пехотинец незнатного происхождения в ряде стран средневековой Европы.
Кнехт (Прибалтика) (от нем. Knecht) — батрак, безземельный крестьянин в Прибалтийском крае Российской империи.
</span>
';
GO

exec spAddArticle 18520, N'Прямой перевод: Quarters(англ:квартиры)', N'Вашкевич, вяк, перевод, слова', N'
<span viak="word">Quarters(англ:квартиры)
КРТ - quarters(англ:квартиры) <a href="http://viakviak.livejournal.com/45219.html" target="_blank">квартира</a> квартет court(англ:суд,двор,площадка,королевский двор,ухаживание) карате крот куратор карета аккуратный каратель картель картон карто(фель) курить куртка курорт crate(англ:упаковочный ящик) carot(англ:морковь)
<a href="http://viakviak.livejournal.com/18821.html" target="_blank">ТРК</a> - таракан тарака(араб:стучать) терка турок тюрк торкнуть отрок трюк attraction(англ:привлекательность) track(след,путь,следить) Аттатюрк
<a href="http://viakviak.livejournal.com/29208.html" target="_blank">чРТ</a> - черта черт чертоги
ТРч - отречение отторочка treacherous(англ:коварный)
</span><span viak="summary">
Quarters - Чертоги
</span><span viak="description">
Слова чертоги, чертить, расчерчены - однокоренные. Квартира (Quarters) - "расчетверенные" или разделенные комнаты.
Таким образом "чертоги" - это просто разделенные комнаты, квартиры.
</span><span viak="reference">
Из Н.Н. Вашкевича:

КВАРТИРА – "жилое помещение в доме, имеющее отдельный вход, обычно с кухней, передней"; нем. quartier < нидерл. kwartier < ст.-фр. quartier < лат. quartārius < quārtus "четвертый"; возможно, название связано с первоначальной формой оплаты нанимаемого помещения: платили за три месяца, т.е. за четверть года. (БЭКМ).
♦ В ар. языке буква вав, будучи на втором месте в слове, может быть показателем мн. числа имени, как в звери (см.), по его вычету получается ар. глаголقر к*арра"обосноваться постоянно", ср. имя места: مقر макарр "резиденция", قارة к*а:ррат "континент".

ЧЕРТОГ - "пышное, великолепное помещение или здание, дворец". (БЭКМ).
       ♦ От ар. صرادقcура:дек "шатёр над жилищем", "палата", "палатка". В ар. языке считается заимствованием из персидского. Родственно чердак (см.).
</span>
';
GO

exec spAddArticle 18821, N'Прямой перевод: Court(англ:суд,двор,площадка,королевский двор,ухаживание)', N'вяк, имя, общество, перевод, слова, тело', N'
<span viak="word">Court(англ:суд,двор,площадка,королевский двор,ухаживание)

КРТ - court(англ:суд,двор,площадка,королевский двор,ухаживание) карате крот куратор карета аккуратный каратель картель картон карто(фель) курить куртка курорт crate(англ:упаковочный ящик) carot(англ:морковь)
ТРК - таракан тарака(араб:стучать) терка турок тюрк торкнуть отрок трюк attraction(англ:привлекательность) track(след,путь,следить) Аттатюрк
чРТ - черта черт чертоги
ТРч - отречение отторочка treacherous(англ:коварный)
<a href="http://viakviak.livejournal.com/36922.html" target="_blank">КРд</a> - кордон краденное курд кредо курдюк кирдык(тюрк:конец,гибель) card(англ:карточка) Кордова
дРК - дырка дурак драка дрек(идиш:испражнения) dork(англ:придурок)
чРд - черед очередь чердак
дРч - дрочить дрючить драчливый
хРТ - heart(англ:сердце,араб:тарака - стучащее)
ТРх - труха Тархун трахея треух тарахтеть тряхнуть трахать (с)таруха (по)троха
</span><span viak="summary">
Court - черта
</span>
';
GO

exec spAddArticle 18993, N'Что в имени твоем: Глаз', N'Вашкевич, вяк, геральдика, символ, слова, тело, экономика', N'
<span viak="word">Глаз
ГЛЗ - глаз
ЗЛГ - залог
ГЛс - голос глист галс галс(тук) Гулистан
сЛГ - слог салага слуга услуга Селигер
кЛЗ - клизма clause(англ:оговорка) Клязма
ЗЛк - злюка злак
кЛс - колесо колос колосс кулиса класс cluster(англ:скопление)
сЛк - слякоть салака silk(англ:шелк) силикон
жЛЗ - железо жалюзи
ЗЛж - залежи заложить
жЛс - жалость
сЛж - сложный слежение служба слаженность
шЛк - шелк шлак Шилка
кЛш - клюшка клише клешня калоша клуша калашный Калашников
ГЛш - голыш глушить глашатай оглашенный
шЛх - шлюха шлях шляхта Шолохов
хЛс - хлыст холостой хлястик холст
сЛх - слух ослух 
</span><span viak="description">
галс - длинное движение судна относительно ветра
глаз голос слух - основные способы общения на расстоянии
глашатай - "голосовик"
глушить - подавлять голос, предотвращать передачу звука на длинные расстояния
железо - увиденное, найденное в глубине
залежи - найденные в глубине
калашный (ряд) - торговля издалека, т.е. заморской дорогой и престижной продукцией 
класс - сложный
клизма - глубоко проникающая
клюшка - длинный крюк
колесо - движитель на дальние расстояния
колос - соцветие, для которого характерна удлинённая главная ось.
колосс - длинный, огромный
салага - послушный
слежение - "глазение" далеко
слог - длинные сочетания звуков
сложный - длинный путь для понимания
слуга - послушный, для слежения, на длинных посылках
служба - послушание, слежение
слух - способность принимать звук на расстоянии
хлыст - длинный
шёлк - (шёл) из-далека
шлюха - послушная
шлях - длинная дорога
шляхта - служивые, а не разбойники с большой дороги
</span><span viak="description">
Знаковые слова: глаз голос слух слог колесо колос железо шелк залог сложный класс залежи слежение служба глашатай

Слово "глаз" может быть прочитано наоборот, как "залог".

Фраза "глаз за глаз" тогда может быть истолковано как "залог за залог", т.е. обмен одной ценной бумаги на другую.

Здесь мы также видим, что значение "масонского" глаза на оборотной стороне доллара может состоять не только во всевидении, но и обозначать один из фундаментов долговых операций.

Глаз - голос. Практически одно и тоже по звучанию слово "голос" и "глаз". Т.к. считается, что слово "глаз" было заимствовано на западе во времена Петра (см. ниже), то возможно, что русское  слово "голос" перешло в западное слово "глаз" (glass). Функция Голоса - "достать" человека на расстоянии, функция Глаза (особенно в очках или с подзорной трубой) - увидеть издалека.

Салага, Слуга, Шлюха - послушные.
</span><span viak="summary">
Слово Глаз находится в смысловом поле "длинный", "дальний", "долгий", "расстояние", "сложный".
</span>
<span viak="reference">Из Н.Н.Вашкевича:

ГЛАЗ1 – "орган зрения, а также само зрение". (Ожегов). До ПетраI в обиходе было слово "око". Но при Петре  в России стали появляться привозимые из Европы стеклянные  протезы для очей, они назывались "glass"  –  стекла. И постепенно "глаз" вытеснило из обращения слово "око". (ЭНЗ, стр. 178).
     ♦От глядеть (см.).
ГЛАЗ2,кто старое помянет,тому глаз вон (пословица) – "не стоит вспоминать старое".
    ♦ Рус. глаз является переводом ар.عين ъайн"глаз", которое означает также "то же самое" (сравните не в бровь, а в глаз), т.е. старое. Имеется в виду:кто старое помянет, тому старое следует забыть.

ГОЛОС– "совокупность звуков, возникающих в результате колебания голосовых связок"; "мнение, высказывание". (Ожегов).
     ♦ От ар.قول гол(каул) "высказывание", "показание (напр. свидетеля)".
ЖЕЛЕЗО – "химический элемент, серебристо-белый металл, главная составная часть чугуна и стали". (Ожегов). 
     ♦ От ар. فولاذ  фу:ла:з, откуда также булат (см.). По месту в алфавите Ж соответствует F (W). Cм. статью Ж.
ЗАЛОГ – линг. "грамматическая категория глагола, выражающая различные отношения между субъектом и объектом действия". (Ахманова). 
     ♦ В этимологических словарях слово не отмечено. Происходит термин от ар. ذا  за: "который" + обратное прочтение ар. ج ه ل (جهل) гхл "быть неизвестным" (ар. буква х пишется как рус. о). "Неизвестный" – так называется форма страдательного залога глагола в ар. грамматике. Имеется в виду, что глагол в том случае, если деятель не известен (не упоминается в предложении), строится по особой модели (огласуется по-особому). Полное название: вазн мабний ли-л-магху:л – букв. "формула, построенная для неизвестного (деятеля)". В рус. языке, где подобные отношения выражаются синтаксически (строил > был построен), термин потерял точный смысл и совсем утратил мотивацию в рус. языке. См. другие грамматические термины: части речи, флексии, спряжение, предложение, субъект, объект, междометие, наречие. Анг. название залога (voice) происходит от рус. вес, перевод ар. وزن вазн "вес, формула, модель слова". 
СЛОГ1 – "манера речи". 
       ♦ От обратного прочтения рус. голос, родственно греч. глосса, англ. сленг, лат. lingua. Все эти слова восходят к ар. لغة луга "язык", "слово" (корень ЛГВ). Ар. سلج слг "создавать", откуда салигиййа "речь по наитию" (вопреки правилам), возможно от рус. голос. Ар. سلاج салла:г "красноречивый (о женихе)", вероятно, из русского. 
СЛОГ2 – "часть слова, произносительная единица речи". 
       ♦ От сложить.
СЛУГА – "работник в частном доме, в каком-н. заведении для выполнения различных услуг". (БЭКМ). 
       ♦ От ар. سلوك сулу:к "следование за кем.-л.", "хорошее (правильное) поведение"; سلك силк "служба, департамент", родственно слух1, заслуга, слушать, послушник (см.).
СЛУЖБА – "работа, занятия служащего, а также место его работы". (БЭКМ). 
       ♦ От ар. سلوك сулу:к "следование за кем.л.", "хорошее (правильное) поведение", откуда заслужить, от ар. ازاء سلوك иза:'' сулу:к "за хорошее поведение", سلك силк "служба, корпус (дипломатический)".
СЛУХ1 – "чувство восприятия звуков". (Ушаков). 
       ♦ От рус. слышать/слушать (см.).
СЛУХ2 – "сплетня, выдумка". (БЭКМ). 
       ♦ От обратного прочтения ар. خلوص хулу:с "освобождение", т.е. "то, что отпускается, распускается", ср. ар. إشاعة ''иша:ъа "слух", букв. "то, что распускается", ср. рус. распускать слухи. См. также толки, утка.
СЛУШАТЬ – "направлять слух на что-н."; "следовать чьим-н. советам, приказам". (БЭКМ). 
       ♦ От ар. سلوك сулу:к "следование вслед за кем-л.", родственно послушник. Ар. слово по форме есть масдар (отглагольное имя) от سلك салака "следовать за". Ар. سلس салиса "быть послушным" от рус. слушаться. 
ШЕЛК – "волокно, выделяемое гусеницами тутового шелкопряда", "нитки и ткань из такого волокна". Происхождение и история этого явно заимствованного слова не вполне ясны. (Черных).
       ♦ От обратного прочтения ар. قلس калас "отрыгивать, выделять слюну (о насекомых), мед (о пчёлах), пены (о море)", "переполниться (о сосуде)".  Ар. название шелка حرير хари:р, производное от корня حر харр "быть горячим" из русского, ввиду созвучия: шелк и щелок "жгучка", сюда же франц. происхождения саржа, от ар. سرج сараж "зажигать", греч. serika "шелка", от рус. серка "спичка". Все - ложные кальки с русского. Родственно шлак, шеллак (см.).
</span>
';
GO


exec spAddArticle 19264, N'Прямой перевод: Revenue', N'вяк, деньги, слова, экономика', N'
<span viak="word">Revenue

РВН - (г)ривеный ровный равнина ревень раввин
НВР - навар нувориш невроз Анвар
РбН - рябина ребенок рабин рубанок (ка)рабин (Ск)рябин Арбенин
НбР - набор Небраска
</span><span viak="summary">
Revenue = Навар
</span>
';
GO

exec spAddArticle 19706, N'Прямой перевод: Profit(англ:выгода)', N'перевод, слова, экономика', N'
<span viak="word">Profit(англ:выгода)
</span><span viak="description">
Переход Ф-П: фраза - phrase(англ:фраза), praise(англ:хвалить)
</span><span viak="summary">
Profit(англ:выгода) - Пропить, Пропита(ние), остаток от сделки или получка после всех вычетов, что можно пропить или использовать на пропитание.
</span>
';
GO

exec spAddArticle 19758, N'Что в имени твоем: Цвет', N'Вашкевич, вяк, символ, слова', N'
<span viak="word">Цвет

Цвет - <a href="http://viakviak.livejournal.com/11024.html" target="_blank">Свет</a>
</span><span viak="description">
Белый - (Б[ал]ый) - главный цвет от баъал(араб:голова) и светлый от <a href="http://viakviak.livejournal.com/11024.html" target="_blank">алый</a>. Основной цвет - сумма всех цветов радуги - собственно <a href="http://viakviak.livejournal.com/11024.html" target="_blank"><b>свет</b></a>.
Черный - (переход "ч"-"q") [ч/к]ерный - коренной, цвет корня дерева, находящегося под землей, в темноте, и явлающегося основой дерева. Это подчеркивает, что это основной цвет, но противоположный белому(главному светломуцвету)-самый темный.
Коричневый - Кора-<a href="http://viakviak.livejournal.com/18274.html" target="_blank">чин(овый)</a> - грязной(или нижней) коры(дерева).
<a href="http://viakviak.livejournal.com/25093.html" target="_blank">Червонный</a> - (<a href="http://viakviak.livejournal.com/4423.html" target="_blank">переход "ч"-"q":ЧРВН-кРВН</a>) - Кровяный. Проверка: Червонец - карбованец (ЧРВНЦ-кР[б]ВНЦ)
Алый - Светло-красный от слова <a href="http://viakviak.livejournal.com/11024.html" target="_blank">"аллах" - свет</a>.
Серый - Царый, Царский цвет - цвет полученный смешением белого и черного основных цветов. Может быть осознан как цвет между светом и тьмой, царь между между богом и силами тьмы.
Красный - От ар.حرس хараса"охранять"(Вашкевич)
 КРС - краса краси(вый) окрас крас(ка) кираса крыса cross крейсер корсар
 СРК - сорок срок сорока срака сурок
 КРш - крыша кореш
 шРК - shark широкий Шурик
 хРС - horse(англ:лошадь)
 хРш - хорошо шорох
Оранжевый - рыжий(Вашкевич)
Желтый - Золтый, Золотой
Зеленый - наобор.: нельзя. Зеленый, незрелый нельзя употреблять в пищу.
Голубой - (ГЛв - главный, БЛк - балик) главный цвет, цвет неба.
Синий - <a href="http://viakviak.livejournal.com/18274.html" target="_blank">"Чин" - ничто</a>. Незначительный цвет.
Фиолетовый- "В-летовый". Лето, лета - показатель зрелости, даже старости. Очевидно, что указатель на то, что это последний цвет радуги. Сравни также с англ. словом "Summer". Summer - С-умер. Другое слово в этом же ряду: Сумерки - С-умер-ки.
<span viak="reference">
Из Н.Н. Вашкевича:

БЕЛЫЙ1– "имеющий цвет мела при естественном дневном освещении", "имеющий цвет, противоположный черному", "светлый, бледный". Общеславянское слово с индоевропейской базой *bhel, *bhol "блестеть", "блестящий", "светлый", "белый".(Черных).
	♦ Вероятно, от обратного прочтения ар.حليب хали:б"молоко", при обычном чтении ар. Х восьмеричного И(Й) восьмеричной. Корень:حلب хлб"доить". Лат. albus  "белый" – прочтение того же слова, но в другом порядке с превращением придыхания(Х восьмеричного) в А, поскольку оно обозначается в семитских языках при посредстве Алифа, ср. древнеарамейский алеф:א. В рус. Выражениях белый грибили белая горячкаречь тоже не о белизне, а о голове.(см.).
БЕЛЫЙ2, белый свет– "земля со всем существующим на ней, мир, вселенная".
	♦ За рус. белый ар.بعل баъал"голова, бог, главный". т.е. Божий свет, родственно Ваал, Бел– древнее божество на Востоке. Сравните белая горячка, белый гриб(см.).
ЧЁРНЫЙ1 – "цвета сажи, угля"; "в старину: то же, что курной"; "с тёмной кожей"; "о труде: физически тяжёлый и неквалифицированный".(БЭКМ).
       ♦ От ар. قار ка:р или قور ку:р"смола". Чёрный цвет может символизировать мудрость(см. чёрным по белому), царство небесное, отсюда траур, преображение(из-за созвучия с ар. صرنا сирна:"мы стали, мы преобразились"), а также беду, несчастье трудности(чёрные дни). В цифровом отношении он соответствует как -28, в смысле противоположности белому, а также 5, как сложение 1 и 4. Вот эта синтетическая пятёрка отражена в цвете кожи негров, аборигенов континента № 5. См. Африка, а также в цвете квадрата Малевича.
ЧЕРВОННЫЙ - "красный, алый".(БЭКМ).
       ♦ От ар. صرف сирф"красная краска". )М., стр. 423). От рус. кровь.
АЛЫЙ–"ярко-красный". В других славянских языках отсутствует. Слово тюркское, широко известное в тюркских языках с давнего времени: al "оранжевая парча", "алый", "розовый".(Черных).
 ♦ От ар.قاليка:ли(в некотopых диалектах произносится–''а:ли) "жгучий", от ар.قلا кала:"жарить(на сковородке)", "калить". Отсюда в рус. языке калий, калить, калина, клен(по характерному цвету осенних листьев)(см.). С семантической стороны ср. ар.أحمر''ахмар"красный"и того же корняمحمر мухаммар"поджаренный", "окрашенный в красный цвет", откуда, кстати, рус. мухомор(см.).
СЕРЫЙ– "цвета пепла, дыма".(БЭКМ).
       ♦ От ар. саъар "гореть", ср. пепельный, ар.رمادي рама:ди"серый", "пепельный". Родственно сера(см.).
ЦАРЬ1–"единовластный государь, монарх".(БЭКМ).
       ♦От обратного прочтения ар.راضра:д(в других семитских языках – рац)  "объезжать лошадь",  ср. кучери кайзер(см.). Другая версия – от аккадс.шару"царь", которое от шар, в смысле "голова".
РИС–"злак с белыми продолговатыми зёрнами, идущими в пищу, а также его зёрна",(БЭКМ); из романских языков.(Фасмер).
       ♦ От ар.أرز арзили арузз. По созвучию с ар.عريس ъари:с"жених": используется в обрядах бракосочетания(посыпание риса на головы молодоженов) из-за созвучия его с ар. словами رأس ра''с"голова",عرس ъарс – "свадьба",عروسة ъру:с а"невеста",عريس ъри:с"жених",رسى раса:"стать на якорь". По этой же причине является преимущественной культурой в Китае, шестом культурном регионе. Важно, что среди злаковых только риси бамбук(см.) имеют шесть тычинок. Свадебные путешествия обусловлены ар. глаголом عرس ъаррас"совершать путешествие". По этой же причине на похоронах едят рисовую кутью(см. кутья). О параллелизме рожденияи смерти ср. ар. родственные корниولدвалада"родить" иلحدлахада"хоронить". Привязка других зерновых к регионам см. гречиха, рожь, просо,сезам, хинта. Рис употребляют в пищуи как закрепляющее средство, работающее по созвучию с ар.رص расс"быть плотным, твёрдым". Аналогично крутоеяйцо.
КРАСНЫЙ 1 –"цвета крови, спелых ягод земляники, яркого цветка мака".(БЭКМ);"название первого цвета видимого солнечного спектра". От названия первого региона(красного), функция которого состояла в охране цивилизации.
	♦ От ар.حرس хараса"охранять". Другое название первого региона – Русь(см.). Ср. латинское russus "красный"(см. Введение). Родственно красить, краска(см). В выражении мороз –красный нос от ар.قرس карас– "сильный мороз". Сюда же Красное море, т.е. русское. Ср. Средиземное(Филистимлянское) море, а такжеПалестина, Финикия, Сирия, Иудея, Израиль, Сур(см.).
ОРАНЖЕВЫЙ– "желтый с красноватым оттенком, цвета апельсина"; от фр. orange  "апельсины".(БЭКМ).
       ♦ От рус. рыжий(см.).
ЖЕЛТЫЙ1 – ♦ вероятно, того же корня, чтои зеленый(см.).
ЗЕЛЕНЫЙ 1 – "цвета травы, листвы".(Ожегов).
     ♦ По-видимому, того же корня, чтои жало(см.), ар.ذيل з ейль"хвост". В таком случае зеленый цвет снят с хвойных вечнозеленых иголок.
ГОЛУБОЙ1– "пятый цвет солнечного спектра".
     ♦ Этимологически связан с голубь (см.), в то же время является маркером пятого культурного ареала под названием Африкаи идеи рабства, точнее рабства-господства, как таковой. Ср. ар. جلب "рабы", جلباء гулаба:'' о рабах "привезенные", старшее значение "тащить", того же корня ар.جلوبة галу:ба "грузовой верблюд", производное от جلب галаба"тащить", откуда рус. оглобли(см.) лат. columbar "шейная колодка, надевавшаяся на рабов"(Дворецкий),  ар. جلب гулб "деревянные части седла", ар. جلاب галла:б"работорговец"  (М., с. 95). Голубой цвет - пятый по счету цвет солнечного спектра, цвет африканского региона, занимавшегося  животноводством,  соответствует  пятому уровню Бытия(фауне). Исключительной работоспособностью африканского населения, вызванной кодированием названия их цвета(голубой), в свое время воспользовались работорговцы. См. Африка1, Волга, Болгария, Бельгия, голубь.
СИНИЙ 1 – "название шестого цвета солнечного спектра".
       ♦ От ар.صيني синий"китайский". Китай – шестой культурный ареал. См. Введение, а также инь-ян, гексаграммы, Геб, медицина, Тибет, пчела, бамбук, панда.По номеру цвета соответствует шестой букве ар. алфавита Вав(و), которая, каки китайская идея, отражает идею множественности, являясь грамматическим показателем мн. числа глаголови имён, а также соединительным союзом однородных членов предложения. Кроме того, через кол-во граней снежинки(6) связан со снегоми сексом, по-арабскиجنس гинс. Ср. снеги гинс.
ФИОЛЕТОВЫЙ-♦ от фиалка(см.).
ФИАЛКА -"цветок фиолетового цвета,наибольшая концентрация видов наблюдается в Северной Америке, Андахи Японии".(Википедия).
       ♦ От обратного прочтения ар.خلف х алф(мн. числоأخلاف ''а х ла:ф) "крайний, последний", "спина"(имеется в виду седьмой, последний среди семи цветов солнечного спектра). По созвучию сفلك фалак"небесный свод"(см. эклиптика) седьмой регион(Междуречье) выбрал небосводи знаки Зодиака на нём в качестве основного предмета внимания. По созвучию ар. названия небесного свода с этнонимом поляк Польша(см.) дала миру величайшего астронома Коперника. Ср. также Пулково, где находится наша обсерватория.Является цветком тотемом японцев (№7), которые любят салат из фиалок. См. Шумер, Япония .
</span>
';
GO

exec spAddArticle 19999, N'Прямой перевод: Patent (англ:Патент)', N'', N'
<span viak="word">Patent

ПТН - пятно питание пятница потный (вы)пытанный
НТП - нетопырь натоптыш
бТН - ботаника ботинок бетон бутон сбитень батон
ПдН - поддон подонок

</span><span viak="summary">
Представляется, что слово Патент происходит от Питание. Это очень точно передает смысл: монополия как источник дохода. Кроме того, исторически патенты давались, для обеспечения легальных прав на монополию, как земли отдавались за службу «на питание».
</span><span viak="reference">

Из Н.Н.Вашкевича:
ПАТЕНТ – "документ, удостоверяющий право изобретателя на его изобретение"; нем. рatent < лат. patеns (patentis) открытый, явный. (Крысин).
       ♦ От ар. فطن фатана "сообразить", "догадаться", т.е. изобрести.
</span>
';
GO

exec spAddArticle 20390, N'Прямой перевод: Smart(англ:Умный)', N'2x, Вашкевич, вяк, материя, мера, перевод, слова, смерть, тело', N'
<span viak="word">Smart

Смерть - тормоз смерить Тирамису самаритянин smart(англ:умный)

СМР смер(ть) смерчь самурай семеро сумерки смирение смрад Самара Сумаро(ков) сморить Сума(рта) Самари(тяне) сморкать сморчок Семирамида 
РМС - рамсы Арамис Рамсес
шМР - Шумеры шмара
РМш - ромашка
зМР - замарать замирить заморыш замер
РМз - Рамаза(н) Рамза(н)

Мертвый
МРТ - мертвый martyr(англ:мученик) mortal(англ:смертный) мортира умертвить mortician(англ:гробовщик) mortadella(сорт колбасы) mart(англ:рынок) Март Мирт Марат Morti Марта
ТРМ - tremor(англ:трепет) трюмо тюрьма трамвай терем тромб трамвай Тирамису тормо(з) тормашки тормо(шить) term terminal(англ:конечный) терминал термит torment(англ:мучение) (s)torm(англ:буря,шторм) трам(плин) Турман Trump
МРд - murder(англ:убийство) морда Мурад Murdok Meredith
дРМ - derma(англ:кожа) драма дурман дрема дерьмо Дуремар dorm(itory)(англ:студенческое общежитие)

Морок
МРК - марка маркиз (oб)морок мерка морко(вь) mercury(англ:ртуть) Меркурий Мураками Марк Merkel Merkava
КРМ - crime(англ:преступление) кромка крем карма кремль керамика корм карман карамель карамболь Crimea Крым Каримов "курам( насмех)" Кромвель
МРч - (с)мерчь March(англ:Март) мрачный
чРМ - черемуха Черемизов
МРг - морг моргать морганатический Morgan
гРМ - грамм грамота грамота гром греметь громада grim(англ:мрачный)
хРМ - храм хром хоромы хромать хрумкать
МРх - марихуана

Мор
МР - мор море мера моряк мир мрамор омары мореный мурена (гла)мур Amarias Мара МУР
РМ - рама arm(англ:рука) армия ром Romeo Рим Irma Urma Арамеи Армения

</span><span viak="description">
arm(англ:рука) - рука способная умертвить, находится на "границе" тела
crime(англ:преступление) - умертвление, убийство
grim(англ:мрачный) - мрачный
derma(англ:кожа) - омертвевший слой
dorm(itory)(англ:студенческое общежитие) - смертельно опасное жилище
mart(англ:рынок) - рынок где торгуют простые смертные (в отличии от торговых рядов)
martyr(англ:мученик) - замученный до-смерти
mercury(англ:ртуть) - смертельно опасное вещество
mortal(англ:смертный) - смертный
mortician(англ:гробовщик) - работающий с мертвыми
murder(англ:убийство) - умертвление
армия - умертвляющая государственная сила
(гла)мур - голая смерть?
грамота - грам+мата = смерть+смерть - удвоение смысла "смерть". Знать грамоту - постигнуть тайны смерти?
греметь - смертельно страшный шум
гром - гремящий
дерьмо - не ешь! Смертельно опасно!
драма - театральный жанр со смертью
дрема - сон похожий на смерть
дурман - смертельно-опасная трава
замарать - грязный до-смерти
замер - притворился мертвым
замирить - успокоить, остановить (умертвить) вражду
заморыш - смертельно недокормленный
карамболь - смерть+боль (болезненая смерть, смертная болезнь)?
карамель - сладкая "смерть"
карма - воздаяние за грехи (смертью)
карман - деталь одежды снаружи, за границей одежды
керамика - мертвая глина, картина, статуя
корм - спасение едой от голодной смерти; пища приготовленная из мертвечины. Сравни с английским словом Meat - мясо.
кремль - граница города за которой смерть
кромка - граница за которой смерть
крем - корм, еда
кремация - уничтожение умерших 
курам( насмех) - идиома, возможно означающая "смешная смерть".
марихуана - успокаивающая
марка - смертельная пограничная зона; денежный знак в пограничной зоне.
маркиз - владелец земли в смертельно-опасной приграничной зоне.
мор - умертвляющая эпидемия
мера - измеренное
мерка - замер сделанный мерой
Меркурий - планета (символ смерти)
мир - среда или место обитания смертных
мир - замирение, успокоение, смерть войне.
<a href="https://ru.wikipedia.org/wiki/%D0%9C%D0%B8%D1%80%D1%82" target="_blank">Mirt</a> - "... символ тишины, мира..." (успокоения, смерти)
морг - дом смерти
морганатический (брак) - мертвый (с точки зрения наследования) брак
моргать - закрытые даже на мгновение глаза, как и сон, ассоциируются со смертью, отсюда предостережение "не моргай".
морда - неживое лицо.
море - смертельно опасная среда.
мортира - сеящая смерть.
мрачный - вид смерти на лице.
моряк - мореход.
мрамор - мертвый камень, статуя; мра+мор - удвоение смысла "смерть"
(oб)морок - состояние близкое к смерти
рама - крепление образующее границы
рамсы - важная и запутаннная ситуация в состоянии смертельной конфронтации
ром - успокаивающий алкогольный напиток
ромашка - цветок гадания на смерть
самурай - профессиональный убийца
смерчь - смертельный ветер
смирение - остановка (смерть) сопротивления
сморить - дать умереть
сморкать - извергать мокроту (как признак смертельной болезни?)
сморчок - смертельно опасный гриб
смрад - смертельный запах
сумерки - конец (смерть) дня
трам(плин) - для смертельно-опасных прыжков
тормоз - остановить, смерть движения
умертвить - убить, сделать мертвым
хоромы - дворец красивый как храм
храм - дворец смерти
хром - токсичный, смертельно опасный металл
хромать - ходить с поврежденной (мертвой) ногой
хрумкать - хрустеть костями умершего животного
шмара - смертельно опасная женщина
</span><span viak="summary">
Английское слово Smart(англ:Умный) напрямую означает "грамотный", но в также, как и слово Грамота находится в смысловом поле "смерть", "граница", наверное с позиции "познание смерти", "владение границами знания".
</span><span viak="reference">
Из Н.Н. Вашкевича:
АРМИЯ – "вооруженные силы государства"; "совокупность сухопутных сил того или иного государства"; "оперативное (в условиях войны) объединение нескольких корпусов или дивизий". Из западноевропейских языков, где оно от  латинского armare  "вооружать", "снабжать", "снаряжать". (Черных).
     ♦ Лат. слово от ар. أرم ''арама "связывать" или от родственного ему عرم ъарама "связывать", "переплетать, (например, книгу)", "усиливаться", "напрягаться", "выходить за пределы", откуда عرام ъура:м "сильный", "большая и сильная армия" (М., с. 502).
ГРАМОТА1 – "умение читать и писать", откуда грамотный; "официальный документ". 
     ♦ От греч. грамма "буква", от графма, от графо "писать", которое восходит к ар. حرف  харф (мн. число:  حروف  хуру:ф или   أحرف ''ахруф) "буква". 
ГРАМОТА2, почетная грамота – "грамота, которой награждают отличившихся в каком-либо деле". 
     ♦ Обычай награждать почетной грамотой обусловлен созвучием рус. слова грамота с ар. كرامة кара:мат "почет". По сути дела билингва. Ар. أكرم ''акрама "оказать честь" cовпадает с рус. кормить, откуда обычай накормить гостя. Отсюда же обычай поставить гостю бутылку:  كرم карм "виноградная лоза", откуда الكرم بنت бинт ал-карм "вино", букв. "дочь виноградной лозы".
ГРАМОТА3 (охранная) – 
     ♦ от ар. حرمة хармат "охранение",  حرم харам или حرمة хурмат "защита", того же корня гарем, храм (см.).
ГРАМОТА4, филькина грамота – ♦ см. Филька.
ГРОМ –  "сильный грохот, раскаты, сопровождающие молнию во время грозы"; "сильный шум, звуки ударов". (Ожегов). 
     ♦ От ар. جرم гуррим "пролиться дождем (о туче)". Перенос на сопровождающий грозу гром произошел на рус. почве. Ср. ар. غريض гари:з "дождь" и рус. гроза (см.).
ДРАМА – "род литературных произведений, написанных в диалогической форме и предназначенных для исполнения актёрами на сцене"; греч. drama действие. (Крысин). 
     ♦ От обратного прочтения ар. معرض маърид "представление", производного (имя места) от глагола عرض ъарада "демонстрировать, показывать", откуда  عرض ъард или  ''истиърад (десятая порода) "демонстрация", "показ", "представление", откуда англ. art "искусство", артист и эстрада (см.), а также артикль и артикул (см.). Греч. название от рус. дремать, откуда англ. dream "мечтать". 
КАРМА – "в буддизме – совокупность деяний в предыдущих существованиях, определяющих судьбу в последующих". В переводе с санскрита "деяние". (МС); "в её основе лежит аффективность "омрачённость" сознания". (КФ, Е). Основная цель буддизма – вывести человека из круга омрачённых состояний, определяемых кармой. Устраняется посредством "просветления" (бодхи). (КФ, Луньхуэй). 
	♦ От обратного прочтения рус. мрак. Сближение со словом санскрита – вторично.  См. также Будда. Основная терминология буддизма, как и других религий, из рус. языка.
КАРМАН – "вшитая или нашивная деталь в одежде - небольшое обычно четырёхугольное вместилище для платка, для мелких нужных под рукой вещиц". (БЭКМ). Старое значение "кошелек". (Черных). 
	♦ От ар.  قهرمان кахрама:н "казначей", "лицо, ведающее доходами и расходами". Ар. слово, вероятно, от ар. كرم карам "изобилие", того же происхождения рус. кормить. Ср. ар. أكرم ''акрама "уважить гостя", т.е. накормить. Колебания между Каф и Кяф имеют место быть, ср. قرب  карраба =  كرب  карраба "приближать".                         
КОРМ – "пища животных"; "вообще пища, пропитание"; в этимологическом отношении неясное слово. (Черных). 
	♦ От ар. أكرم ''акрама "уважить (гостя)", т.е. накормить. Коль скоро от этого же корня ар.كرم  карм "виноград", الكرم بنت бинт ал-карм "вино", то у нас надо еще и напоить. Сюда же ар. كرامة кара:ма "почет", "честь". См. на эту тему также лавр. Родственно лат. cremo "сжигать", т.е. "кормить огонь", рус. (почётная) грамота (см.). Сюда же кормление "воспитание", например, духовное кормление. См. также молоко, масло, мысль.
КОРМА – "задняя часть судна, лодки и некоторых других транспортных средств". (БЭКМ). 
	♦ От ар. قرمة курма "обрубок", "пень", производное от قرم карама "обрезать" (М., стр. 624). Аналогично ср. гузка (см.) иجزء   газа''  "отрезать",   جزرгазар "резать".
КОРМЛЕНИЕ – "воспитание".
	♦ От кормить (см.), перенос значения основан на однорядости женской функции: "родить – вскормить – воспитать" и двузначности слова воспитание (см.). См. также каша березовая, розги. 
КОРМЧИЙ – "рулевой, кормщик"; перен. "мудрый руководитель". (БЭКМ). 
	♦ От корма (см.), поскольку руль судна находится на корме.
КРЕМ – "косметическая мазь"; "сладкое густое кушанье из взбитых сливок, масла с шоколадом, фруктовым соком и т.п., часто добавляемое к кондитерским изделиям"; фр. créme < лат. chrisma "мазь" < греч. chrisma < chriō "мажу" (БЭКМ).
	♦ От обратного прочтения ар. ما رق ма: ракк "то, что мягко, нежно". В греч. языке отыменное образование. 
КРЕМАЦИЯ – "сжигание трупов в специальных печах"; нем. kremation, фр. crémation < лат. cremātio "сжигание" (БЭКМ). 
	♦ Того же корня латинское сremiа "мелкие сухие дрова", "хворост". От рус. кормить (огонь). Ср. греч. гастро и рус. костер. Возможно, родственно ар. كرامة кура:мат "приставший к таннуру (род печки) хлеб", т.е. подгоревший. Сожжение трупов производится из-за созвучия с ар. كرم  каррама "почитать". 
МАРИХУАНА – "вид сильнодействующего наркотика"; англ. marihuana < исп. mariguana - назв. сорта мексиканской конопли. (БЭКМ). 
     ♦ От ар. مارح ма:рих(ун) " веселящий".
МАРКА - "знак оплаты почтовых и некоторых других сборов в виде маленькой, обычно четырехугольной бумажки с изображением кого-чего-н. и указанием цены"; "знак, клеймо на изделиях, товарах"; нем. mаrkе. (БЭКМ). 
     ♦ От ар. مرقى   марка: "ранг", "ступень", производное от رقى   рака: "восходить", "подыматься". Вероятно, не без влияния рус. мерка.
МОРГ – "специально оборудованное помещение, где временно сохраняются трупы людей". В других славянских языках кроме украинского и болгарского отсутствует. Заимствование из фр. Во фр. morgue "морг" (сначала - "помещение в тюрьме, куда поступают арестованные"); ещё более ранее – "лицо", "горделивая осанка". Развитие значения на фр. почве неясно. Происхождение фр. слова неизвестно. (Черных). 
     ♦ От обратного прочтения ар. أهرام ''агра:м "пирамиды", "гробницы фараонов". Интересно созвучие с фамилией французского анатома Дж. Б. Морганьи (1682—1771), после трудов которого сформировалась наука патологическая анатомия. Алиф как О читается во многих языках (например, в еврейском, персидском).
МОРДА – "передняя, вытянутая часть головы с носом и ртом". Связано с лат. mordeo "кусаю", "пожираю", "вцепляюсь" и древнеиндийским mardati "дробит, сжимает", "уничтожает". (Черных). 
     ♦ От ар. معارضة    муъарда "то, что находится напротив", "оппозиция", "противодействие" (М., с. 498). По этой же схеме образовано рус. лик (от ар.  لقاء   лика: "напротив"), ар. وجه ваджх (отواجه  ва:джах "находиться напротив"). Родственные слова: драма, артист, эстрада, парад, эрудиция, меридиан, трудный, раз, разница (см.). Старшее значение корня ЪРД (ЪРЗ) – "широкий" (эрудиция), затем "делать широким, показывать, демонстрировать" (драма, артист, эстрада, парад). С другой стороны, через значение "поперёк" (меридиан) – "ставить поперёк", "затруднять" (трудный).
СМЕРТЬ – "прекращение жизнедеятельности организма". (БЭКМ).
	♦ От мертвый. В ар. языке дало رمس рамс "захоронение, зарывание", "могильный прах". По созвучию с семёрка, иногда влияет на подсознание одержимых людей. Так, широко известный трагический возраст поэтов и художников в 37 лет (Байрон, Пушкин, Хлебников, Маяковский, Караваджо), объясняется тем, что вход в "области заочны" кодируется четырьмя семёрками, и в 37 лет как бы три семёрки обеспечиваются числом прожитых лет, а четвёртая, недостающая, – берётся из слова смерть при исполнении его как команды. Подобное происходит в ритуале самураев (см).
УМЕРЕТЬ - "перестать жить". (БЭКМ).
	♦ От ар. عمر ъуммир "получить долгую жизнь". Такая этимология отражает концепцию вечной жизни.
</span>
';
GO

exec spAddArticle 20627, N'Прямой перевод: Cost (затраты, расходы)', N'', N'
<span viak="word">Cost

КСТ - кость куст кисть киста оксти(сь) касатик касат(ка) касать кусать куста(рь) каста касте(т)
ТСК - тиски тискать тоска тесак отсек таска(ть) туск(ло) Тоскана
КшТ - кошт каштан кушать
ТшК - тишко(м) Ташкент
ТСч - тысяча
чСТ - часть чистый честь часто(та) (от)чество чест(вовать) чу(в)ст(во) чесот(ка)
гСТ - гость густо гаст(рит)
дСК - доска desk disk
</span><span viak="summary">
Кошт - расходы на проживание, часть расходов
</span><span viak="description">
Представляется, что слово произошло от "Кошт", а также имеет смысл "часть" (финансовых расчетов или персональных расходов).

гость - проживает как часть семьи.
густой - плотная часть жидкости.
доска - часть деревянной постройки.
касатик - дорогой.
каста - часть населения; "чистое" сословие.
кость - часть скелета, тела.
кусать - оттяпать зубами часть.
кушать - потреблять, тратить.
отсек - часть помещения; отрубил часть.
(от)чество - от+чести - чествовать, часть имени
тиски - зажать часть заготовки.
тысяча - прочитанное наоборот слово "часть".
честь - "чистая" репутация.
</span>
';
GO

exec spAddArticle 20807, N'What is in the name: Don''t tread on me!', N'english, usa, вяк, геральдика, символ, слова', N'
<span viak="phrase">Don&#39;t tread on me!
</span><span viak="description">
<img alt="" src="http://ic.pics.livejournal.com/viakviak/75606786/2710/2710_900.png" title="" />
<span style="line-height: 19.6px;">From Wiki: </span><a href="https://en.wikipedia.org/wiki/Gadsden_flag" style="line-height: 19.6px;" target="_blank">Gadsden flag</a>
</span><span viak="summary">
Writing:
<b>Don&#39;t tread-on me</b>
Meaning or sounding like:
<b>Don&#39;t threaten me</b>
</span><span viak="description">
<a href="https://www.google.com/webhp?sourceid=chrome-instant&amp;ion=1&amp;espv=2&amp;ie=UTF-8#q=translate+snake+to+russian" target="_blank">Translate &quot;Snake&quot; to Russian</a>: Змея. In Russian &quot;Snake&quot; has another name:&nbsp;Гад (Gad). As we can see, &quot;Gad&quot; is a first part of name <b>Gad</b>sden (American general and statesman <a href="https://en.wikipedia.org/wiki/Christopher_Gadsden" target="_blank">Christopher Gadsden</a>).

<b style="line-height: 19.6px;">Gad</b><span style="line-height: 19.6px;">sden = </span>Gad&#39;s-den - name also sounds as Russian &quot;Гад&#39;s день&quot; - &quot;Snake&#39;s day&quot;, which sounds as a proud statement. On the image, snake is ready to strike, in the first sign of danger. Message from <b style="line-height: 19.6px;">Gad</b><span style="line-height: 19.6px;">sden </span>&quot;don&#39;t threaten me&quot; is played into <span style="line-height: 19.6px;">message from </span><span style="line-height: 19.6px;">heraldic </span>snake &quot;don&#39;t tread on me&quot;.
</span>
';
GO

exec spAddArticle 21101, N'Чтобы это значило: Учеба', N'вяк, слова, шутка', N'
<span viak="word">Учеба
</span><span viak="description">
УЧЕБА - UCHOBA => ОСНОВА
</span><span viak="summary">
Таким образом русское слово "Основа" прочитанная латиницей, звучит как русское слово "Учеба". Это может быть использовано в назидательных целях.
</span>
';
GO

exec spAddArticle 21395, N'Прямой перевод: Cattle', N'вяк, перевод, слова', N'
<span viak="translation">Cattle(англ:крупный рогатый скот)

КТЛ - котел катала Каталониа 
ЛТК - лоток Латакиа 
КдЛ - кидала кодло кудлатое 
Лдк - лодка
Лат - бить, выделывать
</span><span viak="summary">
Cattle - кодло
</span><span viak="reference">Из Н.Н.Вашкевича:
ЛАТЫ – "в старину: металлические доспехи, броня". (БЭКМ). 
      ♦ От ар. لط  латта или лата''а "бить", "стучать" (М., с. 722). Родственно молот, Италия, латины, латать (см.).
</span>
';
GO

exec spAddArticle 21973, N'Испанский скульптор, который владеет искусством мять камни', N'технология', N'
Оригинал взят у <lj user="vsegda_tvoj" /> в <a href="http://vsegda-tvoj.livejournal.com/18394779.html">Испанский скульптор, который владеет искусством мять камни</a><div class="repost">Посмотрите: они слушаются скульптора, будто пластилин! Испанец Хосе Мануэль Лопес Кастро представил серию своих работ, которые производят впечатление слепленных из мягкого и тягучего вещества&hellip; В его руках камни тянутся<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon" target="_blank">,</a> сминаются и даже плачут!

<a href="http://vs-t.ru/" target="_blank"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/1.jpg" /></a>

<lj-cut><a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/2.jpg" /></a>

Художник работает по большей части с гранитом и кварцем из своего региона и утверждает, что его взаимоотношения с местными камнями сродни магии: &laquo;Во время работы я чувствую себя не столько скульптором, сколько друидом. Мои отношения с камнем не физические, а волшебные. Я разговариваю <a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon">с камнями</a>, и в процессе общения мы подчиняем другу друга&hellip; Мои камни не безжизненны&raquo;.

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/3.jpg" /></a>

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/4.jpg" /></a>

Идея будущей скульптуры приходит к мастеру не сама по себе, а при взгляде на материал&hellip; Камень сам &laquo;подсказывает&raquo; ему, во что может превратиться.

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/5.jpg" /></a>

Уже непосредственно воплощение <a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon">замысла</a> может занять как пару дней, так и несколько месяцев. Это тоже зависит от свойств камня.

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/6.jpg" /></a>

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/7.jpg" /></a>

Как подчеркивает сам Хосе Мануэль <a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon">Лопес Кастро</a>, местные камни пропитаны мифической атмосферой, потому при работе с ними технические навыки скульптора &mdash; далеко не главное. Нужно почувствовать их древнюю магию&hellip;

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/8.jpg" /></a>

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/9.jpg" /></a>

<a href="http://vs-t.ru/kak-vyglyadit-veneciya-ne-v-turisticheskij-sezon"><img alt="Испанский скульптор, который владеет искусством мять камни" src="http://www.fresher.ru/mary/2-2016/ispanskij-skulptor-kotoryj-vladeet-iskusstvom-myat-kamni/10.jpg" /></a>

<a href="http://fishki.net/1833307-ispanec-nauchilsja-mjat-kamni-dlja-sozdanija-skulptur.html" target="_blank">источник</a></lj-cut>


Если вам понравился пост, пожалуйста, поделитесь ими со своими друзьями! :)


<lj-like buttons="repost,facebook,twitter,google,vkontakte,surfingbird,odnoklassniki,tumblr,livejournal" />
<lj-repost button="Репост">


</lj-repost>
</div>
';
GO

exec spAddArticle 22501, N'О незаметной пропаганде бестианства. About quiet bestuality propaganda.', N'english, вяк, мнение', N'
<span viak="opinion"><p dir="ltr">Re: Иркутская модель снялась обнаженной ради спасения животных
http://dymontiger.livejournal.com/5790432.html via LiveJournal</p><p dir="ltr">Интересно, как незаметно проходит пропаганда бестианства - полного отождествления человека с животным. Так на последнем плакате, не только ведётся сравнение количества звериных и человеческих &quot;душ&quot;, которое идёт на изготовления одного изделия, в одном ряду, но и подспудно проталкивается идея нормальности использования человеческого &quot;материала&quot;. Да, это подано в гротескной, артистичной форме, и в результате принимается аудиторией положительно, и с пониманием.</p><p dir="ltr"><i>It is interesting how smoothly propaganda of bestuality (identification people as animals) is being shoved down our throats. Thus on last image there is not only one-to-one comparison of human and animal &quot;souls&quot; that are used for to produce fur coats, but they are also pushing the idea of indiscriminate use of human body &quot;material&quot;. Of course, all that served in the grotesque, artistic wrapping for positive and understanding consumption of unsuspecting audience.</i></p><p dir="ltr">В чем заключается опасность массовой пропаганды бестианства для обычных людей? Если просто, что называется, на пальцах, то мы должны понимать на чём держится мировой порядок, и почему массовое уничтожение людей не считается нормальным, хотя время от времени и происходит.</p><p dir="ltr"><i>What is a danger in bestuality propaganda for common people? In simple words, we should realize the underpinnings of modern world order, and why while mass murders are not considered normal, while that happens from time to time anyway.</i></p><p dir="ltr">Многие могут не отдавать себе, но главенствующая современная мораль основана на иудо-христианских ценностях, включающая в себя кроме всего прочего идею &quot;бессмертной человеческой души&quot;, которая была создана богом, и потому принадлежит исключительно ему.</p><p dir="ltr"><i>Many may not realize that the currently dominant moral code is founded on Jewish and Christian values that include besides others the idea of &quot;eternal soul&quot; in every person, which was created and thus belongs only to god.</i></p><p dir="ltr">Примеры массового истребления американских индейцев, африканских племен, работорговля, колонизация, мировые войны, холокост и современная деиндустриализация целых континентов вызывающая падение рождаемости и катастрофическое обрушение качества жизни целых народов - вот послужной список протестанского истеблишмента (ПИ).</p><p dir="ltr"><i>Examples of mass murders of american indians, African tribes, slave trade, colonization, world wars, holocaust, modern deindustrialization of continents, causing significant drop of birthrate and level of living - that is a short list of western protestant establishment.</i></p><p dir="ltr">Да, они не могут преступить закон божий и гореть в геене огненной до скончания веков за преднамеренное&nbsp; убийство хотя бы одного невиновного человека. С другой стороны, с точки зрения этих же законов (десять заповедей), убийство скота, варваров, убийство в качестве самообороны или в справедливой войне или революции не только допустимо, но и является благородным делом.</p><p dir="ltr"><i>Yes, they cannot cross lines of God law, under threat to be punished by ethernal suffering in hell even for killing of one innocent man. From another hand, from the point of view of the same laws (ten commandments) killing of cattle, barbarians, in self-defence or in the name of justice, such as in just war or revolution is not only allowed, but also considered to be nobel and celebrated deads of real men.</i></p><p dir="ltr">Поставьте на минуточку себя на место вершителей судеб миллиардов, представьте, что вы обладаете пониманием предназначением человечества, и вас есть неограниченные финансовые возможности. А теперь поставьте себе задачу очистки Земли от человеческого балласта &quot;законным&quot; способом. В этом свете - решение очевидно. Чем больше атеистов, безбожников, многобожников, новых варваров, идолополонников, врагов первыми напавших или неправильно использовавших вашу собственность (доллары, например) - тем меньше у вас связаны руки для благородного дела спасения.</p><p dir="ltr"><i>Try to put yourself in the shoes of supreme leader of billions, imaging that you poses the insight of the human purpose, and you have unlimited financial possibilities. Now, what would you do, if you have a task of unloading the ballast of billion of unnecessary for that purpose people on your hands? The final solution would seem obvious. The more atheists, barbarians, idol-warshipers, active enemies of your land or property violators (think of misuse of dollars, stolen or used for bribery, for example) the less your hand are bound for nobel task of saving humanity from excess of people.</i></p><p dir="ltr">Да, люди поставленные судьбой в неблагоприятные условия имеют тенденцию умирать раньше или не рождаться. Чья это будет вина? Очевидно же, что это вина их самих, или же отдельных &quot;козлов отпущения&quot;. Молитвы и наказания виновных должны принести прощение. Мысли (в том числе и человеко-ненавистнические) не наказуемы, потому что воздастся каждому только по делам его.</p><p dir="ltr"><i>Yes, people that are put into unfavorable conditions have a tendency to die earlier or not get born at all. Who&#39;s fault would it be? Apparently, it would be victims fault, or fault of some &quot;scape goats&quot; from their midst. More praying and punishments of the &quot;guilty&quot; ones should bring the forgiveness. Remember that thoughts (including the evil ones) are not punishable by law, only deads are.</i></p><p dir="ltr">Надо осознать, что существует исторически состоявшийся безжалостный источник невероятной силы действующий строго по древним законам, считающийся себя монополистом на правду, и умеющий манипулировать сознанием миллиардов.</p><p dir="ltr"><i>It is time to realize that there is historically established, knowing no-mercy source of unimaginable power, acting in boundaries of ancient laws, in full confidence of its own right, with a knowledge of manipulation of minds of billions.</i></p><p dir="ltr">Концентрационные лагеря для миллионов, газовые камеры, этнические чистки, ковровое бомбометание жилых городов, ... Как это было возможно раньше? Как видите - это вполне возможно и сейчас, и в будущем. Что или кто этому может воспрепятствовать? Все ведь делается законно...</p><p dir="ltr"><i>Death camps for millions, gas chambers, ethnic cleansing, carpet bombing of densely populated cities... How was that possible in past? As you can see, it is still quite possible now and&nbsp; in future. What or who could stop that? Everything is being done accordingly the law...</i></p>
</span>
';
GO

exec spAddArticle 22632, N'Прямой перевод: Knowledge - Direct Translation', N'вяк, перевод, слова', N'
<span viak="translation">Know-ledge
</span><span viak="description">
Нов-лежать
Залежи нового.
Новое даёт дополнительное знание.
</span><span viak="summary">
Перевод: Knowledge - залежи новых знаний.
</span>
';
GO

exec spAddArticle 22974, N'Прямой перевод: Love - Direct Translation', N'вяк, перевод, слова', N'
<span viak="translation">Love

ЛВ - лево лев улов leave(англ:оставлять)
ВЛ - evil(англ:зло) воля вол вилы вал валять влия(ние) влить Ваал вилок власть волок <a href="http://viakviak.livejournal.com/25093.html" target="_blank">великий</a> волк wool(англ:шерсть)
Лб - люб(овь) любо лоб лобок Люба Любе улыб(ка)
бЛ - боль быль бл@ть ебло ябло(ко) обло(страшно) било
fL - feel, fool(англ:глупец), fault, file(англ:досье), fall(англ:падать), fellow(англ:парень), flu(англ:грипп), (in)flue(nce)

</span><span viak="summary">
Love - любовь, боль, зло, опасное
</span><span viak="description">
fellow(англ:парень) - любимый друг
file(англ:досье) - file for divorce(англ:подать на развод), подборка проблем
fall(англ:падать) - fall in love(англ:влюбиться), упасть болезненно
flu(англ:грипп) - болезнь
fool(англ:глупец) - больной на голову
(in)flue(nce) - влияние
leave(англ:оставлять) - уходить от бывшей любви
било - аналог предмета любви
Ваал - злое властное божество
валять - заниматься любовью
вол - злобный, тыкающий рогами
волк - злое, опасное животное
воля - свобода любить
вилы - втыкающие
влия(ние) - вливание, заканчивание акта любви; доминирующие отношения с партнером позволяющие "влить"
лев - символ власти
обло - страшно, опасно
улов - результат поиска любви?
улыб(ка) - проявление чувства любви
ябло(ко) - символ запретной любви

</span><span viak="reference">Из Н.Н.Вашкевича:
ЛЕВ1 – "крупное хищное животное сем. кошачьих с короткой желтоватой шерстью и с длинной гривой у самцов". (БЭКМ). 
      ♦ От обратного прочтения بعل баъал "голова", назван по крупной голове. По созвучию с ар. والي  ва:л(и) "властитель", считается царем зверей. С учетом фонетического явления ималя (произнесение долгого А со склонением к Е) произносится ве:л(и). Того же корня ар. لبوة либва "львица", Ливия (см.). Ар. أسد ''асад "лев" также от корня со значением власти: ساد са:да (наст. время: يسود йасу:д) "царить", того же корня, что и рус. сударь, государь (см.). Как элемент семейства кошачьих соответствует Ливии (Африке); ср. ар. عفروس ъафру:с "лев", букв. "гривастый". Когда лев сакрализуется, помимо символа власти, соответствует пятому номеру (в частности Африке, царству зверей). Соответствие других  названий кошачьих см. рысь, пантера, барс, кот, ягуар. Лев как название знака Зодика, как и Ливия, занимает пятую позицию перед Девой (см.), связанной с шестеркой. Ср. ар. ست ситт "шесть", "женщина". См. Введение. Образ льва вместе с тигром выражает число семь из-за совпадения их названия по-арабски с ар. же названием семерки. См. Междуречье, Италия. Лев как символ человеческой натуры проявляет себя во властности, требовании знаков внимания к царствующей особе (ср. Леонид Брежнев), в склонности к назидательности (Лев Толстой), к рассудочной деятельности. 
ЛЕВ2, муравьиный лев, мураволев – "насекомое, личинка которого – жук –  питается муравьями, строя для них ловушки в виде воронки". В. Даль определяет название насекомого как дурной перевод с лат. myrmelion. 
      ♦ На самом деле латинский термин есть калька с рус., во-первых, потому, что лат. название муравья formica (от обратного прочтения рус. корня МРВ), во-вторых, насекомое не лев, а ловец, -лов. Заморочка произошла на рус. почве и бездумно скопирована в латыни. Аналогично ср. лат. название химического элемента мышьяк: Арсений (см.), букв. "мужской".
ЛОБ – "надглазная (надбровная) часть человеческого лица (или головы животного)". В других славянских языках в значении "лоб" употребляется чело, а лоб имеет значение "череп", "темя". Родственно древнерус. луб "лубяной короб". (Черных). 
      ♦ Образовано с помощью огласовки О, имеющей значение инструмента, от глагола любить, поскольку лоб есть орган любви к истине, орган любознания, в противоположность любви к женщине, которой соответствует лобок. Оба вида любви упоминаются в Библии и зафиксированы в так называемой звезде Давида (звезде любви), состоящей из двух треугольников, один из которых указывает острием на лобок, другой – на лоб. Входит в параллельный и противопоставленный ряд терминов любви: голова-головка,  чело-член, сема-семя, ум-умм (ар. "мать"), образование-обрезание, культура-клитор, глупость-гульфа (крайняя плоть), искусство-секс и т.д.; см. также Кааба. Луб от другого корня (см.).
ЯБЛОКО1 - "шаровидный плод фруктового дерева семейства розовых подсемейства яблоневых", (БЭКМ);  слово яблоко в славянских языках стародавнее, но восстановить  его форму нелегко. (Черных). 
       ♦ Связано с библейским сюжетом, где Ева даёт Адаму яблоко. В рус. названии плода раскрывается смысл ситуации. Ср. змей-искуситель и ар. название змеи (корень حوي хуй) на рус. слух. Связано с раем, ср. ар. رياض рийа:з "сады", отсюда розы, название семейства. Ср. также с ар.  جبلة   жибилля (йибилла) "природа человека". Ар. корень جبل жбл означает "создавать" о Боге. Европейские названия яблока все от рус. языка. Рус. название плода может быть осмыслено как билингва: яб + ар. لقح  лаках  "половой акт", а корень йбл дает в ар. языке ещё и حبل хбл "беременеть". Начертание букв И и ар. Х (حـ) совпадает, отличает их только ракурс, см. статью И. 
ЯБЛОКО2, яблоки Гесперид – "о запретном плоде, о труднодостижимом". По древней мифологии в саду Гесперид (дочерей Атласа и Гесперис) росли золотые яблоки – свадебный подарок от Геи (Земли) по случаю свадьбы Геры с Зевсом. Яблоки охранялись драконом Ладоном. 
       ♦ Указанный миф являет собой греческий вариант библейской легенды о рае: Гера, хотя и со смещёнными функциями, соответствует Еве, Зевс – Адаму, Ладон – Змею. Гесперис от ар. عفروسة ъафру:са "львица, жрица любви". Змей искушал Еву попробовать яблоки, Ладон – охранял. Дело в том, что Змей относится к системе нижней любви, Ладон – верхней. Зов верхней любви останется не отвеченным, пока люди находятся в сомнамбулическом состоянии  (см. звезда Давида).
ЯБЛОКО3, адамово яблоко – "кадык". Название идёт от библейской легенды о запретном плоде, который застрял у Адама в горле. 
       ♦ На самом деле речь идёт о половом акте, что ясно видно из рус. названия плода. А произошло это потому, что Ева сказала Адаму قدك  каддак "хватит тебе". Отсюда рус. кадык. См. также Гордиев узел.
ЯБЛОКО4, яблоку негде упасть – "очень людно, тесно, много народу". 
       ♦ Яблоко с теснотой связано через половой акт, который символизируется яблоком через рус. созвучия (ср., в частности, яблоко Адама, яблоко раздора), и наступающую вслед беременность, с течением которой теснота в утробе усиливается, сравни تاسع та:сиъ "девятый (месяц)" и рус. тесно. В верхней любви (см. звезда Давида) девятому месяцу соответствует пора пробуждения, о которой косвенным образом свидетельствует так называемый демографический взрыв. В бытовом употреблении неосознаваемый этимологический подтекст: негде совершить половой акт.
ЯБЛОКО5, яблоко раздора (Эриды) – "повод, причина ссоры, спора, серьезных разногласий". В древнегреческой мифологии богиня раздора Эрида покатила на свадебном пире золотое яблоко с надписью "Прекраснейшей". Среди гостей были Гера, Афина и Афродита, которые заспорили о том,  кому из них следует получить яблоко. Спор разрешил Парис, присудив яблоко Афродите, что послужило причиной ссоры между женщинами. В благодарность Афродита помогла Парису похитить Елену, дочь царя, из-за чего началась троянская война. 
       ♦ Эрида – от ар. حرض харрада "подстрекать". Гера – от ар. غيرى ге:ра: "ревнивая" (без определения ревнивая её имя в греческих мифах практически не употребляется). Афина (по-арабски أثينا Аси:на) в обратном прочтении по-арабски: آنثة ''а:ниса "дева". Афродита – от сложения ар. عفر ъафр "грива, барашек, в том числе волны" + рус.  родить: "рожденная из пены".
ЯБЛОКО6, попасть в самое яблочко – "точно, правильно угадать, сказать, попасть выстрелом в середину мишени".
       ♦ Яблоко издревле символизировало дела сердечные, сравните амуров, стреляющих из лука в яблоко. Пронзённое стрелой яблоко ­– символ сексуальной победы. Если в нижней любви яблоко символизирует женщину, то в  верхней любви (см. звезда Давида) яблочко символизирует Истину. В других терминологических парах термины нижней любви имеют уменьшительную форму, сравните лоб – лобок, голова – головка.
</span>
';
GO

exec spAddArticle 23071, N'Прямой перевод Spark - Direct translation', N'вяк, перевод, слова', N'
<span viak="translation">Spark(англ:искра)

</span><span viak="summary">
Spark(англ:искра) - спарка, спаровать
</span>
';
GO

exec spAddArticle 23421, N'Прямой перевод: Cross - Direct translation', N'вяк, перевод, слова', N'
<span viak="word">Cross

КРС - краса(оберег) краси(вый)(береженный) окрас крас(ка) кираса крыса cross крейсер корсар
СРК - сорок срок сорока срака сурок Саркел
КРш - крыша (оберегает дом сверху)
хРш - хорошо (защищено, надежно)
шРК - shark
</span><span viak="description">
<a href="http://viakviak.livejournal.com/19758.html">Красный</a>  - От ар.حرس хараса"охранять"(Вашкевич)
harass(ment)

КРС  удвоение смысла: Кир-царь:

К(и)Р: кор(оль), Рик, Рейх

С(а)Р: Сэр, Царь

Cross = оберег
Красота - обережение, сбережение, важное?

Царь, Король - имеют также смысл "защитник".

Красная площадь - Оборонительная, предохранительная, защитная плоская, ровная - место свободное от постоянных строений для предохранения крепости.

Car (повозка) - закрытая, "защищенная" (от погоды)
Рак - защищенный
</span>
';
GO

exec spAddArticle 23609, N'Палиндром: Йохан...', N'вяк, имя, шутка', N'
<span viak="word">
Йохан иди нахой
</span>
';
GO

exec spAddArticle 24060, N'Прямой перевод: Шабат (суббота)', N'бог, вяк, перевод, слова', N'
<span viak="word">
Шабат = Суббота

Суббота
СББТ
СвБд свобода

Саваоф
СВФ ~ шбт
Яхве-Саваоф (<a href="https://www.opusangelorum.org/priest_association/documents2/2003_05_god_of_hosts_with_us.html" target="_blank">Yahweh Sabaoth</a>h) - <a href="http://viakviak.livejournal.com/25986.html" target="_blank">Бог</a>-Освободитель

Еврейское "ох, вэй!" означает "Яхве" (Бог).

<a href="http://www.gotquestions.org/names-of-God.html" target="_blank">What are the different names of God and what do they mean?</a>

<a href="http://www.gotquestions.org/names-of-God.html" target="_blank">YAHWEH-SABAOTH</a>: "The Lord of Hosts" (Isaiah 1:24; Psalm 46:7) – Hosts means “hordes,” both of angels and of men. He is Lord of the host of heaven and of the inhabitants of the earth, of Jews and Gentiles, of rich and poor, master and slave. The name is expressive of the majesty, power, and authority of God and shows that He is able to accomplish what He determines to do.
</span>
';
GO

exec spAddArticle 24284, N'Что в имени твоем: Неделя', N'время, вяк, слова', N'
<span viak="word">Неделя
НДЛ надел (часть)

Нед(еля) наоборот - день

</span><span viak="description">
Суббота - Свобода
Воскресенье - день воскресения (Христа)
Понедельник - по(сле) не дела (выходного)
Вторник - второй
Среда - середина недели
Четверг - четвёртый
Пятница - пятый
</span><span viak="summary">
Представляется, что слово Неделя происходит от слова Надел, как деление времени. Слово День похоже является укороченной производной от обратного прочтения Надел.
</span><span viak="description">
Семь дней недели - это длительность фазы Луны, четверть лунного месяца и среднего женского 28-дневного цикла.
</span>
';
GO

exec spAddArticle 24427, N'Brexit', N'вяк, слова, шутка', N'
From Matt Decuir‎''s facebook post: https://www.facebook.com/photo.php?fbid=10104638295765140&set=gm.1206719006005539&type=3&theater

Brexit could be followed by Grexit, Departugal, Italeave, Czechout, Oustria, Finish, Slovakout, Latervia, Byegium. Only Remania will stay.
';
GO

exec spAddArticle 24622, N'Прямой перевод: Volume - Direct translation', N'вяк, перевод, слова', N'
<span viak="translation">Volume
</span><span viak="summary"
Volume - вольем - количество влитого.

По русски Объем, объемный очевидно происходит от "объять" - размер объятия, как широко надо обнять.
</span>
';
GO

exec spAddArticle 25067, N'Прямой перевод: Tennis - Direct translation', N'english, вяк, перевод, слова, спорт, шутка, эзотерика', N'
<span viak="translation">Tennis(англ:Теннис)

ТНС - Тунис Теннесси тонус
СНТ - Saint(англ:святой) сонет
зНТ - зенит
СНд - Синод cinder(окалина)
</span><p dir="ltr" viak="description">Tennis - Saint (<span style="line-height: 19.6px;">святой)</span></p><p dir="ltr">Теннис - это игра двух игроков с одним мячом на корте, перегороженном сеткой до 3х сетов, каждый из 6ти игр. Игрa идёт по правилам за которыми следит судья и публика. <i>Tennis is a game of two players with one ball on a court separated with a net up to 3 sets, 6 games each. Game has strict rules, presided by judge, and watched by public</i>.</p><p dir="ltr">Рассмотрим как это определение может быть интерпретированно. Let&#39;s see how the definition could be spinned.</p><p dir="ltr">Two + ball = duo-ball - devil
Слово &quot;Game&quot; в Английском кроме значения &quot;игра&quot; имеет значение &quot;дичь&quot;. Таким образом, теннисный корт может быть осмыслен как площадка для охоты.
<i>Court - track (reversed).</i> <i>Tracking</i>= следить
Court - корт - черта, черт(<a href="http://viakviak.livejournal.com/29208.html" target="_blank">переход к-ч</a>) = дьявол - devil
Черта, преступить черту, преступник.
<i>Ball</i>- шар, голова (<i>head</i>), балу (главный).
<i>Ball behind line</i>(мяч за линией - пределами/кромкой очерченной площадки)- преступник (<i>criminal</i>). Keep ball in the court.
<i>Court is a place of law.</i>Корт - это зал суда, место совершения правосудия.
<i>Zenit is a height above your head, could be interpreted as a moral height of a person.</i>Зенит - это высота над головой, что может быть понято как моральная высота человека.
<i>Ten-nis - sin-net</i>- сеть греха. <i>Net for </i><i>catching</i> <i>sins</i>. Сеть для улавливания грехов.</p>
<span viak="summary"><p dir="ltr">Попытаемся подытожить. Игра &quot;Святой&quot; - это судилище человеческой души и объявление приговора в момент 666. Душа наказывается за преступления или за совершение грехов. Душа становится &quot;святой&quot;, если человек совершает положительных поступков больше, чем отрицательных. Судья следит за соблюдением правил соревнующихся сторон, дает им право на атаку и защиту, ведет счет и выносит окончательный приговор.</p><p dir="ltr"><i>Let&#39;s try to summarize. Game &quot;Saint&quot; is a court for human soul until the moment 666. Soul is being punished for crimes and sins. Soul will be designated as &quot;saint&quot;, if more moral victories are found than failures. Judge watches for both sides to follow the rules during competition, gives them rights for attacking and defence, keeps score, and declares the final judgment based on score</i>.</p>
</span>
';
GO

exec spAddArticle 25093, N'Что в имени твоем: Червонный', N'вяк, слова, тело', N'
<span viak="word">Черв(онный)

ЧРВ - червь чрево черев(ички)
ВРЧ - <b>врач</b> ворча(ть)
кРВ - кровь кривая кров <b>корова</b> курва карава(н) крова(ть)
ВРк - ворко(вать) Ворку(та)
кРб - carbo(n) карб(ид) (с)карб коряба(ть) кораб(ль) короб краб акробат
бРк - оборки оброк барак бирка барка(с) берк(ут) абрек буряк брак
ЧлВ - <b>челове(к)</b>
ВлЧ - <b>величие</b> волчий влачить волочить вылечить величи(на) влече(ние)
Влк - <b>волк великий</b>
клВ - клюв клёв calve(англ: телиться) calf(англ:<b>теленок</b>,ср:корова) claw(коготь)
</span><span viak="description">
Рассматривая следующую цепочку слов: кровь, червь, корова, кривая, караван, великий, человек, корябать, волочить, чрево, черевички, кровать, враки, корабль - создается впечатление, что общим является смысл "оставляющий за собой след, отпечаток, впечатление".

Червонный - оставляющий кровавый след
Червонец - Карбованец - Гривна

Червонный- (<a href="http://viakviak.livejournal.com/29208.html" target="_blank">переход Ч-К</a>) "К"ервоный - Кровяный.
</span><span viak="summary">Червонный - Кровяный, цвета крови.
</span><span viak="description">
Слово "Врач" напрямую ассоциируется со словом кровь.
Мерилом Величи(ны) является Челов(ек) (читая наоборот).
Влачить, волочить - буквально: оставлять кровавый след
Влечение - буквально: запах крови (жертвы), след от притягивания
Величие - статус по праву крови (по наследству), оставляющий незабываемый след
Оброк - обязанность передающаяся по наследству (праву крови).
Бирка - налог передающийся по наследству (праву крови).
Волк, великий - кровавый
Клюв, Claw - органы раздирания до крови, оставляющие кровавые раны.
Клёв - кровавая охота (на рыбу).
Человек - оставляющий след, впечатление.
Чело - орган запоминания впечатлений, памяти.
Лицо - оставляющее впечатление, запоминайющееся (в человеке)
Шалом, Салом - (добрая) память (о человеке)
</span>
';
GO

exec spAddArticle 25435, N'Что в имени твоем: Пчела', N'вяк, слова', N'
<span viak="word">Пчела

ПЧ - пче(ла) печь <b>пучи(ть)</b> поч(ка) поча(ть) поч(та)  пече(нь)
ЧП - чип (chip) чпо(к) чапа(н)
бЧ - <a href="https://otvet.mail.ru/question/41660579" target="_blank">буче(ла)</a> быче(ла) бичь бече(вка) боч(ка)
Чб - чуб чаба(н) чебо(тарь) chubby(пухленький) Чубайс
Пк - пика poke pike пук(нуть)
Пщ - пища пища(ть)
щП - щуп щипа(ть) щепо(ть)
бк - бок бак бык бука(шка) бока(л) bake(готовить) baco(n) беко(н)
кб - куб кабе(ль) кобе(ль) Куба(нь) cab каби(на)
</span><span viak="description">
Выше были использованы переходы: href="http://viakviak.livejournal.com/33634.html" target="_blank">п-б</a>, href="http://viakviak.livejournal.com/29208.html" target="_blank">ч-к</a>, ч-щ.
</span><span viak="summary">
Создается впечатление, что слово Пчела имеет общий смысл "печь, пучить" очевидно, потому что укус пчелы вызывает жжение и опухоль.
</span><span viak="description">
Другие слова смыслового поля "печь, пучить":
Печь - ожог вызывает опухоль, жжение в животе сопровождается раздутием, нагревание обычно сопровождается увеличением объема.  Возможно распространенная форма печей была раздутой.
Пища - приготовленная в печи, разогретая, раздувающаяся от жара, взошедший на дрожжах хлеб.
Бочка - раздутая.
Чип, щуп, Пика, копье - колящие, вызывающие жжение и опухоль.
Bake, Bacon, Печень - от слова "печь"
Бык - с раздутым животом, предназначен для обжига во время приготовления, удар (укол) рогом вызывает жжение и опухоль.
Кобель - раздувающий самку.
Кабина - раздутой формы, вместительная
Чеботарь - бочечник
Куба - цвет спелых яблок, теплый, печеный.
Куба, Кубань - жаркие скотоводческие (чабан) страны.
</span>
';
GO

exec spAddArticle 25640, N'Что бы это значило: игра Футбол', N'english, вяк, слова, спорт, шутка, эзотерика', N'
<span viak="description">
Попытаемся понять эзотерический смысл популярной игры Футбол, созданный в его современном виде&nbsp;в&nbsp;Англии середины 19 века. <i>Let&#39;s try to understand the esoteric meaning of a very popular game Football (Soccer).</i>

<img alt="" src="http://ic.pics.livejournal.com/viakviak/75606786/4601/4601_900.gif" title="" />
<a href="http://www.football-bible.com/soccer-info/field-dimensions-markings.html" target="_blank">Что мы знаем о футболе?</a> <i>What do we know about football (soccer)?</i>

В футбол играют две команды противников по 11 человек в каждой - 10 полевых &nbsp;игроков и один вратарь. Игра ведется единственным мячом&nbsp;на прямоугольном поле разделенном пополам центральной линией в течении двух периодов времени (таймов) по 45 минут каждый с перерывом 15 минут между ними.&nbsp;По обе стороны поля каждой команде поставлены ворота для защиты в которых стоит вратарь команды. <i>There are two competing teams 11 players each - 10 field players and 1 goalie (goalkeeper). The game has one ball and it is played on a rectangular field divided by the Half Line during 2 periods of time 45 minutes each with 15 minutes break in between. On both sides of the field, each team has a gate to defend with a goalie in it.</i><div>
Игра начинается по жребию&nbsp;одной из команд с центра поля. &nbsp;Задача игры: каждая команда должна провести (&quot;забить&quot;) мяч в ворота противника как можно чаще&nbsp;и защитить свои ворота. Полевые игроки не должны касаться мяча руками, это может делать только вратарь в пределах своей &quot;штрафной&quot; площадки. Мяч не должен выходить за линию поля. Если нарушение происходит в &quot;штрафной&quot; площадке, пенальти (наказание) удар будет назначен с точки пенальти находящейся в 11 метрах от ворот. <i>Game starts from the Center Spot. Goal of a game: each team should get a ball into the gate of competitor as frequently as possible, and should defend its own gate. Field players should not touch a ball with their hands; only a goalie can do that inside his penalty box. Ball should not get out of the field. If rules are broken inside a penalty box, a penalty kick will be ordered from a Penalty Spot, which is located just 11 meters from a gate.</i>

Игра проходит под наблюдением судьи и его двух помощников.&nbsp;За игрой также следит публика. <i>Game is judged by a referree and his two assistants</i>.

Английские футбольные&nbsp;термины (<i>English soccer terms)</i>:
<i><span style="font-size:0.7em;"><span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">football, soccer (assocer short from &quot;football association&quot;).
field, center circle, center spot, half line, penalty box, penalty spot, penalty arc, touch line, goal box, corner arc.</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">two teams, one ball, 2 goals</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">22 players, 10 field players, 1 goalkeeper (</span><span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">goalie)</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">goal, offside</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">referee has 2 assistants</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">kicks: kick off, penalty, corner, free; throw-in</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">foot, chest, head; no hands</span>
<span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; background-color: rgb(255, 255, 255);">pass, save</span></span></i>

Глядя на футбольное поле сверху, с высоты птичьего полета, футбольное поле слегка &nbsp;напоминает двух гигантских борцов &nbsp;в схватке, упертых друг в друга огромными головами (центральный круг), плечами (центральная линия),&nbsp;и&nbsp;упирающиеся ногами (штрафные площадки) в разные стороны. <i>Looking at the football (soccer) field from above, it looks </i><i>somewhat </i><i>like two giant wrestlers in a great grapple, pushing </i><i>against </i><i>one another with their heads (Center Cirle) and shoulders (Half Line), and abut with their feet into different directions.</i></div><div>
Тогда 10 полевых игроков можно отождествить с пальцами обеих рук этих гигантов, которые пытаются загнать мяч в ворота соперника. С точки зрения муже-подобной анатомии футбольных гигантов, 11-ый игрок (вратарь) будет соответствовать 11-му пальцу (пенису), точка пенальти - пупку, а находящиеся сзади вратаря ворота (goal, цель, щель) - анусному отверстию.&nbsp;Так как цель игры - забить мяч в ворота,&nbsp;то продолжая &quot;аналогию&quot;, мы можем увидеть в мяче (шар, ball,&nbsp;голова, головка) -&nbsp;пенис (камешек, игрушка),&nbsp;что превращает наших&nbsp;футбольных гигантов в гомосексуальных борцов (греко-римской борьбы?). <i>Next, the 10 field players could be identified as the fingers of both hands of those giants, who try to get a ball into opponent&#39;s gate. From the man-like anatomy of football (soccer) giants, 11th player (goalie) is correlated to 11th finger (penis), Penalty Spot is correlated to belly button, and gate behind a goalie - anus hole. Since the goal of a game is to get a ball into a gate, we can continue an &quot;analogy&quot; and see in the football (ball, head) - an attacking penis (round stone or toy), which turns our </i><i>half-field </i><i>football giants into homosextual wrestlers (Ancient Greek wrestlers, maybe?).</i></div><div>
Таким образом, эзотерический смысл популярной игры Футбол - гомосексуальная борьба. <i>Summary: the esoteric meaning of the popular game Football (Soccer) is a homosexual wrestling.</i>

P.S.&nbsp;Мы знаем, что в классической (греко-римской) борьбе соперника пытаются положить на лопатки. И все?&nbsp;Может быть традиционная история скрывает дополнительную составляющую этой борьбы, из которой и родился современный футбол? <i>We know that in classic </i><i>(Ancient Greek)</i><i> wrestling the goal is to put an opponent on his shoulder blades. Is that all there is to it? It could be that traditional history hides an additional component to Greek wrestling, which could possibly give a birth to the modern Football (Soccer).</i></div><div>
P.P.S.</div><ol>
<li>Откуда берется название &quot;<b>асс</b>истент&quot; (<i>ass-sis-tent</i>) и какова их истинная роль?</li>
<li>Анус (<i>Anus</i>)&nbsp;- сунь (читая наоборот).</li>
<li><i>Belly button</i> (беллу, пупок) -&nbsp;(про)били?</li>
<li><i>Penalty - P(anal)ty?</i></li>
<li><i>Soccer is short from <a href="http://www.bbcamerica.com/anglophenia/2013/10/football-vs-soccer-how-terminology-differs-between-america-and-britain" target="_blank">assoccer</a> (<i>association </i>football). That is what we are told, but could it be&nbsp;a name for a game loser that should get a <i>similarly sounding </i>&quot;punishment&quot;?</i></li>
<li><i>Goal - hole?</i></li>
</ol><i>P.P.P.S. </i><ol>
<li>Хоккей - то же самое, но одной гигантской&nbsp;рукой (5 полевых игроков)&nbsp;и на скользкой (напомаженной) &quot;коже&quot;. <i>Hockey is the same, but with one giant hand (5 field players) and on slippery (oily) &quot;skin&quot;.</i></li>
<li>Basketball -&nbsp;то же самое, &nbsp;одной гигантской&nbsp;рукой (5 полевых игроков), но руками вместо ног&nbsp;и&nbsp;с высоко-поднятыми &quot;целями&quot;. <i>Basketball is the same </i><i>with one giant hand (5 field players), but with hands instead of legs and&nbsp;high-placed &quot;holes&quot;.</i></li>
</ol>
</span>
';
GO

exec spAddArticle 25986, N'Что в имени твоем: Бог', N'бог, вяк, имя, слова', N'
<span viak="word">Бог

БГ - бог бег убог бугай баге(т) бога(тство) boogey(man) боге(ма)
ГБ - губа гб(гос-безопасность) гоб(лин) гибе(ль)
Бх - бох бах баху(с) Бах Bahai бух бух(ло) Bohemia
хБ - хб(хлопчато-бумажный) хиба(ра) хобо(т)
Бк - бык бок бук(ва) абак бак байка bake bike beacon буек
кБ - куб Кааба кб(конструкторское бюро) каба(н) каба(ла)
Бж - боже беже(вый) буже(нина) бижу(териа) беже(нец)
жБ - жаба жбан
вГ - выго(да) ваго(н) выго(н) ваги(на) Vogue vega(n)
Гв - гав(лай) гав(но)
Бр - бор бар beer  боро(да) бари(н) бура(н)
рБ - рыба раб рябь raby раби(н) ряби(на) рабо(та) руби(ть)
вж - вожжи вежа уваже(ние)
жв - живой живо(т) жева(ть)
кв - КВ(танк) кова(ть) киве(р) кува(лда) Кав(каз) cave кива(ть)
вк - век веко
вх - веха вах(возглас) вах(мистр)
хв - Яхве хва(ла) хава(ть) Хива hove(r)
</span><span viak="summary">
Представляется, что слово <a href="http://viakviak.livejournal.com/38894.html" target="_blank">Бог может означать Движение</a>, как одно из основных качеств Материи (см. также: <a href="http://viakviak.livejournal.com/11024.html" target="_blank">Аллах, Элохим</a>, <a href="http://viakviak.livejournal.com/12976.html" target="_blank">Яхве, Иегова</a>, <a href="http://viakviak.livejournal.com/39064.html" target="_blank">Господь</a>).
</span><span viak="description">
Я бы особо выделил следующую цепочку слов: <b>Бог - <a href="http://viakviak.livejournal.com/12976.html" target="_blank">Яхве - Иегова(Jehovah)</a> - Vogue(популярный) - живой - куб(Кааба) - век - веха - рыба - раб - веко</b>

Несмотря на то, что любое из близких по звучанию слов, может быть ассоциировано с словом Бог, мы можем видеть, что исторически, некоторые из их были использованы чаще, чем другие.

Раб божий ~ Раб Бога - очевидный палиндром (при переходе г-р/грассирование). Это дает удвоение смысла (бог-бог).

Человек - Чело+век - Лицо бога. Это может отнесено к фразе "...по образу и подобию своему...".
</span>
';
GO

exec spAddArticle 26247, N'Что в имени твоем: Омар Хайам', N'вяк, имя, слова', N'
<span viak="name">Омар Хайам
</span><span viak="description">
Omar Khayyam
Umar Khayyam
</span><span viak="summary">
Омар Хайам - Умер к #уям?
</span>
';
GO

exec spAddArticle 26397, N'Что в имени твоем: София', N'вяк, имя, слова', N'
<span viak="name">София

СФ - София софит сфера асфальт Софокл Исфирь
ФС - фосфор
Св - <a href="http://viakviak.livejournal.com/11024.html" target="_blank">свет</a> сова совет сват сев свой
вС - вес весы авось 
</span><span viak="summary">
София - светлая, святая
</span><span viak="reference">
Из Wiki: <a href="https://ru.wikipedia.org/wiki/%D0%A4%D0%BE%D1%81%D1%84%D0%BE%D1%80" target="_blank">...Фо́сфор (от др.-греч. φῶς — свет и φέρω — несу; φωσφόρος — светоносный; лат. Phosphorus)...</a>
</span>
';
GO

exec spAddArticle 26844, N'Прямой перевод: Tired - direct translation', N'вяк, перевод, слова', N'
<span viak="translation">Tired

ТРД - труд тирада отрада
ДРТ - дарт драть удирать дроти(к)
фРД - Фарадей fraud afraid Fred Ford Афроди(та) Фердоу(си)
ТРт - треть тереть трата троти(л) труте(нь)
ТлД - Толедо отлади(ть)
ДлТ - долото дельта
</span><span viak="summary">
<i>Tired</i> - утрудился от слова "труд" (work)
</span><span viak="description">
<i>Tired from work</i> (англ: устал от труда) - билингва и удвоение смысла
</span>
';
GO

exec spAddArticle 26993, N'Что в имени твоем: Совет', N'вяк, слова', N'
<span viak="word">Совет

СВТ - совет свет сват <a href="http://viakviak.livejournal.com/11024.html" target="_blank">святой</a> (пре)свите(р)
ТВС - отвес
СВд - свида(ние) свадь(ба) сведе(ния)
дВц - девица
СбТ - суб(б)ота съ?бать(ся)
ТбС - тубус
СфТ - <a href="http://viakviak.livejournal.com/26397.html" target="_blank">софит</a>

</span><span viak="summary">
<b>Совет - осветить</b> (вопрос), <b>пролить свет на</b>...
</span><span viak="description">
Отвес - вертикальный как падающий сверху свет
Тубус - со светлой дыркой
</span>
';
GO

exec spAddArticle 27188, N'Что в имени твоем: Зима', N'вяк, деньги, слова', N'
<span viak="word">Зима

ЗМ - зима змей заем
МЗ - мазь муза музы(ка) мз(да) моз(г)
См - сам сум(к)а сумма съём(ка) семь (в)осемь семя
мС - месса мессия миссия масса мусс мыс mess(англ:беспорядок)

</span><span viak="summary">
зима - скользкая
</span><span viak="description">
змея - скользящая
мess - скользкий, нестабильный
мессия - рожденный зимой
музыка - ускользающая
заем - ускользнувшие деньги
мзда - склизкие (грязные) деньги.
мозг - склизкий орган.
</span>
';
GO

exec spAddArticle 27526, N'Что в имени твоем: Времена года', N'', N'
<span viak="summary">
<a href="http://viakviak.livejournal.com/27188.html" target="_blank">зима</a> - скользкая (сезон скользкой погоды)
весна - (в)Ясна (в ясную погоду)
лето - отел (сезон отела скота)
осень - осенило (сезон сбора сена)
</span>
';
GO

exec spAddArticle 27831, N'Прямой перевод: Hotel - direct translation', N'вяк, перевод, слова', N'
<span viak="translation">Hotel

</span><span viak="summary">
Hotel - отел (место для отела, отдыха животных и их хозяев; <i>place to calve and rest for cattle and their owners</i>)
</span>
';
GO

exec spAddArticle 28015, N'Прямой перевод: Given - Direct translation', N'вяк, компания, перевод, слова', N'
<span viak="translation">Given (англ: данный, выданный, выделенный)

ГВН - гавно, гиена (в-е), гуано (в-а)
НВГ - Новго(род)
НВк - новик
кВН - квн (ТВ передача)
кбН - кабан кабина
Нбк - набекрень

</span><span viak="summary">
Given - гавно
</span><span viak="description">
----- More:
<a href="http://www.givenchy.com" target="_blank">Givenchy</a>
ГВНЧ
Гавнючий
<i>Givenchy</i> - гавнючий(<i>rus:shitty</i>)
</span>
';
GO

exec spAddArticle 28236, N'Прямой перевод: Bagel - direct translation', N'english, вяк, перевод, слова', N'
<span viak="translation"><a href="https://en.wikipedia.org/wiki/Bagel" target="_blank">Bagel</a> (англ:бублик)

bagel
БГЛ - беглый
БкЛ - бакалея бокал бакла(н)
ЛкБ - ликбез
БхЛ - бухло бахилы
вкЛ - вокал
вхЛ - выхлоп

</span><span viak="summary">
Bagel - бакалея
</span><span viak="description">
Дополнительно: английское слово "bagel" очень близко к французкому "багет", и также может быть произведено от слова "бублик" перевертыванием второго русского "б" в английский "g": бубли(к) - bagel. Если помнить, что слово "bagel" было принесено польскими (российскими) евреями в Америку в начале 20 века, то перевод от кирилицы "б" в латиницу "g" не представляется невозможным.

Additionally: English "bagel" is very close to French "baget" and could be derived from Russian "бублик" by simple flipping of second Russian letter "б" into English "g". Remembering that word "bagel" was introduced by Polish (then part of Russia) Jews at the beginning of 20th century in USA, then transition of Cyrillic "б" into Latin "g" could be plausible.
</span>
';
GO

exec spAddArticle 28551, N'Прямой перeвод: Fellow - Direct translation', N'', N'
<span viak="word">Fellow

ФЛ - фаллос фиалка fool(англ:глупец) fail(англ:терпеть неудачу)
тЛ - отел тело тля Тула
Лв - <a href="http://viakviak.livejournal.com/22974.html" target="_blank">love</a> лев улов ловля лава олива
вЛ - вилы вал вол Ваал 

</span><span viak="summary">
Fellow - тело
</span><span viak="description">
Сравни/<i>Compare: body - friend</i>, друг.
</span>
';
GO

exec spAddArticle 28792, N'Прямой перевод: Pain - Direct translation', N'', N'
<span viak="translation">Pain

ПН - пинать пан piano(англ:пианино) пони пена pinot(англ:вино)
</span><span viak="description">
pinot - молодое виноградное вино, которое традиционно давится ногами.
</span><span viak="summary">
Pain - пинать
</span>
';
GO

exec spAddArticle 29146, N'Прямой перевод: Path - Direct Translation', N'вяк, перевод, слова', N'
<span viak="translation">Path

ПТ - путь pit пот опята паять пить петь пять петух пятка питон питание
ТП - тип тапки top топчан topic тупой tapas топаз тяпка тепло топить
бТ - батя бот ботинки ботаника bet батон бутон бетон баять боятся 
Тб - тебя табак tube туба табор 
Пф - puff пуфик 
Пд - падение под
дП - deep дупло 
бф - buff буфет beef buffalo 
фб - фобия
</span><span viak="summary">
Path - путь
</span>
';
GO


exec spAddArticle 29208, N'Переход: Ч - К', N'вяк, переход, слова', N'
<span viak="transition">Устойчивый переход "Ч - К" и обратно.
</span><span viak="description">
Прозрачные примеры:
алЧность - алКать, боК- боЧок, браК- браЧный, веК - веЧность, всякий - всячина, диЧь - диКий, драКа - драЧливый, дьяК(duke) - дуЧе(duche), клиЧ - оклиКнуть, коКон - коЧан, криК - криЧать, КуКла - ЧуЧело, леКарь - леЧение, лиК - лиЧико(лиЧина), липКий - липуЧий, луК - луЧник, моКнуть - моЧить, муКа - муЧить, мыЧание - мыКать, наука- науЧить, оКо - оЧи -оЧки, паКет - паЧка, пеЧь-пеКарь, ПиКа - ПиЧок(тюрк), поКои - опоЧивальня, попереК - попереЧный, пуКать -пуЧить, реЧь - реКёт(говорит), реКа - реЧной, руКа - руЧной, рыК - рыЧать, риК - криЧать, сеКтор - сеЧение, соК - соЧный, сраЧ- сраКа, теЧение - протеКать, толКать - толЧок, туроК-турЧанка, Часто - Куст(Густо), человеК - человеЧеский, Черствый - Короста - crust, Черта (Чертеж,CHarter) -Карта(Court), четыре - quattro, Чудо - Кудесник, ...

Здесь даже не приводятся поимеры стандартного перехода для уменьшительно-ласкательных слов, таких как: мальчиК - мальЧонка, девКа - девоЧка, и т.д.

Возможные переходы:
Cargo-CHarge, поКемон-поЧемун, мяЧ - мяКоть, <a href="http://viakviak.livejournal.com/13513.html" target="_blank">king - Чинг(из-хан)</a>

Здесь мы видим, что в английском буква Ч передается комбинацией CH, где первая английская часто озвучивается как "К".
</span><span viak="summary">
Таким образом мы можем попытаться рассматривать комбинации английских букв передающие простые русские звуки как своего рода подсказку или намек на возможный переход букв.
</span><span viak="description">
В статье "<a href="http://viakviak.livejournal.com/4423.html">Греческий язык - это Русский!</a>" автором дается другой подход к переходу Ч-К с точки зрения совпадения числового значения букв Ч и Q, соответственно, в русском и греческом алфавитах.
</span>
';
GO

exec spAddArticle 29617, N'Прямой перевод: Preach - Direct Translation', N'вяк, перевод, слова', N'
<span viak="translation">Preach

ПРЧ - причастие при(т)ча прочий пречистый перечить approach
ЧРП - череп
ПРк - парк порка прокат паркет
кРП - крепить крапинка крапива окропить укроп карп crap creep
бРк - брак барак оброк бурка бирка оборки баркас беркут абрек буряк
кРб - короб краб акробат carbon карбид скарб корябать корабль
клП - клепать клоп
Плк - полк полка пеликан pluck(англ:срывать) Полкан

</span><span viak="summary">
Preach - Причастие, Притча
</span>
';
GO

exec spAddArticle 29842, N'Что в имени твоем: Рана', N'вяк, слова', N'
<span viak="word">Рана
РН рана рань руно урна renew(англ:возобновить) уран urine(англ:моча) Иран Рина Ирина Раневская Reno
НР нарыв нарвал нарвать нора нары нырять наяривать
лН лоно лен лень Алёна лиана Луна loan loin lean лунь Лена Лина Элина
Нл ноль anal Нил
</span><span viak="summary">
Представляется, что слово Рана находится в смысловом поле "открыть, открытый".
</span>
';
GO

exec spAddArticle 30099, N'Что в имени твоем: Час', N'вяк, имя, слова', N'
<span viak="word">Час

ЧС - час часы часто чес часовня часовой часослов частокол
СЧ - сечь сучить сочится Сочи счастье
кС - каса(турк:хаза, сакля, дом) касса cash(англ:наличные) kiss(англ:поцелуй) укус уксус икс castle(англ:крепость) костел киса коса axe(англ:топор)
Ск - sick(англ:больной) сука Осака sky ski сакля секунда
кз - кази(судья) коза казак казан
зк - закон зэк(заключенный)
</span><span viak="description">
Представляется важной следующая цепочка слов: каса, часовня, часовой, сакля, касса, костел, castle, кази(судья), коза, казак, казан.
Эти слова так или иначе имеют отношение к понятиям "дом", "домашний", "одомашненный", "местный".

Другое направление: часто, сучить, сочится, чес(ать) сечь, коса, axe. Эти слова описывают периодичность или непрерывность действия.

А еще: сечь, коса, axe, kiss, укус, чес могут ассоциироваться со смыслом "ударить": часы бьют.

Слово Секунда имеет прямую корневую связь со словом Час.
</span><span viak="summary">
Представляется, что слово Час является производным от слова Часовня, которая в свою очередь имеет смысл "дом, домашний".
</span>
';
GO

exec spAddArticle 30351, N'Прямой перевод: Domestic - Direct translation', N'', N'
<span viak="word">Domestic(англ:домашний)
</span><span viak="description">
Domes(tic) = Domash = Домаш(ний) при переходе "С - Ш"
(Do)mest(ic) = мест(ный)
</span><span viak="summary">
Domestic - домашний + местный
</span>
';
GO

exec spAddArticle 30472, N'Прямой перевод: Teacher - Direct translation', N'', N'
<span viak="translation">Teacher

ТЧ - teacher, teach
ЧТ - читать читка чет(нечет) учет учитель

</span><span viak="summary">TeaCHer - уЧиТель
</span>
';
GO


exec spAddArticle 30779, N'Прямой перевод: ...bourg - Direct translation', N'вяк, перевод, слова', N'
<span viak="suffix">-bourg (-бург)
БРГ - берег брага оберег бург(омистер) (Петер)бург (ки)борг Бургу(ндия)
ГРБ - гроб грабить гриб греб(ля) герб горб Аграба
БРк - барак баркас оброк бирка буряк брыкать бурка брак brick(англ:кирпич) бреак(англ:ломать)
кРБ - короб корабль crib(англ:детская кроватка) краб акробат
БРж - буржуа биржа баржа Боржоми Брежнев
жРБ - жеребец жребий
вРГ - враг овраг
ГРв - гривна aggravation(англ:раздражение,гнев) grave(англ:могила) groove(англ:канавка,ручей,выбоина)
БРх - брехня(укр:враки)
хРБ - хребет храбрый
кРв - корова кривая кров кровь кровать
вРк - враки варка
вРх - верх
хРв - хоровод
</span><span viak="description">
-bourg (-бург) - берег, город на берегу, оберег

<i>Peterbourg, Burgundy, ...</i>
Петербург, Бургундия, ...

барак - безопасное место для скота, зимние квартиры для армии.
берег - безопасное место в отличие от моря.
Бургундия - Бург+индия - безопасная Индия (далекая окраина)
оберег - талисман для повышения безопасности
овраг - безопасное место, откуда не скатишься
...

</span><span viak="summary">
Думается, что окончание -бург состоит в смысловом поле "берег, оберег"
</span>
';
GO

exec spAddArticle 31060, N'What is in the name: Chocolate. Шоколад - что в имени твоем?', N'english, вяк, имя, слова', N'
<span viak="word">Chocolate (англ:шоколад, звучит как "Чоколат")
</span><span viak="description">
<a href="http://viakviak.livejournal.com/29208.html" target="_blank">Переход Ч-К</a>

</span><span viak="summary">Choco+late = Чоко+лат = Cacao-latte - какао с молоком
</span><span viak="description">
Примечание: эта простая версия по-видимому неизвестна. </span><span viak="reference">См Вики: "...слово «шоколад» происходит от ацтекского слова «xocolātl» («чоколатль»), что буквально означает «горькая вода» (науатль xocolli — «горечь», ātl — «вода»)(2). Исходное слово xocolātl, однако, не встречается ни в одном из текстов колониального периода; его существование — гипотеза лингвистов..."

</span><span viak="description"><i>This simple version is aparently not known. </span><span viak="reference"><a href="https://en.wikipedia.org/wiki/Chocolate" target="_blank">See Wiki</a>: "... comes from Nahuatl, the language of the Aztecs, from the word chocolātl, which many sources say derived from xocolātl Nahuatl pronunciation: (ʃokolaːtɬ), combining xococ, sour or bitter, and ātl, water or drink.(8) The word <b>chocolatl</b> does not occur in central Mexican colonial sources, making this an unlikely derivation..."
</i></span>
';
GO

exec spAddArticle 31341, N'What is in the name: Evening - что в имени твоем', N'english, вяк, имя, слова', N'
<span viak="word">Evening
</span><span viak="summary">
Evening could be understood as a time of a day to get "even" - end of a day.
</span>
';
GO

exec spAddArticle 31712, N'Что в имени твоем: Свастика', N'вяк, имя, слова', N'
<span viak="word">Свастика

СВСТ - свастика
зВзд - звезда

</span><span viak="summary">Свастика = звезда

</span><span viak="description">
Похоже подтверждается, что свастика является звездным символом.
Дополнительно (благодаря наблюдательности <i><a href="http://lengvizd.livejournal.com/">lengvizd</a></i>):

СВСТК- свастика
зВздК - звездка
Обратим вниманиние на получившееся слово "звездка". Как-то не по-русски выглядит. Мне это напомнило прочитанную давно фразу на коверканном русском: "матка, курки, яйки" в книге про оккупацию в Великую Отечественную. Немецкий? Присмотримся еще раз, но уже с учетом перехода "Ч-К":  "матУШКа, куроЧКи, яИЧКи". Вот это-то уже нормальный русский. А теперь, внимание:
звездКа - звездоЧКа

</span><span viak="summary">Таким образом, слово Свастика - это просто калька с русского Звездочка!
</span><span viak="description">
(с)вастика - с востока

восток - воздух
</span>
';
GO

exec spAddArticle 31981, N'What is in the name: Vagina - что в имени твоем', N'english, вяк, имя, слова', N'
<span viak="word">Vagina

ВГН - вгонять, вoгнать вогнутый вагон Афган(истан) Ваганское
ВжН - <a href="http://viakviak.livejournal.com/40280.html" target="_blank">важно</a> (ск)важина (ск)возняк
НжВ - нажива наживую
бГН - бегун обгон
бжН - бужени(на) боженька

</span><span viak="description">Рассматривая цепочку: "скважина, сквозняк, вгонять, вoгнать, вагон, обгон" создается впечатление, что слово Вагина находится в смысловом поле "пропускное (отверстие)", "проходить через".
</span><span viak="summary">
It seems that word Vagina is in the context of "(go) through (<a href="http://viakviak.livejournal.com/40280.html" target="_blank">hole</a>)".
</span>
';
GO

exec spAddArticle 32225, N'What is in the name: Commerce - что в имени твоем', N'вяк, имя, слова, торговля', N'
<span viak="translation">Commerce (торговля, коммерция)

<i></span><span viak="description">Word Commerce is almost exactly the same as word with another meaning "comers". </span><span viak="summary">It seems that originally commerce was done with traders from abroad that came onshore (comers).</i>
</span><span viak="description">
Слово "Commerce" почти что тоже самое как и слово "comers", что означает "пришельцы", "пришлые", "посетители". <span viak="summary">Очень похоже, что вначале коммерция была с пришельцами из-за рубежа, с моря (comers).
</span>
';
GO

exec spAddArticle 32311, N'Что в имени твоем: Музыка', N'вяк, музыка, слова', N'
<span viak="word">Музыка

МЗК - музыка мазок
<a href="http://viakviak.livejournal.com/8418.html" target="_blank">МсК</a> - маска Москва mosque(мечеть) mosquito(комар) мускат musket(мушкет)
КсМ - космос космы
<a href="http://viakviak.livejournal.com/29208.html" target="_blank">ЧсМ</a> - Чесме(нская бухта)

Принимая в внимание статью "<a href="http://viakviak.livejournal.com/8418.html">Что в имени твоем: Масса</a>", где уже рассматривалась цепочка "маска, Москва, mosque(мечеть) mosquito(комар), космос" в контексте "множество, многолюдность", </span><span viak="summary">можно предположить, что слово Музыка вначале обозначало "мелодия для публики".
</span>
<lj-like buttons="repost,facebook,twitter,google,vkontakte,odnoklassniki,tumblr,livejournal" />
';
GO

exec spAddArticle 32662, N'Что в имени твоем: Сковорода', N'вяк, еда, слова', N'
<span viak="word">Сковорода
</span><span viak="summary">
Представляется, что слово Сковорода может происходить от понятия "сковырнуть", отражающее технику приготовления еды на сковороде.
</span>
';
GO

exec spAddArticle 32945, N'Что в имени твоем: Колобок', N'вяк, имя, сказка, слова', N'
<span viak="word">Колобок

Используем переходы: <a href="http://viakviak.livejournal.com/29208.html" target="_blank">К-Ч</a>, <a href="http://viakviak.livejournal.com/33634.html" target="_blank">Б-В</a>

КлБк = ЧлВк
Колобок = ЧелоВек

</span><span viak="summary">
Таким образом, известный сказочный персонаж Колобок - это просто калька со слова Человек.
</span>
';
GO

exec spAddArticle 33253, N'Что в имени твоем: Курок', N'Вашкевич, вяк, слова', N'
<span viak="word">Курок
</span><span viak="description">
Курок - прикуриватель, (о)курок.

Ассоциация с петухом или, соответственно, с жар-птицей происходит из-за не имеющего никакого тношения, но похожего слова "курица", которое может происходить от способа её приготовления - окуривания.

Создается впечатление, что слово Курок стало использоваться до появления "ударных механизмов", во времена, когда это был только "курящийся" трут.
</span>
<lj-cut><span viak="reference">
Этимологический словарь русского языка Макса Фасмера:

WORD: куро́к
GENERAL: род. п. -ка́. Как и польск. kurek (откуда русск. слово, возм., заимств.), калькирует нем. Наhn "петух"; "курок"; к кур. Аналогично англ. сосk, датск. hаnе, лит. gaidỹs, лтш. gailis, болг. петелка; см. Сандфельд, Festschrift V. Тhоmsеn 168; Преобр. I, 417; Желтов, ФЗ, 1875, вып. 3, стр. 7.
PAGES: 2,427


Из Н.Н.Вашкевича:

КУРОК – "часть ударного механизма в ручном огнестрельном оружии". (БЭКМ).
♦ Образование на рус. почве с помощью суффикса ок (как в сырок) от ар. ка-вар "подобное кресалу", являющегося сложением сравнительной частицы К (ك) и  واري ва:р(и) "кресало", "то, чем разводят огонь", производное от ورى вара: "загораться". (М., с. 898). Того же корня, что и Аврора (см.).

КУРИЦА1 – "одомашненный вид птиц отряда куриных, с кожным выростом на голове (гребнем) и под клювом (серёжками)". (БЭКМ).
♦ Того же происхождения, что и ар. قرقة курка "курица", которое идет отكروى  куравий "округлый, овальный. яйцевидный", производное от كورة  ку:ра "шар"; ср. ар. دجاجة дажа:жа (дайа:йа, дага:га), букв. "дающая яйца".
КУРИЦА2, как курица лапой (писать) – "неразборчиво, так, что нельзя понять". (ФСРЯ).
♦ За рус. курица скрывается ар. قرس куриса "замерзший", т.е. как замерзшей лапой. См. Карское море, карачун. Из-за своего звучания в рус. языке курица в мировом поле смыслов вызывает ассоциации мороза и наоборот. Так, куриный день на Руси приписан к 15 января, когда бывают лютые морозы, и по поведению курицы на шестке предсказывают степень морозности (см. РНК). Известному англ. философу Фрэнсису Бэкону ранней весной 1626 года пришла идея, что на морозе можно хранить мясо. Он тут же купил курицу и начинил её снегом, но простыл, заболел и через десять дней (9 апреля) умер (его хватил карачун). Но пока ученый умирал он, как курица лапой, описывал свой печальный эксперимент (см. Брокгауз). Корсиканцу по имени Наполеон, как и всем французам (галлам, т.е. петухам) за русскими морозами, по-арабски курис "обмороженный" почудились курицы, что заставило их ринуться на Русь на зиму глядя, где они устроили догонялки, брачные танцы куриных (от ар. دواجن дава:гин "домашняя птица", от рус. догонять). Русские не только вступили в игру, но и обеспечили место, где петухи согрелись. Ср. мысли петуха, догоняющего курицу: "не догоню, так хоть согреюсь". Ср. также догоны (см.), которых придумал французский африканист.
КУРИЦА3, мокрая курица – "о жалком, беспомощном на вид человеке", "о безвольном, бесхарактерном человеке". (ФСРЯ).
♦ За рус. курица ар. ك ريض ка ри:ца "как облитый водой", производное от ар روض раввад (ар. Д эмфатическое переходит в Ц). Рус. значение идиомы возникает от второго значения данного ар. глагола: "укрощать". Ср. разливание водой дерущихся собак
</span></lj-cut>
';
GO

exec spAddArticle 33360, N'Переход Г - Х', N'вяк, переход, слова', N'
<span viak="transition">Устойчивый переход: Г - Х
</span><span viak="description">
Устойчивый переход Г-Х очевиден на примере Украинского языка, где все слова с буквой Г произносятся со с смягчением как Х.
</span>
';
GO

exec spAddArticle 33634, N'Переход "звонкий-глухой"', N'вяк, переход, слова', N'
<span viak="transition">
</span><span viak="description">
Переход "звонкий-глухой" является классическим общеизвестным фактом. Примеры:
Б-В barbarian-варвар, Barbara-Варвара
<a href="http://viakviak.livejournal.com/33360.html" target="_blank">Г-Х</a>
Д-Т
З-С-Ц
Ж-Ш
К-Х
Щ-Ш</span>
';
GO

exec spAddArticle 33794, N'Что в имени твоем: Буратино', N'вяк, имя, сказка, слова, шутка', N'
<span viak="word">Буратино

БРТ - брат борт аборт обрат
ТРБ - труба trouble(англ:хлопоты) теребить тюрбан отребье
дРв - дерево дурево
вРд - вред вроде
вРТ - ворота веретено варить врать
ТРв - трава отрава

</span><span viak="description">
Попробуем описать Буратино из полученных из его имени слов: 
</span><span viak="summary">
Деревянный братан got in trouble (попал в переделку), заварил такую кашу - труба, с отребьем по дуреву, но вроде воротился обратно невредимым.
</span>
';
GO

exec spAddArticle 34092, N'Что в имени твоем: Раз, два, три, четыре, пять, шесть, семь, восемь, девять, десять', N'вяк, слова, число, шутка', N'
<span viak="word">Раз
</span><span viak="description">
Сравнивая слова "раз" и "один" видно, что слово Один мотивировано позицией числа Один в общем числовом ряду. С другой стороны, слово Раз не мотивированно, что указывает на его первичность. Это сейчас мы отождествляем слово Раз с понятиями Один и Первый, а вообще то, Раз это не слово, а приставка "раз-" или "рас-". Эта приставка используется  для обозначения раскрытия, раздвигания, разрывания, расхождения, и т.д. и т.п.

Почему приставка стала использоваться как самостоятельное слово?  И только в числовому ряду?

Просматриваясь к словам числового ряда и пытаясь использовать слово Раз как обычную приставку, мы получаем слово Раздва, которое очень сильно напоминает современное русское слово Раздвинуть в повелительном наклонении, вроде современного Раздвинь. Рассмотрим числовой ряд  повнимательнее:

<b>Раз, два, три, четыре, пять, шесть, семь, восемь, девять, десять</b>

Если числовой ряд представляет собой сообщение или наказ по примеру <a href="http://royallib.com/read/kesler_yaroslav/azbuka_poslanie_k_slavyanam.html#0" target="_blank">Азбуки (по Ярославу Кеслеру)</a>, то мы можем проигнорировать современное разделение числового ряда на отдельные слова, и попытаться прочитать его полностью. При этом мы должны понимать, что это будет скорее перевод на современный русский язык, и переступить через ханжество и современное табу на "неприличные" слова в поисках истины.

Попробуем так:
<b>раздва, три, че тыре, епятьш, есть, семь, во семь девя тьде сять</b>
<lj-cut>
Здесь нам уже понадобятся знания о переходах звуков: <a href="http://viakviak.livejournal.com/29208.html" target="_blank">Ч-К</a>, <a href="http://viakviak.livejournal.com/33634.html" target="_blank">Т-Д, Б-П</a>, Ш-С:
<b>раздва, три КеДыр, еБятьС, есть, семь, во семь девя тьде сять</b>

Слегка изменим гласные, которые в старом письме были не принципиальны, чтобы смысл устаревшего письма был более понятен современникам:
<b>раздви, тори к дыре, ебаться, есть семя в сём деве, тоды ссать</b>

Как видим разницы между оригинальным и измененным текстами практически нет. А теперь дадим расширенный перевод на современный русский язык:

</span><span viak="summary">
<b>Раздви</b>(нь ей&nbsp;ноги), <b>тори </b>(приблизься) <b>к половому отверстию</b>, продолжай <b>половой акт</b> до тех пор когда уже <b>есть семя в этой деве,</b> <b>тогда </b>после этого надо <b>помочиться</b>.
</span><span viak="description">
Я не настаиваю именно на таком переводе, хотя он кажется вполне логичным в общем смысловом контексте "плодитесь и размножайтесь" с заботой о мужском здоровье в конце наказа.

Представляется, что как и староруская "Аз-бука", Числовой ряд был сначала наставлением, наказом (наказ = закон). После долгового времени,  этот наказ стал общим местом, культурным фактом, и впоследствии был разделен на слова-числа достаточно произвольным образом.
</lj-cut></span>
';
GO

exec spAddArticle 34476, N'Переход: Т - Ф', N'вяк, переход, слова', N'
<span viak="transition">Устойчивый переход: Т - Ф
</span><span viak="description">
Thomas (Томас, Том) = Фома
Bartolomeo = Варфоломей
Th = Ф
</span>
';
GO

exec spAddArticle 34642, N'Переход: С - Ш (шепелявость)', N'вяк, переход, слова', N'
<span viak="transition">Переход: С - Ш (шепелявость)
</span><span viak="description">
SH = Ш

Шимон = Семен
Slam  = шлем
heb: Shalom (евр:шалом) = араб: салом, салам

Возможные переходы:
 шишка = сиська - из-за сходства по форме?
 каша = каса (тюрк,латин:дом,домашняя) - в смысле домашняя еда

</span><span viak="summary">Переход С-Ш мог быть обусловлен шепелявостью.
</span>
';
GO

exec spAddArticle 34907, N'Что в имени твоем: Пирог', N'вяк, слова', N'
<span viak="word">Пирог

ПРГ - пирог пирога пурга
ПРк - парок порок прок порка опорка
кРП - крепить кирпич крепость куропатка окропить укроп крупный
ПРх - порох порхать Прохор
хРП - храп хрип
бРГ - берег оберег berg(нем: гора, город)
ГРб - горб герб
бРк - барка(с) бурка оброк абрек буряк(укр:свекла)
кРб - короб краб акробат curb(англ:бордюр) скарб карбид

</span><span viak="description">
Piro = fire(англ:огонь) - пиротехника
А что, если приставка Пиро- происходит от слова Пар? Свойства пара: горячий, обжигающий, восходящий, поднимающийся вверх, уносящийся ввысь, парящий высоко, клубящийся, расширяющийся, сильно толкающий, способный взорваться или совершить полезную работу, вздымающий поверхность, шумный, громкий, грохочущий при взрыве, ... Тогда:

пирог - горячий, взошедший
пурга - клубящаяся
порок - обжигающий
прок - накопление
куропатка -  взлетающая вверх
крупный - расширенный
порох - взрывающийся, обжигающий
порхать - взлетать вверх
храп - громкий
Прохор - шумный?
берег - приподнятый
оберег - поднятие, унесение от беды
горб -  вздымающийся
оброк - уносящий
барка - уносящаяся
акробат - взлетающий
скарб - носимый
крепость - высокая
крепкий - сильный, высокий
</span><span viak="summary">
Представляется, что слово Пирог, как и приставка Пиро- происходят от слова "пар".
</span>
';
GO

exec spAddArticle 35114, N'Что в имени твоем: Бетон', N'вяк, слова', N'
<span viak="word">Бетон

Сравни с похожим словом "сбитень". Из Вики: &quot;<a href="https://ru.wikipedia.org/wiki/%D0%91%D0%B5%D1%82%D0%BE%D0%BD#.D0.98.D0.B7.D0.B3.D0.BE.D1.82.D0.BE.D0.B2.D0.BB.D0.B5.D0.BD.D0.B8.D0.B5" target="_blank">...бетон производится смешиванием цемента, песка, щебня и воды...</a>&quot;. Вся эта смесь, включая <b>битый</b> камень, <b>сбивается</b> вместе.

</span><span viak="summary">Таким образом, "Бетон" имеет смысл "битый".

</span><span viak="description">
У архитектора <a href="https://ru.wikipedia.org/wiki/%D0%91%D0%B5%D1%82%D0%B0%D0%BD%D0%BA%D1%83%D1%80,_%D0%90%D0%B2%D0%B3%D1%83%D1%81%D1%82%D0%B8%D0%BD_%D0%90%D0%B2%D0%B3%D1%83%D1%81%D1%82%D0%B8%D0%BD%D0%BE%D0%B2%D0%B8%D1%87" target="_blank">Бетанкур</a> <a href="http://vaduhan-08.livejournal.com/247282.html" target="_blank">строившего Нижний Новгород</a> была "говорящая" фамилия (Betancourt): Бетон+Корт = бетонная площадка
</span>
';
GO

exec spAddArticle 35512, N'Прямой перевод: Severe Weather - direct translation', N'перевод, слова', N'
<span viak="word">Severe Weather (англ: суровая погода) = Северный Ветер

<p viak="reference">Оригинал взят у <lj user="tar_s" type="personal" userhead_url="http://l-stat.livejournal.net/img/userinfo.gif?v=17080?v=142.3" /> в <a href="http://tar-s.livejournal.com/1055804.html">Лингвистическое</a><div class="repost">Weather - погода <br>Severe - суровая </p>
<p dir="ltr"><b>Severe weather</b>(севере веатер) - <b>северный ветер</b>. Суровая погода, вестимо :)</div></p>
</span>
';
GO

exec spAddArticle 35667, N'Что в имени твоем: Шмокодявка', N'вяк, перевод, слова', N'
<span viak="word">Шмокодявка

</span><span viak="description">
Шмак + давка

Шмак - на языке Идиш означает "кусок сырого мяса", а в переносном смысле - ничтожный человек.

</span><span viak="summary">Выглядет так, что слово Шмокодявка означает буквально "раздавленное сырое мясо".</span>
';
GO

exec spAddArticle 35913, N'Что в имени твоем: Шалава', N'вяк, имя, слова', N'
<span viak="word">Шалава
</span><span viak="description">При переходе Ш-Ч получается Челове(к).
</span><span viak="description"><a href="https://ru.wikipedia.org/wiki/%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A1%D1%82%D0%B5%D1%84%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0" target="_blank">Елена Волошанка</a> - жена царя Ивана III.&nbsp;Здесь в слове &quot;Волошанка&quot; можно усмотреть злой умысел называвших, потому что &quot;Волош&quot; наоборот может быть прочитан как &quot;Шалава&quot;.</span>

<span viak="summary">Таким образом: Шалава = Человек</span>
';
GO

exec spAddArticle 36138, N'Что в имени твоем: Суворов', N'вяк, имя, слова', N'
<span viak="word">Суворов

СВР - Суворов север свара свора
СбР - сбор собор Сибирь сбруя сбро(с)
РбС - арабес(к)
зВР - зверь завар изувер извер(г)
збР - зубр зебра забор забра(ло) избир(ать)
Рбц - рубец
</span><span viak="description">
Так имя Суворова может быть ассоциированно с негативным вымышленным образом Северного Зверского Изувера Собравшего Извергов из Сибири.

</span><span viak="summary">
Суворов = Северный
</span><span viak="description">
Князь Суворов-Таврический - князь с севера Таврии?
</span>
';
GO

exec spAddArticle 36515, N'Прямой перевод: Water - direct translation', N'english, вяк, перевод, слова', N'
<span viak="word">Water (англ:вода)

W=В
<a href="http://viakviak.livejournal.com/33634.html" target="_blank">Переход Т-Д (глухой-звонкий)</a>

Water = Водяра/Вёдро = Вода

</span><span viak="summary">
Английское слово Water при переходе <a href="http://viakviak.livejournal.com/33634.html" target="_blank">Т - Д</a> дает слово "Водяра" или "Вёдро", т.е. Вода.

English word Water using transition <a href="http://viakviak.livejournal.com/33634.html" target="_blank">T - D</a> gives Russian word "Вода".
</span>
';
GO


exec spAddArticle 36629, N'Переход Г - Р (грассирование)', N'вяк, переход, слова', N'
<span viak="transition">Переход Г - Р (грассирование)
Рыцарь - Гусар
</span><span viak="summary">
Используйте осторожно, смысл слова после перехода не должен изменяться!
</span>
';
GO

exec spAddArticle 36922, N'Что в имени твоем: Дорога', N'Вашкевич, вяк, имя, слова, тело, экономика', N'
<span viak="word">Дорога

ДРГ - дорога драги драгун дорогой
ГРД - город огород ограда гарда guard гордый greed(англ:жадность) градирня grader(англ:сортировальная или дорожно-строительная машина) grade(англ: оценка) graduate(англ:выпускник)
тРГ - торг(овля) отторгнуть
ГРт - грот
ДРк - дырка дурак драка dork(англ:придурок) drek(идиш:испражнения)
кРД - кордон краденное курд кредо курдюк кирдык(тюрк:конец,гибель) card(англ:карточка) Кордова
тРк - таракан тарака(араб:стучать) терка турок тюрк торкнуть отрок трюк attraction(англ:привлекательность) track(след,путь,следить) Аттатюрк Терек
<a href="http://viakviak.livejournal.com/18821.html" target="_blank">кРт</a> - карате крот куратор карета аккуратный каратель картель картон карто(фель) курить куртка курорт crate(англ:упаковочный ящик) carot(англ:морковь) court(англ:суд,двор,площадка,королевский двор,ухаживание)
жРГ - жаргон
ГРж - горожанин гражданин грыжа гараж ограждение
жРк - жирок жарко jerk (англ:придурок)
кРж - кража кураж корж крыж(польск:крест) кружить
чРД - черед очередь чердак
дРч - дрочить дрючить драчливый
чРт - черта черт
тРх - труха Тархун трахея треух тарахтеть тряхнуть трахать (с)таруха (по)троха
хРт - heart(англ:сердце,араб:тарака - стучащее)
</span><span viak="summary">
Мы можем сказать, что Дорога находится в смысловом  поле: Огороженная Защищенная Кружащая Стучащая(шумная) Черта на Карте между Городами для Торга.
</span><span viak="reference">
Из Н.Н.Вашкевича:

СЕРДЦЕ1 – "центральный орган кровеносной системы в виде мышечного мешка". (БЭКМ).
       ♦ От обратного прочтения ар. صد رأس садд ра''с "отражение головы". В том смысле, что происходящее в голове (обработка разного рода информации), отражается на сердце. Ср. ар. قلوب кулу:б, гулу:б "сердца" и рус. головы. В других европейских языках (в греч., латыни) рус. слово дало кардио… См. также сердитый1.Сердечно-сосудистая система через цвет крови нумеруется как система номер один в организме.
СТУЧАТЬ – жарг. "доносить" (Квеселевич).
       ♦ Сложение ар. приставки СТ со значением "просить" и корня ВКЙ "защита", "предохранение", в котором по условиям грамматики слабые согласные В и Й могут падать. См. жалоба, донос.
</span>
';
GO

exec spAddArticle 37275, N'Переход Д - Ж', N'вяк, переход, слова', N'
<span viak="transition">
Устойчивый переход Д - Ж
</span><span viak="description">
город - горожанин
дорогой - дороже
огород - огораживать
порог - порожек
пирог - пирожок
вожжи - водить
лёд - лужа
</span>
';
GO

exec spAddArticle 37588, N'Вымышленный "Братан" Алексея Николаевича Толстого', N'вяк, имя, книга, слова, эзотерика', N'
<span>Вымышленный "Братан" Алексея  Николаевича Толстого.
Вот это полное название сценария:
ПриКЛЮЧения Буратино Алексея  Николаевича Толстого.

Посмотрим как название "Братан Алексея  Николаевича Толстого" может раскрыться:
</span><span viak=word">Алексей: Алиса, лиса, лес, склеить

</span><span viak=word">(Ни)Колаич:
КЛЧ  - ключ калач кляча
ЧЛК - челка калечить
КЛк - кулак колкий клика кулик калека

</span><span viak=word">Толстой:
ТЛС - толстый атлас
СЛТ - slot (англ:щель) слиток
зЛТ - золотой sold(англ:продал) злато(власка) озолотиться
СЛд - сольдо slide (англ:скатиться) слюда оселедец
зЛд - злодей за-людей

</span><span viak=word">Братан:
Буратино
БРТ - брат братан обретение британский брать бороть берет братия борт обратился брута(льный) бритва обирать
ТРБ - отрубить требуха требовать trabaha (исп:мало) tribe (англ:племя) трибун трибуна трибунал труба теребить турбина отребье (п)отреб(ление)
пРТ - приоткрыть притвориться прыткий прут порт портки прут (ис)портил пороть прыть переть (с)пирт пират пироте(хника) парить упертый партизан проти(вный) упоротый прототип противень парти(тура) аппорт аппарат спрут сопрут (с)переть пирует пируэт
ТРп - тропа терпила терпение труп треп trap торопить оторопь трапеция труппа тряпье (с)атрап трап торопыга тряпье терапия
БРд - Борода бродили бурдяк бардак бордель бред борода бредить бурда бередить bread (англ:хлеб) брод бродяги бард
плТ - плетка плутовка палаты палатка плот плыть полить пилить пол-лит(ра) пулять пульт пальто полто(ра) палета палитра
Тлп - тулуп отлепить отлупить
ТРв - трава отрава
вРТ - варить ворота вертеть верить
дРп - драпать драпировка drop(англ:уронить)
пРд - предел пруд предатель продажа придурок пруд порыдать передача пародия придурок (в)перед парад предок пардон
вРд - вред вурда(лак)
дРв - дерево Дуревар(Дуремар)
фРТ - фарт форт фортуна фритюр
ТРф - трафарет трофей трюфель тариф
БлТ - болото болтун блять болит болт болтать Балтазар облить белить балет
ТлБ - талиб(араб:ученик)
БлД - блуд обладать bleed (англ:кровить) балда bold (англ:лысый,опытный)
фРд - Афродита фьорд

БР - бор beer (англ:пиво) robe (пижама) rob (англ:грабить)

Буратино - бурая-тина
<span><span viak="summary">
Похоже, что тех слов, что мы набрали, при достачной фантазии должно было хватить на увлекательный приключенческий рассказ.
Если, что-то и упущено, то возможно, что применялись и другие ключевые слова или методы получения корней.
</span>
';
GO

exec spAddArticle 37656, N'Прямой перевод: Grill - direct translation', N'english, вяк, перевод, слова', N'
<span viak="translation">Grill

ГРЛ - горел грелка горло
<a href="http://viakviak.livejournal.com/37986.html">жРЛ</a> - жарил жерло
</span><span viak="summary">
Английское слово Grill при переходе  <a href="http://viakviak.livejournal.com/37986.html" target="_blank">Г - Ж</a> дает свой перевод Жарил.

<i>English word Grill with transition <a href="http://viakviak.livejournal.com/37986.html" target="_blank">G - J</a> makes its own Russian translation &quot;Жарил&quot;.</i></p>
</span>
';
GO

exec spAddArticle 37986, N'Переход Г - Ж', N'вяк, переход, слова', N'
<span viak="transition">
Устойчивый переход Г - Ж
</span><span viak="description">
бог боже
утюг утюжок
жар гарь
пожар погорелец
бег бежать
круг кружево кружиться
Георг Жорж
беда бежать
жадина гадина
лёг лежать лежанка
нога ножка ножище 
жена гены гениталии 
рога рожки
ждать годить 
горло жерло
</span>
';
GO

exec spAddArticle 38363, N'Что в имени твоем: Челси', N'вяк, слова', N'
<span viak="word">Челси
ЧЛС - Челси
СЛЧ - силач случка случай сличать
кЛС - колосс класс кулисы клаустрофобия Санта-Клаус
СЛк - slacking ослик силки sleek
зЛк - злюка
кЛз - клизма clause(англ:условие) коллизия
СЛг - слуга sluggish
зЛЧ - злачный
</span>
';
GO

exec spAddArticle 38489, N'Что в имени твоем: Путин', N'вяк, имя, слова', N'
<p viak="name" dir="ltr">Путин

ПТН - путаный путина путана пытание питание потайной потный потоне(т) пятно пятни(ца) питон патен(т) птенец ПоТан(ку) потенциал
НТП - Нетопы(рь) OnTop Антипо(д) НеТипи(чный)
Ндб - НаДыбе надобно неудобно<br>бдН - бидон бодняк бедняк будни
ПдН - Падение поддон поднять
бТН - бетон батон бутан бутон
бфН - бафун</p>
<p viak="description" dir="ltr">Исторические паралели:
(Рас)Путин - убит в Декабре 1916, как условие февральский революции 1917 года. Раз-Путин.
Patton(Патон) - Американский генерал второй мировой. Убит.
пятнистый - Горбачев. Русский ПТН #2.
Путин#3 - Владимир Путин - действующий президент РФ.</p>
';
GO

exec spAddArticle 38894, N'Что в имени твоем: Пехота', N'бог, вяк, имя, слова', N'
<p viak="word" dir="ltr">Пехота

ПХТ - пехота пахота пахта (узб:хлопок) пихта пихать пахтать(рус:сбивать масло)
ПкТ - пукать пикет (пика) пакет покатый  picture (англ:картина)
ТкП - откуп (атака ткнуть)
бгТ - бегать богатырь богатый (бог)
Тгб - (тяготы)
бХТ - бухта бухтеть Бахтияр(узб имя)
ПХд - поход
бХд - обход обиход Бохадыр(узб имя)</p><p dir="ltr">Ясно видно смысловое поле слова Пехота: бегать, поход, обход в смысле &quot;ходить&quot;, &quot;передвигаться&quot;.</p><p dir="ltr">Бухта - место для похода (по морю), подхода с моря.
Богатырь -  &quot;пахотырь&quot;, &quot;пехотырь&quot;, &quot;беготырь&quot;, пехотинец-землепашец
Пахота - движение для разрыхления земли.
Богатый - путешествующий, ездящий по-делам</p><p dir="ltr">Слова <a href="http://viakviak.livejournal.com/25986.html">Бог</a>, Пика, Атака, Ткнуть, Тяготы взяты в квадратные скобки, чтобы исключить их из основного текста, но также показать их близость.</p><p dir="ltr">Представляется, что слово <a href="http://viakviak.livejournal.com/25986.html">Бог </a>может означать Движение, как одно из основных качеств Материи (см. также: <a href="http://viakviak.livejournal.com/11024.html">Аллах, Элохим</a>, <a href="http://viakviak.livejournal.com/12976.html">Яхве, Иегова</a>, <a href="http://viakviak.livejournal.com/39064.html">Господь</a>).</p>
';
GO

exec spAddArticle 39064, N'Что в имени твоем: Пешка', N'бог, вяк, государство, имя, история, оружие, слова', N'
<p viak="word" dir="ltr">Пешка</p>
ПШК - пешка пшик пушок пушка
ПШх - пешеход
бсК - босяк Баски(народ в Испании) Басков
бШК - башка Бишкек
ПсК - пуск писька Псков
КсП - Каспаров
кзб - Казбек
Псх - пасха посох по-суху псих писюха
хсП - hospice(англ:госпиталь для умирающих)
гсП - госпиталь господин Господь Гопитальеры(религиозный орден)</p>

<span viak="description">
Пешка - пешеход, босяк.
Каспаров - выдающийся шахматист
Госпитальеры - Представляется, название религиозного ордена Госпитальеры берет свое название от слова Господь. С другой стороны, слово Госпиталь берет от свое начало от Госпитальеры, как основателей приютов куда &quot;пускали&quot; больных в &quot;постели&quot;.
<b>Господь</b> - имя Бога в характеристике Пускающий (в рай), Отпускающий (грехи), Выпускающий (из рабства).
Пушка - орудие выПускающее снаряд, Пускающая дым.
Псков - Пропускающий
Пасха - история Пасхи вытекает из слов Господь и <a href="http://viakviak.livejournal.com/25986.html" target="_blank">Бог</a> как движение, уход: пасха, посох, по-суху, исход, exit, выход, уход, босиком, пешком, бас(громкий голос сверху), отпусти(мой народ), напасти(казни Египетские), пасти(народ), пустыня(через которую пропустили), пустились(бежать, в погоню).
</span>
';
GO

exec spAddArticle 39200, N'Что в имени твоем: Свет', N'вяк, слова', N'
<p viak="word" dir="ltr">Свет</p><p dir="ltr">СВТ - свет совет <a href="http://viakviak.livejournal.com/11024.html">святой</a>
ТВС - отвес
зВТ - завет завтра (зов) зевота
шбТ - шабат
СбТ - <a href="http://viakviak.livejournal.com/24060.html">суббота</a> сбыт саботаж сбыться
ТбС - тубус
СВд - свод свидание свадьба сведения (севодня)
дВС - Давос advise
зВд - завод
дВз - дивизия
збТ - забыть
збд - забудь</p><p dir="ltr">Свод - собрание, схождение, фокусировка (света)
Святой - &quot;светлый&quot; (<a href="http://viakviak.livejournal.com/11024.html">holy</a>) человек, кто сводит людей к богу
Совет - собрание, полезные сведения
Завод - Свод материалов, энергии, работников, специалистов в одном месте.
Дивизия - свод военных частей под одну команду.
Завет - оставить светлую память и указать светлый путь
Отвес - угол падения света в полдень
Завтра - светлый день после сегодняшнего вечера
Шабат - выходной как самый &quot;светлый&quot; день недели и свод (сбор) на молитву.
Саботаж - субботний отдых в рабочий день
Забыть - потерять сведения
Сегодня - сего дня. Произносится &quot;сево-дня&quot;, что несет в себе смысл светлого времени суток.
Совет - свод на обсужедние, чтобы пролить свет.
Сведения - свод сообщений, чтобы пролить свет.
Тубус - сведенный, скатанный, можно увидеть свет на другом конце
Зов - передача сведений
</p>
<p viak="summary">Создаётся впечатление, что слово Свет может происходить от слова Свод в смысле сбора, объединения, когда единение становится значительно большим, чем простая сумма составляющих. Например, если отдельные люди, каждый со своей свечкой (светом), сходятся вместе, их общий свет становится настолько значительным, чтобы освещать место и для тех, у кого своей свечи (пока) нет.</p>
';
GO

exec spAddArticle 39647, N'Переход Р - Л', N'вяк, переход', N'
<div viak="transition">Устойчивый переход Р - Л (Л-рассирование)</div>

<p viak="summary">Использование Л вместо Р особенно распространено у детей, которые не выговаривают &quot;Р&quot;.</p>
';
GO

exec spAddArticle 39863, N'Прямой перевод: Advise - Direct translation', N'english, вяк, перевод, слова', N'
<div viak="translation">Advise = Совет

ДВС - advise
СВт - совет <a href="http://viakviak.livejournal.com/39200.html">свет</a></div>
';
GO

exec spAddArticle 39939, N'Что в имени твоем: Плюс', N'вяк, слова', N'
<div viak="word">Плюс

ПЛС - плюс полюс полоса палас palas(англ:дворец) пульс police
СЛП - слепой sleep(англ:сон)
ПЛц - пыльца палец плац полиция Пельцер
бЛС - балясы bless(англ:благословить) bliss(англ:блаженство)
бЛз - блюз Белиз Белаз
зЛб - злоба</div>
';
GO

exec spAddArticle 40280, N'Что в имени твоем: Двигать', N'вяк, слова', N'
<div viak="word">Двигать
ДВГ - двигать двигатель
ДВж - движение</div>

Корень слова <span viak="word">Движение: ВЖ
ВЖ - движение вождение вождь важно
Вг - вагон вогнать вагина выгнуть
гВ - гавно говядина гувернант govern(англ:руководить)
бЖ - <a href="http://viakviak.livejournal.com/25986.html" target="_blank">боже</a> бежать
бг - бег <a href="http://viakviak.livejournal.com/25986.html" target="_blank">бог</a> <a href="http://viakviak.livejournal.com/38894.html" target="_blank">богач</a></span>
';
GO

exec spAddArticle 40640, N'Что в имени твоем: Цуцик', N'вяк, слова', N'
<div viak="word">Цуцик
ЦЦК - цуцик цицка цацка
ССК - сиська соска сосок соскок</div>

<span viak="summary">Очевидно, что слово Цуцик представляет собой мужскую форму слова Цицка (Сиська).</span>
';
GO

exec spAddArticle 40952, N'Self-Interest and Ignorance', N'english, вяк, закон, мнение', N'
<p dir="ltr">Self-Interest and Ignorance.</p><p dir="ltr">Ultimately, you have to pay or answer for everything you get or do (one way or another, more or less, now or later). Be aware of that and get ready for it.</p><p dir="ltr">What do people perceive as Good? Good is what people feel good about, what they know or think is good for them. People can learn or be told that.</p><p dir="ltr">It seems that all sins take root in Ignorance: ignorance to other people&rsquo;s interests, time, property, money, lives, &hellip;</p><p dir="ltr">People will always have self-interest. You should be well aware of the Ignorance, which comes with it.</p><p dir="ltr">Ignorance is an important Self-Interest preserving mechanism. It is also very important to be conscious about the Ignorance, and to not allow the Ignorance to become dominant, which will hurt the Self-Interest in the modern life settings.</p><p dir="ltr">Ignorance should serve Self-Interest, but it can easily harm Self-Interest, if not managed properly. The rules below are not constraining as laws are, but instead are an attempt to provide guidance for the taming of Ignorance in order to maximize Self-Interest.</p><p dir="ltr">Principal Rules of Self-Interest:

1. All people are &quot;pigs&quot;. Don&#39;t be one, try to be different. It&#39;s ok to be one, if necessary. Don&#39;t be with one. Don&#39;t expect much and appreciate the little things that you can glean from them.</p><p dir="ltr">2. You control the world around you, or the world controls you. Always have your best interest in mind. Remember why you are out there, observe the surroundings, and learn along the way. Obtain leverage and don&#39;t give your leverage away. Negotiate first to gain an advantage. There would be not enough &ldquo;ammo&rdquo; to make your way by force through everyone every time. Respect, learn and use the laws, customs, people&#39;s needs and beliefs. Find and use &quot;carrots&quot; and &quot;sticks&quot; as needed. Try to understand people, but realize that you will never know all the circumstances, so don&rsquo;t jump to conclusions. Face problems with everything you&#39;ve got to avoid prolonged confrontations. Make allies and pick your battles.</p><p dir="ltr">3. Everything is good in moderation, evil is in the extremes. Try to balance your life and find your own comfort zones. Avoid any kind of waste in your life, optimize, simplify, clean up, learn about yourself along the way and make your own routines to minimize the stress. Normal desires are the product of moderation. Extremes deform desires: depravities exaggerate and pervert them, excesses destroy them.</p><p dir="ltr">4. Everything will be fine. When you were born, your eternal soul received the vessel of your body in order to navigate this world. Take good care of it - you will be hold responsible. Stay positive and focused, don&rsquo;t lose hope, try to find peace, and adjust as needed.</p>
';
GO

exec spAddArticle 40970, N'Что в имени твоем: Волга', N'вяк, слова', N'
<span dir="ltr">Волга
ВЛГ - Волга влага влагалище иволга вульгарный
ГЛВ - голова главный
бЛГ - Болгария блог булыга
ГЛб - голубой глубокий глобус глобальный глыба Глеб голубь гульба</span>
<p viak="reason" dir="ltr">Представляются значимыми слова: главный, глубокий, влага.</p>
<p viak="summary" dir="ltr">Волга: глубокая, главная.</p>
';
GO

exec spAddArticle 41271, N'Что в имени твоем: Трамп', N'english, вяк, имя, слова', N'
<p viak="translation" dir="ltr">Трамп = Trump</p>
<p viak="name">Трамп
ТРМП - Trump(Трамп) Triump(h)(англ:триумф) трамп(лин) tramp(англ:бродяга, тащиться с трудом, <span style="font-family: arial, sans-serif-light, sans-serif; font-size: small; background-color: rgb(255, 255, 255);">утомительное путешествие</span>) ПМРТ - Помереть помирить помарать</p>
<p viak="summary" dir="ltr">Рассморение полного корня фамилии 45-то президента США показывает: утомительный путь на трамплин к триумфу - помирить или помарать или помереть. </p><p dir="ltr"><i>Looking at the last name of 45th president of USA using Russian consonant notation: tramping to the trampoline of triumph to make a peace or mess or die.</i></p>
';
GO

exec spAddArticle 41552, N'Что в имени твоем: Шток', N'слова', N'
<span viak="word">Шток

ШТК - шток штык штакетник штука шутка
КТШ - Катюша катыш
сТК - стояк стойка стук сток стакан stick(англ: палка) истукан сутки
КдШ - кадыш(евр.)
сдК - седок садки
Кдс - кудесник
</span>
<span viak="summary">Похоже, что слово "Шток" находится в смысловом поле "торчащий", "твердый".</span>
';
GO

exec spAddArticle 41969, N'Что в имени твоем: Пистолет', N'Вашкевич, вяк, оружие, слова', N'
<span viak="word">Пистолет

ПСТ - писто(лет,ль,ля) Пестель постель паста pasta(англ:макароны) пусто писать пастораль пасти пастух пустошь (от)пусти пастор пестик пастель(ные цвета) <i>post(англ:почта)</i>
бСТ - быстро баста (за)бастовка бестия <i>бастион Бастилия Бостон</i> бюст абстинент bust(англ:аррест) boost(англ:усиление)
Пзд - пи#да поздно опоздать
</span>
<span viak="summary">
Представляется, что слово Пистолет находится в смысловом поле &quot;пусто&quot;.
</span>
<span viak="description">
пасти - вывод в пустоши
пастбище - пасти-пища
пестик - пустенький, &quot;пизда&quot; растения
pasta - макароны с пустотой внутри
постель - пустующее место для человека
pasta - лапша с дыркой (макароны)
пастор - &quot;пастух&quot; людей
пи#да - &quot;пустота&quot; в теле женщины
пистоль - пусто(ль)
(за)бастовка - пустое времепровождение
бестия - из подземной пустоты
пестик - пи#да цветка
пастораль - пустошь
пастель - пустоватые (разведенные) цвета
абстинент - сексуальная &quot;пустышка&quot;
поздно - вне отведенного времени, в &quot;пустом&quot; времени
</span>
<span viak="reference">Из Н.Н.Вашкевича:

ПАСТА - "тестообразная масса", первоисточник греч. pasth "мучная подлива". (Черных). 
       ♦ От ар. بسط бассата "раскатывать тесто", сравните ар. معجون маъгу:н  "паста", от  عجنъагана "месить".
ПАСТИ – "следить за пасущимся скотом, домашним животным". (БЭКМ). 
       ♦ От обратного прочтения سيف сейф "то чем оберегают", "сабля, меч"; родственно сейф "металлический шкаф", родственно пёс, опасность, спасать (см.).
ПАСТОР – "протестантский священник"; нем. рastor < лат. pаstor пастух, пастырь. (БЭКМ). 
       ♦ От рус. пасти (см.). Другие лат. слова рус. происхождения: бицепс, аскорбинка, кардиология, латины, италики (см.).
ПАСТОРАЛЬ – "в европейском искусстве 14—18 вв.: драматическое или музыкальное произведение, идиллически изображающее жизнь пастухов и пастушек на лоне природы"; фр. pastorale < лат. pаstorаlis пастушеский. (БЭКМ). 
       ♦ Лат. слово от рус. пасти (см.)
ПИСАТЬ2, ничего не попишешь – "нет выхода".
       ♦ От ар. فشاشة фашша:ша "отмычка", т.е. "нет выхода". См. также пиши.
ПЍСАТЬ – "испускать мочу". (БЭКМ). 
       ♦ От рус. писَать. Аналогично ср. англ. penis и pencil, ар. زبر зубр и مزبار мизбар, что соответствует в рус. языке писка и писька. Дело в том, что в егип. мифе бык Апис (см.) покрывал богиню мудрости, небесную корову, Исиду 
   дважды: один раз красной писькой, другой - чёрной пиской.
ПИСК – "очень тонкий звук, крик". (БЭКМ). 
       ♦ От ар. فسى фаса: "выходить (о воздухе)". Родственно пуск (см.).
ПИССУАР – "раковина со стоком для мочи"; фр. pissoir < pisser испускать мочу, мочиться. (Крысин). 
       ♦ От рус. пَисать (см.).
ПИСТОЛЕТ – "короткоствольное ручное оружие для стрельбы на коротких расстояниях"; фр. pistolet. (БЭКМ). 
       ♦ От рус. пустой, т.е. трубка. Того же корня, что и пистон, пищаль, фистула, фиеста, фестиваль (см.).
ПИСТОН – "небольшой металлический колпачок со взрывчатым веществом для воспламенения заряда в патроне"; "заклепка в виде короткой трубочки для соединения плоских деталей, а также для окантовки отверстий в картоне, коже и т.п."; фр. piston. (БЭКМ). 
       ♦ От рус. пустой, т.е. трубочка. 
ПИТАТЬ1 – "кормить, снабжать пищей". (БЭКМ). 
       ♦ От ар. فتح фатах "обеспечивать пропитание (о Боге)", букв. "открывать", откуда فتح фатх "хлеб насущный". Идет от выражения فتح باب الرزق фатах ба:б ар-ризк, букв.: "открыть дверь пропитания".
ПИТАТЬ2 – "ощущать, переживать испытывать (доброту, уважение и т.п.)". 
       ♦ От обратного прочтения أتحف ''атхаф (корень тхф при обычной замене ар. х восьмеричной на рус. и восьмеричную) "оказывать кому-л. благосклонность, 
ПИЩАЛЬ – "старинная пушка или тяжёлое ружьё". (БЭКМ). 
       ♦ Того же корня, что и рус. пустой, пуск, пушка, запуск. Букв. "пускалка". Переход СТ в Щ ср. весть – вещать, СК в Щ – иск – ищу. Родственно пистолет, фистула, фиеста, фестиваль (см.).
ПУЗО – простореч. "то же, что живот". (БЭКМ). 
       ♦ От ар. فخ  фахх "дуть", букв. "надутое", родственно пузырь (см.), здесь реализовано чередование Х/З (Х/С). 
ПУЗЫРЬ – "наполненный воздухом прозрачный шарик в жидкости, жидкой массе ". (БЭКМ). 
       ♦ Того же корня, что и пузо, ср. ар. فخر фахара "гордиться", ср. рус. надувать щеки. Из рус. языка: ар. فزر фазар "лопаться", ''афзар "горбатый", т.е. спина пузырём. ср. فقع факаъа "лопаться" иفقاقيع   фака:ки:ъ "пузыри", "грибы". Сюда же فطر фитр "грибы". См. также чемпион, шампанское, шампунь, грибы.
ПУЛЯ – "заключённый в патрон небольшой снаряд для стрельбы из ружей, винтовок, пулемётов, револьверов". (БЭКМ). 
       ♦ От пулять (см.). Отсюда в ар. فول фу:л "бобы", فولة фу:ла "бобина". Ср. в ар.: بندق бундук "орех", "пуля", или рус. ядро.
ПУЛЯТЬ – "бросать чем–н. куда–н.". (БЭКМ). 
       ♦ От ар. فلاة фала: "свобода, чистое пространство, пустыня". Отсюда فلت фалат "пускать". Ср. пустыня и запускать (ракету)", пушка (см.). Родственно поле (см.).
ПУСК – "момент приведения в движение". (БЭКМ). 
       ♦ От ар. ар. فسحة фусха "свобода, простор". Возможно, что от рус. пуск в ар. языке или قصوف кусу:ф "бомбардировка" (М., с. 634). Родственно пушка, пустой.
ПУСКАТЬСЯ, пускаться во все тяжкие – "без удержу предаваться чему-либо предосудительному, обычно пьянству, разгулу". (ФСРЯ). 
       ♦  За рус. пускаться ар. فسوق фусу:к (фусу:'') "разврат, беспутство", производное от глагола  فسق фасак "свернуть с правильного пути", повторенное в форме фусу:'' в рус. во все, которое сопровождается определением тяжкие. Букв.: распутничать распутством тяжким. Похоже, что ар. слово из рус. пуск т.е. свобода, возможность предаваться чему угодно.
ПУСТОЙ – "ничем не заполненный, полый внутри, лишённый содержимого". (БЭКМ). 
       ♦ От ар. فسا фаса: "выходить наружу о воздухе". Родственно сопеть (в обратном прочтении).
ПУСТЫНЬ – "небольшой монастырь в труднодоступной пустынной местности"; "место, где живёт отшельник". (БЭКМ). 
       ♦ Того же корня, что и пустыня (см.). В ар. языке дает ар. تصوف тасаввуф (в обратном прочтении) "суфизм".
ПУСТЫНЯ – ♦ от пустой (см.).
ПУСТЬ – "образует повелительное наклонение глагола и вносит в предложение значение побудительности". (БЭКМ). 
       ♦ Того же происхождения, что и пустой, пустыня, пускай.  Общая идея – свобода. 
ПУХНУТЬ – "излишне увеличиваться". (БЭКМ). 
       ♦ От ар. фахх "раздуваться", нафах "надувать" или от родственного ему فاخ фа:х "распространяться, расширяться".
ПУЧИТЬ – "вздувать, делать выпуклым". (БЭКМ). 
       ♦ Того же корня, что и пухнуть (см.), но пучить глаза – от ар. بصص бассас "пялиться, пучить глаза". Родственно бачить. 
ПУШКА1 – "длинноствольное артиллерийское орудие с отлогой траекторией для стрельбы на дальние расстояния". (БЭКМ). 
       ♦ Того же корня, что и пуск (см.). Ср. пуск ракеты. Пусковые установки ракетчики называют пушками. Аналогично пуля (см.). Отсюда в ар. فشك фашак "патроны". 
ПУШКА2, пушкой не прошибёшь – "об упрямом человеке, 
     трудно поддающемся убеждению, доказательствам". (ФРЯ).
       ♦ Т.е. о человеке, не слышащем аргументы. Ср. хулиган (от рус. глухой). Речь идет о пушке, выстрелами из которой объявляют время, и которой можно разбудить человека. Пушкой во многих странах отбивают время по причине того, что евр. слово שעח "час" (ар. ساعة са:ъах) по-русски читается ПУШ. Конечное придыхание переходит в П как в продукты (см.).
ПУШКА3, брать на пушку – "действуя обманным путём, прибегая к различным уловкам, ухищрениям, добиваться от кого, либо, чего-либо". (ФСРЯ). 
       ♦ От ар. فشخ фашаха "обманывать и обижать, поступать несправедливо (в игре)".
</span>
';
GO

exec spAddArticle 42057, N'Что в имени твоем: Навь', N'вяк, материя, слова, смерть', N'
<span viak="word">
Навь

НВ - навь новь новый невод нива наив(ность) navy(англ:<span style="background-color: rgb(255, 255, 255); font-family: arial, sans-serif-light, sans-serif; font-size: small;">военно-морские силы)</span> навигатор
ВН - война воин вонь вынь <a href="https://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%BE%D0%BA" target="_blank">венок</a> веник ванна вино wind(англ:ветер) винт веяние ваяние Иван avon(кельт:река) <a href="https://ru.wikipedia.org/wiki/%D0%9E%D0%B2%D0%B5%D0%BD_(%D0%B7%D0%BD%D0%B0%D0%BA_%D0%B7%D0%BE%D0%B4%D0%B8%D0%B0%D0%BA%D0%B0)" target="_blank">овен</a> oven(англ:печь,духовка)
Нб - небо нёбо
бН - баня баян буян бен(евр:сын) ибн(араб:сын) Бонн Бен(джамен) убиен(ный)
</span><span viak="description">
баня - помещение с горячей водой (дар природы набранный из реки) для мытья
ванна - <span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);">резервуар </span>с  водой (дар природы набранный из реки) <span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">для купания</span>
ваяние - <span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">создание скульптур (</span>неживого)</div><div>веник - связка прутьев (дара природы)
<a href="https://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%BE%D0%BA" target="_blank">венок</a> - плетение из цветов (дара природы)
веяние - движение или использованние движения воздуха
вино - алкогольный напиток из ягод (дара природы)
винт - простейший механизм для работы в воде, для перемещения воды, или для движения в воде. По аналогии используется в других средах.
война - вооруженная борьба на реках и морях - территории Нави
вонь - запах Нави
вынь - достань невидимое - из Нави
navy - флот для войны на реках и морях - территории Нави
навигатор - navy+gater(англ: хозяин ворот в море)
невод - сеть для лова рыбы (дара природы) из Нави
нива - плодородное поле - место по(ЯВь)ления нового урожая (дара природы) из Нави
новый, новь  - по(ЯВь)ившийся из Нави
wind - ветер, сила природы
</span>
<span viak="summary">
Слово Навь представляется носителем характеристики "невидимого", "непознанного", "природа", "(водная) стихия".
</span><span viak="reference">
<a href="https://ru.wikipedia.org/wiki/%D0%AF%D0%B2%D1%8C,_%D0%9F%D1%80%D0%B0%D0%B2%D1%8C_%D0%B8_%D0%9D%D0%B0%D0%B2%D1%8C" target="_blank">Справка</a>: Явь, Правь и <b>Навь</b> - в современном русском неоязычестве &laquo;три стороны бытия&raquo;, впервые упоминается в Велесовой книге... <span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);">в аутентичных источниках по славянской мифологии и фольклору известен только термин &laquo;<b>навь</b>&raquo;... </span><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">Слово &laquo;<b>навь</b>&raquo; означает &laquo;мертвец&raquo; и &laquo;смерть&raquo;. Является славянским, и родственно древнегерманским аналогам в том же значении, восходя к индо-европейскому языку</span><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">... </span><b style="color: rgb(37, 37, 37); font-family: sans-serif;">Навь</b><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> в </span><a href="https://ru.wikipedia.org/wiki/%D0%A2%D0%BE%D0%BB%D0%BA%D0%BE%D0%B2%D1%8B%D0%B9_%D1%81%D0%BB%D0%BE%D0%B2%D0%B0%D1%80%D1%8C_%D0%B6%D0%B8%D0%B2%D0%BE%D0%B3%D0%BE_%D0%B2%D0%B5%D0%BB%D0%B8%D0%BA%D0%BE%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%8F%D0%B7%D1%8B%D0%BA%D0%B0" style="font-family: sans-serif; text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Толковый словарь живого великорусского языка">Толковом словаре Даля</a><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> трактуется как встречающийся в некоторых губерниях синоним слов </span><i style="color: rgb(37, 37, 37); font-family: sans-serif;"><a href="https://ru.wikipedia.org/wiki/%D0%A2%D1%80%D1%83%D0%BF" style="text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Труп">мертвец</a>, покойник, усопший, умерший</i><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">. </span><a href="https://ru.wikipedia.org/wiki/%D0%A0%D1%8B%D0%B1%D0%B0%D0%BA%D0%BE%D0%B2,_%D0%91%D0%BE%D1%80%D0%B8%D1%81_%D0%90%D0%BB%D0%B5%D0%BA%D1%81%D0%B0%D0%BD%D0%B4%D1%80%D0%BE%D0%B2%D0%B8%D1%87" style="font-family: sans-serif; text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Рыбаков, Борис Александрович">Б. А. Рыбаков</a><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> в &laquo;Язычестве древних славян&raquo; пишет &quot;</span><a class="mw-redirect" href="https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D0%B2%D1%8C%D0%B8" style="font-family: sans-serif; text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Навьи">Навьи</a><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> &mdash; мертвецы или, точнее, невидимые души мертвецов... </span><span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);"><b>Навь </b>&mdash; это воплощение смерти, а само название связано с образом погребальной ладьи... </span><span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);"><b>Навьим </b>днём назывался </span><a class="mw-redirect" href="https://ru.wikipedia.org/wiki/%D0%9F%D0%BE%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5_%D0%B4%D0%BD%D0%B8" style="text-decoration: none; color: rgb(11, 0, 128); background: none rgb(255, 255, 255); font-family: sans-serif;" title="Поминальные дни">день общего поминовения</a><span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);"> покойников на Руси...</span>
</span>
';
GO

exec spAddArticle 42379, N'Прямой перевод: State - Direct translation', N'usa, вяк, закон, перевод, слова', N'
<span viak="translation">
State = статья
СТТ - статья, стоять, статус.
</span><span viak="summary">
Представляется, что английское слово State имеет полный русский аналог Статья в смысле статья закона, уложение.
Пример: Соединенные Штаты Америки - United States of America

<i viak="english">It seems that English word State has full Russian analog Статья (Statia) in a sense of article of the law.
Example: United States of America</i>
</span>
';
GO

exec spAddArticle 42563, N'Что в имени твоем: Март', N'смерть, число, вяк, слова', N'
<span viak="word">Март

МРТ - Март мертвый mortuary(англ:морг) Марат Марта мартышка maritime(англ:морской) postmortem(англ:посмертный) морить
ТРМ - терем тюрьма тарарам(рус:бесчинство) трюм трам(плин) <a href="http://viakviak.livejournal.com/41271.html" target="_blank">Трам(п)</a> тормоз trauma(англ:травма) тромб trumpet(англ:труба,трампет) tramp(англ:бродяга)
МРд - murder(англ:убийство) морда меридиан мародер (с)мерд (с)мердеть мириад(рус:10000) мордва Мурад Мюрад (Ель-)Мюрид
дРМ - даром дерьмо дармовой дурман дрёма Дуремар дермантин drum(англ:барабан) (аэро)дром dorm(itory)(англ:общежитие)
</span><span viak="description">
аэродром - &quot;конец&quot; воздушного пути, остановка для воздушного пути. См. также космодром.
дерьмо - испорченное
dormitory(англ:общежитие) - &quot;испорченный&quot; дом где живет не отдельная семья, а сборище разного народа.
drum(англ:барабан) - издает (смертельно) громкие звуки, играет марш смерти (на войне). Барабанный бой - это немелодичная (испорченная) музыка.
дрёма - сон, не жизнь.
мириад(рус:10000) - конец исчисления
морда - нечеловеческое лицо
смерд - недочеловек.
тарарам - испорченное поведение.
tramp(англ:бродяга, тащиться с трудом, утомительное путешествие) - &quot;испорченный&quot; длительным хождением.
трамплин - смертельно опасное сооружение для прыжков
тюрьма - место заключения, остановки жизни, &quot;испорченный&quot; дом, исправительный дом.
</span><span viak="summary">
Как мы видим, слово Март находится в смысловом поле &quot;смерть&quot;, включая Конец - &quot;смерть&quot; пути, Испортить - &quot;смерть&quot; качества, Остановить - &quot;смерть&quot; движения.
</span>
';
GO

exec spAddArticle 42783, N'Что в имени твоем: Сатана', N'Вашкевич, бог, вяк, имя, слова', N'
<span viak="word">Сатана

СТН - Сатана стан стоянка остановка стынуть сутана истина стена стон стенать сутенер установка установление Истанбул Астана Седан Стенька ситный стан(дарт)
СдН - сиденье судно ссадина седина Судан
СфН - сафьян сфинктер Safeen
НфС - Анфиса
</span><span viak="description">
истина - остановка гаданий и предположений, точный факт, установление правды.
Седан - широкая река во Франции, останавливающая движение.
сиденье - положение или мебель для позиции остановленного движения.
ситный - идиома &quot;друг ситный&quot; в смысле &quot;друг Сатаны&quot;.
ссадина - рана с уже остановленной кровью
стандарт - точное описание, истинный размер.
Стенька - в устойчивом сочетании &quot;Стенька Разин&quot; можно увидеть смысл Осатанелая Резня. С другой стороны, в имени Степана Разина этот смысл уже утерян.
стена - останавливает движение
стенать - издавать душераздирающие, сатанинские крики.
стынуть - замедление движения крови, приостановка жизненной энергии.
судно - средство передвижения по воде сидя.
сутенер - пособник в сатанинских утехах.
сфинктер - останавливающая мышца.
</span><span viak="summary">
Представляется, что слово Сатана изначально описывало понятие противодействия <a href="http://viakviak.livejournal.com/38894.html" target="_blank">движению</a>, которое олицетворяет слово <a href="http://viakviak.livejournal.com/25986.html" target="_blank">Бог</a>, а уже позже получило резко-негативный символический смысл, давая начало ряду слов, тоже имеющих отрицательный смысл.
</span><span viak="reference">
Из Н.Н.Вашкевича:

<b><span style="font-size:12pt;">САТАНА</span></b><span style="font-size:12pt;"> &ndash; &quot;дьявол, олицетворенное злое начало в различных мистических вероучениях&quot;; греч. satan, satanas &lt; др.-евр. sаtаn. (БЭКМ). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар. </span><span dir="RTL">شيطان</span> <i><span style="font-size:12pt;">шайта:н</span></i><span style="font-size:12pt;"> &quot;черт, сатана, дьявол&quot;. Или от ар. </span><span dir="RTL">ساطن</span> <i><span style="font-size:12pt;">са:тин</span></i><span style="font-size:12pt;"> &quot;зловредный&quot; (М., стр. 333). По облику схож с обезьяной, ср. </span><span dir="RTL">قرد</span> <i><span style="font-size:12pt;">кирд</span></i><span style="font-size:12pt;"> &quot;обезьяна, шайтан&quot; (от рус. <b>дурак</b>), или </span><span dir="RTL">نسناس</span> <i><span style="font-size:12pt;">насна:с</span></i><span style="font-size:12pt;"> (пейоративный повтор от <i>на:с</i> &quot;люди&quot;) </span><span style="font-size:12pt;">&quot;обезьяна&quot;,</span> <span dir="RTL">خناس</span> <i><u><span style="font-size:12pt;">х</span></u></i><i><span style="font-size:12pt;">анна:с</span></i><span style="font-size:12pt;"> &quot;дьявол, совратитель&quot;, где <i><u>х</u></i> &ndash; пейоративный аффикс (&quot;плохой из людей&quot;). Сатанинская функция &ndash; отвлечение от Истины, что осуществляется одинаковым с Истиной написанием в консонантной манере на рус. языке, ср. СТН = СТН, из-за чего <b>сатана</b> и <b>истина</b> становятся трудно различимыми. Например, <b>истина в вине </b>(или сатана?). Приписывается функция существа, призванного жарить людей в пекле, в аду. Это по созвучию с ар. </span><span dir="RTL">شيط</span> <i><span style="font-size:12pt;">шаййат</span></i><span style="font-size:12pt;"> &quot;обжигать, опалять&quot;. У Сатаны много имён, среди них наиболее существенно <b>Иблис</b>, которое в обратном прочтении по-арабски даёт </span><span dir="RTL">سلبي</span> <i><span style="font-size:12pt;">силби</span></i><span style="font-size:12pt;"> &quot;негатив&quot;, &quot;отрицание&quot;,</span><span style="font-size:12pt;"> &quot;минус&quot;, что прямо противопоставлено рус. БОЖЕ, которое в обратном прочтении по-арабски даёт значение &quot;позитив&quot;, &quot;плюс&quot;.</span><span style="font-size:12pt;"> Другое его имя: </span><span dir="RTL">رجيم</span> <i><span style="font-size:12pt;">раги:м</span></i><span style="font-size:12pt;"> &quot;побитый камнями&quot;, от <b>ругма</b> &quot;камень&quot;, &quot;надгробный камень&quot;, откуда </span><span dir="RTL">أرجم</span><span style="font-size:12pt;">&#39;<i>аргуму</i> &quot;кидаю камень в виновного&quot; (ср. <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/A.htm#АРГУМЕНТ1" style="color:purple;">аргумент</a></b>). В некоторых языках название камня созвучно с <i>сатана</i> (шайтан), повторяя эту ар. связь, ср.: англ. <b>стоун</b>, немецк. <b>штейн</b>. Родственно <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/vF.htm#ФАНТАЗИЯ" style="color:purple;">фантазия</a></b>, <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/S.htm#СТАНСЫ" style="color:purple;">стансы</a></b> (см.). В христианском богословии сатана ассоциируется&nbsp;&nbsp;с&nbsp;&nbsp;числом шесть по&nbsp;&nbsp;причине того, что полное произношение по-арабски числа шесть: <i>ситтун</i> (СТН) совпадает с записью СТН. По этой причине число 666 считается сатанинским вопреки текс</span><span style="font-size:12pt;">т</span><span style="font-size:12pt;">у, в котором оно обозначено как &quot;число человеческое&quot;. Для христианских монахов сатана ассоциируется также с женщиной по той же причине: ар. </span><span dir="RTL">ست</span> <i><span style="font-size:12pt;">ситтун</span></i><span style="font-size:12pt;"> &quot;женщина&quot; имеет тот же согласный костяк, что и <b>сатана</b> (СТН). Ср. созвучие в англ.:&nbsp;&nbsp;six и sex. Люди</span><span style="font-size:12pt;">,</span><span style="font-size:12pt;"> имеющие в имени буквы СТН, пытясь найти истину, иногда скатываются в фантазирование, ср. Константин Станиславский (СТН+СТН), театральная концепция которого сводилась к поиску приемов подачи фантазии как истины, откуда его сакраментальное &quot;Не верю!&quot;. Или всемирно известный фантаст Станислав Лем, букв. &quot;придумыватель миров (СТН + </span><span dir="RTL">العـوالم</span> <i><span style="font-size:12pt;">л</span></i><span style="font-size:12pt;">-<i>ъава:лем</i>)&quot; который ищет оправдание своей деятельности</span> <span style="font-size:12pt;">в необходимости гротеска, который </span><span style="font-size:12pt;"> недоступен ни для науки ни для философии: не существует &quot;ни гротескной физики, ни гротескной философии, если же какая-нибудь из них возникла бы, то это влечет автоматически отмену литературы&quot; (&quot;Концепция иллюзорной природы мира&quot; в Энц. словаре &quot;Человек&quot;). На самом деле в 20 веке таковые уже возникли благодаря Эйнштейну (Эйн-ШТН), который считал, что &quot;воображение важнее знаний&quot; (КЕЭ). По этому вопросу см. <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/B.htm#БОЛЬШОЙ6взрыв" style="color:purple;">Большой взрыв</a></b>.</span>

<b><span style="font-size:12pt;">СТЕНАТЬ </span></b><span style="font-size:12pt;">&ndash; &quot;стонать, кричать со стоном&quot;. (БЭКМ). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар.</span><span dir="RTL"> استأن</span> <i><span style="font-size:12pt;">иста&#39;нна</span></i><span style="font-size:12pt;"> &quot;стонать&quot;, </span><span dir="RTL">أنين</span> <i><span style="font-size:12pt;">&#39;ани:н</span></i><span style="font-size:12pt;"> &quot;стон&quot;. По созвучию с рус. <b>стена</b> у евреев стена плача.</span></span>
<div>
<span viak="reference"><b><span style="font-size:12pt;">СТЕНЬГА</span></b> <span style="font-size:12pt;">&ndash; &quot;вертикальный брус, составляющий продолжение мачты в высоту&quot;. (СИС). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар. </span><span dir="RTL">استنجى</span> <i><span style="font-size:12pt;">&#39;истанга</span></i><i><span style="font-size:12pt;">:</span></i><span style="font-size:12pt;"> &quot;рубить под корень (дерево)&quot;.</span></span>
</div><b><span style="font-size:12pt;">СФИНКТЕР</span></b><span style="font-size:12pt;"> &ndash; <i>анат.</i> &quot;система мышечных кольцевых волокон, расположенных вокруг какого-либо отверстия, закрывающих или суживающих его при своём сокращении. В пищеварительной и мочеполовой системах они являются регуляторами моментов поступления того или другого содержимого в следующие отделы. Сфинктер зрачка служит регулятором количества света, падающего на сетчатку&quot;; нем. sphinkter &lt; греч. sphinktеr сжиматель. (БМЭ). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар. </span><span dir="RTL">خناقة</span> <i><u><span style="font-size:12pt;">х</span></u></i><i><span style="font-size:12pt;">ина:кат</span></i><span style="font-size:12pt;"> &quot;удушье&quot;, &quot;уличная пробка&quot;. По созвучию со <b>сфинкс</b> в семантическом поле Египта сжимается сфинктор заднепроходного отверстия. Др. Египтяне считали, что все болезни происходят от прямой кишки. У жителей второго ареала (Египет, Германия, и др.) литерные болезни связаны с желудочно-кишечным трактом, поскольку он в организме пронумерован двойкой.</span>
</span>
';
GO

exec spAddArticle 43148, N'Что в имени твоем: Холст', N'вяк, слова', N'
<span viak="word">Холст
ХЛСТ - холст нахлест хлестать хлыст хлястик холостой

</span><span viak="description">
Если предположить, что первая буква &quot;Х&quot; - это след от приставки &quot;К-&quot;, то корень приходит к нормализованной форме ЛСТ:
ЛСТ - лист (п)ласт лиственница lust(англ:похоть)

Если же, последнюю &quot;т&quot; принять за суффих &quot;-т&quot; или &quot;-ат&quot;, то тогда корень ХЛС или если наоборот: СЛХ
<a href="http://viakviak.livejournal.com/18993.html" target="_blank">СЛХ</a> - слух ослух

</span><span viak="summary">
Представляется, что слово Холст может лежать в смысловом поле &quot;листовой&quot;, &quot;длинный&quot;.
</span>
';
GO

exec spAddArticle 43385, N'Что в имени твоем: Полотно', N'вяк, слова', N'
ПЛТН - полотно плотина полтинник плетеный Палатин платный плотник плотный полотенце платина platoon(англ:взвод)
</span><span viak="description">
Рассмотрим возможность приведения четырех-буквенного корня к классическому трех-буквенному. Если первая буква "П" является приставкой "По-", то корень будет: ЛТН
</span><span viak="word">Полотно
ЛТН - (по)лотно латунь алтын
Если последняя буква "Н" является суффиксом "-ан/ин/-он", то корень: ПЛТ
</span><span viak="word">Полотно
ПЛТ - полот(но) плеть полать палаты плата плут оплот эполет плотный плита палитра плоть
ТЛП - тулуп отлуп толпа тюльпан
ПЛд - плед плод
бЛТ - болт блат бл?ть болтать билет балет булат bullet(англ:пуля)
ТЛб - талиб (араб:ученик)
бЛф - блеф
фЛб - phlebotomy(англ:кровопускание)
бЛд - балда блуд blood(англ:кровь)
дЛб - джеляб(узб:бл@ть)
</span><span viak="summary">
Я склоняюсь к мысли, что Полотно происходит от слова "плетенный".
</span><span viak="description">
Тогда, другие однокоренные слова (ПЛТ): плеть, платок, плетень, полотенце, эполет, плут. В этом же смысловом поле "плетенный, связанный, повязанный" будут и другие слова:
blood(англ:кровь) - кровавая связь
блат - связь по знакомству
блуд - греховная связь
болт - связующий елемент
болтанка - потеря связи
болтать - разговаривать, поддерживать связь
палаты - постройка из связанных материалов
platoon - крепкая, связанная группа солдат
плед - связанное покрывало
плод - зародыш, связанный с материнским организмом
плотный - крепко сбитый, связанный
плотина - связанная преграда
плоть - плотное тело
толпа - плотная группа людей
тулуп - плотная одежда
</span>
';
GO

exec spAddArticle 43711, N'Что в имени твоем: Рот', N'Вашкевич, вяк, слова, тело', N'
<span viak="word">Рот
РТ - рот рота артель (во)рота ритуал рутина (г)урт юрта creator(англ:создатель) (к)арта art порт портянка порты retina(англ:сетчатка) urethra(англ:мочеиспускательный тракт)
РД - ряд рядом род орда ордер рядить (про)редить редут ярд (по)рядок рад(ость) урод (к)ряду обряд наряд редька руда (п)рядь орден ординарец ординатура Рада радение Родина рыдать
Рж - роженица рож(д)ение рожь урожай роженница рожа оружие (сна)ружи раж ружье рыжий ряженый кряж

ТР - тор Тора (с)трана торить торг отара тиара тур тура тара (с)трои(ть) три тра(кт) тарака(араб:стучать) тиран торба театр (амфи)театр <a href="https://en.wikipedia.org/wiki/Tarot" target="_blank">Tarot</a>(англ:Таро)
дР - дыра дар дорога дура(к) дурь одр удар драка door(англ:дверь)
жР - жир жар
</span><span viak="summary">
Представляется, что слово Рот находится в смысловом поле "специально сделанный", "искусственный", "периодический", "ряд", "порядок", "организация", "один из серии".
</span><span viak="description">
(амфи)театр - театр в форме амфоры с поднимающимися вверх рядами зрителей.
артель - организация работников.
ворота - путь в ряды, организованный вход.
(г)урт - отара.
дар - специально организованное получение, приподнесенное по-очереди.
дорога - специально проложенный путь.
драка - серия нанесения ударов.
жар - искусственное, специально созданное или поддерживаемое тепло?
жир - специально вытопленный ресурс
(к)ряду - подряд, без перерыва, периодически, упорядоченно, не отвлекаясь.
(к)ряж - линейно вытянутая возвышенность, характеризующаяся относительно ровными очертаниям вершин и склонов.
наряд - специально сделанная одежда для организованного действия; специально выделенные ресурсы.
обряд - организованное действо.
(на )одре - на специально сооруженном ложе
орда - (вооруженный) род.
орден - вооруженная католическая организация; признак принадлежности к ордену.
ордер - order(англ:порядок, заказ)
ординарец - специально назначенный в помощники командиру
оружие - часть наряда, снаряжения, для наведение порядка
отара - организованный гурт овец
(по)рядок - построение в рядах, упорядочивание, организация
(п)рядь - ряд волос
Рада - организованная дискуссия, суд
радение - специальное старание
раж - радение
(про)редить - организованно прочистить
редька - требующая специального ухода, прополки
редут - организованное укрепление
ритуал - организованное действо
род  - общественная организация основанная по праву старшинства крови, рождения
рожа - рожденный, лицо члена рода, один из многих
рож(д)ение - добавление к роду
роженица - приносящая нового члена рода
руда - специально разрабатываемый ресурс
ружье - оружие
рот - имеет два ряда зубов
рота - отряд бойцов
рутина - организованная, постоянная деятельность
рыдать - постоянно плакать, без перерыва
рыжий - особый, выделяющийся из общего ряда
ряд - организованное местоположение
рядить - судить
ряженый - одетый в специальный наряд
(сна)ружи - за нарядом, за пределами организацииторить - специально сделать дорогу
(с)трои(ть) - складывать кирпичи тройками, где один кирпич всегда ставится на два других обеспечивая крепкое однородное соединение по всей стене.<
<a href="https://en.wikipedia.org/wiki/Tarot" target="_blank"><b>Tarot</b></a>(англ:Таро) - карты Таро, вокруг.
театр - зрелище окруженное зрителями
тиара - головной убор, часть наряда.
торг - продажа в рядах, специально отведенном месте
тра(кт) - дорога
три - ряд, последовательность
тур - организованная поездка
удар - один из серии в драке
урод - нестандартный член рода
ярд - специально сделанный эталон для порядка измерений длины
</span>
<span viak="reference">Из Н.Н. Вашкевича:
ТОР1 - геом. "пространственная фигура, имеющая форму баранки или спасательного круга"; фр. tore < лат. torus вздутие, выпуклость, узел. (БЭКМ). 
       ♦ От ар. إطار ''ита:р "рамка", "шина автомобиля".  
ТОР2 - "в скандинавской мифологии бог грома, сын Одина и Иорды (земли). Изображался в виде юноши с рыжей бородой; обладал тремя страшными знаками отличии — громовым молотом Миольнир, который постоянно попадал в цель и сам собою возвращался обратно, поясом силы Мегингярдар и железными перчатками"; (Брокгауз). 
        ♦ От ар. يثور йсу:р "гневаться" (в диалектах межзубный с произносится как т). Родственно Перун, тур (см.). Миольнир – от рус. молния (см.), Мегингярдар – от ар. (в обратном прочтении) نجم нигм "звезда" +  دائري да:ирий "круговой" (см. ярд), т.е. "звездный круг", видимо, "пояс Зодиака". См. Один, Иорда.
ТОРА - "древнееврейское название части Библии, "Пятикнижие", автором которой является Моисей". (СИС). В Пятикнижии Торой названа совокупность законов и постановлений, относящихся к тому или иному предмету, например, «закон (буквально Тора) всесожжения». В более поздней литературе Библия в целом называется Танах - акроним названий частей Библии: Тора (Пятикнижие), Невиим (Пророки книги) и Ктувим (Писания), однако Торой иногда называют и всю Библию. (ЕЭ, эл. версия) 
       ♦ Согласно преданию, Пятикнижие было получено Моисеем от Бога на горе Синай. Гора по-арабски называется  طور тор (тур). Это же слово обозначает быка. Добавление показателя ж. рода делает слово обозначающим корову. Поскольку Моисей вырос в семье фараона и общался со жрецами, под коровой надо разуметь богиню мудрости Исиду, которая часто изображалась небесной коровой. Ей противостоял чёрный священный бык Апис (см.), покрывавший корову чёрными пятнами (بقعة букъа "пятно", откуда рус. буква). Рус. слово корова даёт в  ар. языке ورق врк "бумага".  По-арабски корова называется также جموسة гаму:са, слово в котором записано имя Муса (ар. имя Моисея). При слабом различении звуков Г и Х (ср. Магомет = Мухаммед) слово воспринимается как хаму:са "пятеричная" (по-еврейски хуммаш). Отсюда и "Пятикнижие". На деле исходное слово ثورة саура (тора) употребляется в значении "революция", букв. "гнев". Все три мировые революции (английская, французская и русская) не обошлись без активного участия евреев. Исходный ар. корень СВР (ТВР) созвучен с рус. творить. По этой причине первая книга из пяти повествует о Сотворении мира и называется по-арабски تكوين такви:н "творение", производное от корня كون квн "бытие", давшего название этой книге в христианской традиции. (Сами евреи называют эти книги не по смыслу, а по первому слову текста.) Отглагольное имя:  каун, каунон, конон, что дало повод называть Тору законом. В связи с тем, что гора Синай, на котрой была получена Тора, означает "сон", то в смысл Торы входит понятие "снотворное"...
</span>
';
GO

exec spAddArticle 43777, N'Что в имени твоем: КВН', N'Вашкевич, вяк, имя, слова, эзотерика', N'
<span viak="word">КВН. Формально это аббревиатура "Клуб веселых и находчивых".
</span><span viak="reference">
Из Н.Н.Вашкевича:
"...Первая книга Торы из пяти повествует о Сотворении мира и называется по-арабски تكوين такви:н "творение", производное от корня كون квн "бытие", давшего название этой книге в христианской традиции..."
</span><span viak="summary">
Таким образом эзотерический смысл игры КВН может заключаться в поддержке интереса многих миллионов к "Творению". Если раньше это было через книгу и молитвенном бдении, то теперь через телевизор и диванном бдении. Есть ли разница с поправкой на новые технологии?
</span><span viak="reference">
Из Н.Н.Вашкевича:
ТОРА - "древнееврейское название части Библии, "Пятикнижие", автором которой является Моисей". (СИС). В Пятикнижии Торой названа совокупность законов и постановлений, относящихся к тому или иному предмету, например, «закон (буквально Тора) всесожжения». В более поздней литературе Библия в целом называется Танах - акроним названий частей Библии: Тора (Пятикнижие), Невиим (Пророки книги) и Ктувим (Писания), однако Торой иногда называют и всю Библию. (ЕЭ, эл. версия) 
       ♦ Согласно преданию, Пятикнижие было получено Моисеем от Бога на горе Синай. Гора по-арабски называется  طور тор (тур). Это же слово обозначает быка. Добавление показателя ж. рода делает слово обозначающим корову. Поскольку Моисей вырос в семье фараона и общался со жрецами, под коровой надо разуметь богиню мудрости Исиду, которая часто изображалась небесной коровой. Ей противостоял чёрный священный бык Апис (см.), покрывавший корову чёрными пятнами (بقعة букъа "пятно", откуда рус. буква). Рус. слово корова даёт в  ар. языке ورق врк "бумага".  По-арабски корова называется также جموسة гаму:са, слово в котором записано имя Муса (ар. имя Моисея). При слабом различении звуков Г и Х (ср. Магомет = Мухаммед) слово воспринимается как хаму:са "пятеричная" (по-еврейски хуммаш). Отсюда и "Пятикнижие". На деле исходное слово ثورة саура (тора) употребляется в значении "революция", букв. "гнев". Все три мировые революции (английская, французская и русская) не обошлись без активного участия евреев. Исходный ар. корень СВР (ТВР) созвучен с рус. творить. По этой причине первая книга из пяти повествует о Сотворении мира и называется по-арабски تكوين такви:н "творение", производное от корня كون квн "бытие", давшего название этой книге в христианской традиции. (Сами евреи называют эти книги не по смыслу, а по первому слову текста.) Отглагольное имя:  каун, каунон, конон, что дало повод называть Тору законом...
</span>';
GO

exec spAddArticle 44207, N'Что в имени твоем: Двор', N'Вашкевич, бог, вяк, закон, имя, мера, оружие, слова, тело', N'
<span viak="word">Двор

ДВР - двор дверь доверие
ДбР - добро дебри
тВР - товар тварь отворить творить товарищ Тверь утварь отвар творог
РВт - рвота рвать
Рбт - работа робот Арбат орбита рубить
тбР - табор отбор Тибр
</span><span viak="description">
Рассмотрим приведенные ниже толкования слов, где Товар сводится к понятию "рядом" и родственности слову "<a href="http://viakviak.livejournal.com/43711.html">тор</a>", а Товарищ еще и сравнивается с близким по смыслу арабским "тарака" - следовать друг за другом, стучать(в смысле периодически: один стук за другим). Учтем, что "в" может, оказывается, переходить в "о". Тогда мы можем увидеть, что корень ДВР может перейти в ДОР, прочитывается наоборот как <a href="http://viakviak.livejournal.com/43711.html">"РОД" или "РЯД"</a>. Мы можем видеть также, что переход "В - О" позволяет объяснить слова Товар и Товарищ без привлечения арабского языка:
</span><span viak="word">
ДР - дыра дар дорога дура(к) дурь одр удар драка door(англ:дверь)
РД - ряд рядом род орда ордер рядить (про)редить редут ярд (по)рядок рад(ость) урод (к)ряду обряд наряд редька руда (п)рядь орден ординарец ординатура Рада радение Родина рыдать
Рт - <a href="http://viakviak.livejournal.com/43711.html">рот</a> рота артель (во)рота ритуал рутина ритм (г)урт юрта creator(англ:создатель) (к)арта art порт портянка порты retina(англ:сетчатка) urethra(англ:мочеиспускательный тракт)
тР - тор Тора (с)трана торить торг отара тиара тур тура тара (с)трои(ть) три тра(кт) тарака(араб:стучать) тиран торба
Рж - (ок)руж(ность) (на)ружу (к)ружи(ть) пряжа роженица рож(д)ение рожь урожай роженница рожа оружие (сна)ружи раж ружье рыжий ряженый кряж
жР - жир жар
</span><span viak="summary">
Представляется, что слово Двор лежит в смысловом контексте "творить", "рядом", "вокруг", "снаружи", ("отличный от", "один за другим"), и означает сотворенное пространство рядом с домом, вокруг дома.
</span><span viak="description">
art - работа, рисунок окружающего, творчество
creator(англ:создатель) - творец, строитель, создатель.
door(англ:дверь) - дверь
retina(англ:сетчатка) - круглая
Арбат - место снаружи где стоял табор.
артель - группа работников
(во)рота - двери
(г)урт - отара собранная вокруг
дар - отдача добра наружу
двор - пространство рядом с домом, снаружи
дверь - выход наружу или в комнату рядом, отворяется по кругу
добро - то что надо хранить рядом, распространять вокруг
доверие - отношение к человеку как к близкому, которого можно иметь рядом.
дорога - окружной сотворенный путь
драка - нанесение ударов вокруг, рядом с собой
дура(к) - отличный от всех
дурь - кружение головы
дыра - круглый выход наружу
жар - чувство когда находишься рядом с источником тепла
жир - расположен вокруг тела
(к)арта - рисунок местности вокруг
(к)ружи(ть) - двигаться вокруг, кругами, рядом
(на)ружу - противоположность понятию "во-внутрь"
обряд - показ наружу, вокруг, действие вокруг чего-либо.
одр - последнее место перед тем как душа уйдет наружу, "дверь" в потусторонний мир.
(ок)руж(ность) - около, рядом (околорядность?)
ординарец - работник
отбор - отложить рядком
орбита - вращение вокруг, рядом
орда - (вооруженный) род.
оружие - для нанесения ударов вокруг, рядом с собой. Носится снаружи, на боку, рядом.
отара - выпасаемые снаружи, окруженные вниманием овцы, требующие радения, работы.
порт - по-рот(ср:по-бережье, по-морье), рядом с "наружей", на краю берега, с выходом на море/реку
порты - штаны вокруг тела, обмотки
портянка - накруженная вокруг ноги
(п)рядь - волосы выбивающиеся наружу
пряжа - намотанная круглым клубком или вокруг (станка)
работа - дела вокруг дома
Рада - сидение рядами, вокруг, творение законов
радение - работа
рад(ость) - чувства наружу
раж - чувства наружу
редут - сооружение для обороны вокруг, рядом
ритм - методично, периодично, одно за другим
ритуал - обряд
род - близкие, живущие рядом
рожа - открытое лицо наружу
рождение - выход плода наружу
роженица - выводящая плод наружу
рожь - зерно снаружи
<a href="http://viakviak.livejournal.com/43711.html">рот</a> - круглый, выход из тела наружу, с рядами зубов
руда - средство для творения
ружье - оружие
рыдать - очень громко (наружу) плакать на всю округу
рыжий - отличный от всех по цвету волос
рядом - близко, вокруг
ряженый - одетый выйти наружу
(с)трана - округа, земля вокруг
(с)трои(ть) - с-троить, создавать стены из моножества троек кирпичей: один кирпич кладется сверху на два других обеспечивая скрепление всей структуры, придавая ей крепкость и однородность.
табор - телеги поставленные кругом
тара - упаковка вокруг содержимого
тарака(араб:стучать) - работать, стучать методично
тварь - животное живущее снаружи, не домашнее, дикое
Тверь - город неподалеку, рядом или "сотворенный", дверь в чужую страну
творить - работать, то же, что и "торить" при выпадении "В".
творог - сотворенный
тиара - нарядный головной убор для публичного выхода наружу
тиран - строитель (пирамид)
товар - то, что лежит рядком на продажу
товарищ - близкий человек рядом, к которому есть доверие.
тор - фигура вращения рядом, вокруг
Тора - Сотворение, книга закона божьего (творца) "О сотворении мира"
торба - мешок вокруг содержимого
тормоз - тор+<a href="http://viakviak.livejournal.com/27188.html">маз</a> - скользить рядом, друг об друга
торить - работать пролагая дорогу
тра(кт) - дорога
три - круговой, вокруг, число "пи" (3 ~ 3.14).
тура - построенная колонна
удар - выброс кулака "наружу"
урод - отличный от всех, снаружи, вне от общества.
урожай - полезный выход наружу
утварь - вещи под руками, рядом
юрта - круглая
ярд - <a href="http://www.beloveshkin.com/2015/07/idealnoe-sootnoshenie-talii-beder-i-vashego-zdorovya.html">длина обхвата вокруг талии нормального мужчины, три фута, круговой фут (3~3.14)</a>
</span><span viak="reference">Из Н.Н.Вашкевича:
ДАР, подарок – "подарок", "способность, талант". (Ожегов). 
     ♦ Интенсив от дать (см.).
ДВЕРЬ –  Восходит к славянскому корню *дворъ (см. двор). – (Черных). 
     ♦ Как и ворота (см.) восходит к идее вращения, выраженной ар. корнем  دور  ДВР. 
ДВОР1 – 1) "огороженный (от соседей) участок земли вместе с домом и другими постройками или прилегающий к дому"; 
     2) "все, что относится к окружению монарха (царя, короля и пр.)", "придворные круги". (Ожегов). 
♦ От ар. دار да:р (мн. число دور дуар) – "дом", "двор". Корень دور ДВР "окружать". Во втором значении – прямо от ар. корня ДВР "окружать".
ДВОР2, прийтись не ко двору – "не подойти, не соответствовать чьим либо требованиям, вкусам, интересам, приходиться некстати". (ФСРЯ). 
     ♦ За русским ко двору скрывается ар. قد кадду "в соответствии с" +  ورعه вараъу "его набожности, вере". Ар. ورع вараъ "богобоязнь" является синонимом اتقاء ''иттика:'', от которого происходит этика.
ДОРОГА – "полоса земли, предназначенная для передвижения, путь сообщения". (Ожегов). 
     ♦ От ар. طرق турук (диалектное дуруг) "дороги" (М., стр. 465),  либо от родственного ему  درج дараг "дорога" (М., стр. 210), родственно дроги (см.).
ДОРОГОЙ – "имеющий высокую цену", "любезный, милый, любимый". (Ожегов). 
      ♦ От ар.  تدارج тада:рага (шестая порода) "постепенно повышаться (в том числе и о цене)", производное от дарага "ступенька", "степень", от обратного прочтения которого лат. происхождения градус (см.). Отсюда дорожить, т.е. "считать дорогим". От обратного прочтения этого ар. слова также город, городить (см.) огораживать, а также гвардия и в обратном прочтении дружина.
ДУРА – ♦ произведено от дурак (см.) в результате переразложения и осмысления корневого К как суффикса.
ДУРАК1 – ♦ от ар. ضركاء дурака: "дураки" (мн. число ضريك  дари:к "дурак") (М., стр. 450). Родственно дрыхнуть (см.). От рус. дурак (ДРК) в ар. языке: قرد кирд (обратное прочтение) – "обезьяна, чёрт". Ар. طرق турика (дурика) "иметь слабый ум", возможно, от русского. 
ДУРАК2, выпить не дурак – "большой любитель выпить". (Ожегов). 
      ♦ Рус. выражение идет от ар. يضرك ما ма йдуррак "не повредит" из выражения مايضرك صغير بق букки сгеййар майдуррак "маленький стаканчик не повредит". Аналогично: пьян как зюзя (см. зюзя).
ДУРАК3, круглый дурак – ♦ см. круглый.
ДУРАК4, валять дурака – ♦ см. валять5.
ДУРЬ – "глупость, сумасбродство". (Ожегов). 
     ♦ Образовано в результате переразложения от дурак (см.). Состояние сознания при кружении, от созвучия с ар. يدور йду:р "вертеться", откуда  دوار дува:р "головокружение".
ТАБОР - "расположившийся лагерем обоз переселенцев, а в старину также (у казаков) лагерь войска с обозом"; тур. tabur. (БЭКМ). 
       ♦ От ар. طابور  та:бу:р "строй", "ряд", "очередь", от ар. دبر даббар "готовить", "приводить в порядок". Родственно теперь (см.). 
ТВЕРЬ – "губернский город, при впадении рек Тверцы и Тьмаки в Волгу". (Брокгауз).
       ♦ От рус. отвори. Три реки: Тверца, Волга и Тьмака образуют смысловую композицию: "отвори голову от тьмы", т.е. от сокрытого, равную по сокрытому смыслу композиции: Тверь – Волга – Каспий. См. Каспий. Эта идея соответствует предназначению рус. этноса, которое осуществляется через его системную идею поиска, уже воплотившуюся, в частности, в первопроходчестве. Ср. способ выражения имени деятеля в рус. языке: щи, (читающий, понимающий), совпадающего по звучанию с названием пищевого кода щи (щи да каша пища наша), с командой ищи. Ср. англ. инг, евр. поэль (см.).
ТВОРИТЬ – "приготовлять (какой–н. состав), растворяя, разжижая". (БЭКМ). 
       ♦ От ар. таввара "крутить", "развивать", от طور тавр "круг", تطور татаввур "развитие", "развитие событий", ср. рус. что творится? Вращение связано с творением, творческим созданием через гончарный круг. См. гончар.
ТВОРОГ – "пищевой продукт из сквашенного молока, освобождённого от сыворотки". (БЭКМ). 
       ♦ От ар. طور твр "круг". Родственно творить. Как молочный продукт отражает одно из звеньев также и духовного кормления, сопряжен с творчеством. См. об этом молоко, сливки, сметана, масло, сыр.
ТИРАН – "жестокий правитель". (Ушаков). 
       ♦ От ар. ثيران  ти:ра:н "быки", букв. "гневные". Огласовки передают форму мн. числа слова ثور саур, тур. Родственно Перун-громовник (см.). Часто слово переходит из языка в язык в форме мн. числа, ср. рус. рельс, где с - показатель мн. числа в английском, Агни; где форма слова предает мн. число рус. языка (огни).  Ср. греч. рассказ о Тиране, казнившем людей в медном быке, под которым раскладывался костёр.
ТИРАНА – "столица Албании".
       ♦ От ар. ثيران ти:ра:н "быки". Ср. азербайджанская Албания и столица Азербайджана Баку (Бакы). Бык является тотемом тюркских народов, ср. Баку (см.). См. также Албания, Азербайджан, тюрки. 
ТОВАР – "предмет продажи, торговли". (БЭКМ). 
       ♦ От ар. طوار  тава:р "то, что лежит бок о бок", т.е. выставленное для продажи. Родственно тор (см.).
ТОВАРИЩ – "человек, близкий кому–н. по взглядам, деятельности, по условиям жизни, а также человек, дружески расположенный к кому–н". (БЭКМ). 
       ♦ Того же происхождения, что и товар. Ср. ар. طرق  тарак (дараг) "следовать друг за другом", с расширителем к. Родственно друг, туареги (см.).
ТОГО, того и жди – "вот-вот (может случиться, произойти что-либо, обычно неприятное, нежелательное)". (ФСРЯ). 
       ♦ того от ар. توقع  таваккаъ (таваггаъ) "ожидать, ожидать неприятностей", пишется ТВГЪ при том, что Вав (و) читается как О (У), а Ъайн в Финикии писался как О и стоял в алфавите на месте греч. и рус. О. Букв. "жди неприятного, жди".
ТОРА - "древнееврейское название части Библии, "Пятикнижие", автором которой является Моисей". (СИС). В Пятикнижии Торой названа совокупность законов и постановлений, относящихся к тому или иному предмету, например, «закон (буквально Тора) всесожжения». В более поздней литературе Библия в целом называется Танах - акроним названий частей Библии: Тора (Пятикнижие), Невиим (Пророки книги) и Ктувим (Писания), однако Торой иногда называют и всю Библию. (ЕЭ, эл. версия) 
       ♦ Согласно преданию, Пятикнижие было получено Моисеем от Бога на горе Синай. Гора по-арабски называется  طور тор (тур). Это же слово обозначает быка. Добавление показателя ж. рода делает слово обозначающим корову. Поскольку Моисей вырос в семье фараона и общался со жрецами, под коровой надо разуметь богиню мудрости Исиду, которая часто изображалась небесной коровой. Ей противостоял чёрный священный бык Апис (см.), покрывавший корову чёрными пятнами (بقعة букъа "пятно", откуда рус. буква). Рус. слово корова даёт в  ар. языке ورق врк "бумага".  По-арабски корова называется также جموسة гаму:са, слово в котором записано имя Муса (ар. имя Моисея). При слабом различении звуков Г и Х (ср. Магомет = Мухаммед) слово воспринимается как хаму:са "пятеричная" (по-еврейски хуммаш). Отсюда и "Пятикнижие". На деле исходное слово ثورة саура (тора) употребляется в значении "революция", букв. "гнев". Все три мировые революции (английская, французская и русская) не обошлись без активного участия евреев. Исходный ар. корень СВР (ТВР) созвучен с рус. творить. По этой причине первая книга из пяти повествует о Сотворении мира и называется по-арабски تكوين такви:н "творение", производное от корня كون квн "бытие", давшего название этой книге в христианской традиции. (Сами евреи называют эти книги не по смыслу, а по первому слову текста.) Отглагольное имя:  каун, каунон, конон, что дало повод называть Тору законом. В связи с тем, что гора Синай, на котрой была получена Тора, означает "сон", то в смысл Торы входит понятие "снотворное"...
ТОРБА1 – "мешок, сума". (БЭКМ). 
       ♦ От ар. طربة  турба "мешок, торба". Первоначально часть волынки, ср. ар. طرب тараб "радость, веселье, музыка", см. труба, откуда ألة الطرب  ''а:лат ат-тараб "музыкальный инструмент".
ТОРЕЦ – спец. "поперечный разрез бревна, бруса, а также вообще поперечная грань чего–н.". (БЭКМ). 
       ♦ От ар. طار та:р (корень ТВР) "быть рядом или с краю".
ТОРИ – "старое название члена консервативной партии в Англии. Партия тори начала складываться в конце 1660-х годов, как группировка сторонников абсолютной власти короля Карла II Стюарта - так называемая «партия двора»; англ. tоrу < ирл. toiridhe преследователь. (БЭКМ). 
       ♦ От ар.  دور= طور дор = тор "круг", "окружение", "двор".
ТОРИТЬ - "прокладывать (путь)", отсюда торный. 
       ♦ От ар.  طرق тарак (тара'') "торить (дорогу)".
ТРЕТИЙ, три - "форма порядкового числительного от три". 
       ♦ От ар. أثارة  ''ата:рат (''аса:рат) "излишек", ср. выражение третий - лишний, которое является билингвой как сорока-воровка (см.). 
ЯРД – "единица длины в английской системе мер, равная 3 футам, или 91,44 см.". (БЭКМ). 
       ♦ Англ. слово (йрд) происходит от обратного прочтения ар. دائري даирий "круговой", поскольку фут приблизитель-но равен радиусу окружности 91,44 см. См. также фут, дюйм.
</span>
'
;
GO

exec spAddArticle 44378, N'Что в имени твоем: Time(англ:время) - what is in the name', N'время, вяк, слова, смерть', N'
<span viak="word">Time(англ:время)

ТМ - time тема том томат тьма отъем тотем туман (р)итм отметка team Thomas
МТ - мат мата(араб:смерть) мать материя мот мотать метка маятник маета муть метать мотор (с)меять(ся) math(англ:математика) meat(англ:мясо)
дМ - дом dome(англ:купол) демон дума Дима Адам
Мд - мода мед медь медаль мудак mud(англ:грязь) mood(англ:настроение)
фМ - Фома Фима 
Мф - миф муфта муфтий Мефодий
</span><span viak="summary">
Слово Time(англ:время) может иметь смысл "отматывать", "тянуть", "отмечать", "портиться", "маяться"; и связано с понятиями материи, математики и смерти
</span><span viak="description">
dome(англ:купол) - размеченный свод
math(англ:математика) - наука о разметке
meat(англ:мясо) - мертвечина, скоропортящееся тело
mood(англ:настроение) - быстро портящееся настроение, заставляющее человека маяться
mud(англ:грязь) - отмечающая следы, тянущаяся за человеком грязь, испорченная земля
team - bodies(англ:тела), в смысле "human meat"(англ:человеское мясо)
Адам - с вытянутым ребром, испорченный искушением, мающийся раскаянием
демон - испорченный ангел, мающаяся душа, утягивающий души людей
дом - размеченное строение где живут и умирают
дума - тянущаяся мысль, наметки
маета - испорченное настроение
мат - испорченные слова
мата(араб:смерть) - испорченная смертью жизнь
мать - испорченная девушка; из нее вытягивают ребенка
материя - (при)рода, мать всего окружающего
маятник - подвешенный, мающийся
мед - тянущийся
медь - хорошо тянущаяся
медаль - вытянутая, выбитая из меди
метать - оттянуть (и затем бросить)
метка - отмечать, наносить отметину
Мефодий - муфтий? Кирилл и Мефодий - муфтий корил(укорял)?
муфтий - отмечающий, намечающий, высказывающий мысль
миф - тянущаяся история
мода - размеченный и предписанный стиль, вытягивающий деньги у мающихся женщин
мот - вытягивает деньги
мотать - тянуть
мотор - (мт+тр) тянущий ритмически стучащий
мудак - испорченный, мающийся дурью человек
муть - испорченная вода
отметка - (тм+мт) удвоение смысла "метка"; отмечать годовщину.
отъем - утягивание
(р)итм - (рт+тм) повторяющаяся маета
(с)меять(ся) - растягивать улыбку
тема - тянущийся вопрос
том - повторяющаяся книга
томат - быстро портящийся
туман - испортившаяся погода
тьма - испортившийся светлый день
Фома - испорченный, неверяще тянущий руку в рану к Христу
</span>
';
GO

exec spAddArticle 44584, N'Что в имени твоем: Время', N'время, вяк, слова, смерть', N'
<span viak="word">Время

МРВ - мурава муравей 
бРМ - бремя бром broom(англ:метла)
МРб - marble(англ:мрамор)
МР - <a href="http://viakviak.livejournal.com/20390.html" target="_blank">мор</a> море мера моряк мир мрамор омары мореный мурена (гла)мур Amarias Мара МУР
РМ - рама arm(англ:рука) армия ром Romeo Рим Irma Urma Арамеи Армения
</span><span viak="summary">
Слово Время лежит в смысловом поле "смерть", "умертвляющее".
</span><span viak="description">
broom(англ:метла) - из мертвой травы.
marble(англ:мрамор) - камень изображающий людей как живых, но все таки мертвый.
бремя - умертвляющая тяжесть.
бром - умертвляющая, токсичная жидкость.
мурава - трава уже проросшая вокруг умершего. "Твой гроб забвенный здесь покрыла мурава!"(Ф. И. Тютчев)
муравей - ползающий в мураве, во прахе
</span>
';
GO

exec spAddArticle 44885, N'Что в имени твоем: Хронос', N'время, вяк, имя, слова, смерть', N'
<span viak="word">Хронос

ХРН - Хронос хоронить хранить схрон охрана хрен херния
кРН - Кронос корона кран курень куранты корень крайний окраина крынка керн крен corn(англ:кукуруза) unicorn(англ:единорог) Коран Керенский Украина
НРк - норка нарок наркоман анорексия
гРН - горн горнило грань граница герань grain(англ:зерно) green(англ:зеленый) граната горение
НРг - единорог
чРН - черный
НРч - нарочный
</span><span viak="summary">
Имя Хронос лежит в смысловом поле "хоронить", "прятать", "скрытый", "не видный"
</span><span viak="reference">
<a href="https://ru.wikipedia.org/wiki/%D0%A5%D1%80%D0%BE%D0%BD%D0%BE%D1%81" target="_blank">Хронос</a> (др.-греч. Χρόνος, «время») — божество в древнегреческой мифологии и теокосмогонии.
</span>
';
GO

exec spAddArticle 45219, N'Падение звука: В', N'Вашкевич, вяк, переход, слова', N'
<span viak="transition">Падение звука: "В"
</span><span viak="description">
звук - зыкнуть
<a href="http://viakviak.livejournal.com/18520.html" target="_blank">квартиры - quarters(англ:квартиры)</a>
Латинские буквы V и U очень похожи и часто путались. Сравни , например, их производную: "W". В английском "W" озвучивается как "дабл-Ю"(англ:двойное "U"), а в немецком как "дубль-Вэ"(нем:двойное "В"). Переход же из согласной в гласную выглядит как выпадение "В" из неогласованного корня.

</span><span viak="reference">Из Н.Н.Вашкевича:
<a href="http://nnvashkevich.narod.ru/SLV/slvPA/T.htm#ТОГОижди" target="_blank">ТОГО</a>, того и жди – "вот-вот (может случиться, произойти что-либо, обычно неприятное, нежелательное)". (ФСРЯ). 
	♦ того от ар. توقع таваккаъ (таваггаъ) "ожидать, ожидать неприятностей", пишется ТВГЪ при том, что <b>Вав (و) читается как О (У)</b>, а Ъайн в Финикии писался как О и стоял в алфавите на месте греч. и рус. О. Букв. "жди неприятного, жди".
</span>
';
GO

/*
<a href="http://viakviak.livejournal.com/.html" target="_blank"></a>
<a href="" target="_blank"></a>

exec spAddArticle , N'', N'', N'
<span viak="word">
</span>
';
GO

*/


SELECT N'<a href="http://viakviak.livejournal.com/' + cast(LiveJournalID as nvarchar)+ N'.html">' + Title + N'</a>'
FROM dbo.Article
ORDER BY LiveJournalID DESC

-- SELECT * FROM dbo.Article