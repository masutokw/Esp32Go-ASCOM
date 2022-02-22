object Cnfrm: TCnfrm
  Left = 0
  Top = 0
  Caption = 'Cnfrm'
  ClientHeight = 271
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ComComboBox1: TComComboBox
    Left = 22
    Top = 24
    Width = 74
    Height = 21
    ComProperty = cpPort
    Text = 'COM13'
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
  end
  object ComComboBox2: TComComboBox
    Left = 112
    Top = 24
    Width = 81
    Height = 21
    Text = ''
    Style = csDropDownList
    ItemIndex = -1
    TabOrder = 1
  end
end
