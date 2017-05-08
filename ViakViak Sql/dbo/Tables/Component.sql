CREATE TABLE [dbo].[Component] (
    [ComponentID]   INT             IDENTITY (1, 1) NOT NULL,
    [ComponentName] NVARCHAR (128)  NOT NULL,
    [LanguageID]    INT             DEFAULT ((1)) NULL,
    [Description]   NVARCHAR (4000) NULL,
    [IsPrefix]      BIT             DEFAULT ((0)) NOT NULL,
    [CreateOn]      DATETIME        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Component] PRIMARY KEY CLUSTERED ([ComponentID] ASC),
    CONSTRAINT [FK_Component_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageID])
);

