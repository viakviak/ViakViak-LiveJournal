-- Via+kViak Schema
-- C:\Users\vroyt\Source\Repos\ViakViak-LiveJournal\ViakViak LiveJournal\Sql\ViakViakSchema.sql

-- Drop foreign keys..
IF OBJECTPROPERTY(OBJECT_ID('FK_ArticleLabel_Label'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleLabel DROP CONSTRAINT FK_ArticleLabel_Label
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_ArticleLabel_Article'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleLabel DROP CONSTRAINT FK_ArticleLabel_Article
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_ArticleWord_Word'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleWord DROP CONSTRAINT FK_ArticleWord_Word
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_ArticleWord_Article'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleWord DROP CONSTRAINT FK_ArticleWord_Article
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_ComponentWord_Component'), 'IsConstraint') = 1
	ALTER TABLE dbo.ComponentWord DROP CONSTRAINT FK_ComponentWord_Component
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_ComponentWord_Word'), 'IsConstraint') = 1
	ALTER TABLE dbo.ComponentWord DROP CONSTRAINT FK_ComponentWord_Word
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_Word_Language'), 'IsConstraint') = 1
	ALTER TABLE dbo.Word DROP CONSTRAINT FK_Word_Language
GO
IF OBJECTPROPERTY(OBJECT_ID('FK_Component_Language'), 'IsConstraint') = 1
	ALTER TABLE dbo.Component DROP CONSTRAINT FK_Component_Language
GO

-- Drop tables..
IF OBJECT_ID(N'dbo.Article', N'U') IS NOT NULL
	DROP TABLE dbo.Article
GO
IF OBJECT_ID(N'dbo.ArticleLabel', N'U') IS NOT NULL
	DROP TABLE dbo.ArticleLabel
GO
IF OBJECT_ID(N'dbo.ArticleWord', N'U') IS NOT NULL
	DROP TABLE dbo.ArticleWord
GO
IF OBJECT_ID(N'dbo.Label', N'U') IS NOT NULL
	DROP TABLE dbo.Label
GO
IF OBJECT_ID(N'dbo.[Language]', N'U') IS NOT NULL
	DROP TABLE dbo.[Language]
GO
IF OBJECT_ID(N'dbo.Word', N'U') IS NOT NULL
	DROP TABLE dbo.Word
GO
IF OBJECT_ID(N'dbo.Component', N'U') IS NOT NULL
	DROP TABLE dbo.Component
GO
IF OBJECT_ID(N'dbo.ComponentWord', N'U') IS NOT NULL
	DROP TABLE dbo.ComponentWord
GO

-- Drop stored procedures..
IF OBJECT_ID('spAddArticle', 'P') IS NOT NULL
	DROP PROCEDURE dbo.spAddArticle	
GO

IF OBJECT_ID('ParseContent') IS NOT NULL
	DROP PROCEDURE dbo.ParseContent	
GO

-- Create tables..
CREATE TABLE dbo.Article(
	ArticleID int IDENTITY(1,1) NOT NULL,
	LiveJournalID int NULL,
	Title nvarchar(256) NULL,
	Content nvarchar(max) NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_Article PRIMARY KEY CLUSTERED 
(
	ArticleID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE dbo.ArticleLabel(
	ArticleLabelID int IDENTITY(1,1) NOT NULL,
	ArticleID int NOT NULL,
	LabelID int NOT NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_ArticleLabel PRIMARY KEY CLUSTERED 
(
	ArticleLabelID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dbo.ArticleWord(
	ArticleWordID int IDENTITY(1,1) NOT NULL,
	ArticleID int NOT NULL,
	WordID int NOT NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_ArticleWord PRIMARY KEY CLUSTERED 
(
	ArticleWordID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dbo.Label(
	LabelID int IDENTITY(1,1) NOT NULL,
	LabelName nvarchar(50) NOT NULL,
	LanguageID int NULL DEFAULT 1,
	[Description] nvarchar(4000) NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_Label PRIMARY KEY CLUSTERED 
(
	LabelID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dbo.[Language](
	LanguageID int IDENTITY(1,1) NOT NULL,
	LanguageName nvarchar(50) NOT NULL,
	[Description] nvarchar(4000) NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_Language PRIMARY KEY CLUSTERED 
(
	LanguageID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dbo.Word(
	WordID int IDENTITY(1,1) NOT NULL,
	WordName nvarchar(128) NOT NULL,
	LanguageID int NULL DEFAULT 1,
	IsName bit NOT NULL DEFAULT 0,
	[Description] nvarchar(4000) NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_Word PRIMARY KEY CLUSTERED 
(
	WordID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dbo.Component(
	ComponentID int IDENTITY(1,1) NOT NULL,
	ComponentName nvarchar(128) NOT NULL,
	LanguageID int NULL DEFAULT 1,
	[Description] nvarchar(4000) NULL,
	IsRoot bit  NOT NULL DEFAULT 0,
	IsPrefix bit  NOT NULL DEFAULT 0,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_Component PRIMARY KEY CLUSTERED 
(
	ComponentID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE dbo.ComponentWord(
	ComponentWordID int IDENTITY(1,1) NOT NULL,
	ComponentID int NOT NULL,
	WordID int NOT NULL,
	CreateOn datetime NOT NULL DEFAULT getdate()
 CONSTRAINT PK_ComponentWord PRIMARY KEY CLUSTERED 
(
	ComponentWordID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Create foreign keys..
ALTER TABLE dbo.ArticleLabel  WITH CHECK ADD  CONSTRAINT FK_ArticleLabel_Article FOREIGN KEY(ArticleID)
REFERENCES dbo.Article (ArticleID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleLabel CHECK CONSTRAINT FK_ArticleLabel_Article
GO

ALTER TABLE dbo.ArticleLabel  WITH CHECK ADD  CONSTRAINT FK_ArticleLabel_Label FOREIGN KEY(LabelID)
REFERENCES dbo.Label (LabelID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleLabel CHECK CONSTRAINT FK_ArticleLabel_Label
GO

ALTER TABLE dbo.ArticleWord  WITH CHECK ADD  CONSTRAINT FK_ArticleWord_Article FOREIGN KEY(ArticleID)
REFERENCES dbo.Article (ArticleID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleWord CHECK CONSTRAINT FK_ArticleWord_Article
GO

ALTER TABLE dbo.ArticleWord  WITH CHECK ADD  CONSTRAINT FK_ArticleWord_Word FOREIGN KEY(WordID)
REFERENCES dbo.Word (WordID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleWord CHECK CONSTRAINT FK_ArticleWord_Word
GO

ALTER TABLE dbo.ComponentWord  WITH CHECK ADD  CONSTRAINT FK_ComponentWord_Component FOREIGN KEY(ComponentID)
REFERENCES dbo.Component (ComponentID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ComponentWord CHECK CONSTRAINT FK_ComponentWord_Component
GO

ALTER TABLE dbo.ComponentWord  WITH CHECK ADD  CONSTRAINT FK_ComponentWord_Word FOREIGN KEY(WordID)
REFERENCES dbo.Word (WordID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ComponentWord CHECK CONSTRAINT FK_ComponentWord_Word
GO

ALTER TABLE dbo.Word  WITH CHECK ADD  CONSTRAINT FK_Word_Language FOREIGN KEY(LanguageID)
REFERENCES dbo.[Language] (LanguageID)
GO
ALTER TABLE dbo.Word CHECK CONSTRAINT FK_Word_Language
GO

ALTER TABLE dbo.Component  WITH CHECK ADD  CONSTRAINT FK_Component_Language FOREIGN KEY(LanguageID)
REFERENCES dbo.[Language] (LanguageID)
GO
ALTER TABLE dbo.Component CHECK CONSTRAINT FK_Component_Language
GO

-- stored procedures

CREATE PROCEDURE dbo.ParseContent
	@articleID [int],
	@content [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ViakViak_Sql].[StoredProcedures].[ParseContent]
GO

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
INSERT INTO dbo.[Language](LanguageName, Description) VALUES (N'Russian', NULL); -- 1
INSERT INTO dbo.[Language](LanguageName, Description) VALUES (N'English', NULL); -- 2

INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'english', 2, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'livejournal', 2, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'usa', 2, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'welcome', 2, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'Англия', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'бог', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'Вашкевич', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'Венеция', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'время', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'вяк', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'геральдика', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'государство', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'деньги', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'долг', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'дом', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'еда', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'закон', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'имя', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'Изобретение', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'история', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'книга', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'компания', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'компонента', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'материя', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'мера', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'мнение', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'музыка', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'общество', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'оружие', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'перевод', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'переход', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'программа', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'свобода', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'символ', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'слова', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'смерть', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'спорт', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'тело', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'технология', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'титул', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'торговля', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'шутка', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'эзотерика', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'экономика', 1, NULL);
INSERT INTO dbo.Label(LabelName, LanguageID, Description) VALUES (N'этнос', 1, NULL);

-- <lj-cut>

/*
<a href="http://viakviak.livejournal.com/.html" target="_blank"></a>
<a href="https://" target="_blank"></a>

exec spAddArticle , N'', N'', N'
<span viak="word">
</span>
';
GO

*/
exec spAddArticle 800, N'Николай Николаевич Вашкевич', N'Вашкевич, вяк, слова', N'
<span viak="name">Николай Николаевич Вашкевич
<p dir="ltr"><h1>Николай Николаевич Вашкевич. Словарь РА</h1><h3><a href="http://nnvashkevich.narod.ru/SLV/slvPA/A.htm">А. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/B.htm">Б. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/bfV.htm">В.</a> <a href="http://nnvashkevich.narod.ru/SLV/slvPA/bG.htm">Г. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/D.htm">Д. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/E.htm">Е. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/eJ.htm">Ж. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/jZ.htm">З. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/jzI.htm">И. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/K.htm">К. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/L.htm">Л. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/M.htm">М. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/N.htm">Н. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/O.htm">О. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/P.htm">П. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/R.htm">Р. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/S.htm">С. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/T.htm">Т. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/U.htm">У. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/vF.htm">Ф. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/vH.htm">Х. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/wC.htm">Ц. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/wCH.htm">Ч. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/wSH.htm">Ш. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/wSK.htm">Щ. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/zE.htm">Э. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/zJU.htm">Ю. </a><a href="http://nnvashkevich.narod.ru/SLV/slvPA/zJA.htm">Я. </a></h3><h3>Поиск слова на народе: <a href="https://www.google.com/search?q=site%3Annvashkevich.narod.ru+слово">site:nnvashkevich.narod.ru слово</a> </p><p dir="ltr"><a href="http://nnvashkevich.narod.ru/">Вашкевич на Народе</a> </p><p dir="ltr"><a href="http://mod-site.net/gb/u/nnvashkevich-1/p/1.html">Гостевая книга Вашкевича</a> </p><p dir="ltr"><a href="https://www.google.com/search?q=николай+николаевич+вашкевич&amp;oq=Николай+Николаевич+Вашкевич">Николай Николаевич Вашкевич. Кто он?</a></h3></p>
</span>
';
GO

exec spAddArticle 2029, N'Люцифер. Что в имени?', N'бог, вяк, слова', N'
<span viak="word">Люцифер

</span><span viak="description">
Одно из имен дьявола Люцифер часто переводится как "Свет несущий". Но можно увидеть в имени Лю-цифер слово "цифра". Перевод всей информации в цифровой вид как одна из форм служение "цифре".
Несущий от слова "фер" или по-русски "пер" (переть). С другой стороны, "фер" может быть прочитано как "fire" (огонь), что соответсвует известному избражению места обитания дьявола как "гиены огненной". Кстати "гиена" (гавно) очевидно относится к описанию запаха.
В слове "дьявол" отчетливо видно "дьа-вол". Первая часть "дьа" в латинице передается как "де" (девил). Консонантная запись: ДВЛ, ДБЛ(, ТБЛ, ТВЛ). Обратная консонантная запись: ЛБД, ЛВД(, ЛБТ, ЛВТ). Возможны варианты:
1. Дий-бол - главный "дий"
2. Дий-вол - известное изображение в виде рогатого быка
3. Дебил - одержимый дьяволом (?)
4. Лебедь - дьявольская птица (?)
5. Левит(ация) - перемещение предметов с дьявольской помощью (?)
6. Тобол(ьск - город) - дьявольское место (?)
Другой известный вариант: evil ивoл (ВЛ, ЛВ). Близко к "бала" - голова, главный.
1. Лов - улавливание душ
2. Love - любовь (грешная), главное занятие
3. Ебля - плотская любовь и множество других похожих терминов. Главное предназначение.
4. Боль - результат. Главное чувство.
5. Eval(uation) - известная команда в программировании "исполнить" для превращения строки текста в исполняемую команду.
6. Лево - направление, противоположное "право". Также соответствует понятию "неправильно".
7. Live, life - жить, жизнь телесная (во грехе). Главное действие.
8. Лев - глава зверей
</span>
';
GO


exec spAddArticle 2143, N'Йер', N' Вашкевич, вяк, слова', N'
<span viak="word">Йер

ВР - вера вар вор авары Уваров веер еврей
РВ - ров рёв river(англ:река) row(англ:ряд) (ко)рявый
</span><span viak="descrition">
Йер - глубокий, плодородный, урожайный, зрелый, щедрый, яркий, наполненный.
Иордан - глубокая (глубоко-донная) река.
Иерихон (Йер хан) - плодородное царство, щедрый царь. Яркий(Йер-ак) - щедрый.
Читая наоборот: РАЙ.
Юркнуть - проникнуть, неожиданно углубиться
Earth - плодородная
Ear - углубление в голове
York(Йер-ак) - стоит на реке Ure (Юркая), меняющая потом имя на Ouse(Уза, Узкая, Связующая).
Мэр, майор (Мой йер) - мой щедрый - обращение к главному.
Ярмо(Йер-мo) - орудие для повышения плодородия.  От ар. أرم ''арама "связывать".
Яри́ла (Яри́ло) - Йер ил - плодородная почва, бог плодородия.
Ривьера (River Jera) - плодородная река
Карьер - углубление в земле(черная). От ар. قرارة кара:ра "низкое место на земле", "округлая яма, где собирается дождевая вода".  От ар. كرا кара: "быстро бежать о животном". От ар. قعر каъара "выдалбливать". От ар. قار ка:р,  га:р "смола", от рус. гарь.
Эрозия - (Йер-азиа) углубление в основе. От ар. قرض  караз (карад, ''араз, гараз) "разъедать, грызть". от آس ''а:с "основа", "фундамент", "центр", того же корня, что рус. ось


Много рек имеют в своем названии "Дон". Кажется, что различали глубокие реки или озера ("Йер") и неглубокие ("Дон"), в которых было видно дно.
</span>
';
GO

exec spAddArticle 2508, N'Повинность', N'', N'
<span viak="word">повинность

ВН - повинность вина вена звено вьюн винт вино вонь венец Иван ион Ян Ина one(англ:один) Веня йена
НВ - Нева новый Навь навей(мертвец) нива
бН - баян баня бин(сын)
Нб - небо Анубис нёбо

</span><span viak="description">
повинность - воинская, ямская
</span><span viak="reference">из Вашкевича:
ВЕНОК –  "сплетённые в кольцо листья, цветы". (Ожегов).
Связано с веник,  венец, производных от индоевропейского корня *uei[1] "связывать". (Черных).

Похоже, что ключевой смысл здесь: "связь". Думается, что слово "повинность" означало не "пРовинность", а "обязанность", что опять выводит нас на смысловое поле "связь". С другой стороны, обязанности часто воспринимаются как наказание, что и приводит "повинность" к пониманию как "пРовинность".
</span>
';
GO

exec spAddArticle 4070, N'Книга: С. Г. КОРДОНСКИЙ. Сословная структура постсоветской России.', N'государство, деньги, книга, общество', N'
<span viak="book>С. Г. КОРДОНСКИЙ. Сословная структура постсоветской России. Москва. Институт Фонда «Общественное мнение» 2008

Написанная ясным простым языком, даже с некоторым юмором, с многими примерам из истории России. Буквально на пальцах разъясняется разница между классами и сословиями современного общества, даются содержательные исторические ссылки. Показывается искуственность марксистского и советского определения классов. Как государство создает и уничтожает сословия. Распределительная экономика современной и исторической России как продукт Российской сословной структуры. Не коррупция, а сословная дань.

... поднимаются проблемы, связанные с социальной структурой современной России, которая рассматривается как двухкомпонентная: сословная и клас- совая. Сделана попытка представить социальную историю России как циклическое доминирование или сословной, или классовой структуры. Описаны принципы сос- ловного устройства СССР и современные российские сословия. Выделены титульные (существующие по закону) и нетитульные (обслуживающие) сословия и показаны их отношения с классовой структурой. Автором описаны межсословные отношения, связанные с распределением ресурсов...
Из предисловия:
"... совсем не банален описанный Кордонским механизм межсо- словного распределения государственного бюджета, увязывающий функции государства и, соответственно, статьи бюджета с выделением ресурсов сословиям, которым положено эти функции выполнять. А каждое сословие претендует на многие функции и соответственно «тянет» на себя ресурсы из многих статей бюджета. Полученный в результате «борьбы за существование» суммарный бюджетный ресурс определяет место в сословной иерархии. Своего рода рейтинг. Предисловие ресурсного успеха и, как следствие, властных возможностей. По- следние предопределяют допустимые амбиции в сборе сословной ренты с нижестоящих и обязанности по сдаче сословного налога вы- шестоящим сословиям. Так формируется социальная структура, где каждый получает «по чину» за выполнение того, что положено, то есть за служение. Вот такой общественный договор! Деньги здесь исполняют роль распре- деляемого ресурса вместо натуральных ресурсов в социалистическом мире..."
Содержание
Кто мы? (предисловие) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
Сословная структура постсоветской России
Проблемы социологической классификации . . . . . . . . . . . . . . . . . . . . . . . . 19
Операциональность понятий сословий и классов . . . . . . . . . . . . . . . . . . . . . 24
Российские классы и российские сословия . . . . . . . . . . . . . . . . . . . . . . . . . 36
Сословное устройство имперской России . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
Советские сословия . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
Трудовые и нетрудовые доходы, административная торговля
и теневая экономика . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
Репрессии как форма регулирования межсословных отношений в СССР . . . 64
Распад системы советских межсословных отношений . . . . . . . . . . . . . . . . . 67
Современные служивые (титульные) сословия и государственная служба . . . 73
Отношения между титульными сословиями . . . . . . . . . . . . . . . . . . . . . . . . . 81
Иерархия титульных сословий и корпоративные отношения . . . . . . . . . . 83
Служение титульных сословий . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 91
Нетитульные сословия . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 95
Отношения между титульными и нетитульными сословиями . . . . . . . . . . . 106
Сословная стратификация в отношениях служения, обеспечения
и обслуживания . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 112
Административный торг как общественная жизнь . . . . . . . . . . . . . . . . . . . 115
Отношения сословного мироустройства с внешним миром:
«формирование ресурсной базы», импорт и заимствование . . . . . . . . 120
Демократия и сословность . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 125
Недоформировавшиеся российские классы и недоделанные сословия . . . 132
Прекраснодушные мечтания.
Вместо заключения . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 134
Боковая ветка. Искусство подражания: наука и образование
в сословном обществе . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 141
</span>
';
GO

exec spAddArticle 4890, N'Книга: Дэвид Гребер. Долг: первые 5000 лет истории', N'', N'
<span viak="book">Дэвид Гребер. Долг: первые 5000 лет истории

</span><span viak="description">
После чтения великолепной книги "Debt: The First 5,000 Years" by David Graeber (<a href="http://flibusta.net/b/399277" target="_blank">Долг: первые 5000 лет, автор: Стивен Грабер</a>) пришло понимание, что деньги - это просто долг. И не важно как этот долг записан - на бумаге, золотом, серебром или деревяшками. Долг - это священное понятие на котором стоит любое человеческое общество, начиная с семьи. В этой книге делается различие между двумя видами денег: собственно деньги (money) и валюта (currency).

Если принять рассуждения автора, то становится легче ориентироваться в потоках рассуждений о ненужности денег. Вопрос должен стоять шире: как будете отдавать долги? Деньги позволяют рассчитаться с долгами. Вы же не хотите быть должны должны сотням незнакомцев, как вы сейчас должны матери, отцу, Pодине(, партии, Иисусу, и т.д. добавить по вкусу). Только отдав долг, можно порвать долговые расписки, расстаться, разойтись в разные стороны, и простить.

Становится очевидно, что идеи о запрете или отмене денег не просто несерьезны. Даже намек на такое выплеснет цунами "непрощения", злобы, ожесточения, войны всех против всех. Поэтому кажется, что упрощенное толкование коммунизма, как царства безденежья, это одна из ловушек в которую легко многие попадаются.
</span>
';
GO

exec spAddArticle 5574, N'Книга: Грэм Лоури. Как Венецианский вирус инфицировал и победил Англию', N'Англия, Венеция, вяк, государство, история, книга, общество', N'
<span viak="book">Грэм Лоури. Как Венецианский вирус инфицировал и победил Англию

</span><span viak="reference">
<a href="http://www.masterjules.net/venetians.htm" target="_blank">Отформатированный мною машинный перевод</a>

Как Венецианский Вирус инфицировал и победил Англию
Х. Грэм Лоури
Напечатано в Executive Intelligence Review, 15 апреля,
</span><span viak="description">
Консолидация венецианской партии в Англии и Великобритании был вопрос культуры. Франческо Зорзи из Венеции, близкий друг и родственник Гаспаро Контарини, который был направлен Венецианской олигархией в Англию в качестве секс-советника Генриха VIII, был кабалист и розенкрейцер. В 1529 году Зорзи приехал в Лондон, чтобы доставить свое мнение, и он остался при дворе для остальной части его жизни, создание важную партию последователей - ядро ​​современной венецианской партии в Англии. В 1525 году, Зорзи опубликовал трактат De Harmonia Mundi, который использует каббалистической Сефирот, чтобы объяснить мистические, иррационалистические взгляды и, чтобы подорвать влияние Николая Кузанского.

В 1536 году, когда он был при английском дворе, Зорзи написал свою вторую основную работу, в Scripturam Sacram Проблемата. Это руководство по магии, Зорзи уверяет читателя - начинающего мага, что христианские ангелы охраняют его, чтобы убедиться, что он не попадет в руки демонов.

Зорзи оказал большое влияние на некоторых поэтов Елизаветинской эпохи. Сэр Филип Сидни был последователем Зорзи, также как и очень популярным Эдмунд Спенсер, автор длинной повествовательной поэмы "Королева фей". Спенсер был ключевым источником идеи английской имперской назначения как богоизбранного народа, с с широким спектром намеков на британский Израиль. Кристофер Марло и Шекспир и нападали на влияние Зорзи в таких пьесах, как "доктор Фауст" и "Отелло", но венецианская школы была продолжена розенкрейцером Робертом Фладдом, и, конечно же, Фрэнсисом Бэконом и Томасом Гоббсом.

Джон Мильтон, поклонник Паоло Сарпи и апологет ростовщичества, является примером про-венецианской пуританина периода Кромвельского Содружества. Милтон учил, что то что Сын Божий ниже Бога-Отца, своего рода запоздалая мысль, и в любом случае не нужная. Милтон был современником Sabbatai Цви, лжемессии из Смирны, Турция, чей отец был агентом английских пуританских торговцев. Разве Мильтоновский "Рай обретенный", изданный в 1671 году отражает знание стремительной карьеры Саббатея Цви, который ворвался в мир в 1665 году?

<b>Британская Ост-Индская компания была основана в 1600 году. К 1672, авантюристы, такие, как "Алмаз" Питт, занимался морским грабежом вокруг Индии.</b>

В декабре 1688 войска голландского принца Вильгельма Оранского (Dutch Prince William of Orange) вторгся в Англию, прерывая войну всех против всех, которую страна пережила при царствовании невменяемого короля Карла II и его брата Джеймса II. Хуже кошмар последовал, когда Вильгельм захватил трон Джеймса II, потому что он воплотил более высоко дистиллированной форму яда, который усовершенствовал Венеция во время его господства над останками Голландской республики. Это прямая узурпация беспечно называется в англо-венецианского языке как "Славная революция" - который должен дать вам некоторое представление о том, как мало внимания к истине существует в этих кругах.

Понятие "английских прав и свобод" быстро превращается из фантастики в мошенничество при диктаторском режиме Вильгельма. Когда король Джеймс II бежал во Францию, законным преемником на английский престол была его старшая дочь Мария, которая вышла замуж за Вильгельма Оранского неохотно (он был завзятым гомосексуалистом). Требование Вильгельма стать королем никогда не был представлено на рассмотрение парламента для "конституционного" одобрения. Вместо этого, он созвал специальную "конвенцию", предоставившию ему полную власть, а не просто звание короля-консорта.

Венецианский багаж короля Уильяма включал злодейского Джона Локка, который стал главным пропагандистом навязывания Банка Англии этой несчастной стране в 1694 году. Это был не тот тип банка, к которому вы бы обратились за финансовой помощью. Это был гигантское Венецианское мошенничество, которые быстро создалo первый национальный долг Англии для финансирования текущей войны на истощение в Европе, ввелo кредитный кризис, сокращая количество циркулирующих английскиx монет почти наполовину, и нагрузило новыми налогами уже разрушающуюся экономику. Главный архитектор банка был лидером партии Венецианский Чарльз Монтегю, новый канцлер казначейства Вильгельма, который позже достиг более высокую позицию британского посла в Венеции. Монтегю назначил жалкого Сэрa Исаакa Ньютонa, чтобы наблюдать за мошенничествоm "перечеканки", и Ньютон погашал этот долг проституцией своей племянницы в качестве приживалки Монтегю.

Нанятый протеже банка Джон Локк более известен как активный пропагандист человеко-ненавистнической теории, что человеческий разум не что иное, чем чистый лист - пассивный регистратор животных ощущений. Он явно отдавал предпочтение кассовому аппарату, и открыто защищал ростовщичество как необходимый сервис для тех, чьe богатство было в деньгах. Теории Локка o правительствe примерно напоминают того оператора казино, который устанавливает правила заведомо в пользу своей конторы, по которым вызверившиеся игроки бьются за деньги, которые затем определяют их ценность как личности. Это "свобода" Локкa, чтобы стремится к обладанию собственностью. Его понятие "общественного договора", которое гарантирует членам клуба игроков право на вход в казино, на самом деле, выдвинуто для того, чтобы оправдать узурпацию Вильгельмом Оранским британского престола. Джеймс II, в сущности, был обвинен в отнятии этиx прав у его более спекулятивных субъектов, тем самым нарушая договор. Локк утверждал, что Венецианцы поэтому имели право перейти к другому договору.

К 1697 году переворот венецианского партии внутри Англии было почти полным, и его члены заполнили "корабль государства" Вильгельма от носа до кормы. Они они надеялись преодолеть наболевший вопрос в английских колониях в Америке: импульс к построению независимого государства, которая бесила венецианцев с 1630-х годов основания колонии в Массачусетском заливe. В 1701 году, Джон Локк, как член Совета Англии по торговлe, выступает за отмену независимости американских колоний, и подпадание их экономической деятельности под королевскую диктатуру, и о запрете изготовление в них любых готовых товаров.

<b>Анти-Венецианскоe движение Лейбница</b>
Тем не менее, даже когда венецианцы чванились их кажущимся торжеством, мощная республиканская оппозиция выстроилась вокруг наивысшего создания природы и предназначения человека, которые оба вдохновили и и открыли путь для последующего создания Соединенных Штатов. Ее лидером был великий немецкий ученый и государственный деятель Готфрид Вильгельм Лейбниц, который вывел то, что вполне может быть названо движением за стремление к счастью - конечной цели свободы, которые Америка приняла в своей Декларации Независимости.

Перед лицом нового венецианского натиска в Англии, Лейбниц изложил свое мнение о человеческом счастье, с точки зрения человеческого создания человека в лице Dei. В своем труде "О понятии права и справедливости" в 1693 году Лейбниц определяет благотворительность, как "универсальную добродетель", которую он навает привычкой любить, т.е., "ценить чужое счастье как свое собственное". Та радость - это первое впечатление, говорил он, в созерцании прекрасной картины Рафаэля, например, "тот, кто понимает это, даже если это не приносит богатства, таким образом, что держа ее у него перед глазами, и оце нивает ее с восторгом, как символ любви."

Когда объект восхищения "в свою очередь также способен испытывать счастье, его привязанность переходит в истинную любовь, говорит Лейбниц. "Но божественная любовь превосходит другие виды любви, потому что Бог может быть любимым с наибольшей силой, так как нет ничего счастливее, чем Бог, и неизвестно ничего более прекрасного и более достойного счастья, чем Он. ''И, поскольку Бог обладает высшей мудростью, Лейбниц говорит, "понятия людей будут лучше поняты, если мы скажем, что мудрость есть не что иное, как сама наука счастья."

В качестве ведущего ученого и философа своих дней, Лейбниц был широко известен по всей Европе, и среди таких республиканских лидеров Новой Англии, как и Winthrops и Mathers, позже включая, самое главное, Бенджамина Франклина. С 1690 ведущий союзник Лейбница в Англии, Шотландии и Ирландии, был блестящий анти-венецианский полемист Джонатан Свифт, который направил культурную борьбу против бестуальных (уподобление человека животному) понятий Бэкона, Гоббса, Рене Декарта, Ньютона, и Локка, в течении более чем 40 лет.

С точки зрения разума, эмпиризм Аристотеля подобно Декарту и Локку низводит понятие человека до уровня просто зверя, что, конечно, является предпосылкой для создания такой империи, как  ее видели венецианцы стремились, тогда и сейчас. Когда Джонатан Свифт поднял свой голос в поддержку опровержения эмпиризма Лейбницем, он высмеял идеи своих противников за то чем они и были: сумасшедшием. Как "отступление от безумия"  Свифт в его работе в 1696 "Сказка о бочке" рассматривает "великих создателей новых схем в философии", как древних, так и современных. Они, как правило, не узнаваемы никем кроме их собственных последователей. Свифт говорит, "были те люди сумасшедшие..." во многом согласные в нескольких теориях с их нынешними преемниками в академии современного Бедлама."

<b>Олигархические семьи переезжают</b>
К 1701 году лунатики последней инкарнации венецианской партии были, как правило, выходцами из немногих олигархических семей, путем смешивания Spencers и Godolphins и Черчиллей - последнюю возглавлял Джон Черчилль, который вскоре стал герцогом Мальборо.

Черчилль начал как паж-мальчик для Карла II в 1665 году, за юбками его сестры Арабеллы, любовницы брата короля Джеймса. Тогда за оказанные услуги, Черчилль получил £10,000 от любимой хозяйки Карла II.

Дела по-видимому двигались так гладко, что венецианцы взяли курс на выполнение своей следующей главной цели: уничтожение Франции, наиболее продуктивной экономической власти в Европе. В министерстве Жана Батиста Кольбера-покровителя, научной академии в Париже, где сам Лейбниц занимался в начале 1670-х гг, Франция лидирует в развитии инфраструктуры и промышленности. Таким образом, в 1701 году Англия начала войну против Франции. Последовало более десяти лет кровопролития и разрушения для населения обеих стран и их европейских союзников. Это была еще одна сфальсифицированая игра, в которой Венеция должна была быть единственным победителем.

Но неизбежны проблемы  в любой злокозненной схеме. Королева Мария умерла в 1694 году, оставив Уильяма без прямого наследника. Ее сестра Энн был следующим в очереди на престол, но смерть единственной сохранившейся ребенка Анны в 1700 году стал новым кризисом преемственности. Закон оседлости был введен в 1701 году. 71-летняя внучка Джеймса I, Софи - глава немецкого Дома Ганновер, был назначена в качестве преемника Энн. Король Вильгельм умер в 1702 году, и Анна стала королевой Англии.

Как и ожидалось Венецианский партией, она быстро даровала первенство при дворе герцогу и герцогине Мальборо, которые плели сети свого влияния над ней в течение многих лет. Проблема для венецианцев, было то, что главный советник Софи и тайный советник, был Готфрид Вильгельм Лейбниц.

<b>- Битва за Британию -</b>

С Лейбницем практически в одном шаге от определения политики в Лондоне, последняя битва против венецианской партийной диктатуры в Англии вспыхнула всерьез. Это был конфликт между стремлением к счастью и жаждой империи. Семейство Мальборо прибегает к обману, террору и предательству, чтобы прервать политические отношения - или даже обычные любезности - между королевой Анной и Софи из Ганновера. Свифт поддерживал ожесточенный шквал публично и в частном порядке против венецианской банды Мальборо, что привело к тому, что он нарушил их господство в кабинете королевы Анны. Он расширил свое влияние на ее внутреннее окружение, а, в течении 1710-1711 гг. он выдворил семейство Мальборо и всех их приспешников из офиса.

Лондон отчаянно бросил Исаак Ньютон в драку против Лейбница, раздувая старую  ложь, что дифференциальное исчисление его изобретение, а не Лейбница. Лейбниц и Свифт сговорились привезти великого композитора Георга Фридриха Генделя из Ганновера в Лондон в 1710 году, стремясь возвысить английскую музыкальную культуру от декадентского рева и откровенного храпа.

<b>Американская Сторона</b>
И в разгар всего этого, Свифту удалось добиться назначения двух своих союзников королевских губернаторами в американских колониях. Роберт Хантер в Нью-Йорке, и Александр Спотсвуд в Вирджинии, начал в 1710 году движение , которое открыло дверь нашей будущей континентальной республике.

В том же году, в штате Массачусетс, Коттон Mather опубликовал свою республиканское руководство к действию, Эссе о пользе, которое распространяло представление Лейбница о науке счастья по всей Америке в течение столетия. Бенджамин Франклин воздал должное книге Мазера как оказавшее наиболее важное влияние на его жизнь.

Джонатан Свифт сказал об этом периоде, что он сомневался, был еще один в истории "более полное высказываний которые кто нибудь заитересованные из другого века было бы приятно узнать, тайные пружины. '' Венецианцы не хотел, чтобы вы знали, что Лейбниц и Свифт построили некоторые из тайных ходов, которые привели к созданию американской республики. Но в Британии (как это стало известно после союза 1707 года, по которому Англия была навязана Шотландии), борьба с венецианской партией вскоре была  потеряна.

Покровительница Лейбница, Софи Ганновер, назначенная преемницей королевы Анны, умерла в мае 1714 года в возрасте 84. Ее сын Георгий был теперь наследник британского престола. Вильгельм Оранский был кумиром Георгия, и Мальборо и венецианская партия купила его много раз. Не прошло и двух месяцев после смерти Софи, жизнь королевы Анны закончилась, вероятно, от яда, в возрасте 49 лет. Герцог Мальборо, который в изгнании в течение многих лет готовил свержение Анны, высадился в Англии в тот же день; и Джордж Ганновер был провозглашен королем Великобритании Георгом I. Джонатан Свифт был вынужден бежать в Ирландию, и Джордж скоро отстрвнил Лейбница от двора Ганноверов.

Как серьезный была угроза Лейбниц и Свифт, заданные заговорщиков венецианского партии? Просто примите во внимание сатанинскую ярость заговорщиков против мертвой королевы Анны, который для всех ее недостатков научилась искать что-то лучше в жизни, чем они могли бы когда-либо знать. Там не было никакого общественного траура, ни королевских похорон; ее труп оставался гнить в течение более чем трех недель. Тогда несколько избранных, служащих Джорджу I, похоронили ее тайно ночью, в Вестминстерском аббатстве - под могилой ее пра-пра-бабушки, Марии, королевы Шотландии. По сей день, ни один камень или планшет не отмечает ее могилу.

Лейбниц сам умер в 1716 году. Джонатан Свифт продолжал сражатся из Ирландии, с позиции королевы Анны дала ему в качестве декана собора Святого Патрика в Дублине.

Он стал признанным политическим лидером всей Ирландии в течение 1720-х годов, строя массовое движение на принципах человека Богом-данное право на свободу и право на национальный суверенитет, основанное на естественном праве. Свифт, таким образом, расширил движение Лейбница для достижения счастья, и неизмеримо влиял на рост республиканизма в Америке восемнадцатого века.

Великобритания, однако, начал быстрый спуск в ад, в соответствии с новым режимом Георга I. Ранее секретные общества сатанистов, таких как Клуб Адского Огня в то время всплыли, отмечены публикацией Бернарда Мандевиля в 1714 году в "Басне о пчелах, или Частные пороки, Общественная польза. Очень просто, Мандевиль утверждал, что интересы государства не было ничего больше, чем максимальное удовлетворен чувственных удовольствий своих физических лиц: чем больше частных пороков, тем больше общественная польза. Таким образом, государство процветает в наибольшей степени на совращении его подданых. Неизбежно, Великобритания вскоре стала скована в венецианской оргии разврата и новых высот финансовых спекуляций, что приводит к огромному взрыву Пузыря Южного Моря в 1720. Соответственно, правительство, которое вышло в 1721 году от этой разрушительного коллапса (http: //en.wikipedia .org / вики / South_Sea_Bubblе), возглавил премьер-министр Роберт Уолпол, который занимал эту должность на службе зла в течение следующих 20 лет. Клубы Адского Огня не только распространялись; они стали святая святых вырождающейся элиты Великобритании. Наиболее крупный из них, основанный в 1720 году лордом Wharton, включал в его меню "Панч Адского Огня", "Пирог Святого Духа, "Пax дьявола" и "Груди Венеры" (украшенный вишенками для сосков). К 1760, когда американские колонии начали открыто порывать с Англией, большинство из кабинета короля были членами Клуба Адского Огня. Когда Бенджамин Франклин служил нашим главой колониальной почты, например, его официальный начальник, сэр Фрэнсис Дэшвуд, был главой Клуба Адского Огня!

Убийственной платой за такой режим на британское население выражается следующей статистикой: с 1738 по 1758 г. было всего 297 тыс. рождений против 486 тыс. смертей. Типизации бестианства нарождающейся Британской империи, была фраза самодовольно высказанная Робертом Уолполом: Каждый человек имеет свою цену".
Мы не должны платить ее.
</span>
';
GO

exec spAddArticle 6866, N'Что в имени твоем: Этруски', N'', N'
<span viak="word">Этруски

ТРС - этруски треск треска торс трусы трусить терраса торосы Тарас Тирас(поль) Терск
СРТ - сорт сирота Саратов Сретенка срать
СРд - среда середина сердце сардины Сардиния
дРС - дроссель дурость дресня
СРд - среда середина сердце
<a href="http://viakviak.livejournal.com/18520.html" target="_blank">кРТ</a> - court(англ:суд,двор,площадка,королевский двор,ухаживание) окорот карате крот куратор карета аккуратный каратель картель картон карто(фель) курить куртка курорт crate(англ:упаковочный ящик) carot(англ:морковь) кретин
ТРк - таракан тарака(араб:стучать) терка турок тюрк торкнуть отрок трюк attraction(англ:привлекательность) track(след,путь,следить) Аттатюрк truck(англ:грузовик) Терек
зРд - заряд
ТРц - торец
<a href="http://viakviak.livejournal.com/18821.html" target="_blank">ДРк</a> - дырка дурак драка дрек(идиш:испражнения) dork(англ:придурок) dark(англ:темно)
<a href="http://viakviak.livejournal.com/36922.html" target="_blank">кРД</a> - кордон краденное курд кредо курдюк кирдык(тюрк:конец,гибель) card(англ:карточка) Кордова кредо cord(англ:шнур) украдено
</span><span viak="description">
Осмотрим слово "Этруски" используя словарь Н.Н. Вашкевича и его правила только одного перехода корневых согласных, чтобы не сойти с ума, как он предупреждает.

Сначала выделим корень: ТРС - три согласные. Будем читать в обе стороны понимая, что гласные не имеют большого значения. Возможны добавки суффиксов и префиксов. Будем осмотрительны к случайностям, не будем торопится с выводами. Главная задача найти "близко-корренные" слова с подходящим смыслом. По ходу будем пытаться найти как русские, так и арабские слова в словаре Н.Н. Вашкевича - никакой отсебятины. Поиск арабских слов производится по их русскому звучанию, образованному прибавлением гласной "а" после каждого согласного, например корень ТРк дает "ТаРака". Поиск этого слова на сайте Н.Н.Вашкевича в Google: site:nnvashkevich.narod.ru ТаРака

Выявленные ниже слова попробуем осмыслить, понимая, что они не обязательно должны выходить одно из другого. Попробуем услышать обьединяющие их идеи, отбрасывая явно посторонние. По Вашкевичу: все, что "слышится" - все может пригодится или быть к месту.

Ключевые слова из тех, что приведены ниже: середина, сардины, Сардиния

Ни в коем случае, не окончательно, но мне кажется, что мне слышатся следующии идеи:
</span><span viak="summary">
Этруски - из Сардинии (середины Италии, средиземноморья)
</span><span viak="reference">
Из Н.Н.Вашкевича:
ЭТРУСКИ – "этнос предшествовавший латинянам до образования государства Древнего Рима".
♦ От ар. التروس эт-турус "латы, щиты", что есть перевод этнонима латиняне, они же (в обратном прочтении) италики, которое от рус. латы. См. также пеласги.

СИРОТА1 – "ребёнок или несовершеннолетний, у которого умер один или оба родителя". (БЭКМ).
♦ От ар. أسير ''аси:р "пленный". В ар. сознании сирота (يتيم йати:м "сирота") и пленный относились к одной категории, что подтверждается кораническим текстом, предписывающим хорошее отношение к этой категории обездоленных людей.

Арабское ГУЛУБ "сердца" происходит от русского голова, а русское сердце происходит от обратного прочтения арабского ЦД РС, отражение головы", чем оно и является по медицинскому факту. 

СЕРДЦЕ1 – "центральный орган кровеносной системы в виде мышечного мешка". (БЭКМ).
♦ От обратного прочтения ар. صد رأس садд ра''с "отражение головы". В том смысле, что происходящее в голове (обработка разного рода информации), отражается на сердце. Ср. ар. قلوب кулу:б, гулу:б "сердца" и рус. головы. В других европейских языках (в греч., латыни) рус. слово дало кардио… См. также сердитый1. Сердечно-сосудистая система через цвет крови нумеруется как система номер один в организме.

Название сардины происходит от арабского سراطين сара:ти:н "раки". Как знак Зодиака Раки (по-арабски سرطان сарата:н) этимологически восходят к значению четыре. Четверка, в свою очередь, делит семерку пополам, следовательно, в конечном итоге, восходит к русскому середина, того же корня, что и среда, четвертый день недели в восточном исчислении. Сравните название четвертой буквы Далет, которая делит семерку пополам и является ее серединой.

Главным городом Этрурии был Тарквиний. Никто не понимает этого названия. А тут и понимать нечего, в переводе с арабского – Кузнецк, от арабского тарака (طرق "бить стучать, ковать"), مطروقات матру:ка:т "кованные изделия".
</span>
';
GO

exec spAddArticle 7192, N'Что в имени твоем: Software(англ:программа)', N'Вашкевич, вяк, слова', N'
<span viak="word">Software(англ:программа)
</span><span viak="description">
Software = soft + ware
<span viak="word">Soft(англ:мягкий)

СФТ - софит soft(англ:мягкий)
ТФС - typhus(англ:сыпной тиф)
СвТ - <a href="http://viakviak.livejournal.com/11024.html" target="_blank">свет</a> совет сват
цвТ - <a href="http://viakviak.livejournal.com/19758.html" target="_blank">цвет</a> цветок
</span><span viak="summary">
Software(англ:программа) - легкая, быстрая, цветастая, советующая, и заразная, применима в военных целях.

<span viak="word"><a href="http://viakviak.livejournal.com/7468.html" target="_blank">Ware(англ:изделие)</a>
ВР - вар (на)вар вера веер Уваров врать war(англ:война)
РВ - ров рёв ровно рвать row(англ:ряд) раввин raw(англ:сырой) river(англ:река)
бР - бар барин боярин брать бор (с)бор обра(т) обро(к) оборо(т) оборо(на) обря(д) bare(англ:голый)
Рб - рыба арба роба рабо(та) rabbi(англ:раввин) Арбат ребе(нок) urban(англ:городской)
</span><span viak="summary">
Software(англ:программа) - .
</span><span viak="reference">
Из Н.Н.Вашкевича:
ДИАЛОГИ с "НЕИЗВЕСТНОЙ ПЛАНЕТОЙ"

МАРТЫНОВ
Николай Николаевич, в свете Вашей концепции как бы вы трактовали фразу :
«В начале было слово» ?

ВАШКЕВИЧ
Обычно её понимают исторически. И тогда правомерным становится возражение со стороны наших современников. Ведь вначале должен быть кто-то, кто его (слово) произнесёт. Мне неоднократно приходилось слышать реплики примерно такого содержания. Понимать эту фразу исторически – неправильно.
Чтобы было понятней, о чём идет речь, приведу фразу из Корана "И был Аллах велик". Обе фразы объединяет наличие глагола в прошедшем времени. Тафсир (Толкование) разъясняет кораническое высказывание следующим образом : Аллах был велик, есть велик и будет всегда велик. Дело в том, что глагольная форма прошедшего времени не всегда обозначает именно прошедшее время, сравните: я пошел бы (когда? вчера, сегодня? завтра?). Как в Коране, так и в библейской фразе речь не идёт о прошедшем времени. В Библии речь идёт не о временных отношениях, а о логических. Всё в конечном итоге сводится к слову.
Сказанное легко понять современному человеку, который работает с компьютером. Всё что происходит на экране монитора определяется программой, а программа есть не что иное, как комбинация знаков.
Всё развивается по программе и, значит, сводится к комбинации знаков. Разница в том, что компьютерная программа строится на искусственном языке, а программы развития Бытия – на языке, который мы называем естественным, знаками которого являются обыкновенные слова, которые мы употребляем при общении, ничего пока не зная об их кибернетической роли.
</span>
';
GO

exec spAddArticle 7468, N'Что в имени твоем: Hardware(англ:аппаратура)', N'Вашкевич, вяк, слова', N'
<span viak="word">Hardware(англ:аппаратура)
</span><span viak="description">
Hardware = hard + ware
<span viak="word">Hard(англ:твердый)

ХРД - hard(англ:твердый) хорда
ДРХ - дрыхнуть дряхлый дирхем
ХРт - heart(англ:сердце,араб:тарака - стучащее)
тРХ - труха Тархун трахея треух тарахтеть тряхнуть трахать (с)таруха (по)троха
<a href="http://viakviak.livejournal.com/18821.html" target="_blank">ДРк</a> - дырка дурак драка дрек(идиш:испражнения) dork(англ:придурок) dark(англ:темно)
<a href="http://viakviak.livejournal.com/36922.html" target="_blank">кРД</a> - кордон краденное курд кредо курдюк кирдык(тюрк:конец,гибель) card(англ:карточка) Кордова кредо cord(англ:шнур) украдено
<a href="http://viakviak.livejournal.com/18520.html" target="_blank">кРТ</a> - court(англ:суд,двор,площадка,королевский двор,ухаживание) карате крот куратор карета аккуратный каратель картель картон карто(фель) курить куртка курорт crate(англ:упаковочный ящик) carot(англ:морковь) кретин
ТРк - таракан тарака(араб:стучать) терка турок тюрк торкнуть отрок трюк attraction(англ:привлекательность) track(след,путь,следить) Аттатюрк truck(англ:грузовик)

<span viak="word"><a href="http://viakviak.livejournal.com/7192.html" target="_blank">Ware(англ:изделие)</a>
ВР - вар (на)вар вера веер Уваров врать
РВ - ров рёв ровно рвать row(англ:ряд) раввин raw(англ:сырой) river(англ:река)
бР - бар барин боярин брать бор (с)бор обра(т) обро(к) оборо(т) оборо(на) обря(д) bare(англ:голый)
Рб - рыба арба роба рабо(та) rabbi(англ:раввин) Арбат ребе(нок) urban(англ:городской)
</span><span viak="summary">
Hardware(англ:аппаратура) - Равномерно-тарахтящее, применима в военных целях.
</span><span viak="reference">
Из Н.Н.Вашкевича:
ДРАХМА – "денежная единица Греции, равная сто лептам", от греч. drachme. (СИС).
♦ Из греч. же ар. دراهم дара:хим "деньги". В греч. языке от ар. طرق тарака (дарага) "стучать", "чеканить". Ср. ар. سكة сиккат "монета", "чеканка".

ПРОДУКТ1 – "предмет, вещество, получившееся в результате человеческого труда", "следствие, результат известных усилий". От лат. productus "произведенный". (СИС).
♦ В словаре Дворецкого не отмечено. Лат. слово означает "удлиненный", "протяжный, долгий", семантическая связь через produx "отпрыск", "отводок". (Дворецкий, с. 816). Вероятно, лат. produx "отводок" от обратного прочтения ар. خضرة худрах "зелень". Продукт от обратного прочтения ар. حضرة хадрах "наличие", откуда حضر хаддара "приготавливать, производить, изготовлять", букв. "делать наличным, имеющимся", откуда تحضير тахди:р "приготовление". Переход Х в П см. статью П.

ХОРДА - геом. "отрезок прямой линии, соединяющий две точки какой-н. кривой, напр. окружности"; из греч. xordh "кишка", "струна", "колбаса". (БЭКМ).
♦ Греч. слово от ар. خردة хурда "всякая мелочёвка", родственно дрек "то, что идет на выброс" (в обратном прочтении).

ДЕТАЛЬ – "часть механизма, машины, прибора, а также вообще какого-нибудь изделия", "мелкая подробность, частность". (Ожегов).
♦ От обратного прочтения ар. العتاد аль-ъата:д "приспособление".

СЕРДЦЕ1 – "центральный орган кровеносной системы в виде мышечного мешка". (БЭКМ).
♦ От обратного прочтения ар. صد رأس садд ра''с "отражение головы". В том смысле, что происходящее в голове (обработка разного рода информации), отражается на сердце. Ср. ар. قلوب кулу:б, гулу:б "сердца" и рус. головы. В других европейских языках (в греч., латыни) рус. слово дало кардио… См. также сердитый1. Сердечно-сосудистая система через цвет крови нумеруется как система номер один в организме.
</span>
';
GO

exec spAddArticle 8020, N'Что в имени твоем: Барак Обама', N'', N'
<span viak="name">Барак Обама
</span><span viak="description">
о бамаба рак =》кара бамабо
Obama, Barak =》kar abama bo, kara bamabo, бар а кобам а
kara bomba
car bomb = бомба в машине
black bomb = черная бомба
кара бомбой
Bar caboom - взрыв бара, разрушение препятствия

Наоборот:
</span><span viak="summary">
амабО караБ - м Бог раб = м(инструмент), раб Божий

Слышимое: барак, короб, корабль, оба, амеба, рак, арак, арык, кара, mob, БАМ, арба, борьба
</span>
';
GO

exec spAddArticle 8418, N'Что в имени твоем: Масса', N'Вашкевич, вяк, слова', N'
<span viak="word">Масса
</span><span viak="reference">
Лат. mаssa "ком, груда". (БЭКМ)
</span><span viak="description">

Mask, маска - одевается на многолюдные собрания.
Mass, масса - перекликается с Many, Multitude, Myriad, Множество, Мирриад (миллиард), Мир. Читая наоборот получаем противоположное значение: some(англ:несколько), сам, сама (один, в смысле немного).
Mass, месса - многолюдное собрание.
Massachusetts - Massa+Chusetts - Масса+Чусет(с) = Масса тысяч (читая второе слово наоборот) - многотысячный
Месить - частое, множественное повторение действия.
Mosque (Мечеть) это собрание множества людей . В этом контексте, Москва и Дамаск - это не города мечетей, как написано у Фоменко и Носовского, просто многонаселенные города.
Косм(ос) - Читая Маска наоборот выходим на Косм(ос), который огромен.
Семя, семена (читая наоборот) - множество семян, для размножения.
</span><span viak="summary">
Похоже, что М, как приставка как места, так и времени, и орудия, может быть осмыслена, как Частота (количество чего-то за какое-то время), или Плотность (количество чего-то в каком-то пространстве), или в общем, как Качество.
</span><span viak="reference">
Из Н.Н. Вашкевича:
МАССА - "величина, измеряющая количество вещества в теле, мера инерции тела по отношению к действующей на него силе"; "тестообразное бесформенное вещество, густая смесь"; "множество, большое количество"; нем. masse < лат. mаssa "ком, груда". (БЭКМ); из греч. maza "тесто". (Фасмер).
	♦ Греч. от ар. مس масса "касаться", "осязать". Родственно египетскому МС "родить", рус. мясо, месить (см.) латышскому miesa "плоть".
М – четырнадцатая буква рус. алфавита, называется мыслете (см). Числовое значение = 40. (Фасмер).
	♦ Сохраняет исконное числовое значение ар. буквы Мим и по начертанию представляет собой точную копию ар. цифры четыре (٤), развернутую на 90 градусов по часовой стрелке. См. эволюцию цифры 4 в статье Д. В ар. алфавите (в исходной цифровой матрице) стоит на тринадцатом месте и с неё начинается площадка зачатия (13-й день менструального цикла. Вместе с последующей буквой Нун (в кириллице – Наш) составляет корень ключевого слова зачатия (منى мана: "сперма"). Начальное М в ар. языке (если не входит в состав корня), – широкоупотребительная приставка со значениями: причастия действительного и страдательного, имени места, времени, орудия. Во множестве наличествует в рус. языке и не только в составе заимствований, например, молот "то чем бьют" (от ар. لط латта "бить"). См. также миска, место, мостить. В рус. этой приставке обычно соответствует приставка по, ср. по-кос "место и время косьбы".
КОСМОС – "вселенная, мир"; "пространство за пределами земной атмосферы"; греч. kosmos. (Крысин).
	♦ От обратного прочтения ар. سماء сама: "небо" + ساق са:к(и) "льющий", т.е. "проливающее влагу небо", откуда греч. космос "небесный свод", "небо". Другое значение греч. слова: "порядок, мироустроение", "мир" происходит от греч. космео "строить, выстраивать, приводить в порядок, украшать", ср. космема "украшение", восходит к ар. قسم касума "быть красивым", откуда ар. قسم касм "творение, натура, характер" (хулук, производное от خلق халака "творить"). То, что у древних греков космос поделен между Зевсом, Посейдоном и Аидом (МФ, с. 296), объясняется созвучием слова с ар. قسم касама "делить".
МЕССА – "католическое богослужение, литургия"; фр. messe < лат. missa < mittere "внушать, сообщать". (БЭКМ).
	♦ От ар. بعث бъс "посылать", "воскрешать".
МЕССИЯ – "в иудаизме и христианстве: спаситель, который должен явиться на Землю для установления царства Божьего"; фр. messie < лат. messia < др.-евр. mashiah "помазанный". (БЭКМ).
	♦ Не от евр., а прямо от ар. مسيح маси:х "помазанник", Христос. На что указывает удвоение с в знак компенсации утраченной гортанной, что происходит в других языках при переходе туда ар. материала, и чего нет в евр. варианте слова. Родственно рус. мазать. На самом деле слово происходит от созвучного корня مسخ мсх, передающего идею преображения, родственного рус. месить (см.), греч. масса, рус. мясо, т.е. плоть (ср. перевоплощение), древнеегипетскому МС "родить", т.е. воплотиться. Идея христианства состоит как раз в перевоплощении, а не в мазании. См. также миропомазание.
МОСКВА – "столица Российской Федерации". (БЭКМ). Первое летописное слово о М. относится к 1147 г., когда суздальский князь Юрий Долгорукий в этой своей вотчинной усадьбе давал сильный обед-пир своему союзнику и другу северскому князю Святославу Ольговичу. (Брокгауз).
	♦ Связано с Да-маск (см.) где мофема да (соединительный союз), прочитанной по-арабски, шестёркой, как ва (соединительный союз в ар.), и поставленный в конец слова. Ср. ар. название Руси: Русия и ар. название Сирии: Сурия. Основной корень سقى сака: в части маск/моск означает "закалять (сталь)". Ср. понятие дамасская сталь, сопоставимое со сталью московского завода "Серп и Молот", лившего броню легендарных танков Т-34. Формант СК, отражает профессию оружейников, и в таковом качестве присутствует во многих рус. названиях городов: Энск, Двинск, Курск, Смоленск. Однако наиболее скрытое и прямое значение вытекает из ар. корня مسك мск "держать", т.е. управлять. Ср. компьютерная мышка (см.).
МАСКА1 – "специальная накладка на лицо (иногда с изображением звериной морды, человеческого лица и т.п.) с вырезами для глаз, а также человек с такой накладкой"; фр. masque < ит. maschera < араб. maschara "шут, насмешник"; "шутка". (БЭКМ).
	♦ Ар. maschara (مسخرة) означает "издевательство" и к маске отношения не имеет. Маска идет от ар. مسخ масаха "преображать", "уродовать", "превращать (об Аллахе) в обезъяну". Корень мсх происходит от مس масс "осязать", "касаться", откуда в рус. мясо т.е. "плоть" и греч. происхождения масса (см.) и отрицательного аффикса х (خ). Того же корня месяц (см.) "ущербная луна", ар.ممسوخ мамсу:х "худой (о коне)".
МИЛЛИАРД – "число, изображаемое единицей с девятью нулями". (БЭКМ).
	♦ От сложения ар. مليان малйа:н "полный" +عريض ъари:д "широкий", или عرض ъард "широта", букв. "полный-широкий".
</span>
';
GO

exec spAddArticle 8744, N'Что в имени твоем: Золотой Телец', N'Вашкевич, вяк, история, слова', N'
<span viak="word">Золото

ЗЛТ - консонантное (без гласных) значение корня слова
ТЛЗ - обратное значение корня
ТЛц - Телец
</span><span viak="description">
Как неоднократно отмечал Н.Н. Вашкевич в своих работах, сказки создаются вокруг смыслов, их сюжет разворачивается как раскрытие смыслов ключевых слов.
Всем известное словосочетание Золотой Телец. Почему именно Золотой Телец, а не Золотой Бык или Корова, например?
А ведь Золотой Телец - это же палиндром. Не простой, конечно. Концептуальный, яркий образ, смысло-образующий, расчитанный на удвоение смысловой нагрузки. Рассмотрим подробнее:

Как видим, слово Телец - это обратное прочтение слова Золото.

Вот так, за образом Золотого Тельца стоит "Золотое золото" или попросу "много золота".
</span>
';
GO

exec spAddArticle 9103, N'Что в имени твоем: Cotton(англ:хлопок)', N'Вашкевич, вяк, слова', N'
<span viak="word">Cotton(англ:хлопок)

KTN - cotton(англ:хлопок) kitten(англ:котенок) катана
НТК - нитка натка(ть) натыка(ть) нотка анютка неток
сТН - сатин сатана стон станина Астана установка сотня сутана
</span><span viak="description">
Представляются близко связанными следующии слова:
cotton, сатин, нитки, моток, котомка с общим базовым смыслом "нить", "связанный".

Другие слова могут буть осмыслены как относящиеся к понятию "связанный":
катана - металл с рисунком в виде вязи
катамаран - две связанные лодки
станина - основание связывающая детали вместе

</span><span viak="reference">
Из Н.Н.Вашкевича:

НИТЬ1 - "то же, что нитка". (БЭКМ).
	♦ От ар. ناط на:та "подвешивать", "подвязывать" (М., стр. 847). Огласовка И передает орудийность, т.е. "чем подвешивают, подвязывают".

САТИН – "плотная хлопчатобумажная или шёлковая ткань с глянцевитой лицевой поверхностью"; фр. satin атлас < араб. zaitūnî букв. из Цзяодуна — назв. кит. города, где начали вырабатывать эту ткань. (БЭКМ); "гладкое переплетение нитей ткани, характеризующееся преобладанием на лице ткани нитей одного и того же направления, что придает ей особый лоск. Применяется при ткачестве из всевозможных материалов, главным же образом, шёлковых (seta лат. - шёлк, отсюда С.). (Брокгауз).
	♦ От ар. ساطع са:тиъ(ун) "блестящий".

МОТАТЬ1 – "навивать, накручивать что-л. длинное на какой-л. стержень или свивать в клубок", "двигать чем-л. из стороны в сторону", "покачивать". Корень, по-видимому, тот же, что и в мера. (Черных).
	♦ От ар. корня مت мтт "разматывать", "растягивать" или متي мтй "растягивать" (М., с. 745). В значении "покачивать" – от корня موجМВГ (МВЙ) – "волноваться о море",  موجة    маугат (мавйат) "волна". (М., с. 779). 

КАТАНА – "самурайский меч"; япон.
	♦ От ар. قطع катаъ "резать, рубить, сечь",  قاطع ка:тиъун "резец".
</span>
';
GO

exec spAddArticle 9497, N'Что в имени твоем: Государство', N'', N'
<span viak="word">Государство

Госу-дарство
ГС - Гусь
Гз - Гизы, Газ
зГ - зиг, заг
кС - коса, киса, кайса(к)
кз - кази, каз(на), каз(ан), каз(нь), Каз(ань), каз(ак), коз(ел)
зк - зэк, зак(он)

</span><span viak="description">
Слово "Государство" является сложно-составным из двух частей: Госу и Дарство.

Второя часть "Дарство" прозрачна - она происходит от слова Дарить, Дарственная, что соответсвует историческим свидетельствам о существовании "ярлыков" на княжение - дарственных.

Первая же часть "Госу" очевидно происходит от известного слова тюркского/арабского "кази" - судья. От него же происходят многие другие слова связанные с государственностью и ее атрибутами, такими как казна, казнь, казаки, закон и др. Возможно слова "козел" и "гусь" несут смысл "облагаемые государственной пошлиной".

Также (см. ниже) слово "ГоСУДарство" содержит "суд", но уже по-русски. Учитывая это, мы видим, что конструкция "ГОСУД" представляет собой удвоенное зеркальное значение смысла "суд": гос+суд. Этот прием служит для усиления (удвоения) смыслового значения.

Найденная "удвоенная зеркальность" не отрицает, а дополняет предыдущие рассуждения о "дарстве". Это все добавляет к силе слова, к величине его смыслового значения.

Дополнительно мы можем видеть слова "Рада", как часть "Государства", чем правительство "Рада" и является.

Лев (аСУД - араб.) является символом законности, судейской составляющей государства.
</span><span viak="reference">
Из Н.Н. Вашкевича:

ГОСУДАРСТВО – "основная политическая организация общества, осуществляющая его управление, охрану его экономической и социальной структуры"; "страна, находящаяся под управлением политической организации, осуществляющей охрану её экономической и социальной структуры". (Ожегов).
  ♦ От сударь, и государь, которое от ар. корня سود СУД, от которого سيادة сийа:да "суверенитет", букв. "господин-ство", которое от ар. أسود ''усу:д "львы". Первая часть го- от ар. ه гу – личное местоим. третьего лица в значении "его (величество)". См. великий. Поскольку понятие суд включено уже в словогосударство, традиционно суд рассматривается в России как инструмент государства, а вне государства суд превращается в пародию. Ср. значения ар. корня حكم (хакама): "держать", "править, управлять", "властвовать", "судить", "быть мудрым", "иметь суждение", откуда حكومة хуку:ма"правительство", слово которое используется иногда для перевода понятия государства. Разделение властей, придуманное англичанами, на самом деле есть маска на экспорт. В ар. названии государства давла (دولة) зашита функция перераспределения, см. довольствие. См. также князь, самодержавие.
</span>
';
GO

exec spAddArticle 10052, N'Что в имени твоем: Царь', N'Вашкевич, вяк, слова, титул', N'
<span viak="word">Царь

ЦР - цер(ковь) цер(емония) цир(куль) цер(бер)
зР - заря, зорька зернь зерно зарок зирвак(узб:жаренное мясо для плова) (ха)зары (кай)зер (ce)zar
Раз - раз разор резня рез(вый)
Рац(рус:REX) - дворец
жаР - jar(англ:кувшин из обожженой глины) Йар=Яр Ярило -ар
Рж - рожь рожа рыжый режут ржать оружие ружье
РиС - Русь Россия рис рис(овать) риск красить рас- раис(узб:большой начальник) (п)росо рис(талище)
сР - саранча сере(бро) сыр сырость серость серебро (гу)сары сэр сарай сорочка срок сорок ср(ать) серь(га)
кР - карта край икра кара кора корь край Корея курок икра
Рк - рука река рок рейка арка
хР - харизма хартия хер охра харя хор
чР - чартер чертить
гР - гора гиря горе огарок игра герой агра(рий) грань гарь Гера гурия <a href="http://viakviak.livejournal.com/45219.html" target="_blank">В</a>иагра
Рг - рог Рига ругань Рейган

</span><span viak="description">
REX - императорский
-ар - суффикс
дворец - двор+рец, царский двор
раз - один
рас- приставка
сарай - дворец
Ярило - божество
</span><span viak="summary">
Царь - правитель при помощи серебра
</span><span viak="reference">
Из Н.Н. Вашкевича:

ЦАРЬ1 – "единовластный государь, монарх". (БЭКМ).
	♦ От обратного прочтения ар. راض  ра:д (в других семитских языках – рац)  "объезжать лошадь",  ср. кучер и кайзер (см.). Другая версия – от аккадс. шару "царь", которое от шар, в смысле "голова".
КАЙЗЕР – "название императора Германской империи"; нем. kaiser < лат. caesar "цезарь". (БЭКМ).
	♦ От ар. قيصر  кайсар "царь". Родственно цезарь, кесарь, кучер (см. кесарь).
КУЧЕР – "слуга, работник, который правит лошадьми в экипаже". (БЭКМ).
	♦ От ар. قصر кассар "укорачивать (повод)", поскольку кучер правит лошадью, держа её на коротком поводке. Родственно ар. قيصر кайсар "царь", лат. цезарь, нем. кайзер. Ср. ар. سائس са:''ис "конюх", "политик", того же корня, что ар. سوس су:с "кобыла". Ср. также сидеть (на облучке) и сидеть (на троне), откуда ар. ساد  са:да (корень  سود  свд) "царить".  См. на эту тему также партия.

ЦЕРКОВЬ – "особой архитектуры здания, где совершаются богослужения по христианскому православному обряду", "организация духовенства и верующих людей какой-либо из христианских религий или отдельных религиозных течений". В этимологическом отношении очень неясное слово. Одна версия предполагает заимствование из немец. kirche "церковь", другая – из греч. kirianoV "господний". (Черных).
       ♦ От ар. حركة харака "движение", "идейное течение".

س раййис, раис "начальник, глава". 
раййис (ريس). Это обращение к разным мастеровым людям, знающим свое дело, мастер. И сейчас можно так обратиться, например, к водителю такси.
Сир и сэр от обратного прочтения рис "начальник" (см. "Энциклопедия пиратов")...  А рис - сокращение от ар. раййис "начальник" (диалект).
ЯРА - "весна" (русск-цслав.), отсюда яровой хлеб, яровые пчелы (первый рой), родственно греч. wra "время года, пора". (Фасмер).
       ♦ От рус. жар (см.).

РИС – "злак с белыми продолговатыми зёрнами, идущими в пищу, а также его зёрна", (БЭКМ); из романских языков. (Фасмер).
       ♦ От ар. أرز арз или арузз. По созвучию с ар. عريس ъари:с "жених": используется в обрядах бракосочетания (посыпание риса на головы молодоженов) из-за созвучия его с ар. словами رأسра''с "голова", عرس ъарс – "свадьба", عروسة ъру:са "невеста", عريس ъри:с "жених", رسى раса: "стать на якорь". По этой же причине является преимущественной культурой в Китае, шестом культурном регионе. Важно, что среди злаковых только рис и бамбук (см.) имеют шесть тычинок. Свадебные путешествия обусловлены ар. глаголом عرسъаррас "совершать путешествие". По этой же причине на похоронах едят рисовую кутью (см. кутья). О параллелизме рождения и смерти ср. ар. родственные корни  ولد валада "родить" и لحد лахада "хоронить". Привязка других зерновых к регионам см. гречиха, рожь, просо, сезам, хинта. Рис употребляют в пищу и как закрепляющее средство, работающее по созвучию с ар. رص расс "быть плотным, твёрдым". Аналогично крутое яйцо.

РИСТАЛИЩЕ – "площадь для гимнастических, конных и других состязаний, а также само такое состязание". (БЭКМ).
       ♦ От ар. رياضة рийа:за "конная выездка, спорт", производно от راض ра:за, рада "садиться на коня",روض равваз "объезжать коня". Родственно рыцарь, рейд, рейтузы.

СРАТЬ – "испражняться". Праслав. *sъrati связано с чередованием с сор. (Фасмер).
       ♦ Этимология неизвестна. От ар. خرا хара: с тем же значением. Переход С/Х обычен для многих языков. Ар. слово от أخر ''ахара "оставлять сзади", آخر ''а:хар "крайний". Родственно край, икра (см.) в обоих значениях.

СЫР1 – "пищевой продукт, получаемый свертыванием молока и дальнейшей обработкой полученного сгустка". (БЭКМ).
       ♦ От ар. يصير йсы:р "становиться" "превращаться", "оборачиваться", т.е. сворачиваться. Родственно сыворотка, серозный, ар. عصير ъаси:р "сок", производное от عصرъасар "отжимать" (при производстве сыра и творога отжимается сыворотка). Сыр как конечный продукт переработки молока (см.) включён в семантические параллельные ряды кормления (младенца) и духовного кормления, начинающиеся с молока, которое соответствует речи (по-арабскиكلام кала:м), и заканчивается либо маслом (см.), соответствующем мысли, либо сыром, что значит итог. Сыр по-арабски جبن жубн (ЖБН "сыр", "бояться") в рус. прочтении НБЖ, набожностью, (боязнью Бога). Рус. название сыра восходит к ар. глаголу из группы глаголов бытия и становления, от которой происходит слово Истина, т.е. Бог. См. также сливки, сметана, масло.
СМЕТАНА – "молочный продукт из кислых сливок. Щи со сметаной". (Ожегов).
     ♦ От арабского مط маттун отглагольное имя от مط матт "тянуть", تمطط таматтат "тянуться, становиться густым и вязким", буквально "сгустившиеся (сливки)". Сметана входит в ряд молочных продуктов молоко – сливки – сметана – масло – сыр, который соответствует по созвучию названиям этапов социализации личности, сметана соответствует формированию сметки, сообразительности. См. молоко, сливки, масло, сыр.
КОРМЛЕНИЕ – "способ содержания должностных лиц за счёт местного населения на Руси до середины 16 в. Князь посылал в города и волости наместников и др. служилых людей. Население было обязано содержать их («кормить») в течение всего периода службы. Наибольшего развития система К. достигает в 14—15 вв. По земской реформе 1555—56 К. было ликвидировано, а сборы на содержание кормленщиков правительство превратило в особый налог в пользу казны". (БСЭ).
	♦ Слово имеет еще и другое значение – "воспитание", иначе "духовное кормление"; от кормить (см.), перенос значения основан на однорядости женской поэтапной функции: "понести – носить – родить – вскормить – воспитать", этапы которой в русском и арабском языках названы со сдвигами в последовательности.  Так, по-арабски кормление грудью называется  رضاعة рида:ъа, от корня رضع радаъа "кормить грудью", сравните в греческой мифологии кормилица Дионисия – Рода), от этого корня в русском – родить. Русское "положение" ("быть в положении", т.е. вынашивать) соответствует по звучанию и буквальному смыслу слова арабскому وضع вадаъ "родить", буквально "положить". Русское снести ("родить") дает в арабском ناس на:с "люди", а русское люди от арабского валад "родить", сравните арабское مولودين маулю:дин "рожденные". С другой стороны, кормление, как один из этапов женской функции, внутри себя распадается на части в соответствии с наименованиями молочных продуктов: молоко – сливки – сметана – масло – творог – сыр, которые оборачиваются в "духовном кормлении" этапами становления интеллекта личности. См. эти продукты.

РУКА1 – "одна из двух верхних конечностей человека от плеча до кончиков пальцев, а также от запястья до кончиков пальцев". (БЭКМ).
     ♦ От ар. ركاء рука:'' "опора", откуда ارتكى ''иртака: "опираться". К семантическому развитию ср.: ар. يد йад "рука" и  ар. أيد ''аййад "поддерживать", англ. hand "рука" и ар.سند санад"опора". Строение руки таково, что она представляет собой некую матрицу универсального счета. Количество фаланг пальцев совпадает с числом дней акушерского месяца – 28 (или дней беременности – 280) и числом букв ар. алфавита. Количество фаланг четырёх пальцев, без большого, который по-арабски называется إبهام ибха:м (родственно наобум) "неясный", т.е. "безымянный", равно количеству месяцев в году. Если из счета исключить и "русский" безымянный, то получится девять – количество месяцев беременности по солнечному календарю". Количество месяцев беременности по лунному календарю дает количество всех пальцев на обеих руках. Отсюда рус. кулак совпадает по согласному костяку с основой слова калькуляция. При этом впадины и костяшки кулаков точно передают порядок чередования полных месяцев (31 день) и неполных (30 дней). Рус. рукадало в японском рейки (см.), искусство целительства с помощью рук.
РУКА2, рука набита, набита – "о хорошем навыке". (ФСРЯ).
     ♦ За рус. набита кроется ар. نابت на:бит "возвращаться (она вернулась)", отсюда понятие навыка, сравните ар. عادة ъа:дат "привычка", от глагола عاد ъа:да "возвращаться". Смысл выражения "рука имеет навык". Ср. глаз набит (см. набить2).
РУКА3, под горячую руку – разг. "(попасть, подвернуться) в сердитую минуту, когда кто–н. раздражён, рассержен". (БЭКМ).
       ♦ От ар. يروق йру:ку "нравиться". Т.е. под горячий норов.
РУКА4, средней руки, не так большой руки – Бывают дураки средней руки, – а наши дураки последней руки. (Даль).
 ♦ От ар. رقي рукий "подъем", откуда مرقى марка "сорт, ранг".
РУКА5, ему это наруку – "ему это как раз подходит".
       ♦ От сложения рус. наречной приставки (предлога) на с ар.  يروق йру:ку "нравится".
РУКА6, не рука – устар. "не удобно, нет смысла, поступать как-либо". (ФСРЯ).
       ♦ За рус. рука ар. يروق йру:к "нравится, подходит".
РУКА7, на руках – "на попечении". (Ожегов).
       ♦ За рус. руках – ар. رقاحة рака:ха "попечение, забота". Возможно, что ар. слово от русского.
РУКА8, греть руки – "нечестно, незаконными путями наживаться, богатеть". (ФСРЯ).
       ♦ От сложения ар. أجرى ''агра; "выполнять, производить, делать" + رقح ракках "поправлять свое финансовое положение".
РУКА9, сон в руку – "о сбывшемся сне". (Ожегов).
       ♦ От ар.  روق раук "жизнь", т.е. о воплотившемся в жизнь.
РУКА10, как рукой сняло – "прошла о боли".
       ♦ От ар. رقي рукй "заговор", "магия".
РУКА11, рукомытный обряд, рукомытие – "размывание рук, обряд меж родильницей и бабкой на 9-й день". (Даль т. 3).
       ♦ По созвучию от ар. رحم рахм(ат) "матка".
РУКА12, из рук вон (плохо) – "очень, совсем (плохо, скверно)". (Ожегов).
       ♦ От обратного прочтения ар.نوكر ну:кир (пишется НВКР) "быть порицаемым", откуда نكير наки:р "порицаемый, плохой",   букв.: "из порицаемого".
РУКА13, обряд рукополагания – "обряд посвящения в чин положением рук архиерея на голову рукополагаемого". (ППБЭС).
       ♦ От ар. رقى ракка: "повышать в чине, в положении". Родственно рука4. Полагание от обратного прочтения русского голова(х) (в ар. языке конечная гласная прикрывается придыханием, которое в иврите обозначается буквой П).
РУКА14, умывать руки – ♦ см. умывать.
РУКА15, рука и имя – "название Национального музея Израиля", по-еврейски яд вашем. Выражение взято из Библии, где еврейский пророк Исайа заверяет бездетных евреев, что и у них будет "рука и имя" в грядущих поколениях.
       ♦ За ар. (и евр.) словом يد йад "рука" скрывается рус. яд (отрава), по-ар. سم самм (СМ), за евр. шем скрывается ар. اسم исм (СМ) "имя". Таким образом, мы видим, что за выражением скрывается дважды повторенное СМ: СМ – СМ. Речь могла бы идти о рус. слове семя,  что значит также "потомство", но не в прямом смысле, поскольку уже ясно по определению, что потомства нет. На самом деле название отражает то обстоятельство, что на кончике стрелы – яд (по-арабски СМ), а на кончике стрелки (лука, например) – семя (по-русски: СМ), что является маской кода входа в интернет Господа: сим-сим откройся. За сакральным заклинанием сим-сим не клад драгоценностей, как в арабской сказке, а знания: каждое слово, по-арабски СМ, получит правильное значение, сему (СМ), идея, которая отображается в виде двух семёрок в звездк Давида (см.), которую мы видим на флаге Израиля.  См. также сим-сим.
РУКАВИЦА – "предмет одежды, закрывающий всю кисть и большой палец отдельно". (БЭКМ).
       ♦ От рука1. Часть -вица от  وقاية вика:йа "защита". Родственно веко (см.).
РУКОВОДИТЬ – "направлять чью–н. деятельность"; "управлять, заведовать". (БЭКМ).
       ♦ Сложения ар. رعى раъа:  "пасти" и قود квд "руководить", "возглавлять", "вести", откуда قائد ка:''ид "вождь", "командир", "руководитель". Родственно кадет (см.).
Протослог -*sar- в топонимах мира и этимология слов с его присутствием в разных языковых семьях
http://www.organizmica.org/archive/907/psar.shtml

Древние предки покланялись богам Ра, Диву, Трибогу (Дажьбогу), Сварогу, Бору (Пану), Сесту (Сэту), Семешу, Весте и Дэву. Но обращение «Всевышний» касалось только Сара. Сар – не просто бог, это ещё и природное явление, ежесуточно наблюдаемое нами на небе – заря, зорька. В русских заговорах слово «заря» означало ещё звезду. Имя Заря осталось не только у русских. Например, у англичан сохранилось слово zero (ноль), которое звучит схоже с именем Заря = Сара, что указывает на повсеместное распространение бога Сара по всему Евроазиатскому континенту...

Названия верхней одежды у многих народов также имеют в своём составе слог -*sar-: сарафан – русская женская верхняя одежда, сари – индийская женская верхняя одежда, саронг – индонезийская национальная одежда...

Название древнего хазарского города Саркел также имеет в своём составе слог -*sar-. Этимология данного названия до сих пор неясна (высказывается предположение о том, что название переводится c хазарского как «белый город» [8]). Но среди сохранившихся слов вымершего хазарского языка есть не только обозначение белого цвета: sār – «белый», но и прилагательное sārïg – «жёлтый», то есть данное прилагательное также имеет слог -*sar- в своём составе.
</span>
';
GO

exec spAddArticle 10325, N'Что в имени твоем: Ходжа Нассреддин', N'', N'
<span viak="word">Ходжа Нассреддин

</span><span viak="description">
Ходжа́ Насредди́н — фольклорный персонаж мусульманского Востока и некоторых народов Средиземноморья и Балкан, герой коротких юмористических и сатирических миниатюр и анекдотов, а иногда и бытовых сказок... Арабское мусульманское личное имя Насреддин (араб. نصرالدين, Naṣr ad-Dīn) переводится как «Победа Веры».

Это имя должно рассматриватся в мусульманско-арабском контексте.

Ходжа - мусульманин осуществивший "хадж" - хождение в Мекку.

Нассреддин - Насср-еддин - Суд Орла, Судейский Орел, Орлиный судья
</span><span viak="summary">
Ходжа Нассреддин - Орлиный судья ходивший в Мекку
</span><span viak="reference">
Поиск у Н.Н.Вашкевича дал следующее:
ر  НСР “клевать”
от ар. ан-наср альтаир "летящий орел".
насер - орел
Viki: From the Arabic اَلنَّسْر اَلطَّائِر ‎(an-nasr aṭ-ṭāʾir, “the flying eagle”), from نَسْر ‎(nasr, “eagle”) + طَائِر ‎(ṭāʾir, “flying”).  https://en.wiktionary.org/wiki/Altair

دين ди:н "суд"
...фразы  из Корана: الدين يوم ملك малик йаум ад-дин (из первой суры), буквально: "властитель дня суда"
</span>
';
GO

exec spAddArticle 10602, N'Что в имени твоем: Грифон', N'Вашкевич, геральдика, имя, история, символ, слова', N'
<span viak="word">Грифон

ГРФ - грифон грейфер граф grief(англ:горе) Греф
ФРГ - фрегат ФРГ
ФРк - фракция freak(англ:урод) фрукт фрикция Африка фрак
<a href="http://viakviak.livejournal.com/34476.html" target="_blank">ГРт</a> - 
<a href="http://viakviak.livejournal.com/33634.html" target="_blank">ГРв</a> - гравитация groove(англ:паз,канавка,выемка,прорез,борозда,выбоина) grave(англ:могила) грива гривна 
вРГ - враг овраг
<a href="http://viakviak.livejournal.com/33634.html" target="_blank">вРх</a> - ворох верх
хРв - хоровод harvest(англ:урожай)
<a href="http://viakviak.livejournal.com/18520.html" target="_blank">кРт</a> - quarters(англ:квартиры) <a href="http://viakviak.livejournal.com/45219.html" target="_blank">кварти(ра)</a> карта карат квартет court(англ:суд,двор,площадка,королевский двор,ухаживание) карате крот куратор карета аккуратный каратель картель картон карто(фель) курить куртка курорт crate(англ:упаковочный ящик) carot(англ:морковь) кретин
<a href="http://viakviak.livejournal.com/18821.html" target="_blank">ТРК</a> - таракан тарака(араб:стучать) терка турок тюрк торкнуть отрок трюк attraction(англ:привлекательность) track(англ:след,путь,следить) Аттатюрк truck(англ:грузовик)
<a href="http://viakviak.livejournal.com/29208.html" target="_blank">чРТ</a> - черта черт чертоги
ТРч - отречение отторочка treacherous(англ:коварный)
хРт - heart(англ:сердце) 
тРх - трахать трюхаться Терехова тарахтеть
<a href="http://viakviak.livejournal.com/33634.html" target="_blank">кРв</a> - кровь кривая кров корова курва караван кровать
	- <a href="http://viakviak.livejournal.com/45394.html" target="_blank">ГРб</a> - grab(англ:захват) гроб грабить горб гребля герб
	- <a href="http://viakviak.livejournal.com/30779.html" target="_blank">бРГ/a> - берег брага оберег бург(омистер) -бург (ки)борг Бургу(ндия)
	- <a href="http://viakviak.livejournal.com/33634.html" target="_blank">ГРп</a> - грипп grope(англ:щупать) Агриппина группа
	- пРГ - пирог пурга  пергамент preg(nant)(англ:беременная) прог(рама) Прага прыгать
</span><span viak="summary">
Представляется, что Гриф (грифон) назван по передним орлиным лапам с когтями для схватывания, которыми он скребет, забирает, захватывает, хапает. Задняя часть грифа - это лев. Соединие льва и орла, где лев (асуд в смысле рассудок, судья) сзади, а орел (в смысле собиратель, захватчик) спереди прекрасно характеризует изменение вектора политики государства - главное захват, собирание (земель).
Дополнительно, имеется смысл "собирать", "взбираться" и "верх". Как символ государства, это добавляет понятия "объединение" (собирать), "величие" (верх), "победа"(одержать верх).
</span><span viak="description">
attraction(англ:привлекательность) - забирает внимание, деньги
court(англ:суд,двор,площадка,королевский двор,ухаживание) - собрание
grave(англ:могила) - выкопанная
grief(англ:горе) - общее всеохватывающее горе
groove(англ:паз,канавка,выемка,прорез,борозда,выбоина) - выхваченное
grope(англ:щупать) - хватать
harvest(англ:урожай) - собранный урожай
heart(англ:сердце) - для забора крови
preg(nant)(англ:беременная) - "подхватившая"
track(англ:след,путь,следить) - выбитый путь
Агриппина - забирающая, захватывающая
Аттатюрк - великий собиратель
Африка - великая, захваченная
берег - возвышение суши
брага - забористая выпивка, всходящее сусло
-бург - сборище домов
верх - куда взбираются(сбираются)
ворох - сметенный, собранный
враг - захватчик
герб - собрание символов
горб - возвышенный
грабить - захватывать
гравитация - сила захвата, притяжения
граф - захватчик, собиратель земель
гребля - загребание весла в воде
<a href="https://ru.wikipedia.org/wiki/Греф,_Герман_Оскарович" target="_blank">Греф</a> - собиратель, захватчик, великий, победитель
<a href="https://ru.wikipedia.org/wiki/Грейферный_механизм" target="_blank">грейфер</a> - хватательный механизм
грива - вздымающиеся волосы
гривна - монета красного (кровянного) золота
грипп - подхваченная болезнь; билингва: схватить грипп
грифон - передние орлиные лапы скребут, схватывают
гроб - в него сметены, собраны останки
группа - собрание
караван - сборный транспорт
карта - собрание географических сведений
корова - схватывающая, хапающая траву
кров - жилье родственников
кровать - для совместного сна родственников
кровь - объединение по родству
пергамент - письменный материал выделанный из верхнего слоя (кожи)
пирог - "сгреблено, сметено" в него, вздымающийся на пару
Прага - вздымающаяся вверх
прог(рама) - собрание функций
прыгать - движение вверх
пурга - сосребающая с земли
трахать - выбивать
трюк - незаметно забрать
трюхаться - быть подбрасываемым вверх
тюрк - захватчик
черт - хватающий человеческие души
черта - выскребленная царапина
чертоги - кров
<a href="https://ru.wikipedia.org/wiki/%D0%A4%D1%80%D0%B0%D0%BA" target="_blank">фрак</a> - костюм у которого пиджак с выемом ("отхваченной" частью материала) спереди.
фракция - составляющая часть
ФРГ - захваченная Германия, объедненная Германия
фрегат - корабль-захватчик
фрикция - сребущая
фрукт - растущий сверху
хоровод - собранные вместе
</span><span viak="reference">
Грифон — мифическое существо с головой, когтями и крыльями орла и телом льва. Он символизирует господство над двумя сферами бытия: землей (лев) и воздухом (орел). Сочетание двух главнейших солнечных животных указывает на общий благоприятный характер существа — грифон олицетворяет Солнце, силу, бдительность, возмездие.
http://www.newacropol.ru/alexandria/symbols/grifon/
</span><span viak="reference">
Пользователь vedaveta (vedaveta) ответил(а) на комментарий, оставленный вами к записи в LiveJournal. Комментарий, на который был получен ответ:
viakviak: Лев (асуд по арабски) это символ КАЗИдарства-гоСУДарства (арабо-русская билингва). Государство - это власть СУДарей-СУДейских. Кто первый имел льва как символ - тот и первый в государственной строительстве.
Ответ был таким:
Грифон лев с орлом был символ Тартарии...до бритов и французов лев был у моголов ...бриты его имеют в гербе как завоевалели и там же единорог на -цепи личный символ Ивана Грозного...
</span><span viak="reference">
Из Вашкевича Н.Н:
га:рифа (араб.) "грабли"
ГАРПИЯ – "в древнегреческой мифологии: крылатая женщина-чудовище, богиня вихря"; перен. "злая женщина"; "крупная хищная птица сем. ястребиных, обитающая в лесах Юж. и Центр. Америки"; от греч. harpyia букв. похитительница. (Крысин). "Гарпии – злобные похитительницы детей и человеческих душ". (МС).
     ♦ Греч. слово от ар. جرف гараф "сметать, сносить о потоке", откуда جارفة га:рифа "грабли". Родственно гриф.
ГРИФ – "в античной мифологии: крылатое чудовище с головой орла и туловищем льва"; "крупная хищная птица, питающаяся падалью". (Крысин).
     ♦ От ар. جرف гарафа "тащить", "сметать" (о потоке). См. гарпия.
ГРАБ1 – "дерево сем. лещиновых с гладким серым стволом". (Ожегов); "грабина", "белый бук", carpinus betulus l. — красивое дерево из семейства березообразных, со светло-серою гладкою корою и белою древесиною. Листья эллиптические или удлиненно-яйцевидные, почти гладкие, по краям двоякопильчатые, т.е. их крупные зубцы сами разрезаны еще на несколько мелких зубцов. Женские цветки, в небольшом числе, в виде редких сережекна концах ветвей (как у березы); каждый состоит из двугнездой завязи с 2 рыльцами и трехлопастного 3-нервного прицветника. Плод односемянный (по недоразвитию другого семени) орешек. Г. распространён в Южной и Средней Европе и Азии, до Афганистана; попадается в Англии, Швеции, Дании. Ископаемый крупнолистый Г., С. grandis, найден в плиоценовых отложениях в Германии (относится к так наз. "Венскому бассейну". Древесина высоко ценится, местами даже дороже буковой, на дрова, но вместе с тем дает поделочный лес высоких качеств (кулаки в машинах, молоты, винты, рукоятки для заступов, топорища, гребни и т.п.) (Брокгауз); дерево "carpinus betulus", Grabovius – эпитет Юпитера. (НЭР).
      ♦ Сакральное дерево германцев, отражает их номер (2) особенностями строения цветов и плодов, а его применение соответствует мастеровитости немцев. Название граба созвучно одному из главных понятий немцев: гроб (ср. что русскому хорошо, то немцу смерть). Созвучие с русским грабитьтоже функционально: в немецком языке показатель причастия действительного "унг" (в английском инг – см. англ. язык) по-арабски значит "грабитель, разбойник". В связи с этим интересно что в германском законодательстве грабёж наказывался гораздо менее строго, чем воровство (см. Брокгауз. Грабеж), в отличие, например, от римского права и вообще здравой логики. Этимологически  от  обратного  прочтения  ар.  برق барг  (барк) "молния". В скандинавской (северогерманской) мифологии богом грома был Тор, сын Одина (см.) и Иорды (земли).
ГРАБ2 – "пиратский корабль; Индийский океан; 18 век. Это название (от ар. гораб, ворон) первоначально применялось к весельной галере. В эпоху королей Ангрии граб был кораблем грузоподъемностью 150 – 300 т. с двумя мачтами и небольшой осадкой. Верхняя палуба переходила в приподнятый нос. Два или три граба обычно окружали свою жертву, позволяя пиратам, пробравшимся по носу граба, взять судно на абордаж". (ЭП).
     ♦ От ар. غراب гура:б "ворон", название, которое, в свою очередь, происходит от рус. грабить1.
ГРАБИТЬ1 – "отнимать, похищать силой"; перен. "разорять, отнимая что–н., обременяя налогами, поборами". (Ожегов).
  ♦ От ар. حرب хараба "грабить" حرب харб "война". (М., с. 128).
ГРАБИТЬ2 – "собирать граблями".
     ♦ От ар. جرف гарафа "тащить". Того же корня гриф (см.).
ГРАБЛИ, простой как грабли – прост. ирон. "о чем ли простом, ясном, понятном". (Квеселевич)
     ♦ За словом грабли скрывается ар. جرب гарраб "проверить, испытать, иметь опыт". Имеется в виду "проверяемо". То же в наступить на те же грабли. Русский образ возникает благодаря ар.  гарраба "иметь опыт". Аналогично см. солома.
ГРАВИТАЦИЯ – "всемирное тяготение"; от лат. gravitas "тяжеcть". (Крысин).
     ♦ Того же корня, что ар. جرو гирв (жирв) или гарв "зародыш", "детеныш животного, преимущественно собаки или льва". К семантическому соответствию ср. греч. эмбрион "детеныш овцы" и рус. бремя. В ар. языке слово от обратного прочтения рус. корня РЖ-РД "родить, рожу", особенно в форме урож-енец.
ГРЕЙФЕР – тех. "грузозахватное приспособление подъемного механизма для перегрузки сыпучих материалов", "в различных аппаратах и машинах – захват, приспособление для захватывания и фиксации предмета при его обработке"; от нем. greifer < greifen хватать, схватывать. (Крысин).
    ♦ От ар. جرف гараф "схватывать и нести, например, о потоке". Родственно гриф в обоих значениях (см.).
</span>
';
GO

exec spAddArticle 10847, N'Что в имени твоем: Закон', N'Вашкевич, государство, закон', N'
<span viak="word">Закон
ЗК - закон зэк
КЗ - кази казан казак казах коза кизяк оказия (с)каз указ Кавказ
<a href="http://viakviak.livejournal.com/30099.html" target="_blank">сК</a> - сакля секира сукно скакать секу(нда) аскер аскет сука сок оско-(лок,мина,пить) оскал Осака
Кс - кусок косить кассета касса коса
Зч - зачать
чЗ - cheese(англ:сыр) чизель
сч - сыч сечь 
<a href="http://viakviak.livejournal.com/30099.html" target="_blank">чс</a> - час чесать чистый честь
жК - жук жэк
Кж - кожа Кижи
</span><span viak="description">
Закон => Наказ, где с одной стороны Закон, как "наказ" - это завещание судейских правил, а с другой, "наказ" - это свод наказаний за проступки. Мы как раз и видим, что слово "наказание" наверное и происходит от слова "наказ" ("закон" наоборот).
Нарок => Коран. Таким образом слово Коран могло обозначать "нарок", "наказ", "закон", чем собственно эта книга сейчас и является.
Кази - судья, законник
Хаза, Каса, Сакля - дом, жилье; "Турецкий язык: hisar – крепость, замок" (from chispa)
Заказ - законный 2 раза - русско-арабская билингва

ЗАкон
накАЗ
Аз - первая буква русского алфавита
Ас (Туз араб.) первая карта в колоде (бьет короля)

ЗАкон
накАЗ
рАЗ
ЦаРь

Вывод: Складывается впечатление, что слово АС представляет собой понятие первый, "перво-основа", "наиглавнейший", высочайший

Отсюда:
османы (АС-маны) - наипервейшие люди, главный народ - наипервейшие люди, главный народ
Осетин - АС-АТ-АН - человек (ИН) главного (АС) защитника (АТ)
Казаки, Казахи - законные, узаконненые, в законе. Очевидно было необходимо разделить народы на лояльные и нет.
</span><span viak="reference">
Из Вашкевича Н.Н.:
АЗ – "название первой буквы рус. азбуки"; (в выражениях ни аза не знать, азы науки, начинать с азов и т.п.) "начальные (элементарные) сведения". В других славянских языках имеет значение "я". Этимология не вполне ясна. (Черных).
	♦ От ар. وز вазз "гусь". Именно гусем (ср. начертание: ى)  в ар. алфавите изображается вариант Алифа, называемого в обиходе وز вазз "гусь". Его официальное название алиф максура (مقصورة ألف), букв. "Алиф укороченный", что  противоречит факту. По изъятии из слова максура приставки и окончания, и прочтении корневой части в обратном направлении получаем смысл этого названия: РУСК. Это действительно "русский гусь", который изображён на древнеегипетской фреске в качестве создателя мира (читай империи). Гусь в качестве символа Руси выбран потому, что рус. буква Глагол в древне-арамейском алфавите совпадала по начертанию с буквой Реш (ר), отчего рус. слово гусь стало совпадать в еврейском прочтении с названием Руси. Значение "начало" у буквы Аз возникло не только по причине начального положения буквы, но и потому что предлог от этого ар. корня إزاء ''иза:''аозначает также "находиться впереди". Эта же конфигурация повторяется в десятой букве под названием Йа: ي. Хотя числовое значение её – 10, она помещена в другом ар. алфавите (не счетном) на последнее место таким образом, что по звучанию названия она совпадает с последней буквой рус. азбуки (Я). Обращает на себя внимание, что индивидуумы одной части в прошлом единого славянского этноса называют себя первой буквой рус. (и ар.) алфавита (Аз), индивидуумы другой части – последней буквой тех же алфавитов (Я). Единственное тому объяснение – то, что в ар. алфавите эти две буквы имеют одинаковое начертание (силуэт гуся). Слово я в рус. языке происходит, тем не менее, не от названия буквы, а от ар. جاي йай (гай, джай) "иду", употребляемого в ответ на зов. Это означает, что Аз как местоимение – вторично, эта функция перенесена на первую букву по сходству начертания с последней буквой, название которой совпало по звучанию с местоимением. С точки зрения физиологии, Аз (гусь), находясь в первой клетке алфавитно-цифровой матрицы, является ярлыком файла, запускающего менструальный цикл (в 28 дней, по букве на каждый день), в первый день которого в женском организме подается команда на овуляцию. Одновременно по числовому значению, соответствующему номеру красного цвета, "Гусь" подает команду на приток крови к матке для вымывания старой яйцеклетки. В ар. счетном алфавите буква Йа десятеричная замещает исконную ар. десятку, которая вытеснена ею в рус. кириллицу: i. Ар. название гуся происходит от глагола أز ''азза "свистеть", ср. рус. название гусей: свищи.
АС – "первоклассный летчик (первоначально летчик-истребитель, мастер воздушного боя). В переносном смысле – большой мастер своего дела"; франц. as – туз. (БЭКМ).
	♦ От ар. آس   ''а:с "туз" – карта старше короля, бющая все карты. Тот, кто старше короля, – Бог. Еврейский бог Апоп, в обратном прочтении попа. Ср. название священной птицы евреев удода на лат. языке: Upupa. Ср. рус. тузы от   ар. طيوز     туйу:з "задницы", откуда рус. таз. Ср. якобы тайное имя бога, так называемый тетраграмматон    יהוה   который в русском восприятии читается ЙпоП (по-еврески читается Йагве или Иегова). Ср. также анг. ass"задница".
ЗАКОН1, юридический закон, закон судопроизводства – "постановление государственной власти, нормативный акт, принятый государственной властью; установленные государственной властью общеобязательные правила". (Ожегов).
	♦ Рус. закон происходит от ар.  ذقون зуку:н "бороды" или от ذقون заку:н "имеющий бороду". В древности за советом, как жить, обращались к старикам, да и сейчас законодательные органы называют советом старейшин, сравните ар. سن синн "возраст", "зуб", مسن мусинн "старик", буквально "беззубый" и سنة суннат "закон", откуда, кстати,сенат и консул – в обратном прочтении الأسنخ л-''аснах "беззубый", откуда и канцелярия.
ЗАКОН2, законы природы – "Не зависящая ни от чьей воли, объективно наличествующая непреложность, заданность, сложившаяся в процессе существования данного явления, его связей и отношений с окружающим миром: законы природы". (Ожегов).
	♦ Рус. закон происходит от ар. زكن закина "понять суть", "познать", откуда отглагольное имя (масдар): زكانة зака:на. Вероятно, ар. корень образован от рус. приставки за и ар. слова كيان кийа:н или كون каун, кон "бытие", букв. "то, что за бытием".
НАРОК1 – "имя, название";  "обет", "завет" (Даль), от ректи, нарекать; того же корня речь (см.).
	♦ От этого слова в обратном прочтении в ар. языке Коран (القرآن), что есть "завет". Всего заветов – четыре: Ветхий, Новый, Веды (от ар. وعد ваъд "завет") и Коран.
НАРОК2 – "умысел" (Даль), откуда нарочно, ненароком.
	♦ От обратного прочтения ар. قرنкарана "связывать", ср.حزم хазм "завязывание", "решимость". Идея идет от образа:  подпоясаться, завязать кушак = иметь решимость, намерение пойти на что-л., замыслить. (см. об этом Майзель, стр. 231), Родственно корень, крона, Кронос, наречие2 (см.).
КАЗАК – "поселенный воин, принадлежащий к особому сословию казаков, легкого конного войска". (Даль).
	♦ От ар. قزع казаъа "прыгать", "быстро скакать (о коне)" (М., с. 627). Ср. пословицы: без коня казак кругом сирота, без коня не казак, казак без коня, что солдат без ружья. (Даль). Родственно коза, козел, стрекоза (см.). Есть версия, что терские казаки – обрусевшие осетины и кабардинцы (сайт Осетия. ру). См. Кабарда.
</span>
';
GO

exec spAddArticle 11024, N'Что в имени твоем: Аллах', N'Вашкевич, бог, вяк, слова, титул', N'
<span viak="word">Аллах
</span><span viak="description">
Слова приветствия на разных языках мира: Olá (португ:привет), Hello (англ:привет), Hola (исп:привет), Aloha(hawaiian:привет), Алле, сАЛАм (узб:привет), шАЛАм(ивр:привет), sALve (латин:привет)

Присутствие звукосочетания АЛА в словах-приветствиях, которые очень устойчивы показывает упоминание Аллаха во многих Западно-Европейских языках.

А что же слово Аллах конкретно означает? Понятно, что это одно из имен бога, очень употребительное. Каждое имя бога называет лишь одно из его качеств. Какое же божественное качество стоит за словом Аллах?

В Английском языке есть слова hOLy - святой, hALO - ореОЛ, нимб, сияние. Мне эти слова кажутся очень показательны, потому что словa hOLIness, "сияние", "светЛОсть", "сиятЕЛьство" употреблялись к важнейшим особам. Вспомним hOLy virgin (Пресвятая богородица), hOLy trinity (Святая троица), "Его Преосвященство", ...

Таким образом представляется, что слово "Аллах" может быть переведeн, в следующих значениях: свет, сияние, свечение, освещение.

Проверочные слова: ИЛЛЮминация, ЛАмпа, кАЛЕние, ЛУч. Ну и приветственные слова на разных языках желают света тем или иным образом.

ОЛИмп - место богов - святилище

ЭЛохим, ЭЛион, ЭЛ - другие имена бога.

бЕЛый - <a href="http://viakviak.livejournal.com/11820.html" target="_blank">БАЛый (главный)</a>, бАЛАй - можно понимать как светлейший <a href="http://viakviak.livejournal.com/19758.html" target="_blank">цвет</a>
АЛый - светло-красный

Исходя из сказанного английское слово "hOLe" может быть осмыслено как "дыра пропускающая свет".
</span><span viak="reference">
Из Н.Н.Вашкевича:

АЛЛАХ–"Бог у магометан". От ар. allah. (Ушаков).
	♦ И в арабских источниках, и в мировой арабистике, и в исламоведении бытует ложная этимология этого слова, основанная на его ошибочном грамматическом членении, при котором оно понимается как сложение артикля ал и слова ''илах"бог". При этом не делается даже попыток объяснить мистическое исчезновения первой корневой, которое противоречит арабской грамматике. На самом деле это форма усиленного причастия (имя деятеля) от корня '' л х, (откудаإله''илах "бог", "предмет поклонения"), который этимологически восходит к корню'' вл أول, откуда глаголأل"возвращаться", "объяснятся", "причинно восходить к чему-либо",каузатив которого дает другое значение: "указывать на причину", "объяснять", в форме причастия: "то, что все объясняет", т.е. то, что в европейской культуре принято называть Абсолютом, ср. производное от данного ар. корня:أول '' аввал"начало".  Таким образом, Аллах можно перевести как "первопричина", "то, к чему все восходит", "то, через что все объясняется". Ср. мусульманскую заклинательную формулу по сути об этом:راجعون اليه وإنا لله إنا   ''Инна ли-ллах ва-''инна ''илейхи ра:гиъу:н"по истине, мы от него (Аллаха) и к нему мы возвращаемся". Иначе говоря, Аллах в представлении самих мусульман, это то, к чему они возвращаются.
А1– первая буква рус. алфавита. Числовое значение – 1. Название – Аз (см.).
	♦ По месту в алфавите и числовому значению соответствует ар. букве Алиф, которая имеет два варианта написания:Алиф тави:ля: اиА лиф макс:ура: ىПо начертанию во всех своих вариантах – так называемой та марбуте: ـة, фонетически – придыханию, которое в определенных случаях, оговариваемых грамматикой, произносится то как а(х), то как ат. Та марбута ( ة или ـة ) является в то же время показателем женского рода,  что говорит о том, что рус. буква А (а) взята с пятого места и это видно также по звучанию. Пятое место в большинстве алфавитных систем, начиная с финикийской, замещено буквой ع(Ъайн), обозначающей в ар. языке гортанный, а в новообразовавшихся алфавитах – звук Е. Об эволюции пятерки и происхождении буквы А см. Н. О физиологической роли буквы А см. Аз.
СВЕТ 1– "лучистая энергия, делающая окружающий мир видимым; электромагнитные волны в интервале частот, воспринимаемых глазом". (БЭКМ).
       ♦ От ар.سوية савиййат"ровные", ср. ар.نور ну:р"свет" от рус. ровный. По созвучию с ар.سبعة сабъат"семёрка", глаз видит при разложении солнечного цвета например, в радуге, семь цветов. Возможно, из рус. названия света происходит ар. СТ "шесть" в обратную сторону ТС "девять", отражая число 609, имя универсального файла воспроизводства, воплощённого в начертании букв рус. слова род. (см.), а также Саваоф (см.). Возможно, имеет место контаминация с ар. СХВ "просыпаться", см. Сава, сова.Рус. свет дало в греческом теос "бог", а ар.ضوء зо''"свет" дало в греческом Зевс.
СВЕТ 2, белый свет - ♦см. белый.
СВЕТ 3, тот свет – "загробный мир, как противопоставление земному миру, жизни". (ФСРЯ).
       ♦ Загробный мир так называется по созвучию русского местоимения тотс египетским богом по имени Тот (Тухут), богом Луны и загробного царства (от арабскогоطوية тавиййат–"сворачивание, сокрытие", производное от глаголаطوى тавва:"сворачивать, складывать вдвое", откуда, кстати, русское два). Тоту принадлежала ведущая роль в погребальных ритуалах.Древние греки считали бога бальзамирования Анубиса ипостасью Тота (см. МС).Разночтения его имени вызваны тем, что русская буква о в арабском языке означает придыхание (х). Согласно преданию, бог Тот через своих сестер и жён Сешет и Мефдот дал людям письменность и счет, поэтому слово текст (text) есть еще одно прочтение имени Тота. Египтологи из-за многообразия функций этого бога (например, бог времени, ведущий записи рождения и смерти) не замечают ни его связи с загробным миром, ни его номера, который записан не только в этимологии его имени, но и в виде арабской двойки изображается на статуэтках, где он в маске ибиса. К тому же он имел две маски: маску ибиса и маску обезьяны, что точно соответствует и его номеру и номеру заупокойного культа и этническому номеру египтян.
СВЕТ 4, ругать на чём свет стоит – "ругать очень сильно, не стесняясь в выражениях".(ФСРЯ).
       ♦ Билингва: ругать + ар.نقم накам(на чём) "упрекать, ругать" +سوء су''+تستاء т иста:"ругать", родственно рус. сетовать.
СВЕТ 5, свет нефизический - "духовный свет, который, в отличие от света солнца, света физического, благодаря которому мы различаем вещи материальные,  позволяет различать вещи духовные".
       ♦Источником нефизического света является семантическая плазма, состоящая, как и солнце, из двух элементов: русского яз. и арабского. Эти языки имеют, как и элементы химические, номера, соотносимые с атомными массами водорода и гелия. Русский язык через красный предпочтительный цвет (цвет №1) и другие особенности русского характера проявляет свой номер как номер 1, ар. язык через зелёный предпочтительный цвет (цвет № 4) и особенности национального характера проявляет свой номер как номер 4. Сложение красного и зелёного даёт чёрный (коричневый) цвет, поэтому можно сказать, что нефизический свет имеет чёрный цвет. Имеется в виду, что Предвечная мудрость(см.) исполнена чёрным по белому, т.е. карандашом (чернилами) по бумаге. Нефизический свет является носителем формулы прояснения смысла 1+4. Подсказкой являются билингвы. Билингвы это такие слова и выражения, одна часть которых выражена по-русски, другая-по-арабски, например,  сорока-воровка, где сорока по-арабски значит "воровка" или указующий перст, где за рус. перст скрывается ар.فهرست фихрист"указатель". См., например, билингвы-идиомы: малая толика, кошмар собачий, пьяный в стельку, шут гороховый, почётная грамота, скотина бессловесная, стоит как вкопанный, дерево познания, высокопарный, лиса Патрикеевна, во время оно, пороть горячку, тоска зелёная, праздновать труса, реветь белугой, сами с усами, ругать на чем свет стоит, сесть в галошу и т.п. Скрытый смысл Бытия во всех его фрагментах раскрывается с помощью кода РА. Всё что непонятно в рус. языке надо читать по-арабски и наоборот. Другие иностранные слова объясняются в конечном итоге либо через рус. язык, либо через арабский. См. на эту тему ковчег спасения, Предвечная мудрость, синдром Ио.
</span>
';
GO

exec spAddArticle 11544, N'Что в имени твоем: Единорог', N'Вашкевич, вяк, геральдика, государство, история, символ, слова', N'
<span viak="word">Единорог
</span><span viak="description">
В свое время на меня произвело неизгладимое впечатление подход Н.Н. Вашкевича к греко-римской мифологии. Он очень наглядно показал, что эти мифы в своей основе - <a href="http://nnvashkevich.narod.ru/kng/SYSJAZ2007/appli4.htm" target="_blank">просто красочные описания имен их героев</a>.

Я пробую применять этот подход к любой мифологии или символам. Чем больше раз данный символ или слово добавит смыслового значения, произнесет ключевое слово, тем символ "богаче" и "лучше".

Символ "Единорог" широко использовался в <a href="http://viakviak.livejournal.com/11518.html" target="_blank">геральдике</a> и в астрологии (как козерог). Попытаемся проанализировать слово Единорог, "прокрутив" его напрямую и обратно, пробуя близкие согласные, и игнорируя гласные. При этом, мы также рассмотрим смысловое поле - другие слова, с которыми Единорог употребляется. Это позволит избежать ошибок и проверить себя.

Единорог
Один рог
ГоРоНиде -> коРоНада -> коРоНа, коРаН, НаРок, каРиНа (супруга), кРоНа (дерева), кРаН, коРеНь, ГоРН, ГоРНило, ГРаНь, кРоНос (бог времени, он же сатуРН)

Горн означает Рог ( От ар. قرن карн (гарн) "рог".), т.е. мы прошли полный круг, доказав правомерность выбранного направления.

Таким образом в обратном русском прочтении Единорога можно увидеть Корону, которая означает "связь", "объединение", "воссоединение". Иван Грозный мог использовать символ Единорога как символ права на объединение, воссоединение земель, права свою царскую корону и может быть права на польскую/литовскую корону.
Крученый рог у Единорога добавляет смысловое значение "туго скрученный/завязанный". Первая часть слова Едино-рог, в свою очередь еще раз добавляет смысл "один, единый, объединенный".

</span><span viak="summary">
Единорог (как и корона, коран) несет в себе смысл объединения, мирного союза, плавильного котла народов.
</span><span viak="description">
Единорог обычно изображается белым. a href="http://viakviak.livejournal.com/19758.html" target="_blank">Белый</a>, <a href="http://viakviak.livejournal.com/11820.html" target="_blank">балу</a>, бала, Валуа, великий = голова, основной, главный, большой. Белый царь - большой, Балтика - главное море, баллиста - большое орудие (главного калибра), балда - голова ...

Белый единорог - великий союз народов.
</span><span viak="summary">
Английское слово Unicorn (One-horn) тоже говорящее: Uni + corn = Uni(ted) cor(o)n(a). Очевидно, что в одном слове дважды повтореннно смысловое "объединение".
</span><span viak="reference">
Из Н.Н. Вашкевича:
КОРОНА – "головной убор или наголовье, служащее признаком известной власти и формой своей определяющее звание, сан, титул, а иногда и заслуги лица, кому она принадлежит" (Брокгауз); от лат. corona  "венец", "венок". (СИС).
	♦ В латыни от ар. قرن карана "вязать, связывать". Родственно корень (см.). Обряд венчания связан по созвучию с ар. قرينة кари:на "супруга", قران кира:н "обряд бракосочетания". Жрецы, вожди и царствующие особы носили короны в знак брачного союза с Богом. В животном мире в роли знака брачения выступают рога (например, у оленей, особенно это заметно в брачный период, когда рога приобретают такую причудливую форму, что их невозможно использовать для защиты). Поэтому ар. название рогов происходит от того же корня: قرن карн "рог" (мн. число قرون куру:н). У деревьев эту роль исполняет крона.  См. также диадема.
КОРЕНЬ – "подземная часть растения, служащая для укрепления его в почве и всасывания из неё воды и питательных веществ". (БЭКМ).
	♦ От ар. قرن карана "связывать", ср. ар. أصل ''асл "корень" и وصلвасала "связывать", "соединять", также ارومات ''арума:т "корни" иأرم ''арама "связывать" (см. аромат). Родственно горн, грань, гарнир, наречие (см.).
ГОРН2 – "духовой медный сигнальный инструмент в виде прямой трубки с раструбом"; от нем. horn букв. рог. (Крысин).
	♦ От ар. قرن карн (гарн) "рог".
КОРАН – "священная книга ислама, содержащая изложение догм и положений мусульманской религии, мусульманских мифов и норм права"; араб. qur’аn "чтение". (БЭКМ).
	♦ От ар. القرآن ал-кур''а:н, производного от قرأ кара''а "восклицать", "читать". Букв. "чтиво". Того же корня рус. каранье, кричать, крокодил (см.), англ. cry. Однако этимологизация на ар. почве не приводит к смыслу. Как и большинство терминов ислама (см. ваду, ислам, закят, суфии, вакф, хадж, шахада, шахид, хиджаб, рамадан), словоКоран  рус. происхождения. Оно происходит от обратного прочтения рус. нарок "постановленье", "завет" (см. Даль), ср.: Ветхий Завет, Новый Завет, Веды (от ар. وعد ваъд"завет, обещание"). При этом, как оказывается, все четыре "завета" – пронумерованы. В частности, Коран нумеруется позой правоверных при молитве, когда они становятся на четвереньки (номер 4, отвечающий зеленому цвету), что по-арабски называется جبا жаба: (поза жабы). Ср. лягушка (см.). См. также богомол, гелий, Ра.
</span>
';
GO

exec spAddArticle 11820, N'Что в имени твоем: Великий', N'', N'
<span viak="word">Великий
</span><span viak="description">
ВЛК - великий волк вол валик великан вилка
КЛВ - клевер коловорот Калевала аки-лев клюв клёв calve(англ:телиться) calf(англ:<b>теленок</b>,ср:корова) claw(англ:коготь)
бЛК - Балканы балка белка Белый булка белок
КЛб - клуб колбаса колба колебание колобок
КрВ - корова кровь кровля каравай
Крб - короб краб
ВЛг - Волга влага влагать вульга(рный)
гЛВ - голова главный 
гЛб - глубина голубой
хЛб - хлеб хлябь халабуда
бЛх - Балхаш балахон бляха блоха
хЛп - хлопок хлопья холоп
гЛВ - голова глава главный главенствующий оглавление
ВЛх - волхвы Волхов валах
хЛВ - хлев халва халява Helvetica(англ:<a href="http://viakviak.livejournal.com/45219.html">Гельветика</a>)
ВЛч - величие влачить влечение величина
чЛВ - <b>человек</b>
<a href="http://viakviak.livejournal.com/45219.html">ЛК</a> - лик лук лека(рь) алкать улика Алик лак лейка lick(англ:лизать)
КЛ - кал кол укол кайло клей келья
Лг - луг лига алгаи лягать
гЛ - гол гель голь голый ugly(англ:неприятный) галлы гулять
Лх - лихо лох ляхи лохань
хЛ - хала хули 

Helvetica - заглавный шрифт
балка - главная опора
Балканы - великие горы
Балхаш - великое озеро
белка - основной обитатель леса
Белый - основной цвет, главный царь, огромное море
великан - большой
влага - основа жизни
вол - "ВОЛочащий" (телегу)
Волга - огромная река
волк - "воликий", "уволакивающий", "волочащий" (жертву)
глубина - большое расстояние до дна
гол - главная цель
голубой - основной цвет неба
Калевала - главное сказание
каравай - большой хлеб
клуб - собрание главных
колба - лучшая бутыль
колбаса - лучшее мясо
колебание - главное движение
корова - главное домашнее животное
кровь - главная жидкость в теле
лига - великий союз
хлев - главное место скота
хлеб - главная еда
хлопок - основное растение
холоп - повсеместно распространенный житель
</span><span viak="summary">
Также заменяя "В" на "Б", мы видим, что слово "Великий" производится от "Бал" (голова, главный"): балик ("Баликий"). Великий находится в смысловом поле "главный, основной, большой".
</span><span viak="reference">
БаЛ (голова араб.) - Лоб
 ар. جلبة галаба "крик, шум, спор"
</span><span viak="reference">
Из Вашкевича Н.Н.:
ГОЛОВА1 – "часть тела человека (или животного), состоящая из черепной коробки и лица (у животного морды); у беспозвоночных — передний, относительно  обособленный  участок тела с органами чувств и ротовым отверстием".(Ожег.)
     ♦ От ар. جلواء جبهة габха галва:'' "высокий лоб", букв.: "оголенный".  Того  же  корня,  что  и  голый (см.).  Голова является органом любви Бога как Истины и является терминологической,   морфологической   и   функциональной параллелью головки члена. Ср. терминологический ряд, в котором термин верхней любви созвучен соответствующему термину нижней любви: познание Истины (Бога) и познание женщины,  любить Бога и любитьженщину, лоб и лобок, чело и член, сема и семя, образование и обрезание, искусство и секс, культура и клитор, глупость и ар.  غلفة гульфа"крайняя плоть", ум (рождающий истину) и ар.أم умм "мать". См. на эту тему также культура. Рус. головы в ар. прочтении дает قلوب гулу:б "сердца", тогда как рус. сердце в обратном прочтении по-арабски дает сд рс  (راس   صدى) "отражение головы", что подтверждается как обиходной практикой, так и клиническими данными. См. сердце.
ГОЛОВА2, голова еловая – "глупый, бестолковый человек";
     ♦ еловая здесь от елак (см.) "летучая мышь", который от ар.  ليل лель "ночь", таким образом, имеется в виду  ночная, спящая голова, т.е. "задница". Ср.:думать не головой, а задним местом.
ГОЛОВА3, голова забубенная – "бесшабашный, разгульный, отчаянный человек". (ФСРЯ).
     ♦ См. забубённый.
ГОЛОВА4, голова садовая; садовая – "не сообразительный, нерасторопный, неловкий человек". (ФСРЯ).
     ♦ Здесь за рус. садовая скрывается ар. سد садд "затыкать, закрывать, закупоривать", откуда سدادة сида:да "пробка".
ГОЛОВА5, выдать себя с головой – "обнаруживать свою причастность, касательство к чему-либо своими поступками, словами и т.п.". (ФСРЯ).
     ♦ С головой – от ар. جليا галиййан (корень глв) "ясно, явно".
ГОЛОВА6, трехглавая мышца, трицепс – "мышца, имеющая сцепление с органом или костью в трех местах".
     ♦ Ложная калька с якобы лат. термина трицепс, который является рус. словом по происхождению: рус. три + рус. цеп(лять), так что понятие головы не применимо к термину ни в каком смысле.
ГОЛОВА7, разбить наголову – ♦ см. наголову.
БАЛТИЙСКОЕ море – "море на северо-западе Европы. На Руси его называли Варяжским морем, позже Свейским (т.е. "Шведским"). У немцев оно известно с 9 века как Ostsee "Восточное море". Этимология названия "Балтийское море" очень спорная. Его связывают с упоминаемым у Плиния островом Балтия, где добывали янтарь. Ряд специалистов усматривают в нем литовское baltas "белый", другие отстаивают латинское balteus "пояс". Впервые топоним "Балтийское море" употребил северогерманский хронист Адам Бременский в 1075 г.". (Губарев, стр. 228).
     ♦ Название моря следует связывать с впадающими в него реками Лабой (Эльбой) и Одером, бассейн которых приблизительно с 5-го века населяли славянские племена Полабы (см.). Река Лаба соотносится с ар. لبى лабба: "удовлетворять". То же означает и Одер: от обратного прочтения ар. أ أرضى''арда: "удовлетворять" (родственно укр. рада). Тогда слово Балтийское согласуется с ар. طلب талаб "потребность, требование". Т.о., все три гидронима образуют единую семантическую конструкцию, которая в целом отражает номер прибалтийских славян. (См. Полабы). Ср. также Лаба – приток Кубани, название, которое как и Лаба, отражает понятие любви, ср. Куба – "остров любви". См. также Багамы.
БАЛЫК – "соленая и провесная хребтовая полоса осетровых (и других сходных) рыб. Отсюда балычня "легкое строение на столбах, крытое камышом, для вялки балыка". Из татарского". (Даль).
 ♦ От обратного прочтения ар. صلب сулб (мн. число: صلبة силаба) "хребет". Способ приготовления определяется тем, что корень صلب слб означает также "сушить,  делать твердым". Родственно бальзам, балясины, (см.).
БАЛДА – "дурак", "болван", "дубина", "кувалда". Заимствование из диалектной формы тюркского balta "топор".  (Фасмер).
 ♦ От ар. بلداء балда'' "дура", "глупая".  (М., с. 47).  Скорее всего, образование от основы بال бал "голова". Ср. ар. بله блх – "быть глупым" (М., с. 49),  или рус. болван (см.). Турецкое  balta не связано ни с рус., ни с ар. словом, оно того же корня, что и рус.  булат, восходящее  к ар.  فولاذ фу:ля:з "железо".
БАЛИЙ – "врач, прорицатель", церковнославянское заимствование. (Фасмер).
 ♦ От ар. بل балла "исцелиться".
БАЛК – "страна в южном Туркестане, преобладающий характер страны — пустынный; плодородная почва встречается лишь в местностях, где приложены заботы об искусственном орошении. Климат подвергается резким переменам в различные времена года: где летом зреет виноград, поспевают абрикосы и растет шелковичное дерево, зимой часто выпадает масса снега и стоит жестокая стужа. Население, принадлежащее к узбекскому племени, относительно рода занятий должно применяться к разнообразным и прихотливым условиям обитаемой им страны; сообразно с ними оно то мирное кочевое, то воинственное разбойничье, то занимается караванной торговлей, то — земледелием и ремеслами в селах и городах". (B&E).
♦ От обратного прочтения ар. قلب калаб "переменчивость".
БАЛКА1 – 1) "четырехгранное бревно"; 2) "горизонтальный брус, служащий связью между стенами", из немец. balken. (Ушаков).
 ♦ От обратного прочтения ар. صلب салуб "быть прочным, крепким", сулб "спинной хребет", "сталь", صلبة салба "опора, подпорка". Родственнобалясины, селяби (см.), См. также блюм.
БАЛКА2 – "длинный овраг, лощина". (Ушаков). Точную этимологию слова определить весьма трудно. Считается исконно родственным лит. bala "болото". (Фасмер).
 ♦ От ар. بلوعة баллу:ъа "место слива, канава, клоака", которое, в свою очередь, производно от بل балла "быть мокрым, влажным", ср. буерак (см.).
ВЕЛИКАН – "то же, что гигант". (Ожегов). В некоторых славянских языках отсутствует. В чешском – obr. (Фасмер).
♦ Чешское слово от ар. عفر ъуфр "грива", того же корня, что عفروس ъуфру:с "лев", букв. "гривастый". В рус. языке от великий (см.).
ВЕЛИКИЙ – "превосходящий общий уровень, обычную меру, значение, выдающийся". (Ожегов).
♦ От обратного прочтения рус. йаки (аки) лев. Сюда же великан. Первый компонент от ар. حاكى ха:ка: "быть подобным", откуда рус. как, какой; второй компонент - того же корня, что и ар.  لبوة   либва "львица".  Оба   слова происходят от слова ар. происхождения Ваал (см.), букв. "господин", ср. ар. سادة са:да "господа" и أسد ''асад "лев".
ГАЛДА – "говор, крик, шум, брань, спор"; "бранчивый человек, горлан, крикун". (Даль).
     ♦ От ар. جلبة галаба "крик, шум, спор". Замена б на д из-за опрокидывания б.
</span>
';
GO

exec spAddArticle 12662, N'Прямой перевод: Silver(англ:серебро) - Direct translation', N'вяк, деньги, перевод, слова, титул', N'
<span viak="translation">Silver(англ:серебро)

СЛВ - silver(англ:серебро) solvent(англ:растворитель) salvo(англ:залп) слава слив слива соловей сельва
ВЛС - волос власть Велес
<a href="http://viakviak.livejournal.com/39647.html">Срб</a> - серебро сруб серб
<a href="http://viakviak.livejournal.com/33634.html">брС</a> - бросать брус(ок) береста барс бросок
брз - борзый Березина бразды борозда брызги bruise(англ:рана)
<a href="http://viakviak.livejournal.com/33634.html">зрб</a> - заработок зарубка
црВ - царевич
<a href="http://viakviak.livejournal.com/.html" target="_blank">цр</a> - царь
црб - цербер

</span><span viak="translation">Argentum(лат:серебро)
РГН - Аргентина Арагон регион
НГР - награда Нигерия Ниагара негр нагар
<a href="http://viakviak.livejournal.com/37986.html">РжН</a> - рожон рыжина

бразды - бразды правления, управление при помощи серебра
брызги - серебристые капли воды
власть - правление при посредстве серебра
волос - седой, серебрянный
заработок - плата серебром за работу. Здесь мы можем видеть удвоение смысла "за-работу" + "серебро".
награда - серебро за заслуги
негр - стоит серебра
регион - область управления с помощью серебра
слава - известность при помощи серебра
сруб - срубить серебрянный рубль
царь - правитель при помощи серебра
цербер - хранитель серебра

</span><span viak="summary">
Представляется, что слово Серебро могло возникнуть в контексте слов Слив и Брусок в смысле "слиток", а уже затем стать основой для понятий могущества (власть), известности (слава) и управления (бразды, царь, цербер, регион).
Денежная единица Рубль может ассоциироваться со словами "срубить серебро" дающими удвоение смысла "серебро".

Слово Silver видится как калька слова Серебро при переходах <a href="http://viakviak.livejournal.com/39647.html">Р - Л</a> и <a href="http://viakviak.livejournal.com/45394.html">Б - В</a>.
</span><span viak="summary">
Слово Argentumи и страна Аргентина возможно были адаптированы от слова Награда в смысле "награда серебром".
</span>
';
GO

exec spAddArticle 12976, N'Что в имени твоем: Яхве, Иегова', N'Вашкевич, бог, вяк, имя, слова, титул', N'
<span viak="word">Яхве
</span><span viak="word">Иегова
</span><span viak="description">
Иегова - богъ (Прочитанное наоборот, с <a href="http://viakviak.livejournal.com/45394.html" target="_blank">переходом Б - В</a>)
Яхве - Яхбе =》ебхъ, бхъ, бог, Vougue(англ:мода,популярность)
Иегова = Jehovah
</span><span viak="summary">
Получается, что Яхве и Иегова - это просто иное произношение русского слова Бог.
</span><span viak="reference">
Из Н.Н.Вашкевича:

ЯХВЕ - "в иудаизме – непроизносимое имя бога. Согласно ветхозаветному преданию было открыто Моисею в богоявлении при горе Хорш". (МС).
       ♦ Известно под названием тетраграмматон (יחוח). Яхве – один из двух вариантов его чтения. Другой: см. Иегова.
ИЕГОВА, Яхве –  тетраграмматон, заместитель имени еврейского бога, произносить которое запрещается; пишется (справа налево) в четыре буквы Йод, Хе, Вав, Хе: יחוח
Иегова и Яхве – два разных способа чтения (огласования) четырех согласных. Ни один из них не открывает тайны этого имени. Следовательно, должен быть третий способ чтения. Для раскрытия тайного смысла тетраграмматон надо читать в кодах языковой плазмы, т.е. в русско-арабском коде.  Придыхание (Хе) обозначается русской буквой П (см. статью П,а также период), буква Вав читается как У (О), буква Йод соответствует в древнерус. азбуке И десятеричной ( i ), в которой точка иногда не пишется, что делает ее соответствующей Алифу (единице). Таким образом, правильное чтение тетраграмматона: Апоп (см.). На храмах средневековой Европы в изобилии можно найти фрески с именем Иегова, начертанным на равнобедренном треугольнике, вершиной обращенном кверху (половина Звезды Давида). Причем треугольник заслоняет солнце, так что видны одни лишь лучи его (ср. с древнеегипетской фреской Апоп). По вопросу см. также любовь, Давид, пепел, суббота, Раав.
</span>
';
GO

exec spAddArticle 13147, N'Что в имени твоем: Князь', N'Вашкевич, вяк, общество, слова, титул', N'
<span viak="word">Князь
</span><span viak="description">
КНЗ - князь кинза
ЗНК - знак
КНж - княже княжна <a href="http://viakviak.livejournal.com/13513.html" target="_blank">книжный</a> кинжал
<a href="http://viakviak.livejournal.com/37986.html" target="_blank">Кнг</a> - книга коняга king(англ:король) княгиня
гнК - гонка гинеколог gunk(англ:дрянь) огонек
сНК - санки синяк
сНг - снег song(англ:песня)
гНс - гнус
</span><span viak="description">
КНяЗь - (читая наоборот) ЗНаК от слова Знать (в обоих смыслах: знание и элита).
Знак (ярлык) на княжение.

От слова ярлык:
Ярл(князь в Швеции),
Royal (королевский);
реал, лира - деньги князя
ареал - владения князя.
Лир - имя князя в произведении Шекспира
</span><span viak="reference">
Из Н.Н. Вашкевича:
ЗНАК – "пометка, изображение, предмет, которыми отмечается, обозначается что-нибудь", "внешнее обнаружение, признак". (Ожегов).
     ♦ От знать. По созвучию с ар. زنق занак "крепко держать, одевать ошейник (на животное)" –  откуда рус. князь (см.) – общество (и вообще Вселенная)  управляется знаками.Зинак (زناق) – это также подшейный шнурок для шляпы или фуражки, чтобы ветром не сдувало. Кроме того, зинак – это термин коневодства (سياسة сийа:са), которое в ар. языке обозначает также политику, откуда ساس са:са "управлять кобылой", и откудаساسة са:са "конюхи", "политики". См. также кучер. Помимо сказанного, рус. слово знак в обратном прочтении дает ар. слово كنز канз "клад", напоминая, что при устройстве клада обязательно следует его помечать знаком. Кладу земному противополагается клад небесный, ср. ар.خلود хулу:д "вечность", в котором собраны знаки РА, управляющие Вселенной. См. также кладбище.
</span>
';
GO

exec spAddArticle 13513, N'Что в имени твоем: Книга', N'', N'
<span viak="word">Книга

КНГ - книга коняга king(англ:король) княгиня
ГНК - гонка гинеколог gunk(англ:дрянь) огонек
чНГ - <a href="http://viakviak.livejournal.com/18274.html" target="_blank">Чинг(из)</a>
ГНч - гнучая
КНж - книж(ка) княже княжна княжить
жНК - женка
жНх - жених
хНж - ханжа
гНГ - гонг ганг(рена) gang(англ:банда) Ганг
хНГ - ханыга
хНк - хныкать
кНх - конюх
</span><span viak="description">
king(англ:король) - Чинг(изид), из рода Чингиз-хана.
княже - князь, Чинг(изид), из рода Чингиз-хана.
</span><span viak="summary">
Слова Книга возможно произошло от понятия "согнутая, скрученная".
</span><span viak="summary">
Возможно, что слово Книга имеет отношение к слову KiNG-Чинг(изид) с <a href="http://viakviak.livejournal.com/29208.html" target="_blank">переходом Ч - К(Q) (cм: Четыре - Quatro)</a>. Тогда, считая слово Книга основным, а Чинг(из) или КиНГ производным, получаем, что Чингизиды(короли, князья) - это люди Книги.
</span><span viak="reference">
Из <a href="http://trueview.livejournal.com/157427.html" target="_blank">TrueView</a>: 
Сыромятная кожа (сыромять) — кожевенный материал древнейшего способа выделки. Производится путём разрыхления структуры кожи с фиксацией этого состояния жирующими веществами. Была повсеместно распространёна, но в настоящее время практически вытеснена дублёными кожами. На Руси название «сыромятная кожа» известно по письменным источникам с XVI в. Кожевники, специализировавшиеся на выделке сыромяти, назывались «кожемяки» (это также вообще кожевники) и «сыромятники». Одновременно существовало другое распространённое название — «мячина» (от слова мять). Кожевники соответственно назывались «мешинники».

Важным этапом является разминание (мятьё) (для тонких кож — потягивание), вручную или методом топтания. При этом часто используются простейшие приспособления (протаскивание через верёвку, через кол с острым ребром, использование мялки «беляк», протаскивание ремней через лещади или донскую мялку). Применяются и простые механические приспособления (например, использование приспособления наподобие пасти животного, выкручивание на специальном станке с использованием силы инерции или использование донской мялки на конной тяге). Есть и такой старый метод как жевание зубами (народы Севера), при котором к тому же участвуют ферменты слюны. В России ремни из сыромяти проходили процесс «посадки», путём протаскивания их через палочки с прямоугольными вырезами. За счёт чего они калибровались и приобретали нужный профиль.

При выделке кожу мяли (гнули)...

</span><span viak="reference">Из Н.Н. Вашкевича:
КНИГА1 – "произведение печати (в старину также рукописное) в виде переплетённых листов с каким–н. текстом". (БЭКМ).
♦ От ар. كنه кунх "сокрытый смысл", "суть", "глубина", откуда إكتنه ''иктанаха (восьмая порода) "исследовать", "постигать глубину".
</span>
';
GO

exec spAddArticle 13811, N'Что в имени твоем: Бердыш', N'', N'
<span viak="word">Бердыш

БРД - борода beard(англ:борода) бред брод обряд bread(англ:хлеб) бард бардак бордель бурда берданка бредень 
ДРБ - дробь дробовик дербанить
пРД - парад перед продукт пердеть pardon(англ:прощение)
ДРп - drop(англ:падение) драп(ать)
пРт - порт портной парта партия part(англ:часть)
тРп - труп тропа торопиться оторопь
вРт - ворота вертеть
</span><span viak="summary">
Слово Бердыш находится в смысловом поле "вращать бродя, дербанить, дробить, расчищать тропу, делать трупы, брать на оторопь, наводить бардак, заставлять драпать".
</span>
';
GO

exec spAddArticle 13982, N'Что в имени твоем: Карл Маркс, Фридрих Энгельс, Владимир Ленин', N'вяк, имя, слова, шутка', N'
<span viak="name">Карл Маркс
<span viak="name">Фридрих Энгельс
<span viak="name">Владимир Ленин
</span><span viak="description">
Карл - король
Маркс - marks(англ:марки)
Фридрих - free tricks(англ:бесплатные трюки)
Энгельс - angels(англ:ангелы), англичане
Владимир - владеть миром
Ленин - Лень-ин = ленивых
</span><span viak="summary">
Королевские марки и бесплатные трюки англичан овладевают миром ленивых
</span>
';
GO

exec spAddArticle 14254, N'Что в имени твоем: Столица', N'', N'
<span viak="word">Столица

СТЛ - столица стол стул стойло сталь стул стелить стиль сутулый остолоп усталость settle(англ:обосновываться,селиться) Сиэтл steal(англ:украсть) steel(англ:сталь)
СдЛ - седло сделал 
здЛ - (Су)здаль, 
Лдз - Łódź (польск:Лодзи)
</span><span viak="summary">
Создается впечатление, что слово Столица находится в смысловом поле "поддержка, место отдыха". См. также слово <a href="http://viakviak.livejournal.com/14782.html" target="_blank">Держава</a>
</span><span viak="reference">Из Н.Н. Вашкевича:

СТОЛИЦА – "главный город государства, как правило, место пребывания правительства и правительственных учреждений". (БЭКМ).
       ♦ От ар. استولى ''иставла: "захватывать (власть), держать", ср. ар. عصم ъасам "держать" и ъа:сима "столица".

СТОЛ – "предмет мебели в виде широкой горизонтальной пластины на опорах, ножках". (БЭКМ).
       ♦ От ар. سطل сатал "пьянить", "лить", откуда سطل сатл
  "ведро", мн. число: سطول суту:л, مسطول масту:л "пьяный". Из этого видно, что первоначально и до сих пор стол – это место возлияний. Ср. название столицы Грузии Тбилиси (от ар. طاولة та:виля "стол") и застольные песни грузин.
</span>
';
GO

exec spAddArticle 14410, N'Прямой перевод: Exit(англ:выход)', N'вяк, перевод, слова, шутка', N'
<span viak="word">Exit(англ:выход)
</span><span viak="summary">
Exit = Исход
По болгарски: Изход
</span><span viak="joke">
Знак "Exit" наборот похож на неправильное русское "Тихо!"
</span>
';
GO

exec spAddArticle 14782, N'Что в имени твоем: Держава', N'Вашкевич, вяк, государство, слова, торговля', N'
<span viak="word">Держава
ДРЖ - держава держать дрожжать дрожжи дорожка дружба дорожный дирижер дирижабль дуреж
ДРг - дорога дорогой дергать дерюга драга
гРД - город град огород ограда гордость гарда гряда guard(англ:сторож)
тРЖ - торжище труженик (ка)торжник сторож тираж treasure(англ:сокровище)
ЖРт - жрать

Слово Столица происходит от арабского "держать", т.е. столица (стол, лоток) и держава (торжище, торг) имеют общий смысловой контекст относящийся к торговле.
город - это обратное прочтение слова "торг". Рынок, торговые ряды всегда были градо-образующим объектом. Существует предположение, что амфитеатры, включая Римский Колизей - это просто огражденный рынок.
</span><span viak="summary">
Таким образом, в слове Держава виден смысл "охрана торговли" и находится в одном смысловом ряду со словами Столица, Город, Торг, Дорога, Ограда, Сторож, Дорогой.
</span><span viak="reference">
Из Н.Н. Вашкевича:

СТОЛИЦА – "главный город государства, как правило, место пребывания правительства и правительственных учреждений". (БЭКМ).
    ♦ От ар. استولى ''иставла: "захватывать (власть), держать", ср. ар. عصم ъасам "держать" и ъа:сима "столица".
</span>
';
GO

exec spAddArticle 15207, N'Прямой перевод: Rent(англ:аренда)', N'вяк, деньги, перевод, слова', N'
<span viak="word">Rent(англ:аренда)
РНТ - rent(англ:аренда) рантье Ринат
ТНР - тенор toner(англ:красящий порошок)
РНД - аренда рондо Rand
дНР - динар донор Динара
</span><span viak="summary">
Слово Rent(англ:аренда) очевидно происходит от прочитанного наоборот слова "динар" - деньги.
</span><span viak="description">
Rand - Ann Rand - известная писательница
динар - деньги
рондо - музыкальная форма, в которой неоднократные (не менее 3) проведения главной темы (рефрена) чередуются с отличающимися друг от друга эпизодами.
</span>
';
GO

exec spAddArticle 15463, N'Прямой перевод: Alert(англ:сигнал тревоги)', N'вяк, закон, музыка, перевод, слова', N'
<span viak="word">Alert(англ:сигнал тревоги)
</span><span viak="description">
ЛРТ - аlert(англ:сигнал тревоги)
ТРЛ - трал турель trial(англ:попытка) trail(англ:след) трель турель тарелка
дРЛ - дрель drill дуралей darling(англ:милый)
ЛРд - lard(англ:сало) lord(англ:господин)
</span><span viak="summary">
Общее значение большинства слов - дребезжание, звучание. Таким образом, Alert(англ:сигнал тревоги) = дребезжащий тревожащий звук
</span><span viak="description">
trail(англ:след) - следовать на звук
trial(англ:попытка)- Шумное выяснение истины
дрель - издающая громкий звук
дуралей - шумный дурак
тарелка - звенящая от качественного обжига
трель - звук музыкального инструмента, чирикание птиц
</span>
';
GO

exec spAddArticle 15747, N'Мои словокопания: Цель, Метод и Ограничения.', N'', N'
<span viak="opinion">Я считаю понятия "слово"и "образ" взаимозаменяемыми. Слово записывется буквами, каждая из которых имеет свой образ, или может быть представлено картинкой или иероглифом. С другой стороны, образ описывается словами.

Главное назначение слова - описание смысла понятия. Количество "смыслов" слова ничем не ограничено. Одно и то же слово может нести разные "смыслы" разным людям.  Чем больше"смыслов" в одном слове, тем оно богаче и шире распространно. Все "смыслы" слова равноправны.

В своих языковых "исследованиях" я испытываю идеи Н.Н.Вашкевича о том, что слова - это не просто "бирки" (labels). Каждое слово и по звучанию, и по написанию несет в себе смыслы, описывающие понятия к которым они приложены. Любые слова, особенно имена. Имена простые и составные, включающие фамилии, клички, псевдонимы, города и улицы на которых человек жил, названия областей и стран, профессия, привычки, и т.д.

Главное правило - в слове должен быть смысл, оно должно быть понятно сразу и без натяжек.

Основной метод заключается в отбрасывании гласных и выделении корня в "консонантной" форме (только согласные). По Вашкевичу, все арабские корни имеют только три согласные. Корень может читаться слева направо и справа налево. Допускаются дозволенные "переходы" букв корня. Рассматриваются все возможные словообразования из корня на любых языках мира. Выделяются слова одного "смыслового" поля. Затем производится анализ выделенных слов, чтобы определить способ их образования слова из смысла. Я использую словарь РА и работы профессора Н.Н.Вашкевича для расширения базы поиска и примеров преобразований слов.

Основное ограничение - недисциплинированные преобразования слов, многочисленные переходы, бессмысленность не допустимы, и даже могут привести к серьезным психическим нарушениям у неискушенного исследователя.

Основная цель - получить понимание процесса словообразования, видить смысл слов и значения имен и образов.
</span>
';
GO

exec spAddArticle 15943, N'Что в имени твоем: Иберия, Европа', N'', N'
<span viak="word">Иберия
</span><span viak="summary">
Слово "Иберия" в случае простого перехода "б" -> "в" становится Иверия или Еврейа.
</span><span viak="word">Европа
</span><span viak="summary">
Если видеть в слове Европа корень "Евр", то основой будет слово "Еврей".
</span><span viak="description">
БР - бор бояре убор бар beer(англ:пиво) robe(англ:пижама) rob(англ:грабить) боро(да) бари(н) бура(н) Иберия
РБ - рыба раб рябь рябой роба арба orb(англ:шар) раби(н) ряби(на) рабо(та) руби(ть) rib(ребро) Аруба
вР - вера вор еврей авар вар веер Авраа(м) авар авра(л) Евро(па)
Рв - рев ров раввин рав(ный) Рива
<a href="http://viakviak.livejournal.com/33634.html" target="_blank">пР</a> - <a href="http://viakviak.livejournal.com/34907.html" target="_blank">пиро(г)</a> пар поры пир poor(англ:плохой) упырь
Рп - репа арап rip(англ:разрыв) rope(англ:веревка) rape(англ:изнасилование)
Р - арий ура иерей Юрий jury(англ:жюри) яр jar(англ:банка) <a href="http://viakviak.livejournal.com/2143.html" target="_blank">йер</a>

Слово Европа может рассматриватся как название "еврейского" континента, а Иберия - место первоначального его заселения евреями.
</span>
';
GO

exec spAddArticle 16161, N'Что в имени твоем: Персона', N'Вашкевич, вяк, деньги, имя, слова', N'
<span viak="word">Персона
</span><span viak="description">
ПРС - персона присный прис(пешник) пирс поросенок просить просо Paris(англ:Париж) прииск Пруссия process(англ:процесс)
бРС - бросать брус барс абрис брысь
СРб - сруб серебро
ПРз - приз проза prizon(англ:тюрма) паразит Прозак призыв
ПРц - процесс
бРз - борзая бриз обрезание образ борозда брызги
зРб - зробить(укр:сделать) заработок Зураб

присный - истинный, приспешник, близкий человек, единомышленник
приспешник - помощник, прислужник, служитель, пособник, соучастник
</span><span viak="summary">
Представляется, что слово Персона может быть тесно связано со словами Присный и Приспешник, и иметь в виду значимых людей, возможно приближенных ко двору.
</span><span viak="reference">
Из Н.Н.Вашкевича:
ПЕРСОНА ­- "личность особа, лицо, обед на десять персон"; от лат. persоna маска; роль; личность, лицо < этрус. phersu фигура в маске. (БЭКМ).
       ♦ От ар. فارس фа:рисон "наездник", "всадник", "рыцарь", "джигит". См. этруски, квалификация. Лат. значение этого слова от фарс "комедия", "грубая шутка", которое идет от фарш "начинка", восходящее к ар. فرث фарс "содержимое кишок". К персона не имеет отношения. См. фарш, фарс.
</span>
';
GO

exec spAddArticle 16618, N'Свобода человека. Источник и предназначение.', N'вяк, государство, закон, история, общество, свобода', N'
<span viak="opinion">
В Английском языке слово "свобода" может пониматся как одно из следующих:

Freedom - собственно "свобода", безо всяких разрешений и ограничений.

Liberty - вольность, т.е. разрешенная "свобода".

Right - право на свободу, не нуждающееся в особых разрешениях.

Если представить себе совершенно свободного человека, то моделью его свободы был бы бесконечный пузырь (bubble) вокруг него. Человек мог бы делать все, что угодно, быть абсолютно независимым (independent). Приходит на ум идея Рая и бестелесных душ его населяющих. Считается, что человек имеет бессмертную душу (soul) и бренное тело (body). Душа принадлежит богу (god), и никто под страхом божественного суда не может погубить ее. Тело человека может быть использовано как угодно его законным владельцем для его блага.
Понятно, что реальный человек в реальном мире, должен выживать с одной стороны, и он будет стремится к комфорту, с другой. Человек работает, общается, пытаясь улучшить свое состояние. В этом процессе у него появляются желания, которые он стремится удовлетворить наиболее известным ему экономным способом.
Счастье (Happiness) - это чувство достижения желаний (desires).
Воля (Willpower)- это способность достижения желаний.
Ресурс (Resource) - все, что мозжет быть использовано для достижения желаний. Ресурсом может быть собственное тело, разум, умения, время, а также другие люди, животные, растения, материалы, земля, вода, полезные ископаемые, и т.д.
Пользование (Usage) - это процесс потребления, создания, уничтожения, обмена и др. действий с ресурсами. Так как ресурс может быть ограниченым, его использование обусловлено его владением. Владение ресурсом одним человеком может провести его к конфликту с желаниями других.
Собственность (Property) - это признанное владение ресурсом, разрешающее конфликт интересов.
Право (Right) - это признанная (окружающими, властью, другими людьми) свобода владения собственностью по праву первого, силы, обычаев, и пр.,
Вольность (Liberty) - это разрешенная (властью) свобода, которая может быть дана, куплена, заслужена, обговорена, завоевана или получена другими способами на определенное время, или сопряженная с другими условиями и ограничениями.
Закон (Law)- свод правил защищающих собственность. В законе прописаны все вольности и их условия. Одновременно могут существовать множество законов для разных регионов, сфер деятельности, сословий, организаций, церквей, клубов, семей и др.
Свобода (Freedom) - чувство легкости владения собственностью в рамках существующих законов.
Суверен (Sovereign) - независимый субъект закона, полноправный владелец своей собственности, признанный законом. Все суверены одинаково защищены законом. Суверен может передать любую часть своей собственности или прав кому угодно и когда угодно.
Контракт (Contract)- это формальное соглашение о передачи собственности или прав в рамках существующего закона. Все контракты защищены законом. Существует только два главных нарушения закона: не уважение суда, включая обман и нарушение контракта.
Семья (Family) - собственность суверена-отца, включающая себя, членов семьи, дом, землю, скот, оборудование и инструменты,  деньги, запасы продовольствия, инвестиции и др.
Племя (Tribe) - большая группа семей, организованная как одна большая семья. Глава племени осознавался его членами, как патриарх, отец (father) племени. Другие примеры больших семей: царствo (kingdom), империя (empire).
Общество (Community) - это неформальная группа семей - соседей, которые делили окружающие ресурсы, имели экономические и другие связи.
Компания (Company) - это объект закона, собственность, которая имеет владельца, например: семья, работники, имущество, рыцарский орден, клуб по интересам, и др. Компания может владеть другими компаниями, полностью или частично. Компания может иметь не одного, а несколько владельцев на основе контракта между ними. Компанией может считаться любой человек, который и будет является ее владельцем. В случае смерти владельца, его имущество (estate) будет продолжать свое существование в рамках закона. Ему найдут новых законных владельцев-наследников, а компания может продолжать управлятся наемной бюрократией (bureaucracy).
Государство (State) - это компания для управления страной. Если государство управляется как семейное владение - это царство, королевство, империя и т.д. Государство может управлятся как обычная компания группы суверенов, тогда оно называется республикой (Republic).
Гражданин (citizen) - это объект управления государства, имеющий вольности подданный.
Олигарх (Oligarh) - это субъект управления государством, суверенное сословие.
Класс (Class) - часть общества, имеющая общие коренные экономические интересы.
Сословие (Caste) - это часть общества (каста) имеющая определенные законом вольности и обязанности.

Таким образом представляется, что свобода человека - это своего рода потенциальная энергия человеческого тела. Человек может обменять часть своей свободы для получения собственной выгоды. С другой стороны, управление массами людей происходит за счет контролирования их индивидуальных свобод.
Представляется, что революционные изменения общества начинаются с освобождения людей от старых долгов и отношений, а затем происходит постепенное их закабаление на новом уровне. Каждая общественная формация дает новые возможности человечеству, и соответственно вырабатывает новые способы эксплуатации человеческой свободы.
</span>
';
GO

exec spAddArticle 16646, N'Прямой перевод: Book(англ:книга)', N'Вашкевич, вяк, имя, книга, перевод, слова', N'
<span viak="translation">Book(англ:книга)
</span><span viak="description">
БК - book(англ:книга) бык бек абак бок бук бука бяка
КБ - куб кааба кабан кэб
Бг - <a href="http://viakviak.livejournal.com/25986.html" target="_blank">бог</a>
гБ - губа ГБ(гос-безопасность) гоб(лин) гибе(ль)
Бч - <a href="https://otvet.mail.ru/question/41660579" target="_blank">буче(ла)</a> быче(ла) бичь бече(вка) боч(ка)
чБ - учеба чуб чаба(н) чебо(тарь) chubby(англ:пухленький) Чубайс
пч - <a href="http://viakviak.livejournal.com/25435.html" target="_blank">пчела</a>
вК - век веко
Кв - ковать оковы <a href="http://viakviak.livejournal.com/43777.html" target="_blank">КВН</a> Киев ква киви какава
Бх - <a href="http://viakviak.livejournal.com/25986.html" target="_blank">бох</a> бах баху(с) Бах Bahai бух бух(ло) Bohemia(англ:Богемиа)
хБ - хобот
пк - пекарь пика poke(англ:тыкать) пук(нуть)
кп - купе купить кап(ля) кепи cop(англ:полицейский) copper(англ:медь) окоп кипа
хв - хвост хавать Хива <a href="http://viakviak.livejournal.com/12976.html" target="_blank">Яхве</a>
вх - веха
вг - <a href="http://viakviak.livejournal.com/31981.html" target="_blank">вагина</a> вагон веган
гв - <a href="http://viakviak.livejournal.com/40280.html" target="_blank">гавно</a> гав агава
вч - вече -вич
</span><span viak="description">
<a href="http://viakviak.livejournal.com/25986.html" target="_blank">Буква "В" может выпадать</a> или переходить в гласные Е и У, включая "Й" (Ю):

K - око -ака(тюрк:старший) йок(тюрк:нет) ку-ку key (англ:ключ) як
X - ухо эхо  х*й ха-ха ух эх ах ох hi(англ:привет) hey(англ:привет) hay(англ:сено) yahoo(англ:гадина)
Г - юг иго яга йога guy(англ:парень) гей Гоя ага угу эге ого-го гой га-га Яго agua(исп:вода)
Ч - чё чай itch(англ:зуд) чей чаять очи
</span><span viak="summary">
Book(англ:книга) = Бук(ва) Бук(и)

</span><span viak="reference">Из Н.Н.Вашкевича:
БУКВА – "письменное изображение звука речи, элемент азбуки". Из старославянского языка, где оно было заимствовано из готского boka "буква". В языках германской группы слово связано с названием дерева бук. (Черных).
    ♦ Как и многие названия знаков, а также насекомых, слово связано с идеей пятна. Происходит от ар. بقعة   букъа "пятно" и родственно рус. букашка (см.). Готское слово из рус.
БУКИ1 – вторая буква рус., лат., греч. и др. алфавитов; в церковно-славянском языке она носит название  т.е. буква; это название происходит от буковых дощечек, на которых первобытные славяне писали "черты и резы", по выражению мниха (монаха) Храбра. (Брокгауз). Род. падеж от буква. (Фасмер).
    ♦ От обратного прочтения  يعقب  йиъкуб"следовать за кем-л.", "быть вторым после кого-л.". Родственно библейскому имениИаков (по-арабски:  يعقوب  Йаъку:б), родившемуся, согласно библейской легенде, вслед за своим двойником Исавом.  Ср. Бета(см.).
</span>
';
GO

exec spAddArticle 17527, N'Прямой перевод: Sovereign(англ:суверенный)', N'вяк, перевод, свобода, слова, титул', N'
<span viak="word">Sovereign(англ:суверенный)
</span><span viak="description">
Суверен - Соборен - Соборный
</span><span viak="summary">
Здесь видно, что слово Sovereign(англ:суверенный) - это калька со слова "соборный" - человек, который имеет права участвовать в Соборе - сборе знати на выбор царя.
</span>
';
GO

exec spAddArticle 17884, N'Что в имени твоем: Рыцарь', N'Вашкевич, вяк, история, слова, титул, этнос', N'
<span viak="word">Рыцарь
</span><span viak="summary">
Рыцарь: Рысь-ар - всадник едущий на рысаке.
</span><span viak="description">
Родственно то Рейтар, Рейдер.

Слово Рысак прочитанное наоборот дает "касыр", что близко по значению другим словам того же ряда: Кайсар, кайзер, кесарь, хазары, козырь(rus:<a href="http://viakviak.livejournal.com/41271.html" target="_blank">trump</a> card), гусар, газырь.
В словах Гусар и хазар окончание -ар может быть осмыслено как суффих. Его изменение на другой общеупотребительный суффих -ак даст ряд других близких по значению слов: казак, казах.

Обратим также внимание на возможность следующего разложения слова Рыцарь: Рыц+царь - удвоение смысла "царь". Слово Царь родственно имени Цезарь, Кайзер или в близневосточом варианте <a href="https://ru.wikipedia.org/wiki/Кайсар" target="_blank">Кайсар</a>.
</span><span viak="description">
газырь - часть национальной одежды кавказских народов, заимствованы казачьими частями русской армии.
гусар - легковооружённый всадник
казак - конный военнослужащий
казах - этнос
рейдер - наездник
рейтар - наездник
рысак - лошадь, способная к бегу быстрой, устойчивой рысью
рыцарь - всадник едущий рысью, на рысаке
хазары - этнос
</span><span viak="description">
Иммет смысл предположить, что слово ри(тт)ер или по-анлийски ri(d)er происходит от слова road(англ:дорога)/route(англ:путь), что в обратном прочтении дает слово "дорога". Продолжая "крутить" слово "дорога", видим, что дороги прокладываются межды "городами" (дорога -> город). Город огораживают, а дороги "кружат" [о(г)ороживать - (к)ружить]. Ограда окружающая город в идеале должна быть круговой.
</span><span viak="summary">
Таким образом мы видим, что слово "круг" стоит в основе смыслового поля езды и пути, как места назначения, путей сообщения и способа передвижения.
</span><span viak="description">
Переводом слова Рейтар могут быть разные слова, например: Наездник, Ездок и Всадник. Это синонимы, но здесь очень хорошо видно разница восприятия человека на лошади посторонним наблюдателем:
 1. Наездник - ударение на смысле "верхом",
 2. Ездок - просто указывается на факт езды,
 3. Всадник - "в сидении", указывается факт наличия седла, которого вообще-то могло и не быть в предыдущих случаях.

</span><span viak="reference">Wiki:
Ры́царь (посредством польск. rусеrz, от, нем. Ritter, первоначально — «всадник»; лат. miles, caballarius, фр. chevalier, англ. knight, итал. cavaliere[1]) — средневековый дворянский почётный титул в Европе...

Ре́йтары (нем. Reiter — «всадник», сокращение от нем. Schwarze Reiter — «чёрные всадники») — наёмные конные полки в Европе и России XVI—XVII веков. Название «чёрные всадники» изначально использовалось по отношению к конным наёмникам из Южной Германии, появившимся в годы Шмалькальденской войны между германскими католиками и протестантами.
</span><span viak="reference">Из Н.Н.Вашкевича:
ГОРОД, град – "крупный населённый пункт, административный, торговый, промышленный и культурный центр"; "в старину на Руси: ограждённое стеной, валом поселение". (Ожегов).
     ♦ Того же корня, что и городить. Родственно гвардия, дружина (см.).
ГУСАР – ист. "в царской и некоторых иностранных армиях: военный из частей так называемой легкой кавалерии", "перен.: о том, кто отличается бесшабашным поведением, показной удалью, молодечеством"; от польск. husar < венг. huszar < husz двадцать. (Крысин).
	♦ От ар. جاسور га:су:р или جسار   гасса:р "храбрец".
ДОРОГА – "полоса земли, предназначенная для передвижения, путь сообщения". (Ожегов).
     ♦ От ар. طرق турук (диалектное дуруг) "дороги" (М., стр. 465),  либо от родственного ему  درج дараг "дорога" (М., стр. 210), родственно дроги (см.).
РАДЕНИЕ – "усердие, старание, забота о чем-либо"; "в некоторых сектах религиозный обряд, сопровождающийся прыганием, кружением, иногда самоистязанием. Часто приводит участников в состояние экстаза". (БЭКМ).
       ♦ От ар. راض ра:д "объезжать коня". Ср. корень خول хвл "радеть, ухаживать за животным" и того же корня خيل хейл "лошади", откуда кавалерия. Родственнорейд, рыцарь (см.). Религиозным смыслом это слово наполняется из-за созвучия с ар.  رضي الله عنه радийа аллах ъанну  "Да будет доволен им Аллах". Это верхняя параллель термина нижней любви ''ард	а: удовлетворять (женщину). Родственно названию реки Одер (см.).
РЕЙТАР – "воин наемной тяжелой конницы в Зап. Европе (16-17 вв.) и в России (17 в.)"; нем. reiter букв. всадник. (БЭКМ).
	♦ От ар. راض ра:да "объезжать лошадь". Родственно рыцарь.
РЕЙТУЗЫ – "брюки для верховой езды".
	♦ Того же корня, что и рейд, рыцарь, рейтар (см.).
РЦЫ – "команда в "слове о полку Игореве" – "по коням".
	♦ От ар. راض ра:д (масдар: рийа:да) – "объезжать коня". Родственно рыцарь, рейд (см.).
РЫЦАРЬ – "в средневековой Европе: феодал, тяжело вооружённый конный воин, находящийся в вассальной зависимости от своего сюзерена". (БЭКМ).
	♦ Образование с помощью суффикса профессии (как в маляр) от ра:да "объезжать коня, ездить на коне". Родственно рейд, рейтузы (см.). Рыцарь печального образа – "наивный, бесплодный мечтатель". От названия Дон-Кихота, героя одноименного романа Сервантеса. Ввиду неприложимости понятия печали к образу Дон-Кихота следует искать объяснения в созвучиях системных языков мозга. Очевидно произошло смешение арабского فاصل фа:сил "решительный" (кто способен воевать с ветряными мельницами) и рус. печаль. Сравните имя героя Сервантеса по-арабски: دون كيشوت ду:н кишу:т "судья, снимающий маски" и имя автора: серв (слуга) ъант (عنت) "решительного, упрямого".
</span>
';
GO

exec spAddArticle 17957, N'Что в имени твоем: Birth(англ:рождение)', N'вяк, еда, имя, слова, тело, экономика', N'
<span viak="word">Birth(англ:рождение)
БРТ - борт обрат брат брать берет brought(англ:принес) Britain Bart(Бартоломео) Буратино буряты обретение бороть берет братия борт обратился брута(льный) бритва обирать
ТРБ - тюрбан торба бурт требуха требовать труба теребить утроба tribe(англ:племя) трибун отребье турбина тарабарщина trabaha(исп:мало) (п)отреб(ление)
БРф - burf(англ:рвота)
фРБ - Forbes
БРд - борода брод обряд bread(англ:хлеб) бард бардак бордель бурда
дРБ - дробь дребедень дряблость
вРТ - вертеть ворота virtue(англ:добродетель) virtual(англ:мнимый) (пре)врат(ить)
ТРв - трава отрава тревога travel(англ:путешествовать)
вРф - верфь
фРв - форватер forward(англ:вперед)
вРв - ворвань воровать
вРД - выродок вред вурдалак word weird(англ:странный) вердикт Вердан
дРв - дерево
пРТ - против(ник) пират порт opportunity(англ:возможность) part(англ:часть)
ТРп - тряпка торопить терпение труп troops(англ:войска) терапия тропа треп(ать)
пРф - профессия парафин proof
пРв - пров(орство) provi(de)(англ:обеспечивать)
вРп - warp(англ:коробить)
пРд - продукт перед парад пердеть pardon
дРп - drop(англ:падение) драп(ать)
</span><span viak="summary">
Создается впечатление, что основной смысл корня БРТ: внутренняя часть конструкции, продукт существования, свойство, выделение или порча, действия по их утилизации или присвоения, а также направление выхода из закрытого пространства или емкости.
</span><span viak="description">
bread(англ:хлеб) - выползающая квашня
brought(англ:принес) - принес обратно
burf(англ:рвота) - выброс непереваренной еды
drop(англ:падение) - выпадение
forward(англ:вперед) - вперед отсюда на выход
pardon(англ:простить) - выпустить
part(англ:часть) - часть
proof(англ:доказательство) - доказательство по найденному выделению?
provi(de)(англ:обеспечивать) - обеспечивать продуктами
travel(англ:путешествовать) - выезд
tribe(англ:племя) - выходцы из (леса, степи, джунглей, саванны, ...)
troops(англ:войска) - боевые части 
virtual(англ:мнимый) - выдуманный, вышедший из головы
virtue(англ:добродетель) - качество исходящее от человека
warp(англ:коробить) - порча
</span><span viak="translation">
weird(англ:странный) - урод
</span><span viak="description">
word(англ:слово) - высказанное слово
бард - выступающий
бардак - срачь
бордель - отбросы общества
борода - выход волос на лице
борт - хранилище, туловище
брат - из своего "помета"
брать - присваивать выброшенное
брод - выход из реки
бурда - суп из отходов
бурт - хранилище
вердикт - высказывание властелина
вертеть - уход и возврат
верфь - для отплытия кораблей
ворвань - выделенный жир
воровать - вытаскивать
ворота - выход
вред - опасное выделение
вурдалак - урод
выродок - урод(ившийся)
дерево - выросшее из земли растение
драп(ать) - убегать
дребедень - отходы
дробь - высыпать частички
дряблость - свисшая кожа
обрат - выделение назад
обряд - публичный выход
отрава - экстракт, вытяжка из травы
отребье - отбросы общества
парад - торжественный выход
парафин - восковое выделение
пердеть - выпускать газы
перед - направление выхода
пират - враждебный выходец из моря
порт - для отплытия кораблей
(п)отреб(ление) - в утробу
(пре)врат(ить) - вытащить измененное
провизия - обеспечение продуктами
пров(орство) - быстрый выход из положения
продукт - выход производства
против(ник) - враждебный выходец
тарабарщина - выброс непонятных слов
терапия - отворение крови
теребить - трепать
терпение - ждать выход
трава - выросшая из земли
требовать - укр:треба, просить для утробы, еды, самого необходимого
требуха - содержимое утробы
тревога - выданный сигнал, чувств
треп(ать) - разрывать на части
трибун - выступающий, вышедший говорить
торба - хранилище
торопить - ускорять выход
тропа - выход
труба - конструкция для вытекания
труп - отход
тряпка - бросовая материя
турбина - выбрасывающая
тюрбан - хранилище головы, выдавленный
утроба - хранилище съеденного
форватер - для выплыва
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
кЛЗ - клизма clause(англ:статья,условие) Клязьма
ЗЛк - злюка злак
кЛс - колесо колос колосс кулиса класс cluster(англ:скопление) класть
сЛк - слякоть салака silk(англ:шёлк) силикон
жЛЗ - железо жалюзи jealous(англ:ревниво оберегающий)
ЗЛж - залежи заложить
жЛс - жалость жулус(тюрк:улус,орда,вотчина,удел)
сЛж - сложный слаженность слежение служба
шЛк - шёлк шлак Шилка
кЛш - клюшка клише клешня калоша клуша калашный Калашников
ГЛш - голыш глушить глашатай оглашенный
шЛх - шлюха шлях шляхта Шолохов
хЛс - хлыст холостой хлястик холст
сЛх - слух ослух
кЛж - college(англ:колледж) (по)клажа
жЛк - жулик 
</span><span viak="summary">
Слово Глаз находится в смысловом поле "длинный", "дальний", "долгий", "долг", "расстояние", "глубокий", "сложный", "слежение".
</span><span viak="description">
clause(англ:статья,условие) - долговое условие
cluster(англ:скопление) - сложенный
jealous(англ:ревниво оберегающий) - следящий
silk(англ:шёлк) - шёлк, длинный, из-далека
галс - длинное движение судна относительно ветра
галс(тук) - длинный
глаз голос слух - основные способы общения на расстоянии
глашатай - "голосовик"
глушить - подавлять голос, предотвращать передачу звука на длинные расстояния
железо - увиденное, найденное в глубине
жулус(тюрк:улус,орда,вотчина,удел) - село, население, сложное социальная структура
залежи - найденные в глубине
залог - обеспечение долга
злак - с продолговатыми зёрнами
калашный (ряд) - торговля издалека, т.е. заморской дорогой и престижной продукцией 
класс - сложный
клизма - глубоко проникающая
клюшка - длинный крюк
колесо - движитель на дальние расстояния
колос - соцветие, для которого характерна удлинённая главная ось.
колосс - длинный, огромный
кулиса - сложный механизм
салага - послушный
салака - удлиненная
слежение - "глазение" далеко
сложный - слаженный, класть
слог - длинные сочетания звуков, долгий звук
сложный - длинный путь для понимания
слуга - послушный, для слежения, на длинных посылках
служба - послушание, слежение
слух - способность принимать звук на расстоянии
слякоть - глубокая
силикон - слякоть
услуга - долг
хлыст - длинный
шёлк - (шёл) из-далека
шлюха - послушная
шлях - длинная дорога
шляхта - служивые, а не разбойники с большой дороги
</span><span viak="description">
Знаковые слова: глаз голос слух слог колесо колос железо шелк залог сложный класс залежи слежение служба глашатай

Слово "глаз" может быть прочитано наоборот, как "залог".

Фраза "глаз за глаз" тогда может быть истолковано как "залог за долг", т.е. обеспечение долга имуществом или ценностями.

Здесь мы также видим, что значение "масонского" глаза на оборотной стороне доллара может состоять не только во всевидении, но и выражать фундаментальные понятия финансового дела: долг и залог.

Глаз - голос. Практически одно и тоже по звучанию слово "голос" и "глаз". Т.к. считается, что слово "глаз" было заимствовано на западе во времена Петра (см. ниже), то возможно, что русское  слово "голос" перешло в западное слово "глаз" (glass). Функция Голоса - "достать" человека на расстоянии, функция Глаза (особенно в очках или с подзорной трубой) - увидеть издалека.

Салага, Слуга, Шлюха - послушные.

Мода на прикрытие одного глаза некоторыми представителями шоу-бизнеса, интерпретируемая некоторыми конспирологами как массонский символ, может обозначать "шлюха привлекающая внимание", т.е. быть символом послушания в сексуальном подтексте.
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
<span viak="description">
Оранжевый - рыжий(Вашкевич)
Рыжий - жар
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
	♦ От ар.  قهرمان кахрама:н "казначей", "лицо, ведающее доходами и расходами". Ар. слово, вероятно, от ар. كرم карам "изобилие", того же происхождения рус. кормить. Ср. ар. أكرم ''акрама "уважить гостя", т.е. накормить. Колебания между Каф и Кяф имеют место быть, ср. قرب  карраба =  كرب  карраба "приближать".                         
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
Court - корт - черта, черт(<a href="http://viakviak.livejournal.com/29208.html" target="_blank">переход Ч - К</a>) = дьявол - devil
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
клВ - клевер коловорот Калевала аки-лев клюв клёв calve(англ:телиться) calf(англ:<b>теленок</b>,ср:корова) claw(англ:коготь)
</span><span viak="description">
Рассматривая следующую цепочку слов: кровь, червь, корова, кривая, караван, великий, человек, корябать, волочить, чрево, черевички, кровать, враки, корабль - создается впечатление, что общим является смысл "оставляющий за собой след, отпечаток, впечатление".

Червонный - оставляющий кровавый след
Червонец - Карбованец - Гривна

Червонный- (<a href="http://viakviak.livejournal.com/29208.html" target="_blank">переход Ч - К</a>) "К"ервоный - Кровяный.
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
Чб - учеба чуб чаба(н) чебо(тарь) chubby(англ:пухленький) Чубайс
Пк - пика poke(англ:тыкать) пук(нуть)
Пщ - пища пища(ть)
щП - щуп щипа(ть) щепо(ть)
бк - бок бак бык бука(шка) бока(л) bake(англ:готовить) baco(n) беко(н) <a href="http://viakviak.livejournal.com/16646.html" target="_blank">буква</a>
кб - куб кабе(ль) кобе(ль) Куба(нь) cab каби(на)
</span><span viak="description">
Выше были использованы переходы: <a href="http://viakviak.livejournal.com/33634.html" target="_blank">п-б</a>, <a href="http://viakviak.livejournal.com/29208.html" target="_blank">Ч - К</a>, ч-щ.
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
Бх - бох бах баху(с) Бах Bahai бух бух(ло) Bohemia(англ:Богемиа)
хБ - хб(хлопчато-бумажный) хиба(ра) хобо(т)
Бк - бык бок book(англ:книга) бук(ва) абак бак байка bake bike beacon буек
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

СФ - София софит сфера асфальт <a href="http://viakviak.livejournal.com/7192.html" target="_blank">soft(англ:мягкий)</a> Софокл Исфирь
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
<a href="http://viakviak.livejournal.com/29208.html" target="_blank">Переход Ч - К</a>

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

ВГН - вгонять, вoгнать вогнутый вагон Афган(истан) Ваганское выгон
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

Используем переходы: <a href="http://viakviak.livejournal.com/29208.html" target="_blank">Ч - К</a>, <a href="http://viakviak.livejournal.com/45394.html" target="_blank">Б - В</a>

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
<span viak="transition">Переход "звонкий-глухой"
</span><span viak="description">
Переход (чередование) "звонкий-глухой" является классическим общеизвестным фактом. Примеры:
Б-П
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
Здесь нам уже понадобятся знания о переходах звуков: <a href="http://viakviak.livejournal.com/29208.html" target="_blank">Ч - К</a>, <a href="http://viakviak.livejournal.com/33634.html" target="_blank">Т-Д, Б-П</a>, Ш-С:
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

exec spAddArticle 41271, N'Что в имени твоем: Трамп(рус:Trump)', N'english, вяк, имя, слова', N'
</span><span viak="name">Трамп(рус:Trump)

ТРМП - Trump(Трамп) Triump(h)(англ:триумф) трамп(лин) tramp(англ:бродяга, тащиться с трудом, утомительное путешествие)
ПМРТ - Помереть помирить помарать
</span><span viak="description">
В карточной терминологии английское слово "trump" означает "козырь". Главная карта Джокер(рус:Joker) соответствует главной карте Таро "шут"(рус:fool).
</span><span viak="summary" >
Рассморение полного корня фамилии 45-то президента США показывает: утомительный путь на трамплин к триумфу - помирить или помарать или помереть.
Вызывающее подчас поведение Трампа в предвыборной компании и его невероятная победа полностью соответствуют его "карточной" роли:
<a href="http://arhangel.ru/temple.php?room=8&door=4" target="_blank">Прекраснодушный беспечный шут (бьющий всех козырь) опьяненный сиянием своей победы на краю пропасти окруженный грозными снежными вершинами с белым псом рядом</a>. 

<i>Looking at the last name of 45th president of USA using Russian consonant notation: tramping to the trampoline of triumph to make a peace or mess or die.
Defiant behavior of Trump in the election campaign and his incredible victory completely justifies his card role:
<a href="https://www.biddytarot.com/tarot-card-meanings/major-arcana/fool/" target="_blank">Starry-eyed careless fool (beating all trump) intoxicated with the radiance of his victory and surrounded by formidable snowy peaks is on the edge of the abyss with the white dog beside</a>.</i>
</span>
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
Считается доказанным, что <a href="http://viakviak.livejournal.com/50841.html" target="_blank">слово Пистоль является калькой слова Пищаль</a>.
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
Рассмотрим приведенные ниже толкования слов, где Товар сводится к понятию "рядом" и родственности слову "<a href="http://viakviak.livejournal.com/43711.html" target="_blank">тор</a>", а Товарищ еще и сравнивается с близким по смыслу арабским "тарака" - следовать друг за другом, стучать(в смысле периодически: один стук за другим). Учтем, что "в" может, оказывается, переходить в "о". Тогда мы можем увидеть, что корень ДВР может перейти в ДОР, прочитывается наоборот как <a href="http://viakviak.livejournal.com/43711.html" target="_blank">"РОД" или "РЯД"</a>. Мы можем видеть также, что переход "В - О" позволяет объяснить слова Товар и Товарищ без привлечения арабского языка:
</span><span viak="word">
ДР - дыра дар дорога дура(к) дурь одр удар драка door(англ:дверь)
РД - ряд рядом род орда ордер рядить (про)редить редут ярд (по)рядок рад(ость) урод (к)ряду обряд наряд редька руда (п)рядь орден ординарец ординатура Рада радение Родина рыдать
Рт - <a href="http://viakviak.livejournal.com/43711.html" target="_blank">рот</a> рота артель (во)рота ритуал рутина ритм (г)урт юрта creator(англ:создатель) (к)арта art порт портянка порты retina(англ:сетчатка) urethra(англ:мочеиспускательный тракт)
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
<a href="http://viakviak.livejournal.com/43711.html" target="_blank">рот</a> - округлый, выход из тела наружу, с рядами зубов
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
Тора - Сотворение, книга закона божьего (творца) "О сотворении мира", свернутая вокруг, свиток
торба - мешок вокруг содержимого
тормоз - тор+<a href="http://viakviak.livejournal.com/27188.html" target="_blank">маз</a> - скользить рядом, друг об друга
торить - работать пролагая дорогу
тра(кт) - дорога
три - круговой, вокруг, число "пи" (3 ~ 3.14).
тура - построенная колонна
удар - выброс кулака "наружу"
урод - отличный от всех, снаружи, вне от общества.
урожай - полезный выход наружу
утварь - вещи под руками, рядом
юрта - круглая
ярд - <a href="http://www.beloveshkin.com/2015/07/idealnoe-sootnoshenie-talii-beder-i-vashego-zdorovya.html" target="_blank">длина обхвата вокруг талии нормального мужчины, три фута, круговой фут (3~3.14)</a>
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
';
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

exec spAddArticle 45394, N'Переход Б - В', N'вяк, переход, слова', N'
<span viak="transition">Переход Б - В

</span><span viak="description">Переход Б - В является классическим общеизвестным фактом. Примеры:
barbarian-варвар
Barbara-Варвара
</span>';
GO

exec spAddArticle 45948, N'Что в имени твоем: Галлия', N'вяк, государство, имя, слова, тело', N'
<span viak="word">Галлия

ГЛ - Галлия Галиция (Порту)галлия (Ан)глия Голла(ндия) Гель(веция) Гали(поли) Algeria(англ:Алжир) (Мон)голия галка <a href="http://viakviak.livejournal.com/18993.html" target="_blank">гла(з)</a> голо(с) глу(шь) голый гулять голень гул гла(гол) гло(тка) гла(нды) голо(ва) <a href="http://viakviak.livejournal.com/45219.html" target="_blank">глубина</a> глу(хой) гли(на) гильо(тина) gallows(англ:виселица) ugly(англ:безобразный) Аглая гале(ра) галео(н) ГУЛАГ гля(нец) гальюн гольф Галлей Галлилей Голгофа
ЛГ - легкий луг лига Ольга Олег Улуг(бек) leg(англ:нога) log(англ:колода)
кЛ - кол киль кал коло(ния) colon(англ:кишка) кулебяка клуб кель(ты) коле(но) клан клён каленый клин кулак кляп клоп клоун
	- хЛ - хала хлеб хлябь хула хилый хлев халява холка
	- Лх - лях лох лихо ольха (с)лух
<a href="http://viakviak.livejournal.com/45219.html" target="_blank">кЛв</a> - клевер коловорот Калевала аки-лев клюв клёв calve(англ:телиться) calf(англ:<b>теленок</b>,ср:корова) claw(англ:коготь)
<a href="http://viakviak.livejournal.com/11820.html" target="_blank">вЛк</a> - великий волк вол валик великан вилка
<a href="http://viakviak.livejournal.com/37986.html" target="_blank">жЛ</a> - жало жила жел(тый) жало(сть) жало(ба) жело(б) 
Лж - лежать лужа
	- Лз - лизать лаз луза лезвие lease(англ:аренда)
	- зЛ - зал зло зола зело узел зеле(ный)
</span><span viak="description">
colon(англ:кишка) - глубоко в животе, трубчатый орган с дырой, просветом, 
gallows(англ:виселица) - для отправления в другой (далекий) мир, на "тот" свет, веревка с просветом
leg(англ:нога) - нога, голень ходить далеко, ЛЕГкая на подъем
галео(н) - пустой, для дальнего плавания, пузатый, полый внутри
гале(ра) - для дальнего плавания, полая внутри
гальюн - отхожее, дальнее место, с дыркой для отходов
гильо(тина) - для отправления в другой (далекий) мир, на "тот" свет, производит просветление межды головой и телом
гла(гол) - часть речи голосом. Умеет удвоенный смысл "ГЛ", проСвещать, произносится полостью рта
<a href="http://viakviak.livejournal.com/18993.html" target="_blank">гла(з)</a> - видит свет
гла(нды) - глубоко во рту
гло(тка) - глубоко во рту
глу(шь) - очень далеко, глубоко
глу(хой) - проблемы со слухом, плохая (далекая, как из глубины) слышимость
голо(ва) - пустая, легкая
гольф - игра в глубокую дырку
гул - неясный звук издалека
ГУЛАГ - "места не столь отдаленные"
гулять - уходить далеко
киль - часть судна находящаяся глубоко
коле(но) - часть ноги ходить далеко
коло(ния) - глубинка, глушь, "дыра", пустошь, вдали от цивилизации
лихо - неприятности издалека
(с)лух - способность принимать звук на расстоянии
Улуг(бек) - великий бек. Улуг=(В)улуг=Велик
хлябь - глубокая лужа
хула - "посылание" далеко
</span><span viak="summary">
Принимая во внимание цепочку "глубина-глу(шь)-коло(ния)-глаз-голос-гул-гло(тка)-гла(гол)-гла(нды)-голо(ва)-гулять-leg(англ:нога)-colon(англ:кишка)-хула" можно предположить, что слово Галлия лежит в смысловом пространстве "глубинка", "глушь", "колония", "даль", "далекий", "дыра", "пустота".
Возможно это подобно слову "PARS" (Париж, Персия), которым на старых картах обозначались дальние окраины.
Существует понятие "Гальского пояса": Галлия, Галиция, (Порту)галлия, (Ан)глия, Голла(ндия), Гель(веция).
Получается, что "Гальский пояс" - это определение "глубинки", окраины. Если это так, то можно попытаться найти метрополию вокруг которой и располагаются многочисленные "галлии". Мне кажется, что такой метрополией скорее всего окажется Италия.
</span><span viak="description">
Слово Галлия может произносится как Халлия. Звук "Х" может выпадать как в известных примерах:
Ольга=Хельга, Отель=Hotel. Если в слове Халлия выпадает первый звук "Х", то мы видим перед собой знакомое слово <a href="http://viakviak.livejournal.com/11024.html" target="_blank">"Алла" (свет, светлый)</a> как одно из имен бога. Можно, также, прочитать "Халлия" наоборот и получим практически то же самое: Аллах.

Это допущение позволяет видеть уже полученные понятие в несколько ином "свете". Точнее, понятия "длинный", "дальний", "долгий", "расстояние", "сложный" можно уже рассматривать как характеристики понятия "Свет": бесконечный, составной, невесомый, а также состояния отсутствия ожидаемого света: невидимый, пустота, глубина, спрятанный, потусторонний мир, ...

С другой стороны, <a href="http://viakviak.livejournal.com/11024.html" target="_blank">компонента "Л"</а> в слове Галлы может указывать на понятие "светлый", т.е. светлокожий, бледнолицый.
</span><span viak="reference">
См. также:

vaduhan_08: <a href="http://vaduhan-08.livejournal.com/293451.html" target="_blank">ФРАНЦИЯ... КОТОРОЙ НИ КОГДА НЕ БЫЛО?</a>
</span><span viak="reference">
Есть теория, что петух ("галос") - это просто символ "голоса", данному людям, чтобы славить бога (славянам): https://www.youtube.com/watch?v=JSHruCh

мое мнение: <a href="http://vaduhan-08.livejournal.com/293451.html?page=3#t10671947" target="_blank">ФРАНЦИЯ... КОТОРОЙ НИ КОГДА НЕ БЫЛО?</a>
Мне кажется что все гораздо проще.  <a href="http://viakviak.livejournal.com/11024.html" target="_blank">Звук "Л"</a> добавляет в любое слово определенный смысл: светлый, легкий, летающий, подвешенный, поддержанный. В данном случае Галка - летающая, Галлы, Англичане - светлокожие, Голос - легкий, быстрый, разносящийся, Gallus(лат: петух) - голосит с восходом солнца-света. Другие примеры: Аллах - несущий свет, Алый - светло-красный, и т.д.

Древние слова обозначают набор базовых понятий, они сами себя описывают. Мы же воспринимаем их как ярлыки, и ожидаем, что один ярлык образовывает другие, что неправильно, и приводит к путанице. Мы избалованы словарями, картинками, нам всё всегда объясняют эксперты. А в древности этой роскоши не было. Поэтому слова обозначали какую-то особую черту, или особо яркое впечатление. Компоненты слов составляющие базовые понятия складывались как кубики в слово и давали возможно полное описание явления.
</span>
';
GO

exec spAddArticle 46083, N'Что в имени твоем: Чин', N'вяк, слова', N'
<span viak="word">Чин

ЧН - чин chin(англ:подбородок) China(англ:Чина, Китай)) чинить учение ученый чваниться
НЧ - ничё ничье ничья нач(ало) ночь унич(тожить) нич(то)
Нк - никто некто нак(лон) нек(рополь)
кН - кино окно конь кануть кинуть кон коне(ц) куни(ца) Ковно Каин con(англ:против,жулик)
- Нг - нога нега анга(р) nugget(англ:комок)
- гН - гной гений огонь гон угон Агни Агния gun(англ:огнестрельное оружие) гиена гавно гуано
- Нх - нюх нахал
- хН - хан хина 
жН - жена жниво Жанна жжение жужание
Нж - ниже нож нуж(да) неж(ность)
- зН - зона зенит зной зонт озон звание звон
- Нз - низ унизить низ(вести) навоз
- - сН - сан сон сено осень весна ясный синий ясень асана свинья основа весна саван сифон сунуть
- - Нс - нос носить навес 
</span><span viak="description">
</span>
';
GO

exec spAddArticle 46763, N'Что в имени твоем: Висла', N'вяк, имя, слова', N'
<span viak="name">Висла

ВСЛ - Висла весло веселый всласть вассал вислый Василий виселица висельник
ЛСб - лесбиянка Лиссабон
ВцЛ - Вацлав
ЛцВ - лицевой
БцЛ - бацилла
 <a href="http://viakviak.livejournal.com/45219.html" target="_blank">СЛ</a> - сила село осел сало соль село
 ЛС - лес лиса
 зЛ - зло зело зал узел
 Лз - лаз
 цЛ - целый целовать
 Лц - лицо улица
</span><span viak="summary">
Висла - веселая, в-силе, сильная
</span><span viak="description">
бацилла - извилистая, дрожащая, "веселая"
вассал - в силе, сильный
Василий - веселый, в силе, сильный
Вацлав - веселый, в силе, сильный
веселый - [ве]силый, в силе, сильный, по нему виселица плачет
весло - весело для сильных
вислый - раскачивающийся, т.е. "веселый"
зело - сильно
лесбиянка - веселая. Ср: gay(англ:беззаботный,гей)
осел - сильный
сало - соленое
село - сильные вместе
соль - дает силу
целовать - в лицо
</span><span viak="reference">
Из <a href="http://trueview.livejournal.com/" target="_blank">TrueView</a>:
<a href="http://trueview.livejournal.com/166542.html" target="_blank">Висла - извилистая (река).</a>
</span>';
GO

exec spAddArticle 46952, N'Переход: С - Х', N'Вашкевич, вяк, переход, слова', N'
<span viak="transition">С - Х

</span><span viak="reference">
Из Н.Н. Вашкевича:

СРАТЬ – "испражняться". Праслав. *sъrati связано с чередованием с сор. (Фасмер).
       ♦ Этимология неизвестна. От ар. خرا хара: с тем же значением. Переход С/Х обычен для многих языков. Ар. слово от أخر ''ахара "оставлять сзади", آخر ''а:хар "крайний". Родственно край, икра (см.) в обоих значениях.
</span>';
GO

exec spAddArticle 47297, N'Что в имени твоем: Моголы', N'имя, вяк, слова, история', N'
<span viak="name">Моголы

МГЛ - моголы мо-галлы могила мгла
ЛГМ - <a href="https://ru.wikipedia.org/wiki/Лагман" target="_blank">лагман</a>
МхЛ - махалля Михаил
ЛхМ - лохматый лихоимец
</span><span viak="summary">
Название Моголы могло быть производным от тюркского слова Махалля - лагерь, община (ср. со словом Орда). Моголы находится в смысловом поле <a href="http://viakviak.livejournal.com/45948.html" target="_blank">Галлы</a>, <a href="http://viakviak.livejournal.com/11024.html" target="_blank">Аллах</a>.
</span><span viak="description">
</span><span viak="reference">
Из Википедиа:
<a href="https://ru.wikipedia.org/wiki/Махалля" target="_blank">Махалля́ или Махалла</a>, также Гузар (араб. محلة maHálla — «перевалочная станция», «привал»; «лагерь»; «городской квартал», от حل Hálla «развязывать», «распутывать»; азерб. məhəllə, тат. мәһәллә, тур. mahalle, тадж. махалла, гузар, узб. mahalla, уйг. مەھەللە, мәһәллә) — в исламском мире часть города размером с квартал, жители которого осуществляют местное самоуправление. Как правило, центром такого квартала — махалля — является мечеть, служащая своего рода культурным центром, в котором проходят пятничные собрания населения махалля и совершается торжественная пятничная молитва (намаз).
Махалля как институт осуществляющий на мусульманском Востоке местное самоуправление имеет глубокие корни. Например, о существовании в XI веке махалля в Каире сообщает поэт, писатель Насир Хосров. В своём произведении «Сафар-наме» (Записки путешественника), которые были составлены в 1043-1052 годах во время путешествия по странам Ближнего Востока, он сообщает, что «город Каир состоит из 10 махалля».
В современном понимании в мусульманских республиках Поволжья махалля — это локальная община, объединяющая вокруг мечети не всех жителей определенного района, а только религиозную её часть, которая посещает мечеть. В Средней Азии, в том числе в Узбекистане, а также в Восточном Туркестане у уйгур[2] под махалля, как правило, понимается традиционный социальный институт общинного типа или квартальная форма организации общественной жизни. То есть это квартал или микрорайон, жители которого осуществляют местное самоуправление путём выбора комитета махалля.[3] и его председателя, решающих вопросы организации быта и досуга жителей своего махалля, а также несущих ответственность перед вышестоящими органами городского управления за обеспечение правопорядка в своем махалля.
</span>';
GO

exec spAddArticle 47551, N'Что в имени твоем: Сто', N'вяк, слова, число', N'
<span viak="word">Сто

СТ - сто (де)сять сито соты сеть есть уста устье усатый тесто (ча)сто (к)уст (г)усто
ТС - тыся(ча) тёс утес отсев таскать task(англ:задача) тесто this(англ:это)
Сд - седой суд седьмой сидеть сад сода
зд - зад
</span><span viak="summary">
Слово Сто близко связано со словами Десять и Тысяча и является их составной частью. Близкое слово Тысяча прочитанное наоборот дает слова: часто, куст, густо со смыслом "часто", "густо", "много", "плотно". В этом же смысловом поле "плотно", "узко" для слова Сто находим другие слова: сито, соты, сеть, уста, устье, зад, сад.
</span><span viak="description">
(г)усто - плотно
(де)сять - дес-сять, тес-сять, часть сотни, неогласованный палиндром с удвоенным смыслом "сто".
есть - плотно поесть устами
сеть - много дырок
сито - много дырок
соты - много тесных ячеек с медом
(к)уст - много частых плотно расположенных веток
тесто - тес-сто, неогласованный палиндром с удвоенным смыслом "сто"
тёс - много плотно-пригнанного дерева
тыся(ча) - (ча)сто, (к)уст,  (г)усто наоборот
уста - узкие губы со многими частыми зубами
(ча)сто - плотно
</span>
';
GO

exec spAddArticle 47759, N'Что в имени твоем: Ус', N'вяк, слова, тело', N'
<span viak="word">Ус

С - Ус кусок сон нос с- суй совать сеять соя сё сиё сия(ние) ас оса сосать ссать есть yes(англ:есть) вас усё всё весы Вася 
З - узкий узник зенит зона Уза закон зов zoom(англ:увеличить) за- воз ваза виза зуав зев Уза Зевс
Ц - цевьё цаца цеце цыц цуцик лицо
</span><span viak="description">
zoom(англ:увеличить) - увеличить, сфокусировать в направлении
весы - ограничитель правильного веса
виза - законное право въезда
воз - возить в определенном направлении, ориентированная для движения вперед, проходящая в определенной щирины ворота
есть - поедать еду черз узкое отверстие рта
закон - направления и ограничения поведения
зев - отверстие во рту
зенит - направление вверх в узком диапазоне погрешности
зона - узилище
зуав - легкая пехота просачивающаяся, обтекающая и действующая в малопроходимых, узких участках
кусок - часть, отломанный, небольшой
лицо - суженое в поперечине передняя часть головы
нос - имеет два узких отверстия для прохода воздуха
оса - жалящая через
суй - совать, протискивать через проход
сеять - процесс вусадки цемян в землю через разрыхленную для этого почву
сё - указание в узком диапазоне направлений
сия(ние) - проходящие лучи, свет проходящий через, выходящий из, исходящий от
сосать - вытагивать ртом жидкость черз узкое отверстие
соя - высеянная
ссать - выпускать мочу через узкое отверстие
Уза - название реки
узник - живущий в узком помещении
ус - уская полоска волос на лице
цевьё -  стержневая, узкая часть
</span><span viak="summary">
Представляется, что "С" и "З" участвуют в создании смыслого поля "узкий", "прохождение сквозь", "направление", "правило".
</span>
';
GO


exec spAddArticle 48069, N'Прямой перевод: Cheek(англ:щека) - direct translation', N'вяк, перевод, слова, тело', N'
<span viak="translation">Cheek(англ:щека)
</span><span viak="description">
При переходе "Щ - Ч" Cheek (звучащий как Чик) становится Щик(а).
</span><span viak="summary">
Cheek = щека
</span>
';
GO

exec spAddArticle 48383, N'Прямой перевод: Über(нем:над,более,сверх) - direct translation', N'вяк, перевод, слова', N'
<span viak="translation">Über(нем:над,более,сверх)
</span><span viak="description">
При переходе "Б - В" немецкое Über становится английским Over(англ:над,более,сверх) и русским Верх.
</span><span viak="summary">
Über = Over => Верх

</span><span viak="word">Верх

ВРХ - верх
ХРВ - Хорив Хорватия
бРХ - брехня брюхо бархат Борух
ХРб - хребет храбрый
ВРк - враки варка Воркута
кРв - кровь кровать кривая корова
бРк - брюки барак беркут брокер бирюк абрек оброк оборки барокко бряк(нуть)
кРб - короб краб корабль
ВРг - враг вериги овраг Вергилий
ХР - хер хор
РХ - ряха рейх
кР - Кир Каир кура курить кара
Рк - река рука арка урка урюк рок
</span><span viak="description">
<a href="https://www.youtube.com/watch?v=yLHGTJjHXLo" target="_blank">Deutschland Uber Alles(Германия превыше всего)</a> - Немецкий гимн
абрек - высоко-горный житель
барокко - высокое, великое, приподнятое, величавое искусство
бряк(нуть) - уронить с высоты
варка - создает пар идущий вверх
кривая - поднимается
корабль - высокая лодка
корова - высокая по сравнению с козой
кровать - приподнимает спящих
кровь - право крови определяет вертикаль власти.
курить - пускать дым поднимающийся вверх
оброк - высокий налог наверх
овраг - высокий обрыв
рейх - высшая империя
река - спускающаяся сверху
рука - поднимающаяся вверх
урюк - растущий высоко
хер - стоящий вверх
хор - поющие вверх небесам
Хорив - высочайшая гора Синай
храбрый - храбрость, высокий героизм
хребет - вертикальный орган поддерживающий верхнюю часть тела
</span>
';
GO

exec spAddArticle 48568, N'Компонента: С/З/Ц - узкий, направленный, проходящий через преграду, ускоренный, охлажденный', N'бог, вяк, компонента, слова', N'
<span viak="component">С/З/Ц

</span><span viak="summary">
С/З/Ц - звук проходящий связь сжатые зубы (препятствие) в одном определённом направлении через узкое горло со свистящим звуком соединяющий в этот момент внутреннее с внешним. По закону Бернулли, прохождение через узкое препятствие ускоряет поток. Кроме того, быстрый поток через узкий канал охлаждает.
"С/З/Ц" выражает понятия "узкий", "направленный", "проходящий через преграду", "тонкая связь", "ускоренный", "охлажденный".
</span><span viak="description">
забава - с+бабой 
звезда - с+воздух
земля -> алмаз, Алла+мазь - тонкий (светлый) почвенный слой благословенный богом
зов - подходящий издалека с определённого направления из-за преграды делающий источник невидимым.
мазь - тонкий размельченный слой соединяющий трущиеся
поц(идиш:половой член) - пробивающий тонкую преграду, направленный
с- обозначает связь двух или нескольких.
связь - узкое соединение (вязь), направленное общение
свет - с+ветер, с+вед, с+иду - идущий в прямо в одном направлении легкий и тонкий, пробивающееся через препятствия божественное движение.
север - направление на холод
сок - выжатый, прошедший через жернова, пьется охлажденным
цап - ускоренный захват
цапля - птица на тонкой ноге цапает
</span>
';
GO

exec spAddArticle 48863, N'Падение звука: Р', N'вяк, переход, слова, смерт', N'
<span viak="transition">Падение звука: "Р"
</span><span viak="description">
Всем известное различие между Британской и Американской весиями английского языка: в британской версии звук "Р" не проговаривается.

Другие примеры:
<a href="http://viakviak.livejournal.com/44378.html" target="_blank">мата(араб:смерть)</a> <a href="http://viakviak.livejournal.com/20390.html" target="_blank">ма(р)та</a> mortem(лат:смерть)
маг могу(чий) ог(р)омный г(р)омадный г(р)ом
</span>
';
GO

exec spAddArticle 49107, N'Что в имени твоем: Мир', N'время, вяк, слова, смерть', N'
<span viak="word">Мир

МР - мир море мор мера самурай <a href="http://viakviak.livejournal.com/20390.html" target="_blank">смерть</a> mortal(англ:смертный) морфий мортира сумерки марк марка маркграф маркиз маркет сморкать камера tumor(англ:опухоль) tomorrow(англ:завтра) шумеры Америка Самара Измир Смирна Самарканд Жмеринка бром мэр summer(англ:лето) morning(англ:утро) mourning(англ:траур)
РМ - ром ремень рамэн(яп:лагман) армия гром греметь кромка Рим Армения Германия Померания Румыния Крым <a href="http://viakviak.livejournal.com/44584.html" target="_blank">время</a> бремя румб форма фирма рама arm(англ:рука) ремень рюмка
</span><span viak="summary">
Слово Мир лежит смысловом пространстве "мера", "измеренный", "ограниченный", "пограничный", "конец", "смертный", "опасный", "конечный", "познаваемый".
</span><span viak="description">
arm(англ:рука) - рука ограниченной длины
morning(англ:утро) - после сна, см. похожее слово mourning(англ:траур)
mourning(англ:траур) - выражения печали или горя по причине смерти
summer(англ:лето) - "мертвый" сезон
tumor(англ:опухоль) - рак
tomorrow(англ:завтра) - после сна, за-утро.
Америка - а-мирок-а, новый "мирок", граница мира
армия - несущая смерть
бремя - ограничение персональной свободы
бром - умертвляющая, токсичная жидкость.
время - мера жизни, умертвляющее
Германия - граничащая с морем, г-Романия, к-Романия, выход к-морю, поморье.
гром - страшный грохот, опасная стихия.
камера - помещение органичивающее свободу узника
кромка - граница
Крым - ограниченный морем, к-Рим, поморье.
марка - мера цены.
маркграф - выше маркиза, владелец земли в приграничной зоне, размеренной колонии.
маркет - огороженный базар со стандартными мерами.
маркиз - владелец земли в приграничной зоне, размеренной колонии.
мера - правовая оценка вины, проступка, степень наказания вплоть до смерти.
мир - земной шар, дает жизнь смертным, познаваемый, конечный
мир - временный конец войны
мир - замкнутая небольшая община с ограниченным членством.
мор - умертвляющая эпидемия, конец жизни.
море - конец, граница земли, смертельно опасная среда
мортира - смертоносное оружие
морфий - ограничивающий сознание, вызывающий сон, смерть
мэр - измеритель, ср. с "мэтр" (что соответствует единице измерения метр). По видимому, измерение было очень важным и отвественным делом в городах. Тогда можно увидеть в названиях некоторых городов понятие "мера": Самара Измир Смирна Самарканд Жмеринка
Померания - поморье, ограниченное морем, конец земли
рама - ограничивающая
ремень - кожанный пояс определенной длины
ром - усыпляющий, ограничивающий сознание, уморяющий, напиток моряков
рюмка - для "уморительных" напитков
Самарканд - самар+канд(узб:сахар) - мера сахара
самурай - несущий смерть, играющий со смертью, готовый к смерти.
смерть - конец жизни, меряет длину жизни.
сморкать - болезнь
сумерки - конец светового дня
фирма - оприрующая в рамках закона, от слова форма, синонимы: корпорация от слова corpus(лат:тело), организация от слова орган.
форма - ограничивающая
</span>
';
GO

exec spAddArticle 49362, N'Прямой перевод: Tree(англ:дерево) - Direct Translation', N'вяк, перевод, слова', N'
<span viak="translation">Tree(англ:дерево)
</span><span viak="description">
ТР - tree(англ:дерево) три
РТ - <a href="http://viakviak.livejournal.com/43711.html" target="_blank">рот</a>
дР - дерево древо
Рд - редька редиска род рад урод выродок Ирод рыдать орда ряд обряд брод вред
</span><span viak="summary">
Tree => дре[во]
Английское слово Tree переходит в русское слово Древо в два приема: переход <a href="http://viakviak.livejournal.com/33634.html" target="_blank">Т - Д</a> и выпадение звука <a href="http://viakviak.livejournal.com/45219.html" target="_blank">"В"</a>.
</span>
';
GO

exec spAddArticle 49641, N'Компонента: ТР - цикличность, повторяемость, нахождение рядом, вокруг, округа, возвращаемость', N'вяк, компонента, слова', N'
<span viak="component">ТР
</span><span viak="summary">
ТР - выражает цикличность, повторяемость, нахождение рядом, вокруг, округа, возвращаемость.
</span><span viak="description">
См. следующие примеры: <a href="http://viakviak.livejournal.com/44207.html" target="_blank">Двор</a>, <a href="http://viakviak.livejournal.com/43711.html" target="_blank">Рот</a>
</span>';
GO

exec spAddArticle 49834, N'Компонента: П - проход, переход', N'2x, вяк, компонента, слова', N'
<span viak="component">П
<span><span viak="summary">
Компонента "П" выражает "проход", "переход".
<span><span viak="description">
под поддон - проход внизу
падать - переходить вниз (в "ад")
п&зда - узкий проход в теле женщины (комбинация компонент "П" и "З"). Если видеть в "-ад", "-од", и "-да" компоненту выражающую "вниз", то получим "узкий проход внизу".
попа - проход (с двойным усилением смысла) возможно для указания смысла "широкий", "увеличенный"
палец перст - делающий проход
пукать пердеть - испускать газ из прохода
письмо - в узкий проход
пися - узкий проход
поморье - проход к морю
поезд - проходящий
пар - восходящий, проходящий вверх
пан - приходящий господин в отличии от постоянно живущих смердов
пони - переходной вариант от собаки к лошади (?)
плата - <a href="http://viakviak.livejournal.com/50020.html" target="_blank">легкие</a> (небольшие) деньги за проход.
пуля плетка плевок - пролетающая
платок платье - развевающееся на ходу (проходе)
</span>
';
GO

exec spAddArticle 50020, N'Компонента: Л - светлый, легкий, подвешенный, поддержанный, летящий, отверстие',  N'вяк, компонента, слова', N'
<span viak="component">Л
</span><span viak="summary">
Компонента "Л" выражает "светлый", "легкий", "подвешенный", "поддержанный", "летящий", "отверстие"
</span><span viak="description">
hello hola alloha аллё - свет вам
hole(англ:дыра) - просвет
holy(англ:святой) - светой/святой, святейщий, его святейшество
<a href="http://viakviak.livejournal.com/11024.html" target="_blank">Аллах</a> - светлый, дающий свет
бля#ь - "дырка", легкого поведения, болтающаяся
глянец блик - отсвечивающие
голова - поддержанная шеей
иллюминация - освещение
клей - держащий
кол - пробивающий отверстие, дыру
лампа - светящая
лес - пробивающийся сквозь деревья свет
липа - клейкая, держащая
лицо лик личина - светлое
Люцифер - светящий
<a href="http://viakviak.livejournal.com/45948.html" target="_blank">галлы</a> <a href="http://viakviak.livejournal.com/47297.html" target="_blank">моголы</a> - светлокожие, бледнолицые
</span>
';
GO

exec spAddArticle 50418, N'Компонента: МР - мера, ограниченный, познаваемый, конечный, смертный, сонный, опасный',  N'вяк, компонента, слова', N'
<span viak="component">МР
<span><span viak="summary">
Компонента "МР" выражает "мера", "измеренный", "ограниченный", "познаваемый", "конечный", "конец", "пограничный", "смертный", "сонный", "опасный".
<span><span viak="description">
См. <a href="http://viakviak.livejournal.com/49107.html" target="_blank">"Мир"</a>, <a href="http://viakviak.livejournal.com/20390.html" target="_blank">"Smart"</a>, <a href="http://viakviak.livejournal.com/42563.html" target="_blank">"Март"</a>, <a href="http://viakviak.livejournal.com/44584.html" target="_blank">"Время"</a>

Вариации:
МР - мера мир
РМ - Рим рум(б)
</span>
';
GO

exec spAddArticle 50449, N'Прямой перевод: Kid(англ:ребенок) - Direct translation',  N'вяк, перевод, слова', N'
<span viak="translation">Kid(англ:ребенок)
</span><span viak="description">
КД - kid(англ:ребенок) куда кадка кеды код
ДК - док дока deck(англ:настил) эдак
Кт - кто кот octal(англ:восьмеричный) Окт(лат:Октябрь) кит
тК - ток так тык тюк -тека атака утек утка отёк
чД - чадо чудо чад
Дч - дача дуче отдача удача дичь дочь
ДвК - девка двойка давка
КвД - квад(рат)
хД - худой hood(англ:капюшон)
Дх - дух дыха(ние)
вДх - выдох вдохно(вение)
хт - хата heat(англ:тепло) хутор
тх - тихо тух(лый) отдых
чт - чёт чета читать чей-то что
тч - туча течь attach(англ:присоединить) точка touch(англ:касаться) тачать
</span><span viak="summary">
Представляется, что слово Kid(англ:ребенок) имеет прямую связь со словами "чадо" и "дочь".
</span>';
GO

exec spAddArticle 50841, N'Переход: Щ - С',  N'2x, вяк, оружие, переход, слова, технологияr', N'
<span viak="transition">Условный переход Щ - С
</span><span viak="description">
борщ - береста, суп с берестой, барский суп, вересковый
вещий - вести
вещь - есть въесть object(англ:объект) вектор актёр
вращать - бросать, обрастать
городище - городской
дщерь - тестерь(?)
дощечка - доска
дрыщь - дристать
дурища - дурость, дурацкий
ещё - есть
идущий - действуй
ищи - искать
кладущий - (по)кладистый
клещ - глист
кощей - кости
кощунство - костинство(?), оскорбление костей
крещение - крестение
крещенные - крестьяне
куща - кусты
лощина - лесок
лещ - леска
лущить - лускать, лузгать
мещане - местные
мощь - мост, mosque(англ:мечеть)
моща - москва(?)
мощёный - мостить
мощи - маски(?)
навощённый - навостить
нищий - нести
нищие духом - несомые духом, унесенные ветром
общ(щ)ее - общество
община - встан, станица, обстановка
орущий - русский(?), уращий(?)
отомщёный - отомстить
ощипать - оскопить
помещение - поместье
праща - простая
плащ - пласт
пещаный песчанный - песковый
пещера - пустырь
пища - паста, pasta(англ:макароны)
пищаль - <a href="http://viakviak.livejournal.com/41969.html" target="_blank">пистоль</a>
пищать - пискать, пиздеть
площадь - плоскоть плескать полоскать
плющ - плести
плющить - пластать полоскать плескать
помощь - помост
пощада - пустить
прощать - простить
проще - простой
прыщ - простуда, прыскать, прусский(?), priest(англ:священник)
пуща - пусто
пуще - пусти
пущать - пустить, пускать
пуще - пускай
Радищев - радеющий, радейский
расщедриться - раствориться (раскрыться)
роща - расти
рубище - рубаска, рубашка
рыщи - рыскать
свищ - свист
становище - становится(?)
стращать - страсти
сущный - составной
сыщик - сыск
тащить - таскать
теща - тесть
толщина - толстина
тощий - доска
трещать - трескать, трясти
трущоба - трястёбы(растресённые?), трескова(?), треснутое(?)
тщета - досада, sad(англ:грустный)
удирающий - этруский
укрощение - окрещение, укрестение, окрестение
чаща - частый
щавель - стебель сабля соль(?)
щедрый - сидорый(?)
щель - скол(?), цель(?)
щелочь - солька
щека щёки - сток стоки (слёз?), cheek(англ:щека)
щекотать - искать
щемить - смять смеяться сметь
щенок - сынок
щепа щебень - скоп(?), цепкий
щепки - сапоги сопки
щепоть - сыпать
щёлкнуть - столкнуть
щель - цель сель(?) стелить стелька сделка сделать
щериться - створ отвориться сраться
щетина - ссадина, седина(?), скотина(?)
щетка - сетка(?) садок(?)
щиколотка - стекало-течь, стекало+течет (моча), удвоение смысла "течь".
щирий(укр:искренний) - сирый старый
щи - stew(англ:тушенка)
щит - суд
щука - сука сухая штука
Щукарь, дед - <a href="http://ukrlit.org/slovnyk/стукарь" target="_blank">Стукарь, т.е. ночной сторож</a>
щупать - цапать, скупать, цыпа
щучить - стучать, стукать, ссучивать
хвощ - хвост
хлыщь - хлыст
хрущ - хруст
ямщик - ямской
ящер - явствер, т.е. поедающий
ящик - ясак
</span><span viak="summary">
Выглядит так, что существует переход "Щ - С" с сохранением смысла слов. Похоже, что если "Щ" находится в середине слова, то "Щ" трансформируется в "СТ", реже "СК". Иногда начальное "Щ" может тоже трансформироваться в "СК". Это частный случай известного звукового перехода "СЧ - Щ", например: счет - щёт
</span>';
GO

exec spAddArticle 51037, N'Что в имени твоем: Счёт',  N'вяк, слова, экономика', N'
<span viak="word">Счёт
</span><span viak="summary">
Представляется, что слово Счёт могло быть образовано от слова Скот путем <a href="http://viakviak.livejournal.com/29208.html" target="_blank">перехода Ч - К</a>, что может служить еще одним подтверждением появлением счета из за нужд скотоводства.
</span>
';
GO

exec spAddArticle 51358, N'Что в имени твоем: Щелочь',  N'вяк, переход, слова, технология', N'
<span viak="word">Щелочь
</span><span viak="summary">
Представляется доказанным, что <a href="http://viakviak.livejournal.com/50841.html" target="_blank">слово Щелочь является калькой слова Солька</a>.
</span>
';
GO

exec spAddArticle 51639, N'Что в имени твоем: Сущность',  N'вяк, переход, слова', N'
<span viak="word">Сущность
</span><span viak="summary">
В свете открывшегося <a href="http://viakviak.livejournal.com/50841.html" target="_blank">условного перехода "Щ - С(Т)"</a> и учитывая возможность <a href="http://viakviak.livejournal.com/45219.html" target="_blank">выпадения "В"</a>, слово "Сущность" может быть развернута в слово "Составность", что великолепно совпадает по смыслу с первоначальным словом.
</span><span viak="description">
Проверкой может послужить слово Существо, которое подобным образом может быть переведо в слова "Составище", "Составство". Эти слова хотя формально и не являются общепринятыми, но их смысл достаточно прозрачен для "русского уха".
</span>
';
GO

exec spAddArticle 51924, N'Прямой перевод: Delete(англ:удалить) - Direct Translation',  N'вяк, перевод, слова', N'
<span viak="translation">Delete(англ:удалить)

ДЛТ - delete(англ:удалить) удалить делить долото уделать уделить длительный дальтоник
ТЛД - Толедо
тЛТ - телятина Тольяти
ДЛд - дилдо
</span><span viak="summary">
Английское слово Delete(англ:удалить) настолько хорошо соответствует русскому слову Удалить, что мне пришлось сделать усилие, чтобы осознать, что это два разных слова из разных языков.
</span>
';
GO

exec spAddArticle 52134, N'Прямой перевод: Divide(англ:делить) - Direct Translation',  N'вяк, наука, перевод, слова', N'
<span viak="translation">Divide(англ:делить)

ДВД - divide(англ:делить) двад(цать) Давид два(ж)ды
ДВт - давить удвоить удивить
тВт - ответ tweet(англ:щебетать) туфта тавто(логия)
ДД - дуда удод dad(англ:отец) dead(англ:мертвый)
Дт - дать дуть 
тД - туда оттуда
тт - тут тет-а-тет
</span><span viak="summary">
Представляется, что английское слово Divide(англ:делить) хорошо соответствует русскому слову Давить.
</span>
';
GO

exec spAddArticle 52446, N'Прямой перевод: Multiply(англ:умножить) - Direct Translation',  N'вяк, наука, перевод, слова', N'
<span viak="translation">Multiply(англ:умножить)
</span><span viak="description">
Очевидно, что в слове Multiply(англ:умножить) есть корень Multi(лат:многие)

МЛТ - multi(лат:многие) молот омлет мулат молоть амулет мулета Мальта melt(англ:плавить)
МЛд - молодой mold(англ:плесень)
дЛМ - дилемма долма
</span><span viak="summary">
Представляется, что английское слово Multiply(англ:умножить) имеет хорошое соответствие русскому слову Молоть.
</span>
';
GO

exec spAddArticle 52733, N'Что в имени твоем: Библия',  N'бог, вяк, имя, книга, слова', N'
<span viak="word">Библия

ББЛ - Библия Бабилон бабло бублик bubble(англ:пузырь)
ввЛ - Вавилон Вавилов
ЛБв - лоб любовь улыбка
вБЛ - вы$бал вобла во-бля
ЛБ - лоб улыбка
БЛ - боль быль Баал белый bull(англ:вол)
вЛ - Ваал вал вол вилы воля великий великан вуаль "Владимир Ленин"
Лв - лев лов улов лавина love(англ:любовь) live(англ:жить)
фЛ - file(англ:досье) филе flight(англ:полет) fly(англ:муха) fall(англ:падение)
Лф - альфа лафа лафет life(англ:жизнь)
</span><span viak="summary">
Представляется, что слово Библия, как и слово <a href="http://viakviak.livejournal.com/43711.html" target="_blank">Тора</a>, находится в смысловом поле "свиток", "скрученный вокруг", "окруженный", "бублик", "bubble(англ:пузырь)". Другие важные ассоциации: лоб любовь улыбка воля великий боль быль Баал Вавилон лев лов live(англ:жить) лафа. 
</span>
';
GO

exec spAddArticle 52993, N'Переход: СТ/ШТ - Щ',  N'вяк, переход, слова', N'
<span viak="transition">СТ/ШТ - Щ
</span><span viak="description">
Переход "СТ/ШТ - Щ" - это частный случай перехода "Щ - С", рассматриваемый наоборот. Т.к. в компоненты "СТ" и "ШТ" встречаются довольно часто, то интересно выяснить их понимание или изначалный смысл.

Если же переход "не срабатывает", то интересно выяснить возможные признаки "проблем". Так, например, это ограничение может быть географическим, климатическим, бытовым (слова Шторм, Стакан и др.), что может позволить локализовать использование этого перехода.

блестит - блещет, плещет
каста - кощи, кости, определение по роду
короста - корища, грубая кора
полоскать - плющить, отжимать, выжимать; похоже процесс полоскания прежде, до использования мыла, заключался в "плющении"
скипетр - щипетр, для разбивания в щепки, ощупывания
стоит - щит
стучать - щучить, стукать
холст - холщёвый
</span>
';
GO

exec spAddArticle 53467, N'Компонента: МФ/МТ - обволакивать, объединять, окружать, тесно, объем',  N'', N'
<span viak="component">МФ

МФ - муфта muff(англ:муфта) амфора миф Мефодий амфибия амфитеатр мафия муфтий
ФМ - family(англ:семья) fume(англ:дым) feminine(англ:женский) female(англ:матка) Фома
Мт - мать матка мата(араб:смерть) мат метан муть омут митра метр метка мэтр матрона материя митральеза мотать meat(англ:мясо,мякоть,суть) мыть мять метить маятник
тМ - том тема team(англ:команда,артель) тьма туман темень тумен атаман тумак комета томный тамга
- Мд - mud(англ:грязь,слякоть) мёд медь мудрый мода мадьяр 
- дМ - дума дом дым Дима
- Мв - move(англ:движение) омовение умывание
- вМ - вымя вам 
- - Мб - mob(англ:толпа,банда,мафия) mobile(англ:подвижный) мебель амбар амёба амбал амёба
- - Бм - объем бомба бумеранг бум бумага beam(англ:луч,балка,щирина) бомж bum(англ:бомж)
- - - Пм - помощь пума
- - - мП - ампула empale(англ:пронзать,обносить частоколом) империя emporium(англ:рынок) mop(англ:швабра,космы)
<span><span viak="summary">
Компонента "МФ" выражает "обволакивать", "объединять", "окружать", "тесно", "ограниченная подвижность", "объем".
<span><span viak="description">
muff(англ:муфта) - муфта, гильза
амфибия - земно-водное, объединяет характеристики наземных и водных.
амфитеатр - окружающий театр
амфора - объем, умывара
миф - объединение историй
муфта - объединяет руки, сцепление
муфтий - объединяющая фигура
</span>
';
GO

exec spAddArticle 53626, N'Что в имени твоем: Ветер',  N'вяк, слова', N'
<span viak="word"><a href="http://viakviak.livejournal.com/35512.html" target="_blank">Ветер</a>

ВТР - ветер автор ватру(шка) втереть аватар
РТВ - ретивый
ВдР - ведро вёдро водяра выдра
РдВ - рядовой рыдван
наряд редька руда (п)рядь орден ординарец ординатура Рада радение Родина рыдать
РТ - <a href="http://viakviak.livejournal.com/43711.html" target="_blank">рот</a> рота артель (во)рота ритуал рутина ритм (г)урт юрта creator(англ:создатель) (к)арта art порт портянка порты retina(англ:сетчатка) urethra(англ:мочеиспускательный тракт)
ТР - тор Тора (с)трана торить торг отара тиара тур тура тара (с)трои(ть) три тра(кт) тарака(араб:стучать) тиран торба
<a href="http://viakviak.livejournal.com/44207.html" target="_blank">дР</a> - дыра дар дорога дура(к) дурь одр удар драка door(англ:дверь)
Рд - ряд рядом род орда ордер рядить (про)редить редут ярд (по)рядок рад(ость) урод (к)ряду обряд 
</span><span viak="summary">
Слово Ветер "несет" в себе смысл "мокрый", "ретивый", "кружащий", "без конца повторяющийся".
</span>
';
GO

exec spAddArticle 53769, N'Компонента: ВС - высота, ввысь, сверху, выше, висящий',  N'вяк, имя, компонента, слова, тело', N'
<span viak="component">ВС

ВС - высота высь восток восход висок виски хвост авось вес все всё вассал овёс Василий восстание
СВ - свет совет свист свой сова сев свастика свинья свинец совок совать Савва
бС -  бастион бес босой босс Баски Бастилия boost(англ:увеличение)
Сб - сбор собор Сабрина Сибирь
Вш - выше вышка вешний вши вуши
шВ - шов швец швабра Швеция Шива Швабия
Вц - овца Вицин Авиценна
цВ - цвет
Вз - визг воз ваза виза
зВ - зов звук зев заявка звон
бш - башня башка баши Башкирия Бишкек bush(англ:куст)
шб - шабат шабаш шуба шибко
С - ус
ш - уши
ц - яйца
</span><span viak="summary">
ВС - выражает "высота", "ввысь", "сверху", "выше", "висящий". "С" - это направление, "В" - это "выше", "приподнятое", "вверх".
</span><span viak="description">
босой - подпрыгивающий от холода?
Василий - высокий
вассал - поднимающийся по зову
вес - измеренный взвешиванием
восстание - вставание, становление выше
виски - полученный возгонкой
висок - область головы выше и в районе уха
восток - направление на восходящее солнца
восход - движение по направлению вверх
все - сбор, собор
всё - сбор, куча поднимающаяся вверх
высота - выше, направление вверх
высь - высота
овёс - растение, поднимающееся
свет - идущий свыше
свист - высокий звук
свой - подобранный для себя
сев - бросание сверху
сова - сидящая выше
совет - освещающий вопрос 
хвост - подвешенный, висящий
</span>
';
GO

exec spAddArticle 54023, N'Компонента: СТ - замедление, остановка, установка',  N'вяк, имя, компонента, слова', N'
<span viak="component">СТ

СТ - стать остановка стоянка стоять стена сатана стоп пост поступок south(англ:юг,вниз) sit(англ:сидеть) сито стон -стан post(англ:почта)
ТС - тесать тоска тиски Тесла Атос
Сд - сад сидеть суд сидор седина ссадина сосуд Саид Исида
дС - досада диск доска досье dis-(англ:не-) 
зд - здание создание создатель зад зуд задание заядлый здоровье задор
дз - дозор доза
щ - щщщ! ща!
</span><span viak="summary">
Компонента "СТ" выражает "замедление", "остановка", "установка", "прерывание", "падение вниз". <a href="http://viakviak.livejournal.com/50841.html" target="_blank">Звук "Щ"</a> использующийся в замещении "СТ" имеет тот же смысл.
</span><span viak="description">
post(англ:почта) - станция почтовой службы, остановка для сбора почты
sit(англ:сидеть) - сидеть, стать ниже
south(англ:юг,вниз) - направление вниз
здание - стены
остановка - становиться, стена
пост - религ: остановка мясоедства; стоянка часового
поступок - остановился, прервал обычнуе занятия, чтобы совершить
сад - установка, обустройство растений
сатана - останавливающее движение, препятствующий <a href="http://viakviak.livejournal.com/25986.html" target="_blank">богу</a>
сидеть - "sit down"(рус:садись), "остановись вниз"
сито - останавливает крупные
сосуд - стоячая вода
ссадина - остановленная кровь
-стан - суффих означающий "штат", становище, территория
стать - стоять, становиться
стена - останавливать
стоп - остановить
стон - остановиться от боли
стоянка - стан, становиться, становище
стоять - штат
суд - заседают, сажают, защита, заЩитывают срок
тесать - тщательно, очищать
тоска - тиски, тощий
щщщ! ща! - тихо!
</span>
';
GO

exec spAddArticle 54363, N'Компонента: ВЛ - приподнять, волочить, перемещать, владеть, шевелящееся, катящееся',  N'вяк, имя, компонента, слова, тело', N'
<span viak="component">ВЛ

ВЛ - evil(англ:зло) воля вол вилы вал валять влияние Ваал вилок власть волок войлок <a href="http://viakviak.livejournal.com/25093.html" target="_blank">великий</a> волк великий великан вуаль "Владимир Ильич Ленин" wool(англ:шерсть) волос власть Велес <a href="http://viakviak.livejournal.com/25093.html" target="_blank">Волга</a> влага влагалище иволга вульгарный wild(англ:дикий) валет влечение
ЛВ - <a href="http://viakviak.livejournal.com/22974.html" target="_blank">love(англ:любовь)</a> лев улов ловля лава олива live(англ:жить) голова главный клевер clever(англ:умный,юркий) Калевала клюв claw(англ:коготь) хлев халва халява Helvetica(англ:<a href="http://viakviak.livejournal.com/45219.html">Гельветика</a>) <b>человек</b> silver(англ:серебро) solvent(англ:растворитель) salvo(англ:залп) слава слив слива соловей сельва залив
бЛ - боль быль бл@ть ебло яблоко обло било Болгария блог булыга <a href="http://viakviak.livejournal.com/52733.html" target="_blank">Библия</a>
Лб - <a href="http://viakviak.livejournal.com/19758.html" target="_blank">голубой</a> любовь любо лоб лобок Люба Любе улыбка глубокий глобус глобальный глыба Глеб голубь гульба клуб колбаса колба колебание колобок бублик bubble(англ:пузырь)
фЛ - feel, fool(англ:глупец), fault(англ:вина,дефект), file(англ:досье), fall(англ:падать), fellow(англ:парень), flu(англ:грипп), influence фаллос фиалка fail(англ:терпеть неудачу) флаг
Лф - альфа лафа лафет life(англ:жизнь) филе flight(англ:полет) fly(англ:муха) гольф gulf(англ:залив) calf(англ:<b>теленок</b>,ср:корова) 
пЛ - поле плов пиала pile(англ:навал,куча,кипа,свая) плата пуля плевок паэлья палка полка палец Польша Пилат play(англ:играть,люфт) please(англ:пожалуйста,изволить,соблаговолить)
Лп - лапа лопата липа лопать лепить лопасть залп Альпы Липецк
</span><span viak="summary">
Компонента "ВЛ" выражает "приподнять", "волочить", "перемещать", "двигать", "владеть", "шевелящееся", "катящееся", "валящий", "развевающаяся". "В" указывает направление вверх, а "Л" показывает легкость, приподнятость, способность к перемещению.
</span><span viak="description">
ball(англ:мяч,яйцо) - катящийся
<a href="http://viakviak.livejournal.com/52733.html" target="_blank">Библия</a> - скрученная в свиток цилиндрической формы, катящаяся
bubble(англ:пузырь) - катящийся
claw(англ:коготь) - для волочения
clever(англ:умный,юркий) - шевелящий мозгами
evil(англ:зло) - овладевающее
live(англ:жить) - двигаться, владеть
love(англ:любовь) - движение души и тела, волочиться
salvo(англ:залп) - валящий, залп
silver(англ:серебро) - дающее власть
solvent(англ:растворитель) - развеять
wild(англ:дикий) - валяющийся, делающий неожиданные движения
wool(англ:шерсть) - войлок
било - двигающееся
бл@ть - с приподнятыми юбками, трясущая задом
боль - поднятие, увеличение страдания, главное зло
бублик - катящийся
Ваал - владеющий
вал - катящийся
валет - перемечающий
валять - волочочить
великан - приподнятый
великий - владеющий, поднятый, "аки-лев"
вилок - скатанный
вилы - приподнимающие
влага - протекающая вода
влагалище - влажное, текущее
Владимир Ильич Ленин - божественный владелец мира с правом на убийство> Влади-мир: ВИЛ, владеющий миром; Ленин: имеющий "право удержания"(рус:<a href="http://dictionary.law.com/Default.aspx?selected=1160" target="_blank">lien</a>); Ильич: kill(англ:убить) прочитанное наоборот, и с переходом "К - Ч".
власть - владение, ассоциируется с поднятым и развевающимся флагом.
влечение - чувство овладевающее, двигающее
влияние - владение отношениями
войлок - свалянный
вол - волочащий
волк - уволакивающий
волок - волокуша
волос - шевелящийся
воля - стремление к владению
вуаль - развевающаяся, приподнимающаяся
вульгарный - неприлично себя ведущий, двигающийся
голова - приподнятая, катящаяся
<a href="http://viakviak.livejournal.com/19758.html" target="_blank">голубой</a> - главный цвет, цвет неба
главный - головной
ебло - перемещающееся
залив - заходящая вода
клевер - шевелящийся
клюв - волочаший
лава - надвигающаяся
лоб - приподнятый, вверху
лобок - как лоб
лев - волокущий, владелец прайда, главный хищник
ловля - движение за добычей
любовь - овладевающая
обло - заставляющее отшатнуться
сельва - шевелящаяся листва, рапространяющаяся зелень
слава - поднимающая на остальными
слив - перемещение воды
человек - подвижный
улов - двигающаяся добыча
улыбка - двигающая, перемещающая мышцы лица
халява - прихваченное
хлев - помещение, место куда перемещается скот
яблоко - шевелящее листвой
</span>
';
GO

exec spAddArticle 54707, N'Компонента: МТ/МФ - окруженный, окутанный, удушающий, обмотанный, покрывающий, объединять',  N'вяк, имя, компонента, слова, смерть', N'
<span viak="component">МТ
МТ - мата(араб:умер) шахматы мать муть мыть мята метка матрёшка митральеза обмотка мотать Митрий мат матрац мытарь метан mittens(англ:рукавицы) метать комета <a href="https://ru.wikipedia.org/wiki/Митра_(головной_убор)" target="_blank">митра</a> метр мэтр материя meat(англ:мясо,мякоть,суть) мять маятник маета
ТМ - тема томить туман темень темя там тамтам томный томограф Тюмень атаман тумен том team(англ:команда,артель) тьма тумак тамга
Мд - мудрый медресе мадера мода мёд mud(англ:грязь,слякоть) middle(англ:середина) модель медь мадьяр
дМ - дом дым Дмитрий дума демпфер dome(англ:купол)
Мф - muffin(англ:кекс) муфтий миф Мефистофель муфта muff(англ:муфта) амфора Мефодий амфибия амфитеатр мафия Мемфис
Фм - fume(англ:дым) Фома famous(англ:известный) family(англ:семья) feminine(англ:женский) female(англ:матка) Фома
- Мв - move(англ:движение) омовение умывание
- вМ - вымя vomit(англ:рвота)
- - Мб - mob(англ:толпа,банда,мафия) mobile(англ:подвижный) мебель амбар амёба амбал амёба
- - Бм - объем бомба бумеранг бум бумага beam(англ:луч,балка,щирина) бомж bum(англ:бомж)
- - - Пм - помощь пума
- - - мП - ампула empale(англ:пронзать,обносить частоколом) империя emporium(англ:рынок) mop(англ:швабра,космы)
</span><span viak="summary">
Компонента МТ выражает "окруженный", "окутанный", "обмотанный", "обернутый", "покрывающий", "окружение", "обволакивать", "объединять", "окружать", "тесно", "ограниченная подвижность", "объем", "общество", "обмазанный", "липкий", "малоподвижный", "опоясанный", "признанный обществом", "известный", "огороженный", "ограниченный".
</span><span viak="description">
bum(англ:бомж) - обмазанный
dome(англ:купол) - окружающий купол, обмазанный, облепленный
empale(англ:пронзать,обносить частоколом) - огороженный, насадить на ограду
female(англ:матка) - способная стать матерью, окруженная детьми, известная в семье
family(англ:семья) - семья, закрытое общество
famous(англ:известный) - признанный обществом, известный
feminine(англ:женский) - способная стать матерью, окруженная детьми, известная в семье
fume(англ:дым) - удушающий, смертельный, обволакивающий
mobile(англ:подвижный) - маетный
mop(англ:швабра,космы) - окруженная космами
move(англ:движение) - маета
meat(англ:мясо,мякоть,суть) - обволакивает кость
middle(англ:середина) - окруженный, в середине
mittens(англ:рукавицы) - обматывающие
mob(англ:толпа,банда,мафия) - общество, мафия
mud(англ:грязь) - обмазывающая, липкая
muff(англ:муфта) - муфта, гильза, окружающая оболочка патрона
muffin(англ:кекс) - обернутый
vomit(англ:рвота) - покрывающая вокруг
амбал - малоподвижный
амбар - покрывающий
амёба - обёрнутая мембраной, малоподвижная
ампула - окруженный объем
амфибия - земно-водное, объединяет характеристики наземных и водных.
амфитеатр - окружающий театр
амфора - облепленный объем, лепка, умывара
атаман - окруженный, уважаемый, лидер общества, выбранный общиной
бомба - объемная, обернутая
бомж - обмазанный
бум - глухой, "обёрнутый" звук
бумага - обёртка
бумеранг - окружающий, кружащий, обращающийся
вымя - объемная, окруженная сосками
демпфер - глушащий, обертывающий
дом - окруженный стенами, испускающий дым. Сравни со словом "курень" - куриться.
дума - погружение в мысли; общественное собрание
дым - душащий, окружающий
emporium(англ:рынок) - огороженный
империя - объединенная
комета - окутанная, смертельная, удушающая
маета - обратное (оборотное) движение туда-сюда, в тесноте
материя - все окружающее
матрац - (мт+рц) раскутанный, развернутый 
мата(араб:умер) - удушен, не дышит
матрёшка - мать, вложенная в другие
мать - окруженная детьми, известная в семье
мафия - семья, закрытое общество
маятник - маяться, маета
мебель - малоподвижная
медь - обволакивающее
медресе - (мд+рс) разорвавший своё окружение, уединенное место, развеивающая туман разума
метан - удушающий
метка - окружающая разметка
Мефистофель - (мф+стфл/щфл/сбл) - опоясанный саблей
мёд - утомляющий, липкий
митральеза - (мт+тр+л+с) передвижная тарахтелка(система автоматической стрельбы) для прикрытия направления.
<a href="https://ru.wikipedia.org/wiki/Митра_(головной_убор)" target="_blank">митра</a> - покрывающая
Митрий - выбранный общиной
миф - свиток, обернутый
мода - популярно в окружении, обществе
модель - обмотанная
мотать - укутывать
мудрый - окруженный почетом, уважаемый в обществе
мудрец - окончивший медресе, (мд+рс) разорвавший своё окружение, уединенный, признанный обществом
муть - взвесь, не видно в окружении грязи
муфта - объединяет руки, сцепление
муфтий - объединяющая фигура, выбранный общиной, признанный обществом
мыть - чистить вокруг, кругами
мытарь - душащий за долги
мэтр - признанный обществом, мудрый
мята - удушающая, духмянная
мять - теснить
обмотка - для укутывания
объем - окруженный, обложенный, ограниченный
омовение - умывание, публичное погружение, ополаскивание
помощь - окружить заботой
смотреть - разглядывать окружающих
тема - покрывающая
темень - окружающая
темя - место кружения волос вокруг себя
том - свиток, обернутый
томить - удушать, мучить
томный - полу-удушенный
томограф - окружающий
туман - окружающий, окутывающий
тумен - тьма народу
умывание - публичное погружение, ополаскивание
Фома - признанный обществом
<a href="https://ru.wikipedia.org/wiki/Шахматы" _target="_blank">шахматы</a> - шах окружен, удушен
</span>
';
GO

exec spAddArticle 54989, N'Компонента: ГН - изогнутая, согнутый, извивающийся, гибкий, подчиненный, свернутый, выдутый, юный',
 N'вяк, закон, имя, книга, компонента, оружие, слова, тело, титул, этнос', N'
<span viak="component">ГН

ГН - гнутый изогнутый гнать гон огонь гиена каган регент гнев гной гнездо гнёт гнида гнильё гном гнус гинея Гондурас Гонконг Гиндукуш Гана Аргентина Ургенч гунны гуано вагон вагина Иоганн Геннадий гандон генерал гонг генератор
НГ - нога нега нагая нагайка ангар Негус Англия негр Нигерия награда ноготь young(англ:молодой)
кН - книга князь окно кино кон канон конь куница Каин canine(англ:собачий,клык) книксен knight(англ:всадник,кнехт) кнопка canopy(англ:навес) канд(тюрк:сахар) конституция Канада conquest(англ:завоевание) контора кантор king(англ:король) конунг Конго каннибал 
Нк - nook(англ:угол,закоулок) нектар Анкара Инки Николай наказ
хН - хан кухня Йохан
Нх - нюх нахал
ГвН - гавно Гвинея
Нвх - Навахо
жН - жена женщина жнец важный Жан 
Нж - ниже нежность нужда обнаженный нож
 - Н - Ян Иоанн
</span><span viak="summary">
Компонента "ГН" выражает "изогнутая", "согнутый", "извивающийся", "гибкий", "подчиненный", "свернутый", "выдутый", "важный", "бугор", "свитый", "юный".
</span><span viak="description">
canine(англ:собачий,клык) - волнистая линия спины собаки, изогнутый зуб
canopy(англ:навес) - изогнутый навес
conquest(англ:завоевание) - con+quest: основные правила поиска
hindu(англ:индус,индийский) - подчиненный. Представляется, что Индия - это название окраины, подчиненной области.
ink(англ:чернила) - писать вязью
king(англ:король) - важный подчиненный
knight(англ:всадник,кнехт) - важный подчиненный, из свиты, витязь
young(англ:молодой) - юный, подчиненный
nook(англ:угол,закоулок) - изогнутая линия или улица
Анкара - извилистый город
ангар - выгнутый
Англия - подчиненная
вагина - извилистая, важная, место надувания женщины
вагон - выдутый, вместительный
важный - надутый
гавно - навитое
гандон - выдуваемый
ген - изогнутая ДНК
генерал - важный подчиненный
генератор - (гн+ротор) обвивает ротор
гиена - согбенная, волнистая линия спины, собаковидная
гинея - деньги для колонии, подчиненной страны
гнать - заставлять выйти ногами
гнев - сердиться на подчиненного, подчинять негодованием
гнездо - свитое, скрученное
гнёт - подчинение
гнида - гнойный, изгибающийся
гнильё - гной, перегной
гной - выдувающийся
гном - согбенный
гнус - извивающийся, из гнили
гнутый - согнутый
гон - бег ногами
гондола - изогнутая, надутая
гонг - выгнутый
гуано - гавно
гунны - порабощенные, подчиненные
жандарм - подчиненная, вспомогательная, "юная", новая армия
жена - важная подчиненная, надувающаяся
женщина - важная подчиненная, надувающаяся
жнец - согбенный
закон - (з+кон) "узкий" кон - специализированные правила в отличии от основных правил "кона"; наказ, свиток, кон, конституция, домашние/местные правила для подчиненных (кон+каса(рус:дом,хаза))
изогнутый - выгнутый
инок - подчиненный
каган - согнутый, сгибающийся, важный подчиненный, из свиты
канд(тюрк:сахар) - колониальный товар, из подчиненной окраины
канон - основные правила подчинения, кон
кантор - подчиненный певчий
кино - гибкая и скрученная лента
книга - сгибаемая, свернутая, свиток
книксен - сгибание
кнопка - выгнутая
князь - буквально: согнутый вниз (кн + низ), подчиненный, из свиты
<a href="https://ru.wikipedia.org/wiki/Кон" target="_blank">кон</a> - свиток, подчинение устоям, основные правила, конституция
кон - основные правила подчинения, канон
конституция - буквально: кон штата
контора - буквально: подчиненная "тарахтелка"
конунг - king(англ:король), (кон+нг) важный подчиненный основному закону
конь - волнистая линия спины, изгибающий шею
куница - гибкая
кухня - угловая комната подчиненного назначения
нагайка - кнут, гибкая
нагая - гибкая, видны изгибы тела
наглость - нахальство, надувание собственной безнаказанностью
награда - дар подчиненному (читая наоборот), знак отличия "на груди"
наказ - свиток, указание подчиненным
нахал - надувшийся
нега - выгибание
негр - подчиненный
Негус - важный подчиненный
нежность - нега
нектар - пахнущий
ниже - низ
нога - сгибаемая
ноготь - выгнутый
нож - изогнутый, кривая линия режущей кромки, "обнажить нож"
нужда - заставляет подчиниться
нюх - сгибаться понюхать
обнаженный - нагой, видны изгибы тела
огонь - извивающийся, "извивающиеся языки пламени".
окно - выдутое из стекла
регент - важный подчиненный, из свиты
хан - важный подчиненный, из свиты
</span>
';
GO

exec spAddArticle 55260, N'Прямой перевод: Kill(англ:убить,зарезать) - Direct translation',  N'вяк, перевод, слова, смерть', N'
<span viak="translation">Kill(англ:убить,зарезать)
</span><span viak="summary">
Kill = кол, колоть
</span>
';
GO

exec spAddArticle 55486, N'Что в имени твоем: Купол',  N'вяк, слова', N'
<span viak="word">Купол

КПЛ - купол купля капля акапелла
ЛПК - лепка
КбЛ - кабалла Кобол
ЛбК - лобок лубок
чПЛ - chapel(англ:часовня,капелла) Чиполлино Чаплин
ЛПч - липучий
</span><span viak="summary">
Купол = лепка в церкви. Представляется, что купол строится технологически как круговая, сводчатая "лепка" или кирпичная обкладка потолка.
</span>
';
GO


exec spAddArticle 55569, N'Прямой перевод: Food stamp(англ:продовольственный талон)',  N'вяк, перевод, слова', N'
<span viak="translation">Food stamp(англ:продовольственный талон)

food - еда, продовольствие
stamp - (ст+мп = щ+мп => пмщ) помощь
</span><span viak="summary">
Food stamp(англ:продовольственный талон) = продовольственная помощь
</span>
';
GO

exec spAddArticle 56014, N'Прямой перевод: Platoon(англ:взвод,группа)',  N'вяк, перевод, слова', N'
<span viak="translation">Platoon(англ:взвод,группа)

</span><span viak="summary">
Platoon(англ:взвод,группа) = <a href="http://viakviak.livejournal.com/43385.html" target="_blank">плотный</a>, сплетённый
</span>
';
GO

exec spAddArticle 56257, N'Прямой перевод: Dance(англ:танец)',  N'вяк, перевод, слова', N'
<span viak="translation">Dance(англ:танец)

ДНС - dance(англ:танец)
СНД - сандаль sand(англ:песок)
</span><span viak="summary">
Dance(англ:танец) = танец
</span>
';
GO

exec spAddArticle 56395, N'Компонента: РЗ/РС - разрезать, раздвигать, раскрывать, делать просвет, проступать, насквозь, расти',  N'вяк, компонента, слова, тело', N'
<span viak="component">Компонента: РЗ/РС

РС - рас- роса рис раис рассвет крест просо Россия бросать trust(англ:доверие) береста просто брус парус красный красота кираса horse(англ:лошадь) корысть контраст конгресс крыса расстояние grass(англ:трава) grace(англ:грация) crust(англ:корка) верес
СР - сор срать серый суровый сирый сарынь сердце середина среда средство сарацин Саратов сорок срок сорока срака сурок Саркел сироп сарай серьга серебро 
Рц - рыцарь рцы курица крица корица
цР - царь церковь цирюльник цирк циркуль церебральный церемония
РЗ - раз- раз резать роза риза breeze(англ:ветерок) круз бразды резон разум паразит crazy(англ:псих) коррозия мороз rise(англ:восход,подъем) резвый чрезвычайный через разряд разбой
ЗР - заря зреть зрение зрачок зирвак зарок козырь хазары зря Азербайджан зерно зря позор базар лазер узурпация зирвак
Рщ = роща прыщ дрыщь 
щР - ощерить ящер пещера
Рш - решение Russia(англ:Россия) rush(англ:спешка) крошка порошок крыша 
шР - шар широкий шариат кашрут кошер shred(англ:кромсать) shark(англ:акула)
Рч - речь ручей врач арча кручина карачки Карачи Керчь курчавый парча treacherous(англ:коварный) preach(англ:проповедовать) roach(англ:таракан) reach(англ:достигать) порча torch(англ:факел) горячий
чР - чары чирей чердак чардаш череда чарка черевички червоный
</span><span viak="summary">
Компонента: РЗ/РС выражает "разрезать", "делать просвет", "раскрывать", "раздвигать", "открытие", "проступать", "проходить насквозь", "торчащий из", "расти".
</span><span viak="description">
breeze(англ:ветерок) - дующий из
crazy(англ:псих) - порежет
crust(англ:корка) - режущая кромка, раздающийся хруст
grace(англ:грация) - красота, проступающая
grass(англ:трава) - прорастающая
horse(англ:лошадь) - выскакивающая
preach(англ:проповедовать) - рассказывать
rise(англ:восход,подъем) - рассвет, восход, озарение, заря
roach(англ:таракан) - выбегающий
rush(англ:спешка) - "рассекать"
shark(англ:акула) - режущая, "резарка"
shred(англ:кромсать) - резанный
torch(англ:факел) - высвечивающий
treacherous(англ:коварный) - пронзающие
арча - верес, растение
верес - растение
врач - вырезающий
базар - раскинувшийся
береста - кора с проступающими вкраплениями
бразды - режущие, дерущие
бросать - кидать сквозь
брус - торчащий из
горячий - разожженный
гусары - режущие, разрубающие, рассыпающиеся
дрыщь - (трст)трость, тростиночка
зарок - зарубка на память
заря - рассвет, восход
зерно - прорастающее
зирвак - нарезанное мясо
зрачок - рассматривающий
зрение - рассматривание
зреть - расцвести; рассматривать
зря - соря, сор, напрасно теряя
кашрут - кашеварить
козырь - видный, выступающий, "бугор"
кираса - открывающаяся
конгресс - исходящий из канона, проявление канона, (кон+красв)красота канона
контраст - резкое различие, отход от канона
корица - растение
коррозия - проступает
корысть - вылезающая
кошер - кашевар, кашрут
красный - разрезанный до крови
красота - проступающая
крест - один брус "разрезает" другой, проходит через другой
крица - выделение из руды, creation(англ:создание)
крошка - высыпавшаяся, режущая
крыша - раскрытая
круз - выплывающий
кручина - пронзающая сердце 
крыса - выбегающая, прогрызающая
курица - срака (прочитанное наоборот), роняющая яйца
курчавый - с торчащими локонами
лазер - (л+зр)свет режет
мороз - режущий холод
паразит - ползущие к разрезу, порезу
парча - ткань с проступающей металлической нитью
парус - раскрывающийся
пещера - разрыв, открытие в земле
позор - (по+сор)путь к сору, сраму
порошок - рассыпающийся
порча - проступающая
просо - прорастающее, просеянное
просто - открывающееся совсем несложно
прыщ - выросший, выступивший
раис - выступающий, "бугор"
разбой - (раз+бой)разбивают, режут, разрывают
разряд - разрывающий, разрушающий, раздающийся
разум - рассекающий ум
рассвет - разгорающийся
расстояние - развод, раздвиг
резвый - рассекающий
резон - разумное основание
речь - исходящая
риза - разрезанная
рис - прорастающий
роса - выступающая на листве
роза - раскрывающаяся
роща - растущая
ручей - вытекающий
рцы - выскажи
рыцарь - (рц+цр) удвоение смысла: выступающий, "бугор", выскакивающий, протыкающий, режущий
сарай - открывающийся
сарацин - (СР+РЦ) - удвоение смысла СР 
<a href="https://ru.wikipedia.org/wiki/Сарынь_на_кичку" target="_blank">сарынь</a> - срань, падаль, сорынь, "сарынь на кичку"
пещера - разрыв в земле
сердце - в середине
серебро - се+ребро ребристый сыр-бор рубрика реверс zero(англ:ноль) роза цор роса сыр раис рис
середина - просвечивает между, открывается из, выходит из
серьга - просвечивающая в середине
серый - высветленный черный
сироп - вываренный
сирый - выпавший из семьи, общества
сор - выпадающий
сорок - выпавшее число
срака - место выхода
срам - срака; позор
срать - сорить, выдавливать
среда - средний день недели 
суровый - рассматривающий пристально, "разрезающий" зрачками
сурок - выглядывающий
царь - выступающий, "бугор": цезарь, кесарь, сэр, кайзер
церемония - выход
церковь - во+кресте (прочитанное наоборот), крец, крест, место выступлений. Церковь в форме креста на плане сверху, с крестом на крыше дает умножение смысла "крест".
цирк - место выступлений
циркуль - инструмент рисования на выбранном "расстоянии", дающий в итоге окружность.
цирюльник - режущий
узурпация - отодвигание прежней власти
чардаш - венгерский танец на постоялых дворах (венг:csárda) - чердаках, чертогах, квартирах.
чарка - для горячительных, горячих, горящих напитков
чары - выходящие
червоный - (чр+вн)из-вены, из разреза; (ч+рвн,к+рванный)кровяной, вырванный, разорванный; красный
чердак - чертоги, квартиры
череда - с просветами между
через - пересекающий
чирей - выскочивший
чрезвычайный - пересекающий
шар - выкатывающийся
шариат - стараться, зарок
широкий - распахнутый
ящер - разрывающий
</span>
';
GO

exec spAddArticle 56766, N'Прямой перевод: Crust(англ:корка)',  N'вяк, перевод, слова', N'
<span viak="translation">Crust(англ:корка)

</span><span viak="summary">
Crust(англ:корка) = хруст, хрустит
</span>
';
GO

exec spAddArticle 57063, N'Что в имени твоем: Дрыщь',  N'вяк, слова', N'
<span viak="word">Дрыщь

ДРЩ - дрыщь дерущийся дурища дрыщущий
ДРст - дрыстать дурость пидараст 
стРД - страда sturdy(англ:крепкий)
тРст - трость тростинка трусить trust(англ:доверие) турист
стРт - старт страта стратег стратосфера
</span><span viak="summary">
дрыщь = тростиночка, трусящийся, дурище, стартующий/начинающий, турист
</span>
';
GO

exec spAddArticle 57155, N'Префих: ЧР-/КР- - разор, разрыв, разрез, разбитый, рыцарь, разворовали, разобрали, развёрнутый',  N'вяк, дом, префих, слова, тело', N'
<span viak="prefix">ЧР-/КР-

ЧР- - червоный черный черт черта чертоги черешня чур чары чиркнуть черкануть
КР- - кровь карта красивый красный каратель картель король картофель кирпич крот крыша крошить кормить корчма курица Крым курить курень курия крупа крупный карась кривой корова корчить круглый Кир кара
КвР - квартира Каверин аквариум ковер cover(англ:крышка)
КбР - кабаре кубрик Акбар кобра кибер кобура 
хбР - хибара Хабаровск hebrew(англ:иврит,еврей)

РЗР - разор разрыв разорение разрушение разрешить razor(англ:бритва) resurrection(англ:воскресение)
РцР - рыцарь
РЗвР - разворовать разувериться разварить разврат 
РвЗР - ревизор 
РЗбР - разбор разброс разбазаривание
</span><span viak="description">
Глядя на анализ слова <a href="http://viakviak.livejournal.com/56395.html" target="_blank">Червоный</a> мы видим, что префих "чр" там очень хорошо ложится на корень "РЗР": разор-, разре-. Другие слова начинающиеся на "чр" также хорошо соответствуют своим переходам в "рзр"
</span><span viak="summary">
Префиксы "ЧР-" и "КР" выражают "разор", "разрыв", "разорение", "разрез", "разбитый", "рыцарь", "разворовали", "разобрали", "развёрнутый"
</span><span viak="description">
hebrew(англ:иврит,еврей) - еврей
аквариум - "квартира" для рыб
кабаре - квартира
кара - разорение
карась - "разресь", разреж
каратель - разоритель
карта - разрыта
картофель - "разрытвель"
картель - разоритель
квартира - чертоги, разбордюрена, разобрана на комнаты
Кир - разоритель, рыцарь, кара
кирпич - крепич разрубич; крепить разрубить
красивый - "разрисовый", разрисованный
красный - разрисованный
кривой - "разорвой", разорванный
круглый - (кр+угол)"разруглый", "разрыхлый", разрыхленный, с разбитыми углами
кобра - разоряющая
кобура - "квартира" для оружия
кормить - "разрумить", разрумянить
ковер - развёрнутый
корова - "разрёва",  ревущая
король - "разруль", "разруливающий"
корчить - "разрычить", разрушить
корчма - "разречимый", разрешенный
кровь - разрыв
крот - разрыт
крошить - разрушить
крупа - "разруба", разрубленная
крупный - "разрубный"; достаточно большой, чтобы быть разрубленным
Крым - разорим
крыша - разрушиваемая; разрешенная
кубрик - квартира
курень - курящийся дымком
курить - разорить
курия - курящая
рыцарь - разор, разоряющий, кара
хибара - квартира
чары - разоры
червоный - разорванный
черешня - (ч+ршн = к+рсн)красная, разрешенная
черный - разорный
черт - разрыт
черта - разрыта
чертоги - разодраны
чур - разори; "чур меня!" - разори меня!
</span>
';
GO


exec spAddArticle 57451, N'Что в имени твоем: Угол',  N'вяк, слова', N'
<span viak="word">Угол

ГЛ - угол уголь гулять глаз голос голый glue(англ:клей) Галя Гоголь загогулина
ЛГ - луг лягушка легкий лига
кЛ - укол кол колокол ключ киль куль кал клей кляп текила
Лк - лук лик lick(англ:лизать) лак алкать альков алкоголь палка локон
хЛ - хлюпать хлеб хлев хохол хала халва
Лх - ольха лихо лох
зЛ - зло зола зело зал узел
Лз - лаз лоза лизать
чЛ - чело человек чучело
Лч - луч лечить личина личность
</span><span viak="summary">
Слово Угол находится в смысловом поле "излучина", "изгиб", "изогнутая", "меняющий", "изменяющийся", "загогулина", "гулять", "неровный".
</span><span viak="description">
glue(англ:клей) - клей
алкать - извиваться от желания
алкоголь - (лк+гл) - удвоение смысла гулять, алкать; перегнанный через изогнутую трубку
глаз - изменяющийся, выпуклый
голый - угловатый без одежды
гулять - изгибаться при ходьбе, гнуть ноги, идти непрямо.
загогулина - гуляющая, неровная поверхность
кал - загогулина
киль - изогнутая
клей - засыхает загогулиной
кляп - неровное утолщение
куль - выпуклый
ключ - с изогнутым, неровным профилем "бородки"
кол - острый угол глядя сбоку, пробивающий дыру(рус:hole)
колокол - с изогнутым профилем
лак - клей
лягушка - лягающаяся "гнутыми" ногами
лик - кривизна черт лица
локон - изогнутые волосы, завитушка
луг - меняющийся, затапливаемый
лук - утолщающийся
текила - алкать, алкоголь
угол - излучина
укол - удар острым углом
</span>
';
GO

exec spAddArticle 57742, N'Прямой перевод: Money(англ:деньги)',  N'вяк, перевод, слова', N'
<span viak="translation">Money(англ:деньги)

МН - money(англ:деньги) moon(англ:луна) mine(англ:мой;мина) мне мина мена обман Маня манна many(англ:много) много мнуть карман кремень мандарин монтировать ремонт
НМ - немой animal(англ:животное) номер нимб
</span><span viak="summary">
Money(англ:деньги) = менять, обменивать, мне, для меня
</span><span viak="description">
many(англ:много) - много, достаточно для обмена
mine(англ:мой;мина) - мне, мое; выкапывание для обмена
moon(англ:луна) - меняющаяся; фазы луны; серебристая
money(англ:деньги) - обмениваемые
карман - (кр+мн) "разрыв мне", разорванный
манна - для меня, на обмен
мина - выкапывание для обмена
мне - для меня
много - достаточно для обмена
обман - нечестный обмен
</span>
';
GO

exec spAddArticle 57876, N'Прямой перевод: You(англ:вы)',  N'вяк, перевод, слова', N'
<span viak="translation">You(англ:вы)
</span><span viak="summary">
You(англ:вы) = <a href="http://viakviak.livejournal.com/45219.html" target="_blank">вы</a>
</span><span viak="description">
Таким образом, становится очевидно, что английский язык является натурально вежливым. Неточный перевод английского You как "ты" огрубляет и делает говорящего невежливым помимо его воли.
</span>
';
GO

exec spAddArticle 58254, N'Прямой перевод: Me(англ:мне)',  N'вяк, перевод, слова', N'
<span viak="translation">Me(англ:мне)
</span><span viak="summary">
Me(англ:мне) = Мы
</span><span viak="description">
Английское слово Me(англ:мне) хорошо соответствует русскому Мы, приблизительно так же, как You(англ:вы) и Вы. Последнее просто более употребительно. Хорошо известная фраза "Мы, Николай Второй" используемая в насмешливом тоне, тем не менее хорошо демонстрирует использование уважительного Мы как кальку английского Me(англ:мне) в смысловом значении "Я": "Я, Николай Второй".
</span>
';
GO


exec spAddArticle 58517, N'Прямой перевод: They(англ:они)',  N'вяк, перевод, слова', N'
<span viak="translation">They(англ:они)
</span><span viak="summary">
They(англ:они) = Те(rus:those)
</span><span viak="description">
Английское слово Me(англ:мне) прекрасно соответствуют русскому "Те".
</span>
';
GO

exec spAddArticle 58626, N'Прямой перевод: I(англ:я)',  N'вяк, перевод, слова', N'
<span viak="translation">Прямой перевод: I(англ:я)
</span><span viak="summary">
I(англ:я) = Я(rus:I) прочитанное наоборот
</span><span viak="description">
Английское слово I(англ:я) прочитанное наоборот полностью совпадает с русским словом Я.
</span>
';
GO

exec spAddArticle 59118, N'Что в имени твоем: Банк',  N'вяк, слова', N'
<span viak="word">Банк

БНК - банк банка banks(англ:берега реки)
КНБ - каннибал cannabis(англ:конопля)
БНч - bench(англ:скамья)
вНК - веник венок внук
КНв - конвейер конверт конвенция конвент
БНг - bang(англ:бах) бунгало бинго Бангладеш
гНБ - гнобить
пНК - пинок панк пункт пенька
КНп - конопля кнопка 
</span><span viak="summary">
Слово Банк содержит в себе компоненту "НГ/ГН", что позволяет нам отнести слово Банк к смысловому полю "подчиненный".
</span><span viak="description">
banks(англ:берега реки) - извилистые берега
bench(англ:скамья) - изогнутая, доска со спинкой
cannabis(англ:конопля) - конопля (переход Б-П)
банк - подчиненный пайщикам
банка - выпуклая
веник - гнущийся, но не ломающийся
венок - веник
внук - подчиненный
конвейер - извилистый
конвент - подчиненный
конверт - свернутый, сложенный
</span>
';
GO

exec spAddArticle 59118, N'Что в имени твоем: Банк',  N'вяк, слова', N'
<span viak="word">Банк

БНК - банк банка banks(англ:берега реки)
КНБ - каннибал cannabis(англ:конопля) knob(англ:набалдашник,кнопка,ручка,выпуклость)
БНч - bench(англ:скамья)
вНК - веник венок внук
КНв - конвейер конверт конвенция конвент know(англ:знать,уметь)
БНг - bang(англ:бах) бунгало бинго Бангладеш
гНБ - гнобить
пНК - пинок панк пункт пенька
КНп - конопля кнопка конопатить
</span><span viak="summary">
Слово Банк содержит в себе компоненту "НГ/ГН", что позволяет нам отнести слово Банк к смысловому полю подчиненный, гнутый, свёрнутый, свиток, знание.
</span><span viak="description">
banks(англ:берега реки) - извилистые берега
bench(англ:скамья) - изогнутая, доска со спинкой
cannabis(англ:конопля) - конопля (переход Б-П)
knob(англ:набалдашник,кнопка,ручка,выпуклость) - наб+алдашник, т.к. первая буква "к" не произносится
know(англ:знать,уметь) - свиток содержащий написанное знание, умение
банк - подчиненный пайщикам, know(англ:знать,уметь), свиток с долговой распиской
банка - выпуклая
веник - гнущийся, но не ломающийся
венок - веник, олицетворение знания, познания, мудрости, инициации
внук - подчиненный, young(англ:молодой)
гнобить - гнуть, сгибать
кнопка - выпуклость, knob(англ:набалдашник,кнопка,ручка,выпуклость)
конвейер - извилистый
конвент - подчиненный
конверт - свернутый, сложенный
пенька - свернутая, сплетенная
пинок - удар согнутой ногой
</span>
';
GO

exec spAddArticle 59364, N'Прямой перевод: Corrosion(англ:ржавчина) - Direct Translation',  N'вяк, перевод, слова', N'
<span viak="translation">Corrosion(англ:ржавчина)

КРЗ - corrosion(англ:ржавчина) коррозия кирза креозот корзина
ЗРК - зыркать зеркало зарок 
гРЗ - грязь гроза гюрза груз гроздь огрызок горазд
КРс - окрас крыса керосин кираса корысть карась curse(англ:проклятие,бедствие,менструация) курс карст Курск корсет
сРК - срака саркома сурок срок сорока
гРс - Герасим горсть грусть Герострат grease(англ:смазка) Greece(англ:Греция) грассировать
сРг - серьга Саргассы
Крц - корица
цРК - цирк циркуль церковь
Кврц - кварц скворец
гРц - грация Греция Гораций Герцин гарцевать
</span><span viak="summary">
Corrosion(англ:ржавчина) = грязь
</span><span viak="summary">
Слово Грязь лежит в смысловом пространстве "ненужный", "пачкающий", "окрашивающий", "покрывающий", "тяжесть", "груз", "противный"
</span><span viak="description">
corrosion(англ:ржавчина) - ржавая грязь
curse(англ:проклятие,бедствие,менструация) - грязь человеческая
grease(англ:смазка) - грязь
горазд - (опытен, ловок, искусен)достатоно испачкан, собаку съел, нахлебался
горсть - тяжесть, груз
грассировать - окрашивать речь
грация - покрашенная
гроза - делающая грязь
гроздь - груз винограда
груз(rus:cargo) - карго
грусть - тяжелые, противные мысли
грязь - земля с водой; груз земли
гюрза - грязная
карась - покрытый, окрашенный
карст - грязь
кварц - грязь
корзина - для переноса груза
кираса - покрывающая, тяжелая
кирза - КИРовский+ЗАвод; защита от грязи; <a href="http://viakviak.livejournal.com/57155.html" target="_blank">(кр+за)разреза</a>
коррозия - ржавая грязь
корсет - покрывающий, тяжелый
корысть - грязное чувство
креозот - грязь;<a href="http://viakviak.livejournal.com/57155.html" target="_blank">(кр+еозот)разрыв/разор азота,разрезать</a>
крыса - грязная тварь
курс - куда везется груз
огрызок - ненужный, грязь
окрас - окраска, покрывающий
саркома - грязная болезнь
серьга - тяжелая, покрытая
скворец - грязный
сорока - испачканная
срака - грязная
сурок - грязный
</span>
';
GO

/*

exec spAddArticle , N'',  N'', N'
';
GO

<a href="http://viakviak.livejournal.com/.html" target="_blank"></a>
<a href="" target="_blank"></a>

<span viak="component">
</span><span viak="summary">
</span><span viak="description">
</span>
*/


SELECT N'<a href="http://viakviak.livejournal.com/' + cast(LiveJournalID as nvarchar)+ N'.html">' + Title + N'</a>'
FROM dbo.Article
ORDER BY LiveJournalID DESC

-- SELECT * FROM dbo.Article
