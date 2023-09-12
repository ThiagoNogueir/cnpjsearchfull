object FormCNPJ: TFormCNPJ
  Left = 0
  Top = 0
  ClientHeight = 173
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 549
    Height = 173
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 635
    ExplicitHeight = 299
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 222
      Height = 29
      Caption = 'Consulta CNPJ.WS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 344
      Top = 54
      Width = 177
      Height = 31
      Caption = 'Consultar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 32
      Top = 54
      Width = 306
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit1'
    end
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://publica.cnpj.ws'
    Params = <>
    Left = 168
    Top = 120
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Resource = 'cnpj/27233726000120'
    Response = RESTResponse1
    Left = 40
    Top = 120
  end
  object RESTResponse1: TRESTResponse
    Left = 104
    Top = 120
  end
end
