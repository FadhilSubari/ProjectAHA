pageextension 55004 "Ext Transport Plan" extends "Warehouse Shipment"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Print Non Covercial Invoice")
            {
                Promoted = true;
                Image = PrintDocument;
                PromotedCategory = Category4;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Message('hellow');
                end;
            }
        }
    }

    var
        myInt: Integer;
}