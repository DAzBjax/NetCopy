object TestForm: TTestForm
  Left = 0
  Top = 0
  Caption = 'TestForm'
  ClientHeight = 574
  ClientWidth = 860
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 24
    Width = 769
    Height = 21
    TabOrder = 0
    Text = '\\169.254.223.106\compare'
  end
  object Edit2: TEdit
    Left = 32
    Top = 104
    Width = 769
    Height = 21
    TabOrder = 1
    Text = 'C:\Users\qqq\Desktop\CompareClone'
  end
  object Button1: TButton
    Left = 742
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 131
    Width = 769
    Height = 422
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
end
