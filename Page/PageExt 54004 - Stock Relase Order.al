pageextension 54004 "Ext Stock Release Order" extends "Stock Release Order"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addbefore("Request Approval")
        {
            action("Print")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                var
                    filterStock: record "Stock Release Header";
                begin
                    CurrPage.SetSelectionFilter(filterStock);
                    Report.Run(Report::"Report Stock Release Order", true, true, filterStock);
                end;
            }
        }
    }
    var
        myInt: Integer;
}