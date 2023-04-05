MODULE Main_
    VAR num nWhichTool:=1;

    PROC main()
        Init;
        ToolAttach(nWhichTool);
        FOR dx FROM 0 TO 1 DO
            FOR dy FROM 0 TO 4 DO
                wPallet.oframe.trans.x:=dx*600;
                wPallet.oframe.trans.y:=dy*200;
                Pick;
                Place;
            ENDFOR
        ENDFOR
        ToolDetach(nWhichTool);
    ENDPROC

    PROC Pick()
        MoveJ offs(pPick,0,0,50),v1000,z5,tGripper2\WObj:=wPallet;
        MoveL pPick,v200,fine,tGripper2\WObj:=wPallet;
        Tool2\Magnet\On;
        MoveL offs(pPick,0,0,100),v200,z0,tGripper2\WObj:=wPallet;
        Tool2\Gripper\On;
    ENDPROC

    PROC Place()
        MoveJ offs(pPlace,0,0,50),v1000,z0,tGripper2\WObj:=wobj0;
        Tool2\Gripper\Off;
        MoveL pPlace,v200,fine,tGripper2\WObj:=wobj0;
        Tool2\Magnet\Off;
        MoveL offs(pPlace,0,0,50),v400,z5,tGripper2\WObj:=wobj0;
    ENDPROC

    PROC Init()
        MoveJ pHome,v1000,z50,tGripper2\WObj:=wobj0;
        SetDO doGripper2Open,1;
        Reset doMagnetOn;
        reset doAttachTool;
        reset doDetachTool;
        WaitTime 4;
    ENDPROC

    PROC Tool2(\switch Gripper|switch Magnet\switch On|switch Off)
        IF Present(Gripper) THEN
            IF present(On) THEN
                WaitTime 1;
                Reset doGripper2Open;
                waittime 1;
            ELSEIF Present(Off) THEN
                WaitTime 1;
                Set doGripper2Open;
                waittime 1;
            ELSE
                Stop;
            ENDIF
        ELSEIF Present(Magnet) THEN
            IF present(On) THEN
                WaitTime 1;
                Set doMagnetOn;
                waittime 1;
            ELSEIF Present(Off) THEN
                WaitTime 1;
                Reset doMagnetOn;
                waittime 1;
            ELSE
                Stop;
            ENDIF
        ENDIF
    ENDPROC

    PROC ToolAttach(num nWhich)
        TEST nWhich
        CASE 1:
            MoveJ offs(pTool1,0,0,200),v1000,z50,tool0\WObj:=wobj0;
            MoveL offs(pTool1,0,0,200),v1000,fine,tool0\WObj:=wobj0;
            MoveJ pTool1,v1000,fine,tool0\WObj:=wobj0;
            Set doAttachTool;
            WaitTime 1;
            MoveL offs(pTool1,0,0,200),v1000,fine,tool0\WObj:=wobj0;
        CASE 2:
            MoveJ offs(pTool2,0,0,200),v1000,z50,tool0\WObj:=wobj0;
            MoveL offs(pTool2,0,0,200),v1000,fine,tool0\WObj:=wobj0;
            MoveJ pTool2,v1000,fine,tool0\WObj:=wobj0;
            Set doAttachTool;
            WaitTime 1;
            MoveL offs(pTool2,0,0,200),v1000,fine,tool0\WObj:=wobj0;
        ENDTEST
        MoveL offs(CRobT(),0,0,300),v1000,z50,tGripper2\WObj:=wobj0;
    ENDPROC

    PROC ToolDetach(num nWhich)
        TEST nWhich
        CASE 1:
            MoveJ offs(pTool1,0,0,200),v1000,z50,tool0\WObj:=wobj0;
            MoveL offs(pTool1,0,0,200),v1000,fine,tool0\WObj:=wobj0;
            MoveJ pTool1,v1000,fine,tool0\WObj:=wobj0;
            Set doDetachTool;
            WaitTime 1;
            MoveL offs(pTool1,0,0,200),v1000,fine,tool0\WObj:=wobj0;
        CASE 2:
            MoveJ offs(pTool2,0,0,200),v1000,z50,tool0\WObj:=wobj0;
            MoveL offs(pTool2,0,0,200),v1000,fine,tool0\WObj:=wobj0;
            MoveJ pTool2,v1000,fine,tool0\WObj:=wobj0;
            Set doDetachTool;
            WaitTime 1;
            MoveL offs(pTool2,0,0,200),v1000,fine,tool0\WObj:=wobj0;
        ENDTEST
        MoveL offs(CRobT(),0,0,300),v1000,z50,tGripper2\WObj:=wobj0;
    ENDPROC

ENDMODULE