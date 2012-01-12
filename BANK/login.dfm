object LoginForm: TLoginForm
  Left = 290
  Top = 251
  BorderStyle = bsToolWindow
  Caption = 'Вход в систему "Банк" ОАО "ГКСМ"'
  ClientHeight = 89
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 235
    Height = 89
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object RxLabel1: TRxLabel
      Left = 4
      Top = 13
      Width = 101
      Height = 13
      Caption = 'Имя пользователя:'
    end
    object RxLabel2: TRxLabel
      Left = 62
      Top = 37
      Width = 43
      Height = 13
      Caption = 'Пароль:'
    end
    object okButton: TButton
      Left = 34
      Top = 61
      Width = 75
      Height = 25
      Caption = '&Вход'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object CancelButton: TButton
      Left = 122
      Top = 61
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Отмена'
      ModalResult = 2
      TabOrder = 3
    end
    object Password: TEdit
      Left = 110
      Top = 29
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      OnChange = PasswordChange
    end
    object UserName: TEdit
      Left = 110
      Top = 5
      Width = 121
      Height = 21
      TabOrder = 0
      OnChange = PasswordChange
    end
  end
end
