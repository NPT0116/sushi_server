Build started...
Build succeeded.
IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'36ea4c83-5df7-4daa-98ff-3d60caa2f7ca', NULL, N'User', N'USER'),
(N'50f1a885-cb85-4a39-9e35-4e26718e6fb7', NULL, N'Emp', N'EMP'),
(N'92fd13f0-ee4e-464a-95b2-d1ad0082bfe0', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241106145431_Users', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'36ea4c83-5df7-4daa-98ff-3d60caa2f7ca';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'50f1a885-cb85-4a39-9e35-4e26718e6fb7';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'92fd13f0-ee4e-464a-95b2-d1ad0082bfe0';
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'2c2d3887-e57f-4309-9e0a-bc400165953d', NULL, N'Admin', N'ADMIN'),
(N'76564bfb-c0c8-479f-aa91-3ae43bc6c009', NULL, N'Emp', N'EMP'),
(N'bba5c06b-869d-4edd-84a0-571c2afa7b38', NULL, N'User', N'USER');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241107134015_customer', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'2c2d3887-e57f-4309-9e0a-bc400165953d';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'76564bfb-c0c8-479f-aa91-3ae43bc6c009';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'bba5c06b-869d-4edd-84a0-571c2afa7b38';
SELECT @@ROWCOUNT;

GO

ALTER TABLE [AspNetUsers] ADD [CustomerId] uniqueidentifier NULL;
GO

CREATE TABLE [Customer] (
    [CustomerId] uniqueidentifier NOT NULL,
    [Name] nvarchar(100) NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,
    [Gender] int NOT NULL,
    [CitizenId] nvarchar(20) NOT NULL,
    [Phone] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([CustomerId])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'63643154-6f9f-4cca-8455-95eb482d74b7', NULL, N'User', N'USER'),
(N'ea87dbdb-367a-4958-9d39-6c94969603a4', NULL, N'Admin', N'ADMIN'),
(N'ebdd87be-2170-451c-ae0f-5987cf6d8370', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_AspNetUsers_CustomerId] ON [AspNetUsers] ([CustomerId]);
GO

ALTER TABLE [AspNetUsers] ADD CONSTRAINT [FK_AspNetUsers_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241107135049_LinkAppUserToCustomer', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [AspNetUsers] DROP CONSTRAINT [FK_AspNetUsers_Customer_CustomerId];
GO

ALTER TABLE [Customer] DROP CONSTRAINT [PK_Customer];
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'63643154-6f9f-4cca-8455-95eb482d74b7';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'ea87dbdb-367a-4958-9d39-6c94969603a4';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'ebdd87be-2170-451c-ae0f-5987cf6d8370';
SELECT @@ROWCOUNT;

GO

EXEC sp_rename N'[Customer]', N'Customers';
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'DateOfBirth');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Customers] ALTER COLUMN [DateOfBirth] datetime2 NULL;
GO

ALTER TABLE [Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY ([CustomerId]);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'1c5919fc-f5a8-4376-9b51-60f946badbb7', NULL, N'Emp', N'EMP'),
(N'540e009f-a649-4799-864a-1b87d0019124', NULL, N'User', N'USER'),
(N'c11b643c-ae67-4dd3-91a5-9a1d46e13531', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

ALTER TABLE [AspNetUsers] ADD CONSTRAINT [FK_AspNetUsers_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241107142652_constraint', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'1c5919fc-f5a8-4376-9b51-60f946badbb7';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'540e009f-a649-4799-864a-1b87d0019124';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'c11b643c-ae67-4dd3-91a5-9a1d46e13531';
SELECT @@ROWCOUNT;

GO

CREATE TABLE [Sections] (
    [SectionId] uniqueidentifier NOT NULL,
    [SectionName] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_Sections] PRIMARY KEY ([SectionId])
);
GO

CREATE TABLE [Dishes] (
    [DishId] uniqueidentifier NOT NULL,
    [DishName] nvarchar(max) NOT NULL,
    [CurrentPric] int NOT NULL,
    [SectionId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_Dishes] PRIMARY KEY ([DishId]),
    CONSTRAINT [FK_Dishes_Sections_SectionId] FOREIGN KEY ([SectionId]) REFERENCES [Sections] ([SectionId]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'9417ca04-89eb-41a4-ab9c-30096214e787', NULL, N'Emp', N'EMP'),
(N'a0312133-5a86-46cb-b589-448f7f74f2fe', NULL, N'User', N'USER'),
(N'd328656b-580e-4a2f-8ebe-cd978e542fd9', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_Dishes_SectionId] ON [Dishes] ([SectionId]);
GO

CREATE UNIQUE INDEX [IX_Sections_SectionName] ON [Sections] ([SectionName]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241108140903_AddDishAndSection', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'9417ca04-89eb-41a4-ab9c-30096214e787';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'a0312133-5a86-46cb-b589-448f7f74f2fe';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'd328656b-580e-4a2f-8ebe-cd978e542fd9';
SELECT @@ROWCOUNT;

GO

EXEC sp_rename N'[Dishes].[CurrentPric]', N'CurrentPrice', N'COLUMN';
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'1f0babb8-709b-4748-81b5-bbb882f3c2f7', NULL, N'Admin', N'ADMIN'),
(N'a6007636-8569-4d3a-bec7-ddb386de1a50', NULL, N'User', N'USER'),
(N'e935b6af-6203-49d1-9a8d-b908239de557', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241108141540_FixCurrentPrice', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'1f0babb8-709b-4748-81b5-bbb882f3c2f7';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'a6007636-8569-4d3a-bec7-ddb386de1a50';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'e935b6af-6203-49d1-9a8d-b908239de557';
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'580c0605-d836-419e-a088-9e517ab5c099', NULL, N'Admin', N'ADMIN'),
(N'7a4c8686-f411-4a4a-a1fd-1e4e55ae4530', NULL, N'User', N'USER'),
(N'7f06f141-2bca-42d7-8d40-1189de6a4e83', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241109080814_BranchAndBranchDish', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'580c0605-d836-419e-a088-9e517ab5c099';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'7a4c8686-f411-4a4a-a1fd-1e4e55ae4530';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'7f06f141-2bca-42d7-8d40-1189de6a4e83';
SELECT @@ROWCOUNT;

GO

CREATE TABLE [Branches] (
    [BranchId] uniqueidentifier NOT NULL,
    [ManagerId] uniqueidentifier NULL,
    [Name] nvarchar(100) NOT NULL,
    [Address] nvarchar(200) NOT NULL,
    [Phone] nvarchar(max) NOT NULL,
    [OpeningTime] time NOT NULL,
    [ClosingTime] time NOT NULL,
    [CarParking] bit NOT NULL,
    [MotorParking] bit NOT NULL,
    [Ship] bit NOT NULL,
    [TotalTable] int NOT NULL,
    CONSTRAINT [PK_Branches] PRIMARY KEY ([BranchId])
);
GO

CREATE TABLE [BranchDishes] (
    [BranchDishId] uniqueidentifier NOT NULL,
    [BranchId] uniqueidentifier NOT NULL,
    [DishId] uniqueidentifier NOT NULL,
    [Status] bit NOT NULL,
    [ShipStatus] bit NOT NULL,
    CONSTRAINT [PK_BranchDishes] PRIMARY KEY ([BranchDishId]),
    CONSTRAINT [FK_BranchDishes_Branches_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [Branches] ([BranchId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BranchDishes_Dishes_DishId] FOREIGN KEY ([DishId]) REFERENCES [Dishes] ([DishId]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'9e9938d1-c78f-42fe-b6ea-f71ab813f728', NULL, N'User', N'USER'),
(N'a496f010-5123-422f-be16-93d54b142407', NULL, N'Emp', N'EMP'),
(N'b0ee1b20-509a-4661-baa2-df421a596f87', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_BranchDishes_BranchId] ON [BranchDishes] ([BranchId]);
GO

CREATE INDEX [IX_BranchDishes_DishId] ON [BranchDishes] ([DishId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241109080954_BranchAndBranchDishMigration', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'9e9938d1-c78f-42fe-b6ea-f71ab813f728';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'a496f010-5123-422f-be16-93d54b142407';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'b0ee1b20-509a-4661-baa2-df421a596f87';
SELECT @@ROWCOUNT;

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

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'5133e80b-fde6-4dcd-bcaf-d22600b825c9', NULL, N'Admin', N'ADMIN'),
(N'702d2f8a-a71f-4677-88af-23bd5a9edcb9', NULL, N'Emp', N'EMP'),
(N'fd0448de-ac4c-4ac2-ac24-508fb30736b0', NULL, N'User', N'USER');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE UNIQUE INDEX [IX_TableDetail_BranchId_TableNumber] ON [TableDetail] ([BranchId], [TableNumber]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241110082916_tableDetail', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'5133e80b-fde6-4dcd-bcaf-d22600b825c9';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'702d2f8a-a71f-4677-88af-23bd5a9edcb9';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'fd0448de-ac4c-4ac2-ac24-508fb30736b0';
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'0dda79cd-6b23-4be3-9522-bdda21965433', NULL, N'User', N'USER'),
(N'72810a97-9e9f-44a3-9562-169c742dd4f6', NULL, N'Admin', N'ADMIN'),
(N'7538076f-c72b-48ea-b091-78f86aadd9d3', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241110083022_tableDetails', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'0dda79cd-6b23-4be3-9522-bdda21965433';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'72810a97-9e9f-44a3-9562-169c742dd4f6';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'7538076f-c72b-48ea-b091-78f86aadd9d3';
SELECT @@ROWCOUNT;

GO

CREATE TABLE [Departments] (
    [DepartmentId] uniqueidentifier NOT NULL,
    [DepartmentName] nvarchar(max) NOT NULL,
    [BaseSalary] int NOT NULL,
    CONSTRAINT [PK_Departments] PRIMARY KEY ([DepartmentId])
);
GO

CREATE TABLE [Employees] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    [Dob] datetime2 NOT NULL,
    [Gender] nvarchar(max) NOT NULL,
    [Salary] int NOT NULL,
    [StartDate] datetime2 NOT NULL,
    [ResignedDate] datetime2 NULL,
    [DepartmentId] uniqueidentifier NOT NULL,
    [BranchId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Employees_Branches_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [Branches] ([BranchId]) ON DELETE CASCADE,
    CONSTRAINT [FK_Employees_Departments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Departments] ([DepartmentId]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'13585a1a-ed81-404c-9943-4e1caaf679e7', NULL, N'Admin', N'ADMIN'),
(N'9f20e900-fd9c-4f81-b94f-32c5f1f8502b', NULL, N'User', N'USER'),
(N'd8acd0e8-c3aa-4429-ae28-64d7d87a6dc1', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_Employees_BranchId] ON [Employees] ([BranchId]);
GO

CREATE INDEX [IX_Employees_DepartmentId] ON [Employees] ([DepartmentId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241113133635_addEmployeesAndDepartment', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'13585a1a-ed81-404c-9943-4e1caaf679e7';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'9f20e900-fd9c-4f81-b94f-32c5f1f8502b';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'd8acd0e8-c3aa-4429-ae28-64d7d87a6dc1';
SELECT @@ROWCOUNT;

GO

CREATE TABLE [Rankings] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [RequirePoint] int NOT NULL,
    [Discount] int NOT NULL,
    [UpgradePoint] int NOT NULL,
    CONSTRAINT [PK_Rankings] PRIMARY KEY ([Id])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'392fb7a8-a965-4233-b9d9-974d16d6ff6d', NULL, N'Emp', N'EMP'),
(N'cfbcde85-9a95-4b27-b1d4-19c640d99852', NULL, N'User', N'USER'),
(N'ea3c3bae-cd36-4694-886e-0a404a110518', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241113161017_ranking', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'392fb7a8-a965-4233-b9d9-974d16d6ff6d';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'cfbcde85-9a95-4b27-b1d4-19c640d99852';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'ea3c3bae-cd36-4694-886e-0a404a110518';
SELECT @@ROWCOUNT;

GO

CREATE TABLE [Cards] (
    [Id] int NOT NULL IDENTITY,
    [StartDate] datetime2 NOT NULL,
    [AccumulatedPoints] real NOT NULL,
    [Valid] bit NOT NULL,
    [AccumulatedDate] datetime2 NULL,
    [EmployeeId] uniqueidentifier NOT NULL,
    [RankingId] int NOT NULL,
    [CustomerId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_Cards] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Cards_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cards_Employees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [Employees] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cards_Rankings_RankingId] FOREIGN KEY ([RankingId]) REFERENCES [Rankings] ([Id]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'0f55e95e-cf01-490a-9832-c20a22379fd5', NULL, N'User', N'USER'),
(N'38565780-3c05-47ec-9730-9bd31c36c07d', NULL, N'Emp', N'EMP'),
(N'ad416dd5-6060-4abe-a23f-a7d2ae92f31d', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_Cards_CustomerId] ON [Cards] ([CustomerId]);
GO

CREATE INDEX [IX_Cards_EmployeeId] ON [Cards] ([EmployeeId]);
GO

CREATE INDEX [IX_Cards_RankingId] ON [Cards] ([RankingId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241113161630_Cards', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Cards] DROP CONSTRAINT [PK_Cards];
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'0f55e95e-cf01-490a-9832-c20a22379fd5';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'38565780-3c05-47ec-9730-9bd31c36c07d';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'ad416dd5-6060-4abe-a23f-a7d2ae92f31d';
SELECT @@ROWCOUNT;

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cards]') AND [c].[name] = N'Id');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Cards] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Cards] DROP COLUMN [Id];
GO

ALTER TABLE [Cards] ADD [CardId] uniqueidentifier NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000';
GO

ALTER TABLE [Cards] ADD CONSTRAINT [PK_Cards] PRIMARY KEY ([CardId]);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'40c61aee-8179-49b6-b207-599d465f292a', NULL, N'User', N'USER'),
(N'569f11a5-1136-4fea-b974-619d8aecf3af', NULL, N'Admin', N'ADMIN'),
(N'fae804d7-3b4a-443e-826a-bbdc4f19d14a', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241113161830_CardsID', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [TableDetail] DROP CONSTRAINT [FK_TableDetail_Branches_BranchId];
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'40c61aee-8179-49b6-b207-599d465f292a';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'569f11a5-1136-4fea-b974-619d8aecf3af';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'fae804d7-3b4a-443e-826a-bbdc4f19d14a';
SELECT @@ROWCOUNT;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TableDetail]') AND [c].[name] = N'MaxPeople');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [TableDetail] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [TableDetail] DROP COLUMN [MaxPeople];
GO

EXEC sp_rename N'[TableDetail].[TableId]', N'Id', N'COLUMN';
GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TableDetail]') AND [c].[name] = N'Status');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [TableDetail] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [TableDetail] ALTER COLUMN [Status] int NOT NULL;
GO

ALTER TABLE [TableDetail] ADD [MaxCapacity] bigint NOT NULL DEFAULT CAST(0 AS bigint);
GO

CREATE TABLE [Reservation] (
    [Id] uniqueidentifier NOT NULL,
    [DatedOn] datetime2 NOT NULL,
    [Note] nvarchar(max) NULL,
    [Status] int NOT NULL,
    [OrderedBy] uniqueidentifier NOT NULL,
    [CustomerId] uniqueidentifier NOT NULL,
    [BranchId] uniqueidentifier NOT NULL,
    [OrderId] uniqueidentifier NOT NULL,
    [TableId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_Reservation] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Reservation_TableDetail_TableId] FOREIGN KEY ([TableId]) REFERENCES [TableDetail] ([Id]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'0f8e6e15-3443-4649-a8be-7325cdaeabe1', NULL, N'Admin', N'ADMIN'),
(N'1c91f521-4c03-4698-b210-268d9b4fffb1', NULL, N'User', N'USER'),
(N'89f4b167-b4ee-4444-9e9a-51bc5d594d74', NULL, N'Emp', N'EMP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE INDEX [IX_Reservation_TableId] ON [Reservation] ([TableId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241126125832_InitialCreate', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DROP INDEX [IX_TableDetail_BranchId_TableNumber] ON [TableDetail];
GO

DROP INDEX [IX_Sections_SectionName] ON [Sections];
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'0f8e6e15-3443-4649-a8be-7325cdaeabe1';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'1c91f521-4c03-4698-b210-268d9b4fffb1';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'89f4b167-b4ee-4444-9e9a-51bc5d594d74';
SELECT @@ROWCOUNT;

GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Reservation]') AND [c].[name] = N'OrderId');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Reservation] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [Reservation] DROP COLUMN [OrderId];
GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Sections]') AND [c].[name] = N'SectionName');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Sections] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [Sections] ALTER COLUMN [SectionName] nvarchar(max) NOT NULL;
GO

ALTER TABLE [Reservation] ADD [TotalPeople] int NOT NULL DEFAULT 0;
GO

CREATE TABLE [Orders] (
    [Id] uniqueidentifier NOT NULL,
    [Total] bigint NOT NULL,
    [LastModified] datetime2 NULL,
    [Status] int NOT NULL,
    [ReservationId] uniqueidentifier NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Orders_Reservation_ReservationId] FOREIGN KEY ([ReservationId]) REFERENCES [Reservation] ([Id])
);
GO

CREATE TABLE [Invoices] (
    [Id] int NOT NULL IDENTITY,
    [Total] bigint NOT NULL,
    [PaymentMethod] nvarchar(max) NOT NULL,
    [AfterDiscount] int NOT NULL,
    [BonusPoint] int NOT NULL,
    [Paid] bit NOT NULL,
    [DatedOn] datetime2 NOT NULL,
    [OrderId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_Invoices] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Invoices_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([Id]) ON DELETE CASCADE
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

CREATE INDEX [IX_Invoices_OrderId] ON [Invoices] ([OrderId]);
GO

CREATE INDEX [IX_OrderDetail_OrderId] ON [OrderDetail] ([OrderId]);
GO

CREATE INDEX [IX_Orders_ReservationId] ON [Orders] ([ReservationId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241127055422_fix_reservation', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Sections]') AND [c].[name] = N'SectionName');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Sections] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [Sections] ALTER COLUMN [SectionName] nvarchar(450) NOT NULL;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'55b6fb40-8723-4e68-b26a-db64593bf9e1', NULL, N'Emp', N'EMP'),
(N'b56c0bd5-777e-40f2-a50b-01dd84ba208c', NULL, N'User', N'USER'),
(N'e5c60ce4-77a8-4e86-8f04-91fc0d7dd143', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

CREATE UNIQUE INDEX [IX_TableDetail_BranchId_TableNumber] ON [TableDetail] ([BranchId], [TableNumber]);
GO

CREATE UNIQUE INDEX [IX_Sections_SectionName] ON [Sections] ([SectionName]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241127133622_seed_role', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'55b6fb40-8723-4e68-b26a-db64593bf9e1';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'b56c0bd5-777e-40f2-a50b-01dd84ba208c';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'e5c60ce4-77a8-4e86-8f04-91fc0d7dd143';
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'5696c690-61c2-4ce7-83e2-da2e03cc49ff', NULL, N'User', N'USER'),
(N'6eaddb63-1825-45cc-aed4-c7af1057c70d', NULL, N'Emp', N'EMP'),
(N'9f7594c4-6315-4277-a07e-2b2a7a60f9f9', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241127134040_AddIdentityRoles', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DROP INDEX [IX_TableDetail_BranchId_TableNumber] ON [TableDetail];
GO

DROP INDEX [IX_Sections_SectionName] ON [Sections];
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'5696c690-61c2-4ce7-83e2-da2e03cc49ff';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'6eaddb63-1825-45cc-aed4-c7af1057c70d';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'9f7594c4-6315-4277-a07e-2b2a7a60f9f9';
SELECT @@ROWCOUNT;

GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Sections]') AND [c].[name] = N'SectionName');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Sections] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [Sections] ALTER COLUMN [SectionName] nvarchar(max) NOT NULL;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'4f908d11-bc1e-4206-95fa-570c4b2a778d', NULL, N'User', N'USER'),
(N'7a626b0c-4a95-405f-9aba-de4c18d64ae4', NULL, N'Emp', N'EMP'),
(N'9c521b64-3987-4b15-9300-5699d3928106', NULL, N'Admin', N'ADMIN');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241127134900_SeedRoles', N'8.0.10');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'4f908d11-bc1e-4206-95fa-570c4b2a778d';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'7a626b0c-4a95-405f-9aba-de4c18d64ae4';
SELECT @@ROWCOUNT;

GO

DELETE FROM [AspNetRoles]
WHERE [Id] = N'9c521b64-3987-4b15-9300-5699d3928106';
SELECT @@ROWCOUNT;

GO

DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Orders]') AND [c].[name] = N'LastModified');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [Orders] DROP CONSTRAINT [' + @var8 + '];');
UPDATE [Orders] SET [LastModified] = '0001-01-01T00:00:00.0000000' WHERE [LastModified] IS NULL;
ALTER TABLE [Orders] ALTER COLUMN [LastModified] datetime2 NOT NULL;
ALTER TABLE [Orders] ADD DEFAULT '0001-01-01T00:00:00.0000000' FOR [LastModified];
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'5cee2967-7fd3-4bf8-bdb1-ddb1a10a965c', NULL, N'Emp', N'EMP'),
(N'7840cf38-8777-4205-93f2-8bc62c4a23ec', NULL, N'Admin', N'ADMIN'),
(N'baffa4d9-bcc1-425d-9111-dc3063efd198', NULL, N'User', N'USER');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241128113917_latest', N'8.0.10');
GO

COMMIT;
GO


