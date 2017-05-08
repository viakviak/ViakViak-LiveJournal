CREATE TABLE [dbo].[ArticleWord] (
    [ArticleWordID] INT      IDENTITY (1, 1) NOT NULL,
    [ArticleID]     INT      NOT NULL,
    [WordID]        INT      NOT NULL,
    [CreateOn]      DATETIME DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ArticleWord] PRIMARY KEY CLUSTERED ([ArticleWordID] ASC),
    CONSTRAINT [FK_ArticleWord_Article] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Article] ([ArticleID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_ArticleWord_Word] FOREIGN KEY ([WordID]) REFERENCES [dbo].[Word] ([WordID]) ON DELETE CASCADE ON UPDATE CASCADE
);

