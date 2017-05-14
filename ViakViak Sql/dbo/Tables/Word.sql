CREATE TABLE [dbo].[Word] (
    [WordID]      INT             IDENTITY (1, 1) NOT NULL,
    [WordName]    NVARCHAR (128)  NOT NULL,
    [LanguageID]  INT             DEFAULT ((1)) NULL,
    [RootID]      INT             NULL,
    [IsName]      BIT             DEFAULT ((0)) NOT NULL,
    [Description] NVARCHAR (4000) NULL,
    [CreateOn]    DATETIME        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Word] PRIMARY KEY CLUSTERED ([WordID] ASC),
    CONSTRAINT [FK_Word_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageID]),
    CONSTRAINT [FK_Word_Root] FOREIGN KEY ([RootID]) REFERENCES [dbo].[Root] ([RootID])
);



