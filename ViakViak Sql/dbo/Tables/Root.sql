CREATE TABLE [dbo].[Root] (
    [RootID]      INT             IDENTITY (1, 1) NOT NULL,
    [RootName]    NVARCHAR (12)   NULL,
    [LanguageID]  INT             DEFAULT ((1)) NULL,
    [Description] NVARCHAR (4000) NULL,
    [CreateOn]    DATETIME        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Root] PRIMARY KEY CLUSTERED ([RootID] ASC),
    CONSTRAINT [FK_Root_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageID])
);

