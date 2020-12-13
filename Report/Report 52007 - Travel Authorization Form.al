report 52007 "Travel Authorization Form"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 52007 - Travel Authorization.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Advance Header"; "Advance Header")
        {
            column(No_; "No.") { }
            column(Employee_Name; "Employee Name") { }
            column(Employee_No_; "Employee No.") { }
            column(Posting_Date; "Posting Date") { }
            // column(Destination; Destination) { }
            column(Purpose_of_Travel; "Purpose of Travel") { }
            column(tiket; tiket) { }
            column(tanggal; tanggal) { }
            column(user; userr) { }

            // column(Mission_Period_Starting_Date; "Mission Period Starting Date") { }
            // column(Mission_Period_Ending_Date; "Mission Period Ending Date") { }
            // column(Contact_Address_and_Number; "Contact Address and Number") { }
            // column(Additional_Notes; "Additional Notes") { }
            column(Starting_Date; "Starting Date") { }
            column(Ending_Date; "Ending Date") { }
            dataitem("Advance Line"; "Advance Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_Type; "Document Type") { }
                column(Document_No_; "Document No.") { }
                column(Departure_Time; "Departure Time") { }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
                column(From; From) { }
                column(Ticket_Type; "Ticket Type") { }
                column(Destination_Line; Destination) { }
                column(Starting_Line; Starting) { }
                column(Ending_Line; Ending) { }
                column(DaperaturReturn; DaperaturReturn) { }
                column(DateReturn; DateReturn) { }
                column(FromReturn; FromReturn) { }
                column(Organiser; Organiser) { }
                column(DestinationReturn; DestinationReturn) { }
                trigger OnPreDataItem()
                begin
                    SetRange("Ticket Type", "Ticket Type"::Itinerary);
                end;

                trigger OnAfterGetRecord()
                begin
                    DateReturn := 0D;
                    if "Advance Line"."Travel Type" = "Travel Type"::"Return Trip" then begin
                        DateReturn := "Advance Line".Ending;
                        DaperaturReturn := "Advance Line"."Departure Time";
                        FromReturn := "Advance Line".From;
                        DestinationReturn := "Advance Line".Destination;
                    end;
                end;
            }
            dataitem("Other Line"; "Advance Line")
            {
                // DataItemTableView = SORTING("starting");
                // PrintOnlyIfDetail = true;


                DataItemLink = "Document No." = field("No.");
                column(Document_Type_Other; "Document Type") { }
                column(Document_No_Other; "Document No.") { }
                column(Description; Description) { }
                column(Starting_other; Starting) { }
                column(Ending_other; Ending) { }
                column(Ticket_Entry; "Ticket Entry") { }
                column(Expense_Type; "Expense Type") { }
                column(Destination_other; Destination) { }
                trigger OnPreDataItem()
                begin
                    SetRange("Expense Type", "Expense Type"::"Hotel Reservation");
                    SetRange("Ticket Type", "Ticket Type"::Others);
                end;

                // trigger OnAfterGetRecord()
                // var
                //     myInt: Integer;
                // begin

                //     IF Starting = 0D
                //      THEN
                //         Currreport.SKIP;
                // end;
            }
            trigger OnAfterGetRecord()
            begin
                AdcanceLine.Reset();
                AdcanceLine.SetRange("Expense Type", AdcanceLine."Expense Type"::"Hotel Reservation");
                AdcanceLine.SetRange("Ticket Type", AdcanceLine."Ticket Type"::Others);
                AdcanceLine.FindFirst();
                if AdcanceLine.FindFirst() then begin
                    tiket := AdcanceLine."Ticket Entry";
                    tanggal := AdcanceLine.Starting;
                end else begin
                    tiket := AdcanceLine."Ticket Entry";
                    tanggal := 20221001D;
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
    }
    trigger OnInitReport()
    begin
        userr := UserId;
    end;

    var
        DateReturn: Date;
        tiket: Boolean;
        tanggal: date;
        AdcanceLine: Record "Advance Line";
        DaperaturReturn: Time;
        FromReturn: Text;
        DestinationReturn: Text;
        Organiser: Option;
        userr: text;
}