GO
create DATABASE sushiDB
go
use sushiDb
go


GO
 CREATE TABLE [dbo].[Branches] (
    [BranchId]     UNIQUEIDENTIFIER NOT NULL,
    [ManagerId]    UNIQUEIDENTIFIER NULL,
    [Name]         NVARCHAR (100)   NOT NULL,
    [Address]      NVARCHAR (200)   NOT NULL,
    [Phone]        NVARCHAR (30)   NOT NULL,
    [OpeningTime]  TIME (7)         NOT NULL,
    [ClosingTime]  TIME (7)         NOT NULL,
    [CarParking]   BIT              NOT NULL,
    [MotorParking] BIT              NOT NULL,
    [Ship]         BIT              NOT NULL,
    [TotalTable]   INT              NOT NULL,
    CONSTRAINT [PK_Branches] PRIMARY KEY CLUSTERED ([BranchId] ASC)
);
go
GO

CREATE TABLE [TableDetail] (
    [TableId] uniqueidentifier NOT NULL,
    [BranchId] uniqueidentifier NOT NULL,
    [TableNumber] int NOT NULL,
    [MaxPeople] int NOT NULL,
    [Status] bit NOT NULL,
    CONSTRAINT [PK_TableDetail] PRIMARY KEY ([TableId]),
    CONSTRAINT [FK_TableDetail_Branches_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [Branches] ([BranchId]) ON DELETE CASCADE
);
GO

CREATE TABLE [dbo].[Sections] (
    [SectionId]   UNIQUEIDENTIFIER NOT NULL,
    [SectionName] NVARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED ([SectionId] ASC)
);
go

CREATE TABLE [dbo].[Dishes] (
    [DishId]       UNIQUEIDENTIFIER NOT NULL,
    [DishName]     NVARCHAR (50)   NOT NULL,
    [CurrentPrice] INT              NOT NULL,
    [SectionId]    UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Dishes] PRIMARY KEY CLUSTERED ([DishId] ASC),
    CONSTRAINT [FK_Dishes_Sections_SectionId] FOREIGN KEY ([SectionId]) REFERENCES [dbo].[Sections] ([SectionId]) 
);

go

CREATE TABLE [dbo].[BranchDishes] (
    [BranchDishId] UNIQUEIDENTIFIER NOT NULL,
    [BranchId]     UNIQUEIDENTIFIER NOT NULL,
    [DishId]       UNIQUEIDENTIFIER NOT NULL,
    [Status]       BIT              NOT NULL,
    [ShipStatus]   BIT              NOT NULL,
    CONSTRAINT [PK_BranchDishes] PRIMARY KEY CLUSTERED ([BranchDishId] ASC),
    CONSTRAINT [FK_BranchDishes_Branches_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branches] ([BranchId]) ,
    CONSTRAINT [FK_BranchDishes_Dishes_DishId] FOREIGN KEY ([DishId]) REFERENCES [dbo].[Dishes] ([DishId]) 
);

go

CREATE TABLE [dbo].[Departments] (
    [DepartmentId]   UNIQUEIDENTIFIER NOT NULL,
    [DepartmentName] NVARCHAR (50)   NOT NULL,
    [BaseSalary]     INT              NOT NULL,
    CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
);

go

CREATE TABLE [dbo].[Customers] (
    [CustomerId]  UNIQUEIDENTIFIER NOT NULL,
    [Name]        NVARCHAR (100)   NOT NULL,
    [DateOfBirth] DATETIME2 (7)    NULL,
    [Gender]      INT              NOT NULL,
    [CitizenId]   NVARCHAR (20)    NOT NULL ,
    [Phone]       NVARCHAR (50)   NOT NULL ,
    [Email]       NVARCHAR (50)   NOT NULL ,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerId] ASC)
);
go

CREATE TABLE [dbo].[Employees] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [Name]         NVARCHAR (MAX)   NOT NULL,
    [Dob]          DATETIME2 (7)    NOT NULL,
    [Gender]       NVARCHAR (MAX)   NOT NULL,
    [Salary]       INT              NOT NULL,
    [StartDate]    DATETIME2 (7)    NOT NULL,
    [ResignedDate] DATETIME2 (7)    NULL,
    [DepartmentId] UNIQUEIDENTIFIER NOT NULL,
    [BranchId]     UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Employees_Branches_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branches] ([BranchId]) ,
    CONSTRAINT [FK_Employees_Departments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Departments] ([DepartmentId]) 

);
go

--add fk to branches for managerId
alter table branches add CONSTRAINT [FK_Branches_Employees_ManagerId] FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employees] (Id)
go
CREATE TABLE [dbo].[WorkHistory] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [EmployeeId]   UNIQUEIDENTIFIER NOT NULL,
    [BranchId]     UNIQUEIDENTIFIER NOT NULL,
    [StartDate]    DATE             NOT NULL,
    [ResignDate]   DATE              NULL,
    [DepartmentId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_WorkHistory] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_WorkHistory_Branches_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branches] ([BranchId]) ,
    CONSTRAINT [FK_WorkHistory_Departments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Departments] ([DepartmentId]) ,
    CONSTRAINT [FK_WorkHistory_Employees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employees] ([Id])
);
go

CREATE TABLE [dbo].[Rankings] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (MAX) NOT NULL,
    [RequirePoint] INT            NOT NULL,
    [Discount]     INT            NOT NULL,
    [UpgradePoint] INT            NOT NULL,
    CONSTRAINT [PK_Rankings] PRIMARY KEY CLUSTERED ([Id] ASC)
);

go

CREATE TABLE [dbo].[Cards] (
    [StartDate]         DATETIME2 (7)    NOT NULL,
    [AccumulatedPoints] REAL             NOT NULL,
    [Valid]             BIT              NOT NULL,
    [AccumulatedDate]   DATETIME2 (7)    NULL,
    [EmployeeId]        UNIQUEIDENTIFIER NOT NULL,
    [RankingId]         INT              NOT NULL,
    [CustomerId]        UNIQUEIDENTIFIER NOT NULL,
    [CardId]            UNIQUEIDENTIFIER  NOT NULL,
    CONSTRAINT [PK_Cards] PRIMARY KEY CLUSTERED ([CardId] ASC),
    CONSTRAINT [FK_Cards_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId]) ,
    CONSTRAINT [FK_Cards_Employees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employees] ([Id]) ,
    CONSTRAINT [FK_Cards_Rankings_RankingId] FOREIGN KEY ([RankingId]) REFERENCES [dbo].[Rankings] ([Id]) 
);
go

CREATE TABLE [dbo].[Reservation] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [DatedOn]     DATETIME2 (7)    NOT NULL,
    [Note]        NVARCHAR (MAX)   NULL,
    [Status]      INT              NOT NULL,
    [OrderedBy]   UNIQUEIDENTIFIER NULL,
    [CustomerId]  UNIQUEIDENTIFIER NOT NULL,
    [BranchId]    UNIQUEIDENTIFIER NOT NULL,
    [TableId]     UNIQUEIDENTIFIER ,
    [TotalPeople] INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Reservation_TableDetail_TableId] FOREIGN KEY ([TableId]) REFERENCES [dbo].[TableDetail] ([TableId]),
    CONSTRAINT [FK_Reservation_Branch_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branches] ([BranchId]),
    CONSTRAINT [FK_Reservation_Employee_OrderedBy] FOREIGN KEY ([OrderedBy]) REFERENCES [dbo].[Employees] ([Id])
);


go

CREATE TABLE [dbo].[Orders] (
    [Id]            UNIQUEIDENTIFIER NOT NULL,
    [Total]         BIGINT           NOT NULL,
    [LastModified]  DATETIME2 (7)    DEFAULT ('0001-01-01T00:00:00.0000000') NOT NULL,
    [Status]        INT              NOT NULL,
    [ReservationId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Orders_Reservation_ReservationId] FOREIGN KEY ([ReservationId]) REFERENCES [dbo].[Reservation] ([Id])
);


GO

CREATE TABLE [OrderDetail] (
    [Id] uniqueidentifier NOT NULL,
    [Status] int NOT NULL,
    [Price] bigint NOT NULL,
    [Quantity] bigint NOT NULL,
    [DishId] uniqueidentifier NOT NULL,
    [OrderId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_OrderDetail] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_OrderDetail_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([Id]) ON DELETE CASCADE
);
GO
go

    CREATE TABLE [dbo].[Invoices] (
    [Id]            UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Total]         BIGINT           NOT NULL,
    [PaymentMethod] NVARCHAR (10)   NOT NULL,
    [AfterDiscount] INT              NOT NULL,
    [BonusPoint]    INT              NOT NULL,
    [Paid]          BIT              NOT NULL,
    [DatedOn]       DATETIME2 (7)    NOT NULL,
    [OrderId]       UNIQUEIDENTIFIER NOT NULL,
    [BranchId]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Invoices_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([Id]) ,
    CONSTRAINT [FK_Invoices_Branch_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branches] ([BranchId]) 
);
GO

CREATE TABLE [dbo].[Surveys] (
    [Id]        UNIQUEIDENTIFIER NOT NULL,
    [InvoiceId] UNIQUEIDENTIFIER NOT NULL,
    [Point]     INT              NOT NULL,
    [Comment]   NVARCHAR (MAX)   NOT NULL,
    CONSTRAINT [PK_Surveys] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Surveys_Invoices_InvoiceId] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoices] ([Id])
);

go
CREATE TABLE [dbo].[AccessHistories] (
    [Id]         UNIQUEIDENTIFIER NOT NULL,
    [CustomerId] UNIQUEIDENTIFIER NOT NULL,
    [AccessTime] DATETIME2 (7)    NOT NULL,
    [Duration]   INT              NOT NULL,
    CONSTRAINT [PK_AccessHistories] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AccessHistories_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId])
);

CREATE TABLE Account (
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),  -- Automatically generate GUIDs
    CustomerId UNIQUEIDENTIFIER,
    EmployeeId UNIQUEIDENTIFIER,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(20) NOT NULL,
    Role varchar(10) NOT NULL,
    CONSTRAINT PK_Account PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_Account_Customer_CustomerId FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId),
    CONSTRAINT FK_Account_Employee_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employees (Id)
);


