report 53316 "Report Daily Sales"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 53316 - Report Daily Sales.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_1; "No.") { }
            column(Amount1; Amount) { }
            column(DateTo1; DateTo1) { }
            column(FromDate; FromDate) { }
            column(Quartal; Quartal) { }
            column(Month_1; Month_1) { }
            column(Month_2; Month_2) { }
            column(Month_3; Month_3) { }
            column(MountSO_1; MountSO_1) { }
            column(MountSO_2; MountSO_2) { }
            column(MountSO_3; MountSO_3) { }

            trigger OnPreDataItem()
            begin
                if (Quartal = 0) OR (FilterYear = 0) then begin
                    Error('Fill not be Empty');
                end else begin
                    if (Quartal = 1) OR (Quartal = 2) OR (Quartal = 3) OR (Quartal = 4) then begin
                        Quartal := Quartal;
                    end else begin
                        Error('Fill must "1 or 2 or 3 or 4"');
                    end;
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                MountSO_1 := 0;
                MountSO_2 := 0;
                MountSO_3 := 0;
                RecSO.Reset;
                RecSO.SetRange("Document Type", "Document Type"::"Order");
                RecSO.SetRange("Order Date", Month_1, CalcDate('3M-1D', Month_1));
                if RecSO.FindFirst() then begin
                    repeat
                        if ("Order Date" >= Month_1) AND ("Order Date" <= CalcDate('CM', Month_1)) then begin
                            MountSO_1 := Amount;
                        end;
                        if ("Order Date" >= Month_2) AND ("Order Date" <= CalcDate('CM', Month_2)) then begin
                            MountSO_2 := Amount;
                        end;
                        if ("Order Date" >= Month_3) AND ("Order Date" <= CalcDate('CM', Month_3)) then begin
                            MountSO_3 := Amount;
                        end;
                    until RecSO.Next = 0;
                end;
            end;
        }
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            column(PSI1_1; PSI1_1) { }
            column(PSI1_2; PSI1_2) { }
            column(PSI1_3; PSI1_3) { }
            column(PSI1_4; PSI1_4) { }
            column(PSI1_5; PSI1_5) { }
            column(PSI2_1; PSI2_1) { }
            column(PSI2_2; PSI2_2) { }
            column(PSI2_3; PSI2_3) { }
            column(PSI2_4; PSI2_4) { }
            column(PSI2_5; PSI2_5) { }
            column(PSI3_1; PSI3_1) { }
            column(PSI3_2; PSI3_2) { }
            column(PSI3_3; PSI3_3) { }
            column(PSI3_4; PSI3_4) { }
            column(PSI3_5; PSI3_5) { }
            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                PSI1_1 := 0;
                PSI1_2 := 0;
                PSI1_3 := 0;
                PSI1_4 := 0;
                PSI1_5 := 0;
                PSI2_1 := 0;
                PSI2_2 := 0;
                PSI2_3 := 0;
                PSI2_4 := 0;
                PSI2_5 := 0;
                PSI3_1 := 0;
                PSI3_2 := 0;
                PSI3_3 := 0;
                PSI3_4 := 0;
                PSI3_5 := 0;
                SetRange("Shipment Date", Month_1, CalcDate('3M-1D', Month_1));
                if ("Shipment Date" >= Month_1) AND ("Shipment Date" <= CalcDate('CM', Month_1)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        PSI1_1 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        PSI1_2 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        PSI1_3 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        PSI1_4 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        PSI1_5 := "Sales Invoice Line".Amount;
                end;
                if ("Shipment Date" >= Month_2) AND ("Shipment Date" <= CalcDate('CM', Month_2)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        PSI2_1 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        PSI2_2 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        PSI2_3 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        PSI2_4 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        PSI2_5 := "Sales Invoice Line".Amount;
                end;
                if ("Shipment Date" >= Month_3) AND ("Shipment Date" <= CalcDate('CM', Month_3)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        PSI3_1 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        PSI3_2 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        PSI3_3 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        PSI3_4 := "Sales Invoice Line".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        PSI3_5 := "Sales Invoice Line".Amount;
                end;
            end;
        }
        dataitem("Sales Line SO"; "Sales Line")
        {
            column(Document_No_Sales_Line_SO; "Document No.") { }
            column(SO1_1; SO1_1) { }
            column(SO1_2; SO1_2) { }
            column(SO1_3; SO1_3) { }
            column(SO1_4; SO1_4) { }
            column(SO1_5; SO1_5) { }
            column(SO2_1; SO2_1) { }
            column(SO2_2; SO2_2) { }
            column(SO2_3; SO2_3) { }
            column(SO2_4; SO2_4) { }
            column(SO2_5; SO2_5) { }
            column(SO3_1; SO3_1) { }
            column(SO3_2; SO3_2) { }
            column(SO3_3; SO3_3) { }
            column(SO3_4; SO3_4) { }
            column(SO3_5; SO3_5) { }
            trigger OnPreDataItem()
            begin
                SetRange("Shipment Date", Month_1, CalcDate('3M-1D', Month_1));
                SetRange("Document Type", "Document Type"::"Order");
            end;

            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                SO1_1 := 0;
                SO1_2 := 0;
                SO1_3 := 0;
                SO1_4 := 0;
                SO1_5 := 0;
                SO2_1 := 0;
                SO2_2 := 0;
                SO2_3 := 0;
                SO2_4 := 0;
                SO2_5 := 0;
                SO3_1 := 0;
                SO3_2 := 0;
                SO3_3 := 0;
                SO3_4 := 0;
                SO3_5 := 0;
                if ("Shipment Date" >= Month_1) AND ("Shipment Date" <= CalcDate('CM', Month_1)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SO1_1 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SO1_2 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SO1_3 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SO1_4 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SO1_5 := "Sales Line SO".Amount;
                end else begin

                end;
                if ("Shipment Date" >= Month_2) AND ("Shipment Date" <= CalcDate('CM', Month_2)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SO2_1 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SO2_2 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SO2_3 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SO2_4 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SO2_5 := "Sales Line SO".Amount;
                end;
                if ("Shipment Date" >= Month_3) AND ("Shipment Date" <= CalcDate('CM', Month_3)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SO3_1 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SO3_2 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SO3_3 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SO3_4 := "Sales Line SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SO3_5 := "Sales Line SO".Amount;
                end;
            end;
        }
        dataitem("Sales Line SQ"; "Sales Line")
        {
            column(SQ1_1; SQ1_1) { }
            column(SQ1_2; SQ1_2) { }
            column(SQ1_3; SQ1_3) { }
            column(SQ1_4; SQ1_4) { }
            column(SQ1_5; SQ1_5) { }
            column(SQ2_1; SQ2_1) { }
            column(SQ2_2; SQ2_2) { }
            column(SQ2_3; SQ2_3) { }
            column(SQ2_4; SQ2_4) { }
            column(SQ2_5; SQ2_5) { }
            column(SQ3_1; SQ3_1) { }
            column(SQ3_2; SQ3_2) { }
            column(SQ3_3; SQ3_3) { }
            column(SQ3_4; SQ3_4) { }
            column(SQ3_5; SQ3_5) { }
            trigger OnPreDataItem()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                SetRange("Shipment Date", Month_1, CalcDate('3M-1D', Month_1));
                SetRange("Document Type", "Document Type"::"Quote");
            end;

            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                SQ1_1 := 0;
                SQ1_2 := 0;
                SQ1_3 := 0;
                SQ1_4 := 0;
                SQ1_5 := 0;
                SQ2_1 := 0;
                SQ2_2 := 0;
                SQ2_3 := 0;
                SQ2_4 := 0;
                SQ2_5 := 0;
                SQ3_1 := 0;
                SQ3_2 := 0;
                SQ3_3 := 0;
                SQ3_4 := 0;
                SQ3_5 := 0;
                if ("Shipment Date" >= Month_1) AND ("Shipment Date" <= CalcDate('CM', Month_1)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SQ1_1 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SQ1_2 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SQ1_3 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SQ1_4 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SQ1_5 := "Sales Line SQ".Amount;
                end;
                if ("Shipment Date" >= Month_2) AND ("Shipment Date" <= CalcDate('CM', Month_2)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SQ2_1 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SQ2_2 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SQ2_3 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SQ2_4 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SQ2_5 := "Sales Line SQ".Amount;
                end;
                if ("Shipment Date" >= Month_3) AND ("Shipment Date" <= CalcDate('CM', Month_3)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SQ3_1 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SQ3_2 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SQ3_3 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SQ3_4 := "Sales Line SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SQ3_5 := "Sales Line SQ".Amount;
                end;
            end;
        }

        dataitem("Sales Line Old SO"; "Sales Line")
        {
            column(SOOLD1_1; SOOLD1_1) { }
            column(SOOLD1_2; SOOLD1_2) { }
            column(SOOLD1_3; SOOLD1_3) { }
            column(SOOLD1_4; SOOLD1_4) { }
            column(SOOLD1_5; SOOLD1_5) { }
            column(SOOLD2_1; SOOLD2_1) { }
            column(SOOLD2_2; SOOLD2_2) { }
            column(SOOLD2_3; SOOLD2_3) { }
            column(SOOLD2_4; SOOLD2_4) { }
            column(SOOLD2_5; SOOLD2_5) { }
            column(SOOLD3_1; SOOLD3_1) { }
            column(SOOLD3_2; SOOLD3_2) { }
            column(SOOLD3_3; SOOLD3_3) { }
            column(SOOLD3_4; SOOLD3_4) { }
            column(SOOLD3_5; SOOLD3_5) { }
            column(OldYear; OldYear) { }
            trigger OnPreDataItem()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                OldYear := CalcDate('-1Y', Month_1);
                OldYear2 := CalcDate('-1Y', Month_2);
                OldYear3 := CalcDate('-1Y', Month_3);
                SetRange("Shipment Date", OldYear, CalcDate('3M-1D', OldYear));
                SetRange("Document Type", "Document Type"::"Order");
            end;

            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                OldYear := CalcDate('-1Y', Month_1);
                OldYear2 := CalcDate('-1Y', Month_2);
                OldYear3 := CalcDate('-1Y', Month_3);
                SOOLD1_1 := 0;
                SOOLD1_2 := 0;
                SOOLD1_3 := 0;
                SOOLD1_4 := 0;
                SOOLD1_5 := 0;
                SOOLD2_1 := 0;
                SOOLD2_2 := 0;
                SOOLD2_3 := 0;
                SOOLD2_4 := 0;
                SOOLD2_5 := 0;
                SOOLD3_1 := 0;
                SOOLD3_2 := 0;
                SOOLD3_3 := 0;
                SOOLD3_4 := 0;
                SOOLD3_5 := 0;
                if ("Shipment Date" >= OldYear) AND ("Shipment Date" <= CalcDate('CM', OldYear)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SOOLD1_1 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SOOLD1_2 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SOOLD1_3 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SOOLD1_4 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SOOLD1_5 := "Sales Line Old SO".Amount;
                end;
                if ("Shipment Date" >= OldYear2) AND ("Shipment Date" <= CalcDate('CM', OldYear2)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SOOLD2_1 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SOOLD2_2 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SOOLD2_3 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SOOLD2_4 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SOOLD2_5 := "Sales Line Old SO".Amount;
                end;
                if ("Shipment Date" >= OldYear3) AND ("Shipment Date" <= CalcDate('CM', OldYear3)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SOOLD3_1 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SOOLD3_2 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SOOLD3_3 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SOOLD3_4 := "Sales Line Old SO".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SOOLD3_5 := "Sales Line Old SO".Amount;
                end;
            end;
        }
        dataitem("Sales Invoice Line Old"; "Sales Invoice Line")
        {
            column(PSIOLD1_1; PSIOLD1_1) { }
            column(PSIOLD1_2; PSIOLD1_2) { }
            column(PSIOLD1_3; PSIOLD1_3) { }
            column(PSIOLD1_4; PSIOLD1_4) { }
            column(PSIOLD1_5; PSIOLD1_5) { }
            column(PSIOLD2_1; PSIOLD2_1) { }
            column(PSIOLD2_2; PSIOLD2_2) { }
            column(PSIOLD2_3; PSIOLD2_3) { }
            column(PSIOLD2_4; PSIOLD2_4) { }
            column(PSIOLD2_5; PSIOLD2_5) { }
            column(PSIOLD3_1; PSIOLD3_1) { }
            column(PSIOLD3_2; PSIOLD3_2) { }
            column(PSIOLD3_3; PSIOLD3_3) { }
            column(PSIOLD3_4; PSIOLD3_4) { }
            column(PSIOLD3_5; PSIOLD3_5) { }
            trigger OnPreDataItem()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                OldYear := CalcDate('-1Y', Month_1);
                OldYear2 := CalcDate('-1Y', Month_2);
                OldYear3 := CalcDate('-1Y', Month_3);
                SetRange("Shipment Date", OldYear, CalcDate('3M-1D', OldYear));
            end;

            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                OldYear := CalcDate('-1Y', Month_1);
                OldYear2 := CalcDate('-1Y', Month_2);
                OldYear3 := CalcDate('-1Y', Month_3);
                PSIOLD1_1 := 0;
                PSIOLD1_2 := 0;
                PSIOLD1_3 := 0;
                PSIOLD1_4 := 0;
                PSIOLD1_5 := 0;
                PSIOLD2_1 := 0;
                PSIOLD2_2 := 0;
                PSIOLD2_3 := 0;
                PSIOLD2_4 := 0;
                PSIOLD2_5 := 0;
                PSIOLD3_1 := 0;
                PSIOLD3_2 := 0;
                PSIOLD3_3 := 0;
                PSIOLD3_4 := 0;
                PSIOLD3_5 := 0;
                if ("Shipment Date" >= OldYear) AND ("Shipment Date" <= CalcDate('CM', OldYear)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        PSIOLD1_1 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        PSIOLD1_2 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        PSIOLD1_3 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        PSIOLD1_4 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        PSIOLD1_5 := "Sales Invoice Line Old".Amount;
                end;
                if ("Shipment Date" >= OldYear2) AND ("Shipment Date" <= CalcDate('CM', OldYear2)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        PSIOLD2_1 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        PSIOLD2_2 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        PSIOLD2_3 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        PSIOLD2_4 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        PSIOLD2_5 := "Sales Invoice Line Old".Amount;
                end;
                if ("Shipment Date" >= OldYear3) AND ("Shipment Date" <= CalcDate('CM', OldYear3)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        PSIOLD3_1 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        PSIOLD3_2 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        PSIOLD3_3 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        PSIOLD3_4 := "Sales Invoice Line Old".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        PSIOLD3_5 := "Sales Invoice Line Old".Amount;
                end;
            end;
        }
        dataitem("Sales Line Old SQ"; "Sales Line")
        {
            column(SQOLD1_1; SQOLD1_1) { }
            column(SQOLD1_2; SQOLD1_2) { }
            column(SQOLD1_3; SQOLD1_3) { }
            column(SQOLD1_4; SQOLD1_4) { }
            column(SQOLD1_5; SQOLD1_5) { }
            column(SQOLD2_1; SQOLD2_1) { }
            column(SQOLD2_2; SQOLD2_2) { }
            column(SQOLD2_3; SQOLD2_3) { }
            column(SQOLD2_4; SQOLD2_4) { }
            column(SQOLD2_5; SQOLD2_5) { }
            column(SQOLD3_1; SQOLD3_1) { }
            column(SQOLD3_2; SQOLD3_2) { }
            column(SQOLD3_3; SQOLD3_3) { }
            column(SQOLD3_4; SQOLD3_4) { }
            column(SQOLD3_5; SQOLD3_5) { }
            trigger OnPreDataItem()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                OldYear := CalcDate('-1Y', Month_1);
                OldYear2 := CalcDate('-1Y', Month_2);
                OldYear3 := CalcDate('-1Y', Month_3);
                SetRange("Shipment Date", OldYear, CalcDate('3M-1D', OldYear));
                SetRange("Document Type", "Document Type"::Quote);
            end;

            trigger OnAfterGetRecord()
            begin
                Month_1 := _Month1();
                Month_2 := _Month2();
                Month_3 := _Month3();
                OldYear := CalcDate('-1Y', Month_1);
                OldYear2 := CalcDate('-1Y', Month_2);
                OldYear3 := CalcDate('-1Y', Month_3);
                SQOLD1_1 := 0;
                SQOLD1_2 := 0;
                SQOLD1_3 := 0;
                SQOLD1_4 := 0;
                SQOLD1_5 := 0;
                SQOLD2_1 := 0;
                SQOLD2_2 := 0;
                SQOLD2_3 := 0;
                SQOLD2_4 := 0;
                SQOLD2_5 := 0;
                SQOLD3_1 := 0;
                SQOLD3_2 := 0;
                SQOLD3_3 := 0;
                SQOLD3_4 := 0;
                SQOLD3_5 := 0;
                if ("Shipment Date" >= OldYear) AND ("Shipment Date" <= CalcDate('CM', OldYear)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SQOLD1_1 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SQOLD1_2 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SQOLD1_3 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SQOLD1_4 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SQOLD1_5 := "Sales Line Old SQ".Amount;
                end;
                if ("Shipment Date" >= OldYear2) AND ("Shipment Date" <= CalcDate('CM', OldYear2)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SQOLD2_1 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SQOLD2_2 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SQOLD2_3 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SQOLD2_4 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SQOLD2_5 := "Sales Line Old SQ".Amount;
                end;
                if ("Shipment Date" >= OldYear3) AND ("Shipment Date" <= CalcDate('CM', OldYear3)) then begin
                    if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                        SQOLD3_1 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                        SQOLD3_2 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                        SQOLD3_3 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                        SQOLD3_4 := "Sales Line Old SQ".Amount;
                    if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                        SQOLD3_5 := "Sales Line Old SQ".Amount;
                end;

            end;
        }
        dataitem("Sales Invoice Line YTD"; "Sales Invoice Line")
        {
            column(PSIYTD1_1; PSIYTD1_1) { }
            column(PSIYTD1_2; PSIYTD1_2) { }
            column(PSIYTD1_3; PSIYTD1_3) { }
            column(PSIYTD1_4; PSIYTD1_4) { }
            column(PSIYTD1_5; PSIYTD1_5) { }
            trigger OnPreDataItem()
            begin
                if Quartal = 1 then begin
                    FromDate := _getQ1();
                    SetRange("Shipment Date", FromDate, CalcDate('3M-1D', FromDate));
                end;
                if Quartal = 2 then begin
                    FromDate := _getQ2();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                end;
                if Quartal = 3 then begin
                    FromDate := _getQ3();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                end;
                if Quartal = 4 then begin
                    FromDate := _getQ4();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                PSIYTD1_1 := 0;
                PSIYTD1_2 := 0;
                PSIYTD1_3 := 0;
                PSIYTD1_4 := 0;
                PSIYTD1_5 := 0;
                if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                    PSIYTD1_1 := "Sales Invoice Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                    PSIYTD1_2 := "Sales Invoice Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                    PSIYTD1_3 := "Sales Invoice Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                    PSIYTD1_4 := "Sales Invoice Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                    PSIYTD1_5 := "Sales Invoice Line YTD".Amount;
            end;
        }

        dataitem("Sales Line YTD"; "Sales Line")
        {
            column(SOYTD1_1; SOYTD1_1) { }
            column(SOYTD1_2; SOYTD1_2) { }
            column(SOYTD1_3; SOYTD1_3) { }
            column(SOYTD1_4; SOYTD1_4) { }
            column(SOYTD1_5; SOYTD1_5) { }
            trigger OnPreDataItem()
            begin
                if Quartal = 1 then begin
                    FromDate := _getQ1();
                    SetRange("Shipment Date", FromDate, CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
                if Quartal = 2 then begin
                    FromDate := _getQ2();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
                if Quartal = 3 then begin
                    FromDate := _getQ3();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
                if Quartal = 4 then begin
                    FromDate := _getQ4();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                SOYTD1_1 := 0;
                SOYTD1_2 := 0;
                SOYTD1_3 := 0;
                SOYTD1_4 := 0;
                SOYTD1_5 := 0;
                if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                    SOYTD1_1 := "Sales Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                    SOYTD1_2 := "Sales Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                    SOYTD1_3 := "Sales Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                    SOYTD1_4 := "Sales Line YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                    SOYTD1_5 := "Sales Line YTD".Amount;
            end;
        }
        dataitem("Sales Line SQ YTD"; "Sales Line")
        {
            column(SQYTD1_1; SQYTD1_1) { }
            column(SQYTD1_2; SQYTD1_2) { }
            column(SQYTD1_3; SQYTD1_3) { }
            column(SQYTD1_4; SQYTD1_4) { }
            column(SQYTD1_5; SQYTD1_5) { }
            trigger OnPreDataItem()
            begin
                if Quartal = 1 then begin
                    FromDate := _getQ1();
                    SetRange("Shipment Date", FromDate, CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::Quote);
                end;
                if Quartal = 2 then begin
                    FromDate := _getQ2();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::Quote);
                end;
                if Quartal = 3 then begin
                    FromDate := _getQ3();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::Quote);
                end;
                if Quartal = 4 then begin
                    FromDate := _getQ4();
                    SetRange("Shipment Date", _getQ1(), CalcDate('3M-1D', FromDate));
                    SetRange("Document Type", "Document Type"::Quote);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                SQYTD1_1 := 0;
                SQYTD1_2 := 0;
                SQYTD1_3 := 0;
                SQYTD1_4 := 0;
                SQYTD1_5 := 0;
                if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                    SQYTD1_1 := "Sales Line SQ YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                    SQYTD1_2 := "Sales Line SQ YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                    SQYTD1_3 := "Sales Line SQ YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                    SQYTD1_4 := "Sales Line SQ YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                    SQYTD1_5 := "Sales Line SQ YTD".Amount;
            end;
        }

        dataitem("Sales Invoice OLD YTD"; "Sales Invoice Line")
        {
            column(PSIOLDYTD1_1; PSIOLDYTD1_1) { }
            column(PSIOLDYTD1_2; PSIOLDYTD1_2) { }
            column(PSIOLDYTD1_3; PSIOLDYTD1_3) { }
            column(PSIOLDYTD1_4; PSIOLDYTD1_4) { }
            column(PSIOLDYTD1_5; PSIOLDYTD1_5) { }
            trigger OnPreDataItem()
            begin
                if Quartal = 1 then begin
                    FromDate := _getQ1();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', FromDate), CalcDate('-1Y', Year1));
                end;
                if Quartal = 2 then begin
                    FromDate := _getQ2();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                end;
                if Quartal = 3 then begin
                    FromDate := _getQ3();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                end;
                if Quartal = 4 then begin
                    FromDate := _getQ4();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                PSIOLDYTD1_1 := 0;
                PSIOLDYTD1_2 := 0;
                PSIOLDYTD1_3 := 0;
                PSIOLDYTD1_4 := 0;
                PSIOLDYTD1_5 := 0;
                if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                    PSIOLDYTD1_1 := "Sales Invoice OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                    PSIOLDYTD1_2 := "Sales Invoice OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                    PSIOLDYTD1_3 := "Sales Invoice OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                    PSIOLDYTD1_4 := "Sales Invoice OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                    PSIOLDYTD1_5 := "Sales Invoice OLD YTD".Amount;
            end;
        }
        dataitem("Sales Line OLD YTD"; "Sales Line")
        {
            column(SOOLDYTD1_1; SOOLDYTD1_1) { }
            column(SOOLDYTD1_2; SOOLDYTD1_2) { }
            column(SOOLDYTD1_3; SOOLDYTD1_3) { }
            column(SOOLDYTD1_4; SOOLDYTD1_4) { }
            column(SOOLDYTD1_5; SOOLDYTD1_5) { }
            trigger OnPreDataItem()
            begin
                if Quartal = 1 then begin
                    FromDate := _getQ1();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', FromDate), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
                if Quartal = 2 then begin
                    FromDate := _getQ2();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
                if Quartal = 3 then begin
                    FromDate := _getQ3();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
                if Quartal = 4 then begin
                    FromDate := _getQ4();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Order");
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                SOOLDYTD1_1 := 0;
                SOOLDYTD1_2 := 0;
                SOOLDYTD1_3 := 0;
                SOOLDYTD1_4 := 0;
                SOOLDYTD1_5 := 0;
                if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                    SOOLDYTD1_1 := "Sales Line OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                    SOOLDYTD1_2 := "Sales Line OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                    SOOLDYTD1_3 := "Sales Line OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                    SOOLDYTD1_4 := "Sales Line OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                    SOOLDYTD1_5 := "Sales Line OLD YTD".Amount;
            end;
        }
        dataitem("Sales Line SQ OLD YTD"; "Sales Line")
        {
            column(SQOLDYTD1_1; SQOLDYTD1_1) { }
            column(SQOLDYTD1_2; SQOLDYTD1_2) { }
            column(SQOLDYTD1_3; SQOLDYTD1_3) { }
            column(SQOLDYTD1_4; SQOLDYTD1_4) { }
            column(SQOLDYTD1_5; SQOLDYTD1_5) { }
            trigger OnPreDataItem()
            begin
                if Quartal = 1 then begin
                    FromDate := _getQ1();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', FromDate), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Quote");
                end;
                if Quartal = 2 then begin
                    FromDate := _getQ2();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Quote");
                end;
                if Quartal = 3 then begin
                    FromDate := _getQ3();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Quote");
                end;
                if Quartal = 4 then begin
                    FromDate := _getQ4();
                    Year1 := CalcDate('3M-1D', FromDate);
                    SetRange("Shipment Date", CalcDate('-1Y', _getQ1()), CalcDate('-1Y', Year1));
                    SetRange("Document Type", "Document Type"::"Quote");
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                SQOLDYTD1_1 := 0;
                SQOLDYTD1_2 := 0;
                SQOLDYTD1_3 := 0;
                SQOLDYTD1_4 := 0;
                SQOLDYTD1_5 := 0;
                if ("Shortcut Dimension 2 Code" = 'INSTRUMENT') or ("Shortcut Dimension 2 Code" = '') then
                    SQOLDYTD1_1 := "Sales Line SQ OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'CHEMISTRY') then
                    SQOLDYTD1_2 := "Sales Line SQ OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'SERVICE') then
                    SQOLDYTD1_3 := "Sales Line SQ OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'INFORMATIC') then
                    SQOLDYTD1_4 := "Sales Line SQ OLD YTD".Amount;
                if ("Shortcut Dimension 2 Code" = 'LOCAL-SUPP') then
                    SQOLDYTD1_5 := "Sales Line SQ OLD YTD".Amount;
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
                group("Filter Daily Sales")
                {
                    field(FilterYear; FilterYear)
                    {
                        Caption = 'Filter Tahun';
                        ApplicationArea = All;
                    }
                }
                group("Quartal Filter")
                {
                    field(Quartal; Quartal)
                    {
                        Caption = 'Quartal';
                        ApplicationArea = All;
                    }
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
        // SO VARIABLE
        RecSO: Record "Sales Header";
        OldYear: date;
        OldYear2: date;
        OldYear3: date;
        Year1: date;
        Year2: date;
        Year3: date;
        MountSO: Decimal;
        MountSO_1: Decimal;
        MountSO_2: Decimal;
        MountSO_3: Decimal;
        SO1_1: Decimal;
        SO1_2: Decimal;
        SO1_3: Decimal;
        SO1_4: Decimal;
        SO1_5: Decimal;
        SO2_1: Decimal;
        SO2_2: Decimal;
        SO2_3: Decimal;
        SO2_4: Decimal;
        SO2_5: Decimal;
        SO3_1: Decimal;
        SO3_2: Decimal;
        SO3_3: Decimal;
        SO3_4: Decimal;
        SO3_5: Decimal;
        nilai1: Decimal;
        nilai2: Decimal;
        nilai3: Decimal;
        // SQ VARIABLE
        MountSQ: Decimal;
        MountSQ_1: Decimal;
        MountSQ_2: Decimal;
        MountSQ_3: Decimal;
        SQ1_1: Decimal;
        SQ1_2: Decimal;
        SQ1_3: Decimal;
        SQ1_4: Decimal;
        SQ1_5: Decimal;
        SQ2_1: Decimal;
        SQ2_2: Decimal;
        SQ2_3: Decimal;
        SQ2_4: Decimal;
        SQ2_5: Decimal;
        SQ3_1: Decimal;
        SQ3_2: Decimal;
        SQ3_3: Decimal;
        SQ3_4: Decimal;
        SQ3_5: Decimal;
        // PSI VARIABLE 
        MountPSI: Decimal;
        MountPSI_1: Decimal;
        MountPSI_2: Decimal;
        MountPSI_3: Decimal;
        PSI1_1: Decimal;
        PSI1_2: Decimal;
        PSI1_3: Decimal;
        PSI1_4: Decimal;
        PSI1_5: Decimal;
        PSI2_1: Decimal;
        PSI2_2: Decimal;
        PSI2_3: Decimal;
        PSI2_4: Decimal;
        PSI2_5: Decimal;
        PSI3_1: Decimal;
        PSI3_2: Decimal;
        PSI3_3: Decimal;
        PSI3_4: Decimal;
        PSI3_5: Decimal;
        PSIOLDYTD1_1: Decimal;
        PSIOLDYTD1_2: Decimal;
        PSIOLDYTD1_3: Decimal;
        PSIOLDYTD1_4: Decimal;
        PSIOLDYTD1_5: Decimal;
        SOOLDYTD1_1: Decimal;
        SOOLDYTD1_2: Decimal;
        SOOLDYTD1_3: Decimal;
        SOOLDYTD1_4: Decimal;
        SOOLDYTD1_5: Decimal;
        SQOLDYTD1_1: Decimal;
        SQOLDYTD1_2: Decimal;
        SQOLDYTD1_3: Decimal;
        SQOLDYTD1_4: Decimal;
        SQOLDYTD1_5: Decimal;
        PSIYTD1_1: Decimal;
        PSIYTD1_2: Decimal;
        PSIYTD1_3: Decimal;
        PSIYTD1_4: Decimal;
        PSIYTD1_5: Decimal;
        SOYTD1_1: Decimal;
        SOYTD1_2: Decimal;
        SOYTD1_3: Decimal;
        SOYTD1_4: Decimal;
        SOYTD1_5: Decimal;
        SQYTD1_1: Decimal;
        SQYTD1_2: Decimal;
        SQYTD1_3: Decimal;
        SQYTD1_4: Decimal;
        SQYTD1_5: Decimal;
        PSIOLD1_1: Decimal;
        PSIOLD1_2: Decimal;
        PSIOLD1_3: Decimal;
        PSIOLD1_4: Decimal;
        PSIOLD1_5: Decimal;
        PSIOLD2_1: Decimal;
        PSIOLD2_2: Decimal;
        PSIOLD2_3: Decimal;
        PSIOLD2_4: Decimal;
        PSIOLD2_5: Decimal;
        PSIOLD3_1: Decimal;
        PSIOLD3_2: Decimal;
        PSIOLD3_3: Decimal;
        PSIOLD3_4: Decimal;
        PSIOLD3_5: Decimal;
        SOOLD1_1: Decimal;
        SOOLD1_2: Decimal;
        SOOLD1_3: Decimal;
        SOOLD1_4: Decimal;
        SOOLD1_5: Decimal;
        SOOLD2_1: Decimal;
        SOOLD2_2: Decimal;
        SOOLD2_3: Decimal;
        SOOLD2_4: Decimal;
        SOOLD2_5: Decimal;
        SOOLD3_1: Decimal;
        SOOLD3_2: Decimal;
        SOOLD3_3: Decimal;
        SOOLD3_4: Decimal;
        SOOLD3_5: Decimal;
        SQOLD1_1: Decimal;
        SQOLD1_2: Decimal;
        SQOLD1_3: Decimal;
        SQOLD1_4: Decimal;
        SQOLD1_5: Decimal;
        SQOLD2_1: Decimal;
        SQOLD2_2: Decimal;
        SQOLD2_3: Decimal;
        SQOLD2_4: Decimal;
        SQOLD2_5: Decimal;
        SQOLD3_1: Decimal;
        SQOLD3_2: Decimal;
        SQOLD3_3: Decimal;
        SQOLD3_4: Decimal;
        SQOLD3_5: Decimal;
        MountPSILine_1: Decimal;
        MountPSILine_2: Decimal;
        MountPSILine_3: Decimal;
        // QUARTAL VARIABLE
        Quartal: Integer;
        //FILTER BULAN
        DateTo1: Date;
        FilterYear: Integer;
        FromDate: date;
        Q1_Month1: date;
        Q1_Month2: date;
        Q1_Month3: date;
        Q1_Month4: date;
        Month_1: date;
        Month_2: date;
        Month_3: date;
        Day: integer;
        Month: integer;
        Year: integer;
        no1: Text;

    local procedure _getQ1(): Date;
    begin
        Day := 01;
        Month := 01;
        Year := FilterYear;

        exit(DMY2DATE(Day, Month, Year));
    end;

    local procedure _getQ2(): Date;
    begin
        Day := 01;
        Month := 04;
        Year := FilterYear;

        exit(DMY2DATE(Day, Month, Year));
    end;

    local procedure _getQ3(): Date;
    begin
        Day := 01;
        Month := 07;
        Year := FilterYear;

        exit(DMY2DATE(Day, Month, Year));
    end;

    local procedure _getQ4(): Date;
    begin
        Day := 01;
        Month := 10;
        Year := FilterYear;

        exit(DMY2DATE(Day, Month, Year));
    end;

    local procedure _Month1(): date;
    begin
        if Quartal = 1 then
            exit(_getQ1());
        if Quartal = 2 then
            exit(_getQ2());

        if Quartal = 3 then
            exit(_getQ3());

        if Quartal = 4 then
            exit(_getQ4());
    end;

    local procedure _Month2(): date;
    begin
        exit(CalcDate('1M', _Month1()));
    end;

    local procedure _Month3(): date;
    begin
        exit(CalcDate('2M', _Month1()));
    end;
}