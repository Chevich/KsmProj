{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         vgVCLRes resource constants unit               }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC}
{$D-,L-}

unit vgVCLRes;

interface

const
  MaxVCLStrID                = 51000;

  { Registration }
  SRegFirst                  = MaxVCLStrID;
  SRegSystem                 = SRegFirst - 1;
  SRegTools                  = SRegFirst - 2;
  SRegControls               = SRegFirst - 3;
  SRegExplorer               = SRegFirst - 4;
  SRegReports                = SRegFirst - 5;
  SRegHASP                   = SRegFirst - 6;
  SRegDataAccess             = SRegFirst - 7;
  SRegDataControls           = SRegFirst - 8;
  SRegMultiTier              = SRegFirst - 9;
  SRegMisc                   = SRegFirst - 10;

  SRegIniFile                = SRegFirst - 20;
  SRegIniSection             = SRegIniFile - 1;

  { Library constants }

  MaxVCLResStrID             = MaxVCLStrID - 100;

  { vgUtils, vgSystem, vgComObj }
  MaxVgUtils                 = MaxVCLResStrID - 1;
  SCannotDeleteFile          = MaxVgUtils - 1;
  SCannotRenameFile          = MaxVgUtils - 2;
  STlsCannotAlloc            = MaxVgUtils - 3;
  SUknownCompressorSign      = MaxVgUtils - 4;
  SBadVariantType            = MaxVgUtils - 5;

  { vgTools, vgStndrt }
  MaxVgTools                 = MaxVgUtils - 100;
  SParameterNotFound         = MaxVgTools - 1;
  SParamTooBig               = MaxVgTools - 2;
  SFieldUndefinedType        = MaxVgTools - 3;
  SFieldUnsupportedType      = MaxVgTools - 4;
  STextTrue                  = MaxVgTools - 5;
  STextFalse                 = MaxVgTools - 6;

  { TMoneyString }
  MaxMoneyString             = MaxVgTools - 100;
  SsrMaleOne                 = MaxMoneyString - 1;
  SsrFemaleOne               = MaxMoneyString - 2;
  SsrTen                     = MaxMoneyString - 3;
  SsrFirstTen                = MaxMoneyString - 4;
  SsrHundred                 = MaxMoneyString - 5;
  SsrThousand                = MaxMoneyString - 6;
  SsrMillion                 = MaxMoneyString - 7;
  SsrCurrencySub             = MaxMoneyString - 8;
  SsrCurrency                = MaxMoneyString - 9;
  SsrZero                    = MaxMoneyString - 10;

  { Dialogs }
  MaxDialogStrID             = MaxVgTools - 200;

  { Login Dialog }
  SLoginDialogCaption        = MaxDialogStrID - 1;
  SLoginCaption              = MaxDialogStrID - 2;
  SLoginPassword             = MaxDialogStrID - 3;

implementation

{$R *.RES}

end.