report 54006 "Report Stock Card"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 54006 - Stock Card.rdlc';
    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            column(CompanyInformasiPicture; CompanyInformasi.Picture) { }
            column(CompanyInformasiName; CompanyInformasi.Name) { }
            column(LocationCodeFilter; LocationCodeFilter) { }
            column(ItemCodeFilter; ItemCodeFilter) { }
            column(BatchFilter; BatchFilter) { }
            column(ProjectIDFilter; ProjectIDFilter) { }
            column(ExpiryDateFilter; ExpiryDateFilter) { }
            column(Location_Code; "Location Code") { }
            column(Weight; Weight) { }
            column(Item_No_; "Item No.") { }
            column(Reason_Code; "Registering Date") { }
            column(Entry_No_; "Entry No.") { }
            column(Expiration_Date; "Expiration Date") { }
            column(Registering_Date; "Registering Date") { }
            column(Reference_Document; "Reference Document") { }
            column(Reference_No_; "Reference No.") { }
            column(CategoryFilter; CategoryFilter) { }
            column(Entry_Type; "Entry Type") { }
            column(InVar; _InVar) { }
            column(OutVar; _OutVar) { }
            column(LossVar; _LossVar) { }
            column(FromDate; FromDate) { }
            column(PreBalance; PreBalance) { }
            column(Balance; Balance) { }
            column(ToDate; ToDate) { }
            trigger OnPreDataItem()
            begin
                if (LocationCodeFilter = '') OR (FromDate = 0D) OR (ToDate = 0D) then begin
                    Error('Fields cannot be empty');
                end else begin
                    ItemTable.SetRange("No.", ItemCodeFilter);
                    // ItemTable.SetRange("Item Category Code", CategoryFilter);
                    // if ItemTable.FindFirst() then begin
                    SetRange("Registering Date", FromDate, ToDate);
                    SetFilter("Entry Type", '<> %1', "Entry Type"::Movement);
                    // SetRange("Location Code", LocationCodeFilter);
                    // SetRange("Item No.", ItemTable."No.");
                    // SetRange("Expiration Date", ExpiryDateFilter);
                    // SetRange("Lot No.", BatchFilter);
                    // SetRange("Variant Code", ProjectIDFilter);
                    // end;
                end;
            end;

            trigger OnAfterGetRecord()
            var
                WarehouseEntryTable_2: Record "Warehouse Entry";
            begin
                if GetPreBalance = 0 then
                    GetPreBalance := 0
                else
                    GetPreBalance := GetPreBalance;

                WarehouseEntryTable_2.Reset;
                WarehouseEntryTable_2.SetRange("Location Code", LocationCodeFilter);
                WarehouseEntryTable_2.SetRange("Registering Date", 0D, FromDate);
                WarehouseEntryTable_2.SetFilter("Entry Type", '<> %1', "Entry Type"::Movement);
                // WarehouseEntryTable_2.SetRange("Item No.", ItemTable."No.");
                // WarehouseEntryTable_2.SetRange("Expiration Date", ExpiryDateFilter);
                // WarehouseEntryTable_2.SetRange("Lot No.", BatchFilter);
                // WarehouseEntryTable_2.SetRange("Variant Code", ProjectIDFilter);
                PreBalance := 0;
                if WarehouseEntryTable_2.FindFirst() then begin
                    repeat
                        PreBalance := 0;
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
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Filter: Stock Card Report")
                {
                    field(FromDate; FromDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = All;
                    }
                    field(ToDate; ToDate)
                    {
                        Caption = 'To Date';
                        ApplicationArea = All;
                    }
                    field(LocationCodeFilter; LocationCodeFilter)
                    {
                        Caption = 'Location Code';
                        ApplicationArea = All;
                        TableRelation = Location."Code";
                    }
                    // field(CategoryFilter; CategoryFilter)
                    // {
                    //     Caption = 'Category';
                    //     TableRelation = "Item Category"."Code";
                    //     ApplicationArea = all;
                    // }
                    // field(ItemCodeFilter; ItemCodeFilter)
                    // {
                    //     Caption = 'Item Code';
                    //     ApplicationArea = All;
                    //     TableRelation = Item."No.";
                    // }
                    // field(ExpiryDateFilter; ExpiryDateFilter)
                    // {
                    //     Caption = 'Expiry Date';
                    //     ApplicationArea = All;
                    // }
                    // field(BatchFilter; BatchFilter)
                    // {
                    //     Caption = 'Batch No';
                    //     TableRelation = "Lot No. Information"."Lot No.";
                    //     ApplicationArea = All;
                    //     // trigger OnLookup(var Text: Text): Boolean
                    //     // var
                    //     //     PageWE: Page "Warehouse Entries";
                    //     //     RecWE: Record "Warehouse Entry";
                    //     // begin
                    //     //     RecWE.Reset();
                    //     //     Clear(PageWE);
                    //     //     PageWE.SetTableView(RecWE);
                    //     //     PageWE.LookupMode(true);
                    //     //     if PageWE.RunModal() = Action::LookupOK then begin
                    //     //         PageWE.GetRecord(RecWE);
                    //     //         BatchFilter := RecWE."Lot No.";
                    //     //     end;
                    //     // end;
                    // }
                    field(ProjectIDFilter; ProjectIDFilter)
                    {
                        // Caption = 'Project ID';
                        // TableRelation = "Item Variant"."Code";
                        // ApplicationArea = All;
                        // trigger OnLookup(var Text: Text): Boolean
                        // var
                        //     PageWE2: Page "Warehouse Entries";
                        //     RecWE2: Record "Warehouse Entry";
                        // begin
                        //     RecWE2.Reset();
                        //     Clear(PageWE2);
                        //     PageWE2.SetTableView(RecWE2);
                        //     PageWE2.LookupMode(true);
                        //     if PageWE2.RunModal() = Action::LookupOK then begin
                        //         PageWE2.GetRecord(RecWE2);
                        //         ProjectIDFilter := RecWE2."Variant Code";
                        //     end;
                        // end;
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
        ItemTable: Record Item;
        CompanyInformasi: Record "Company Information";
        WarehouseEntryTable: Record "Warehouse Entry";
        _InVar: Decimal;
        _OutVar: Decimal;
        _LossVar: Decimal;
        PreBalance: Decimal;
        GetPreBalance: Decimal;
        GetQuantity: Decimal;
        Balance: Decimal;
        PreQuantity: Decimal;
        LocationCodeFilter: Code[50];
        ItemCodeFilter: Code[50];
        CategoryFilter: Code[50];
        BatchFilter: Code[50];
        FundSourceFilter: Code[50];
        ProjectIDFilter: Code[50];
        ExpiryDateFilter: Date;
        FromDate: date;
        ToDate: date;

    local procedure GetPrebalanceFunc()
    begin

    end;
}