page 50130 "ForNAV Reports"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ForNAV Report";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; ID) { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Run)
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Print;
                PromotedIsBig = true;
                trigger OnAction();
                begin
                    Report.run(ID, true, true);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Report);
        AllObjWithCaption.SetRange("Object ID", 50000, 99999);
        AllObjWithCaption.SetFilter("Object Name", 'ForNAV*');
        if AllObjWithCaption.FindSet then repeat
                                              ID := AllObjWithCaption."Object ID";
                                              Name := AllObjWithCaption."Object Caption";
                                              Insert;
            until AllObjWithCaption.Next = 0;
    end;
}