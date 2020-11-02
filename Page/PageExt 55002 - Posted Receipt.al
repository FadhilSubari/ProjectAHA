pageextension 55002 "Ext Posted Received" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        modify("Buy-from Contact No.")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Buy-from Address 2")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("No. Printed")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Quote No.")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Vendor Order No.")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Purchaser Code")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Responsibility Center")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Order Address Code")
        {
            Visible = false;
            ApplicationArea = all;
        }
    }

    actions
    {

        // Add changes to page actions here
        addbefore("&Receipt")
        {
            group(Process)
            {
                action("Print By Fadhil")
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        FilterHeader: Record "Purch. Rcpt. Header";
                    begin
                        CurrPage.SetSelectionFilter(FilterHeader);
                        Report.Run(Report::"Report Posted Purchase Receipt", true, true, FilterHeader);
                    end;
                }

            }
        }
        modify(PrintGRN)
        {
            Visible = true;
        }
    }

    var
        myInt: Integer;
}