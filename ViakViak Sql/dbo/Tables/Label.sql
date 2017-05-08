CREATE TABLE [dbo].[Label] (
    [LabelID]     INT             IDENTITY (1, 1) NOT NULL,
    [LabelName]   NVARCHAR (50)   NOT NULL,
    [LanguageID]  INT             DEFAULT ((1)) NULL,
    [Description] NVARCHAR (4000) NULL,
    [CreateOn]    DATETIME        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Label] PRIMARY KEY CLUSTERED ([LabelID] ASC)
);

