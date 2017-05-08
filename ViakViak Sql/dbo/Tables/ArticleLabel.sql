CREATE TABLE [dbo].[ArticleLabel] (
    [ArticleLabelID] INT      IDENTITY (1, 1) NOT NULL,
    [ArticleID]      INT      NOT NULL,
    [LabelID]        INT      NOT NULL,
    [CreateOn]       DATETIME DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ArticleLabel] PRIMARY KEY CLUSTERED ([ArticleLabelID] ASC),
    CONSTRAINT [FK_ArticleLabel_Article] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Article] ([ArticleID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_ArticleLabel_Label] FOREIGN KEY ([LabelID]) REFERENCES [dbo].[Label] ([LabelID]) ON DELETE CASCADE ON UPDATE CASCADE
);

