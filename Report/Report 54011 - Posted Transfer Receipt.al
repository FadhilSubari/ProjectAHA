report 54011 "Posted Transfer Receipt"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 54011 - Posted Transfer Receipt.rdlc';

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            column(No_; "No.") { }
            column(CompanyInformasiPicture; CompanyInformasi.Picture) { }
            column(Transfer_from_Name; "Transfer-from Name") { }
            column(Transfer_from_Name_2; "Transfer-from Name 2") { }
            column(Transfer_from_Address; "Transfer-from Address") { }
            column(Transfer_from_Address_2; "Transfer-from Address 2") { }
            column(Posting_Date; "Posting Date") { }
            column(Transport_Method; "Transport Method") { }
            column(Phone; _Phone) { }
            column(Phone2; _Phone2) { }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Item_No_; "Item No.") { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
            }
            trigger OnAfterGetRecord()
            var
                RecLocation: Record Location;
            begin
                RecLocation.Reset;
                RecLocation.SetRange("Code", "Transfer-from Code");
                if RecLocation.FindFirst() then begin
                    _Phone := RecLocation."Phone No.";
                    _phone2 := RecLocation."Phone No. 2";
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformasi.get;
        CompanyInformasi.CalcFields(Picture)
    end;

    var
        CompanyInformasi: Record "Company Information";
        _Phone: text;
        _Phone2: Text;
}