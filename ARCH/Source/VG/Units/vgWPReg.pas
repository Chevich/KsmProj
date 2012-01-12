{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Report components for MS Word: registration   }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgWPReg;

interface

procedure Register;

implementation
uses SysUtils, Classes, vgVCLRes, vgWP, vgWPDB, vgWPBDE {$IFDEF MIDAS}, vgWPCDS{$ENDIF};

{$R vgDWP.dcr}

procedure Register;
begin
  RegisterComponents(LoadStr(SRegReports), [
    TvgDBWordPrint, TvgBDEWordPrint {$IFDEF MIDAS}, TvgCDSWordPrint{$ENDIF}]);
end;

end.
