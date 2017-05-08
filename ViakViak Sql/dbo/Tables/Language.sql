CREATE TABLE [dbo].[Language] (
    [LanguageID]   INT             IDENTITY (1, 1) NOT NULL,
    [LanguageName] NVARCHAR (50)   NOT NULL,
    [Description]  NVARCHAR (4000) NULL,
    [CreateOn]     DATETIME        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED ([LanguageID] ASC)
);

