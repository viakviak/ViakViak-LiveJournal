CREATE TABLE [dbo].[Article] (
    [ArticleID]     INT            IDENTITY (1, 1) NOT NULL,
    [LiveJournalID] INT            NULL,
    [Title]         NVARCHAR (256) NULL,
    [Content]       NVARCHAR (MAX) NULL,
    [CreateOn]      DATETIME       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED ([ArticleID] ASC)
);

