object Esp32frm: TEsp32frm
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Esp32go'
  ClientHeight = 239
  ClientWidth = 120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 107
    Width = 120
    Height = 41
    Margins.Top = 0
    Caption = 'Speed'
    Columns = 4
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'S'
      'F'
      'C'
      'G')
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 120
    Height = 123
    Margins.Bottom = 0
    Caption = 'Telescope'
    TabOrder = 2
    object ButtonNE: TButton
      Tag = 4
      Left = 11
      Top = 15
      Width = 30
      Height = 30
      Caption = 'NE'
      TabOrder = 0
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object Button_N: TButton
      Left = 42
      Top = 13
      Width = 35
      Height = 35
      Caption = 'N'
      TabOrder = 1
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object ButtonNW: TButton
      Tag = 7
      Left = 80
      Top = 15
      Width = 30
      Height = 30
      Caption = 'NW'
      TabOrder = 2
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object Button_W: TButton
      Tag = 3
      Left = 77
      Top = 46
      Width = 35
      Height = 35
      Caption = 'W'
      TabOrder = 3
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object ButtonSW: TButton
      Tag = 6
      Left = 80
      Top = 83
      Width = 30
      Height = 30
      Caption = 'SW'
      TabOrder = 4
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object Button_S: TButton
      Tag = 1
      Left = 43
      Top = 81
      Width = 35
      Height = 35
      Caption = 'S'
      TabOrder = 5
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object ButtonSE: TButton
      Tag = 5
      Left = 11
      Top = 83
      Width = 30
      Height = 30
      Caption = 'SE'
      TabOrder = 6
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object Button_E: TButton
      Tag = 2
      Left = 8
      Top = 47
      Width = 35
      Height = 35
      Caption = 'E'
      TabOrder = 7
      OnMouseDown = Button_NMouseDown
      OnMouseUp = Button_NMouseUp
    end
    object ButtonH: TButton
      Left = 45
      Top = 50
      Width = 29
      Height = 15
      Caption = 'H'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object ButtonPark: TButton
      Left = 45
      Top = 64
      Width = 29
      Height = 15
      Caption = 'Park'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
  end
  object GroupBoxFocus: TGroupBox
    Left = 0
    Top = 139
    Width = 120
    Height = 63
    Caption = 'Focuser'
    TabOrder = 1
    object LabelFocusCount: TLabel
      Tag = 1
      Left = 55
      Top = 14
      Width = 61
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clAqua
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      StyleElements = []
    end
    object ButtonIn: TButton
      Left = 3
      Top = 14
      Width = 25
      Height = 20
      Caption = 'In'
      TabOrder = 0
      OnMouseDown = ButtonInMouseDown
      OnMouseUp = ButtonInMouseUp
    end
    object ButtonOut: TButton
      Left = 30
      Top = 14
      Width = 25
      Height = 20
      Caption = 'Out'
      TabOrder = 1
      OnMouseDown = ButtonInMouseDown
      OnMouseUp = ButtonInMouseUp
    end
    object ButtonM1: TButton
      Left = 3
      Top = 35
      Width = 25
      Height = 20
      Caption = 'M1'
      TabOrder = 2
    end
    object ButtonM2: TButton
      Left = 32
      Top = 35
      Width = 25
      Height = 20
      Caption = 'M2'
      TabOrder = 3
    end
    object ButtonM3: TButton
      Left = 61
      Top = 35
      Width = 25
      Height = 20
      Caption = 'M3'
      TabOrder = 4
    end
    object ButtonM4: TButton
      Left = 90
      Top = 35
      Width = 25
      Height = 20
      Caption = 'M4'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 194
    Width = 120
    Height = 45
    Caption = 'Coord'
    TabOrder = 3
    object Label2: TLabel
      Left = 88
      Top = 29
      Width = 27
      Height = 13
      Caption = 'count'
    end
    object labelAR: TLabel
      Left = 2
      Top = 13
      Width = 43
      Height = 15
      Caption = 'ASCOM'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      WordWrap = True
      StyleElements = [seBorder]
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 29
    Top = 247
  end
end
