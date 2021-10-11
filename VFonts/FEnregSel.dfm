object FormEnregSel: TFormEnregSel
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Enregistrer la s'#233'lection sous...'
  ClientHeight = 146
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 101
    Width = 305
    Height = 41
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 81
    Top = 10
    Width = 88
    Height = 13
    Alignment = taRightJustify
    Caption = 'Un nouveau nom :'
  end
  object Label2: TLabel
    Left = 9
    Top = 75
    Width = 160
    Height = 13
    Alignment = taRightJustify
    Caption = 'En remplacement de la s'#233'lection :'
  end
  object LabelOU: TLabel
    Left = 138
    Top = 40
    Width = 24
    Height = 19
    Caption = 'OU'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EditNouveauNom: TEdit
    Left = 177
    Top = 8
    Width = 97
    Height = 21
    TabOrder = 0
    OnChange = EditNouveauNomChange
    OnClick = EditNouveauNomClick
  end
  object BitBtnCancel: TBitBtn
    Left = 8
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtnOK: TBitBtn
    Left = 218
    Top = 112
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    TabOrder = 2
    OnClick = BitBtnOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cbSel: TComboBox
    Left = 177
    Top = 73
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    OnChange = cbSelChange
    OnClick = cbSelClick
  end
end
