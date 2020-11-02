report 54004 "Report Stock Release Order"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    RDLCLayout = './Report/Report 54004 - Stock Release Order.rdlc';

    dataset
    {
        dataitem("Stock Release Header"; "Stock Release Header")
        {
            column(CompanyInformasiImage; CompanyInformasi.Picture)
            {

            }
            column(CustomerData; CardLocation.Name)
            {

            }
            column(No_; "No.")
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Ship_to_Client_No_; "Ship-to Client No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            dataitem("Stock Release Line"; "Stock Release Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Unit_Cost__LCY_; "Unit Cost (LCY)")
                {

                }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                {

                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {

                }
            }
            trigger OnAfterGetRecord()

            begin

                CustomerData.SetRange("No.", "Ship-to Client No.");
                CustomerData.FindFirst();
                if CustomerData.FindFirst() then begin
                    CardLocation.SetRange("Code", CustomerData."Location Code");
                    CardLocation.FindFirst();
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
        CompanyInformasi.CalcFields(Picture);

    end;

    var
        CompanyInformasi: Record "Company Information";
        CustomerData: Record Customer;
        stockRelease: Record "Stock Release Header";
        CardLocation: Record Location;


}