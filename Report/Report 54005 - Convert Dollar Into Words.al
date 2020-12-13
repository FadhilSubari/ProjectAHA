report 54005 "Convert Dollar Into Words"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 54005 - Convert Dollar Into Words.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            var
                PurchaseTable: Record "Purchase Header";
            begin
                AmountVendor := Round("Purchase Header".Amount, 0.01);

                RepCheck.InitTextVariable;

                RepCheck.FormatNoText(NoText, AmountVendor, "Purchase Header"."Currency Code");

                AmountInWords := NoText[1];
            end;
        }
    }

    requestpage
    {
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

    var
        TotalPrice: Decimal;
        NoText: array[2] of Text;
        AmountInWords: Text;
        AmountVendor: Decimal;
        TotalCost: decimal;
        Nilai: Decimal;
        RepCheck: Report Check;

}