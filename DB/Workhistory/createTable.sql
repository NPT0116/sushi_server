CREATE TABLE WorkHistory (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    EmployeeId UNIQUEIDENTIFIER NOT NULL,
    BranchId UNIQUEIDENTIFIER NOT NULL,
    StartDate DATE NOT NULL,
    ResignDate DATE NOT NULL,
    DepartmentId UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_WorkHistory_Employees_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employees(Id) ON DELETE NO ACTION,
    CONSTRAINT FK_WorkHistory_Branches_BranchId FOREIGN KEY (BranchId) REFERENCES Branches(BranchId) ON DELETE NO ACTION,
    CONSTRAINT FK_WorkHistory_Departments_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId) ON DELETE NO ACTION
);