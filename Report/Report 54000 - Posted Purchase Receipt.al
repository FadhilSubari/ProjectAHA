report 54000 "Report Posted Purchase Receipt"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './Report/Report 54000 - Posted Purchase Receipt.rdlc';


    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {

            PrintOnlyIfDetail = true;
            column(CompanyInformasiImage; CompanyInformasi.Picture)
            {

            }
            column(No_; "No.")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Pay_to_Name; "Pay-to Name")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(No_Code; "No.")
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
                dataitem(Vendor; Vendor)
                {
                    DataItemLink = "No." = field("Buy-from Vendor No.");
                    column(No_Vendor; "No.")
                    {

                    }
                    column(Phone_No_; "Phone No.")
                    {

                    }
                }
            }
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

}