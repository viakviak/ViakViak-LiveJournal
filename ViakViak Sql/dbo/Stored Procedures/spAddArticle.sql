
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
