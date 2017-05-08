CREATE TABLE [dbo].[ComponentWord] (
    [ComponentWordID] INT      IDENTITY (1, 1) NOT NULL,
    [ComponentID]     INT      NOT NULL,
    [WordID]          INT      NOT NULL,
    [CreateOn]        DATETIME DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ComponentWord] PRIMARY KEY CLUSTERED ([ComponentWordID] ASC),
    CONSTRAINT [FK_ComponentWord_Component] FOREIGN KEY ([ComponentID]) REFERENCES [dbo].[Component] ([ComponentID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_ComponentWord_Word] FOREIGN KEY ([WordID]) REFERENCES [dbo].[Word] ([WordID]) ON DELETE CASCADE ON UPDATE CASCADE
);

