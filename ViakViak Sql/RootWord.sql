CREATE TABLE [dbo].[RootWord]
(
	[RootWordID] INT NOT NULL PRIMARY KEY, 
    [RootID] INT NOT NULL, 
    [WordID] INT NOT NULL, 
    [CreateOn] DATETIME NOT NULL DEFAULT getdate(), 
    CONSTRAINT [FK_RootWord_ToRoot] FOREIGN KEY (RootID) REFERENCES [Root](RootID), 
    CONSTRAINT [FK_RootWord_ToWord] FOREIGN KEY (WordID) REFERENCES Word(WordID)
)
