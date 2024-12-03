

create or alter proc submitSurvey
@invoiceId UNIQUEIDENTIFIER,
@point INT,
@comment NVARCHAR(100)
AS
BEGIN
     if not exists ( select 1 from Invoices where Id = @invoiceId)
    BEGIN
        RAISERROR('khong tim thay invoice', 16,1 );
        RETURN;
    END

    INSERT INTO Surveys (Id, InvoiceId, Point, Comment)
    VALUES (NEWID(), @InvoiceId, @Point, @Comment);
END

