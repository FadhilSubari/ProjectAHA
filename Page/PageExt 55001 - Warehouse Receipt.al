pageextension 55001 "Wwarehouse Receipt" extends "Warehouse Receipt"
{

    layout
    {
        // Add changes to page layout here
        modify("zone Code")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Bin Code")
        {
            Visible = false;
            ApplicationArea = all;
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Print By Fadhil")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = Print;

                Caption = 'Print';

                trigger OnAction()
                var
                    FilterPurchase: Record "Warehouse Receipt Header";
                begin
                    CurrPage.SetSelectionFilter(FilterPurchase);
                    Report.Run(Report::"Report Purchase Receipt", true, true, FilterPurchase);
                end;
            }
        }

    }

    var
        myInt: Integer;
}