report 54008 "Report Stock Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 54008 - Stock Report.rdlc';

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            column(Entry_No_; "Entry No.") { }
            column(CompanyInformasiPicture; CompanyInformasi.Picture) { }
            column(CompanyInformasiName; CompanyInformasi.Name) { }
            column(Lot_No_; "Lot No.") { }
            column(Variant_Code; "Variant Code") { }
            column(Expiration_Date; "Expiration Date") { }
            column(InVar; _InVar) { }
            column(OutVar; _OutVar) { }
            column(LossVar; _LossVar) { }
            column(LocationFilter; LocationFilter) { }
            column(FilterDate; FilterDate) { }
            column(PreBalance; PreBalance) { }
            column(Balance; Balance) { }
            column(FirstDate; FirstDate) { }
            column(Registering_Date; "Registering Date") { }
            column(LastDate; LastDate) { }
            column(CategoryItem; CategoryItem) { }
            trigger OnPreDataItem()
            begin
                FirstDate := CalcDate('-CM', FilterDate);
                LastDate := CalcDate('CM', FilterDate);
                if (LocationFilter = '') then begin
                    Error('Fields Filter Stock Report cannot be empty');
                end else begin
                    SetRange("Location Code", LocationFilter);
                    SetRange("Registering Date", FirstDate, LastDate);
                    SetFilter("Entry Type", '<> %1', "Entry Type"::Movement);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                WarehouseEntryTable_2: Record "Warehouse Entry";
                RecItem: Record Item;
            begin

                RecItem.SetRange("No.", "Item No.");
                if RecItem.FindFirst() then begin
                    repeat
                        CategoryItem := RecItem."Item Category Code";
                    until RecItem.Next = 0;
                end;

                if GetPreBalance = 0 then
                    GetPreBalance := 0
                else
                    GetPreBalance := GetPreBalance;

                WarehouseEntryTable_2.Reset;
                WarehouseEntryTable_2.SetRange("Location Code", LocationFilter);
                WarehouseEntryTable_2.SetRange("Registering Date", 0D, CalcDate('-1D', FirstDate));
                WarehouseEntryTable_2.SetFilter("Entry Type", '<> %1', "Entry Type"::Movement);
                PreBalance := 0;
                if WarehouseEntryTable_2.FindFirst() then begin
                    repeat
                        PreBalance := 100;
                    until WarehouseEntryTable_2.Next = 0;
                end;

                WarehouseEntryTable.Reset;
                WarehouseEntryTable.SetRange("Entry No.", "Entry No.");
                _InVar := 0;
                _LossVar := 0;
                _OutVar := 0;
                if WarehouseEntryTable.FindFirst() then begin
                    repeat
                        if WarehouseEntryTable."Whse. Document Type" = "Whse. Document Type"::"Whse. Phys. Inventory" then begin
                            if WarehouseEntryTable."Entry Type" = "Entry Type"::Movement then begin
                                _InVar := 0;
                                _OutVar := 0;
                                _LossVar := 0;
                            end else begin
                                if (WarehouseEntryTable."Reason Code" = 'LOSS') OR (WarehouseEntryTable."Reason Code" = 'DAMAGE') then begin
                                    _LossVar := WarehouseEntryTable.Quantity;
                                    _InVar := 0;
                                    _OutVar := 0;
                                end;
                                if WarehouseEntryTable."Reason Code" = 'FINDINGS' then begin
                                    _InVar := WarehouseEntryTable.Quantity;
                                    _OutVar := 0;
                                    _LossVar := 0;
                                end;
                            end;
                        end else begin
                            if WarehouseEntryTable."Entry Type" = "Entry Type"::"Negative Adjmt." then begin
                                _InVar := 0;
                                _OutVar := WarehouseEntryTable.Quantity;
                                _LossVar := 0;
                            end;
                            if WarehouseEntryTable."Entry Type" = "Entry Type"::"Positive Adjmt." then begin
                                _InVar := WarehouseEntryTable.Quantity;
                                _OutVar := 0;
                                _LossVar := 0;
                            end;
                            if WarehouseEntryTable."Entry Type" = "Entry Type"::Movement then begin
                                _InVar := 0;
                                _OutVar := 0;
                                _LossVar := 0;
                            end;
                        end;
                        // end;
                        GetQuantity := _InVar + _OutVar + _LossVar;
                        balance := GetPreBalance + GetQuantity;
                        GetPreBalance := Balance;
                    until WarehouseEntryTable.Next = 0;
                end;
            end;
            // batas
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Filter: Stock Report")
                {
                    field(LocationFilter; LocationFilter)
                    {
                        caption = 'Location Code';
                        ApplicationArea = All;
                        TableRelation = Location."Code";
                    }
                    field(FilterDate; FilterDate)
                    {
                        caption = 'Filter Month & Year';
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
    trigger OnInitReport()
    begin
        CompanyInformasi.get;
        CompanyInformasi.CalcFields(Picture)
    end;

    var
        CompanyInformasi: Record "Company Information";
        WarehouseEntryTable: Record "Warehouse Entry";
        _InVar: Decimal;
        _OutVar: Decimal;
        _LossVar: Decimal;
        ExpiryDateFilter: Date;
        LocationFilter: Code[50];
        Yeardate: DateFormula;
        FilterDate: Date;
        GetPrebalance: Decimal;
        PreBalance: Decimal;
        Balance: Decimal;
        GetQuantity: Decimal;
        FirstDate: Date;
        LastDate: Date;
        MonthDate: text[30];
        CategoryItem: Code[50];


}