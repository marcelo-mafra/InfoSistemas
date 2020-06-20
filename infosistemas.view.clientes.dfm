object FrmMainForm: TFrmMainForm
  Left = 0
  Top = 0
  ActiveControl = EdtCPFFind
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Meus clientes'
  ClientHeight = 453
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    693
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 8
    Top = 5
    Width = 89
    Height = 13
    Caption = '&&Localizar por CPF'
    FocusControl = EdtCPFFind
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 51
    Width = 677
    Height = 129
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Dados do Cliente'
    TabOrder = 3
    ExplicitWidth = 667
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 19
      Height = 13
      Caption = '&CPF'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 160
      Top = 24
      Width = 52
      Height = 13
      Caption = '&Identidade'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 16
      Top = 75
      Width = 27
      Height = 13
      Caption = '&Nome'
      FocusControl = DBEdit3
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 39
      Width = 121
      Height = 21
      DataField = 'CPF'
      DataSource = DMClientes.DsrClientes
      MaxLength = 14
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 91
      Width = 641
      Height = 21
      DataField = 'NOME'
      DataSource = DMClientes.DsrClientes
      TabOrder = 2
    end
    object DBEdit3: TDBEdit
      Left = 160
      Top = 39
      Width = 121
      Height = 21
      DataField = 'IDENTIDADE'
      DataSource = DMClientes.DsrClientes
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 194
    Width = 675
    Height = 74
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Meios de Contato'
    TabOrder = 4
    object Label4: TLabel
      Left = 16
      Top = 25
      Width = 42
      Height = 13
      Caption = '&Telefone'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 160
      Top = 25
      Width = 24
      Height = 13
      Caption = '&Email'
      FocusControl = DBEdit5
    end
    object DBEdit4: TDBEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      DataField = 'TELEFONE'
      DataSource = DMClientes.DsrClientes
      MaxLength = 14
      TabOrder = 0
    end
    object DBEdit5: TDBEdit
      Left = 160
      Top = 40
      Width = 497
      Height = 21
      DataField = 'MAIL'
      DataSource = DMClientes.DsrClientes
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 281
    Width = 677
    Height = 162
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Endere'#231'o'
    TabOrder = 5
    object Label6: TLabel
      Left = 16
      Top = 25
      Width = 95
      Height = 13
      Caption = 'C'#243'digo &Postal (CEP)'
      FocusControl = DBEditCEP
    end
    object SpeedButton1: TSpeedButton
      Left = 137
      Top = 41
      Width = 23
      Height = 23
      Action = ActGetCEPData
      Glyph.Data = {
        76060000424D7606000000000000360000002800000014000000140000000100
        2000000000004006000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFF00FEFE
        FF00F7FDFE00FEFFFF00FEFFFF00FEFFFE00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FEFEFF00FEFEFF00C4F0FE00E7F9FE00E7F9FE00FEFE
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFF00FEFE
        FF00C8F1FE0082E1FF0082E1FF00F8FDFE00FBFEFE00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEF6FE002FC8FD002FC8FD00A9EA
        FE00FDFEFE00FFFEFF00FFFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFEFF00FFFEFF00FEFEFE00FEFFFE00FEFF
        FE00F2FCFE0047D0FF0047D0FF0028C9FE00D8F5FF00FEFFFF00FEFFFF00FFFF
        FF00FEFFFF00FEFFFF00FFFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
        FF00FEFEFF00FFFFFF00FEFFFF00FEFFFF00FBFDFE0080E0FE0080E0FE0006BE
        FF0059D6FD00F8FDFF00F8FDFF00FFFFFE00FEFFFE00FEFFFE00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFEFF00FFFEFF00FEFEFE00FEFFFF00FEFF
        FF00FDFEFE00BAEDFE00BAEDFE0009C0FF0006C0FF008FE3FF008FE3FF00F9FD
        FE00FFFFFF00FFFFFF00FDFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FEFEFE00FDFFFE00FDFFFE00FCFEFE00F0FBFF00F0FBFF001EC6
        FF0005C1FE001EC7FE001EC7FE00CAF2FE00FCFEFF00FCFEFF00FEFFFE00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFEFE00EEFBFF00C4EFFF00C4EF
        FF00C2F0FE00C2F0FF00C2F0FF0039CEFE0008C1FF0007C0FE0007C0FE0042CE
        FE00ECFBFE00ECFBFE00FEFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFF
        FF00FEFFFF00EAF9FF0037CCFF0037CCFF0006C0FF0008C1FF0008C1FF0009C2
        FE0068D9FD008AE1FD008AE1FD008BE1FE0094E5FF0094E5FF00EDFAFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFEFF006CD9FF006CD9
        FF0005C0FD0006C2FE0006C2FE0007C1FF0079DEFE00FBFEFE00FBFEFE00FEFE
        FF00FFFEFE00FFFEFE00FFFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FEFFFF00AEECFE00AEECFE0007C1FF0005C2FE0005C2FE0006C0
        FE0025C8FF00E5F9FF00E5F9FF00FFFFFF00FEFFFF00FEFFFF00FDFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FEFFFF00FEFFFF00FFFFFF00EAFAFF00EAFA
        FF0024C8FD0006C0FF0006C0FF0007C2FF0007C0FF009BE5FF009BE5FF00FEFF
        FE00FFFFFF00FFFFFF00FFFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFE
        FF00FFFEFF00FEFFFF00FBFEFF00FBFEFF0065D7FE0005C0FE0005C0FE0008C1
        FF0004C1FF0046D1FE0046D1FE00F2FBFF00FDFFFF00FDFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFF00FEFE
        FF00A7E9FF000AC1FE000AC1FE0006C1FF0007C2FE001AC4FF001AC4FF00CDF3
        FE00FDFEFF00FDFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FEFFFD00FEFFFD00D5F4FF001BC5FE001BC5FE0004C1
        FF0004C0FE0007C1FE0007C1FE0083DEFF00FCFEFE00FCFEFE00FEFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F3FCFF009CE6FE009CE6FE008BE1FE008AE1FE008BE2FF008BE2FF00A6E8
        FF00FDFEFF00FDFEFF00FDFFFE00FFFEFF00FFFEFF00FEFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFFFF00FDFFFF00FDFFFF00FDFE
        FE00FDFEFE00FCFEFE00FCFEFE00FCFEFE00FEFFFF00FEFFFF00FFFEFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    end
    object Label8: TLabel
      Left = 166
      Top = 25
      Width = 55
      Height = 13
      Caption = '&Logradouro'
      FocusControl = DBEditLogradouro
    end
    object Label9: TLabel
      Left = 576
      Top = 25
      Width = 37
      Height = 13
      Caption = 'N&'#250'mero'
      FocusControl = DBEditLogradouro
    end
    object Label10: TLabel
      Left = 16
      Top = 74
      Width = 28
      Height = 13
      Caption = '&Bairro'
      FocusControl = DBEditBairro
    end
    object Label11: TLabel
      Left = 296
      Top = 74
      Width = 33
      Height = 13
      Caption = '&C&idade'
      FocusControl = DBEditCidade
    end
    object Label12: TLabel
      Left = 576
      Top = 74
      Width = 13
      Height = 13
      Caption = '&UF'
      FocusControl = DBEditCidade
    end
    object Label13: TLabel
      Left = 16
      Top = 117
      Width = 19
      Height = 13
      Caption = 'P&a'#237's'
      FocusControl = DBEditPais
    end
    object Label14: TLabel
      Left = 296
      Top = 117
      Width = 65
      Height = 13
      Caption = 'C&omplemento'
      FocusControl = DBEditComp
    end
    object DBEditCEP: TDBEdit
      Left = 16
      Top = 43
      Width = 121
      Height = 21
      DataField = 'CEP'
      DataSource = DMClientes.DsrClientes
      MaxLength = 9
      TabOrder = 0
    end
    object DBEditLogradouro: TDBEdit
      Left = 166
      Top = 42
      Width = 404
      Height = 21
      Color = clBtnFace
      DataField = 'LOGRADOURO'
      DataSource = DMClientes.DsrClientes
      ReadOnly = True
      TabOrder = 1
    end
    object DBEditBairro: TDBEdit
      Left = 16
      Top = 90
      Width = 265
      Height = 21
      Color = clBtnFace
      DataField = 'BAIRRO'
      DataSource = DMClientes.DsrClientes
      ReadOnly = True
      TabOrder = 3
    end
    object DBEditCidade: TDBEdit
      Left = 296
      Top = 90
      Width = 274
      Height = 21
      Color = clBtnFace
      DataField = 'CIDADE'
      DataSource = DMClientes.DsrClientes
      ReadOnly = True
      TabOrder = 4
    end
    object DBEditUF: TDBEdit
      Left = 576
      Top = 90
      Width = 81
      Height = 21
      Color = clBtnFace
      DataField = 'UF'
      DataSource = DMClientes.DsrClientes
      ReadOnly = True
      TabOrder = 5
    end
    object DBEditPais: TDBEdit
      Left = 16
      Top = 132
      Width = 265
      Height = 21
      DataField = 'PAIS'
      DataSource = DMClientes.DsrClientes
      TabOrder = 6
    end
    object DBEdit10: TDBEdit
      Left = 576
      Top = 42
      Width = 81
      Height = 21
      DataField = 'NUMERO'
      DataSource = DMClientes.DsrClientes
      TabOrder = 2
    end
    object DBEditComp: TDBEdit
      Left = 296
      Top = 132
      Width = 361
      Height = 21
      DataField = 'COMPLEMENTO'
      DataSource = DMClientes.DsrClientes
      TabOrder = 7
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 441
    Top = 14
    Width = 234
    Height = 34
    DataSource = DMClientes.DsrClientes
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
    TabOrder = 2
    TabStop = True
  end
  object EdtCPFFind: TMaskEdit
    Left = 8
    Top = 21
    Width = 136
    Height = 21
    EditMask = '999.999.999-99;1;_'
    MaxLength = 14
    TabOrder = 0
    Text = '   .   .   -  '
  end
  object BitBtn1: TBitBtn
    Left = 150
    Top = 20
    Width = 155
    Height = 25
    Action = ActLocateClient
    Caption = 'Localizar!'
    TabOrder = 1
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 320
    Top = 16
    object ActLocateClient: TAction
      Caption = 'Localizar!'
      ImageIndex = 0
      OnExecute = ActLocateClientExecute
      OnUpdate = ActLocateClientUpdate
    end
    object ActGetCEPData: TAction
      ImageIndex = 1
      OnExecute = ActGetCEPDataExecute
      OnUpdate = ActGetCEPDataUpdate
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 20
    Left = 368
    Top = 16
    Bitmap = {
      494C010102000800040014001400FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFEFE00FFFFFF00FEFFFE00FFFFFF00FEFEFD00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FEFEFF00F7FD
      FE00FEFFFF00FEFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFF00FFFFFF00FEFFFF00FDFEFE00E0E0DD00F8F8F800FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FEFEFF00C4F0
      FE00E7F9FE00FEFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFF00FFFEFE00FBFEFD00D2CFCD005D564A00908E8600F7F7
      F700000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FEFEFF00C8F1
      FE0082E1FF00F8FDFE00FBFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFFFE00FDFDFD00CCCAC5005D5749004F473700B1ACA600FBFB
      FB00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEF6
      FE002FC8FD00A9EAFE00FDFEFE00FFFEFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00FCFCFC00F2F2F200EDEDED00F0F0EF00F8F8F800FDFE
      FE00FFFFFE00FDFDFD00CECCC9005D564800564D3E00B0ADA700FCFBFC00FFFF
      FF00000000000000000000000000FFFFFF00FFFEFF00FEFEFE00FEFFFE00F2FC
      FE0047D0FF0028C9FE00D8F5FF00FEFFFF00FFFFFF00FEFFFF00FFFEFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FE00FBFCFC00DFDEDD00A0A1A0007E8084007173760077797C008F919100C3C5
      C500F9F9F900D4D3D300615D54004E473600B4B0AB00F9F9F800FFFEFE00FFFF
      FF00000000000000000000000000FFFFFF00FEFEFF00FFFFFF00FEFFFF00FBFD
      FE0080E0FE0006BEFF0059D6FD00F8FDFF00FFFFFE00FEFFFE00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FEFEFE00FEFFFE00F6F6
      F600B2B1B300696865007F715E00AC8A6000C1976200B8926100927C5F006964
      5D00808182006C6D6C0069696800BCB9B600FCFDFD00FEFEFE00FEFEFE00FFFF
      FF00000000000000000000000000FFFFFF00FFFEFF00FEFEFE00FEFFFF00FDFE
      FE00BAEDFE0009C0FF0006C0FF008FE3FF00F9FDFE00FFFFFF00FDFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FEFEFE00F8F8F800A4A4
      A3006C676300C4996300F0B16300F5B56300F7B56400F6B56300F3B36500DFA8
      62008A7760005E5E5F00BCBCBB00FBFBFA00FFFFFE00FEFEFE00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FEFEFE00FDFFFE00FCFE
      FE00F0FBFF001EC6FF0005C1FE001EC7FE00CAF2FE00FCFEFF00FEFFFE00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FEFEFE00D5D5D5006767
      6600C49A6300F8B66400F6B56500F5B56400F8B66300F6B56500F5B56500F7B6
      6400E9AE64007B705F0097999900FAF9F900FEFEFE00FEFFFF00FEFEFF00FFFF
      FF00000000000000000000000000FFFFFF00FEFEFE00EEFBFF00C4EFFF00C2F0
      FE00C2F0FF0039CEFE0008C1FF0007C0FE0042CEFE00ECFBFE00FEFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FDFDFD0093939400967F
      6000F9B66300F6B56400F6B56400F7B56300F6B56300F6B56300F6B56400F6B5
      6400F8B66400C89C62006B6A6C00E1E2E200FEFEFE00FFFFFE00FEFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FEFEFE00D4F4FE0025C6FE000FC3
      FE0010C3FE000AC1FE0005C0FE0005C0FF0006BEFE0067D9FE00F5FCFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00EEEEEF0073717000C99B
      6300F8B66400F6B46500F6B56500F6B56400F6B46400F7B56500F6B56500F8B5
      6500F4B56400EDB0640079706300C4C3C400FEFEFE00FEFFFF00FFFFFD00FFFF
      FF00000000000000000000000000FFFFFF00FEFFFF00EAF9FF0037CCFF0006C0
      FF0008C1FF0009C2FE0068D9FD008AE1FD008BE1FE0094E5FF00EDFAFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00E3E4E50068656200DDA7
      6300F7B56400F7B66400F6B46300F5B56500F6B56500F5B56500F6B56400F7B5
      6300F6B56500F9B6630088776100B2B2B400FEFEFE00FFFFFE00FFFEFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FCFEFF006CD9FF0005C0
      FD0006C2FE0007C1FF0079DEFE00FBFEFE00FEFEFF00FFFEFE00FFFEFE00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00E7E8E9006C6B6700D4A2
      6300F6B66500F6B56400F6B56400F7B56400F6B56500F7B56500F7B56400F6B5
      6500F6B56500F4B4650083756100B6B8BA00FEFEFD00FFFFFF00FFFEFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FEFFFF00AEECFE0007C1
      FF0005C2FE0006C0FE0025C8FF00E5F9FF00FFFFFF00FEFFFF00FDFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F6F7F7007E7E7E00B38E
      6000FBB66300F6BC7200F7C28000F6B46200F6B46400F7B56300F6B86B00F7C2
      7F00FAB66000DFA963006D6A6500D3D2D300FEFDFE00FEFFFE00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FEFFFF00FFFFFF00EAFAFF0024C8
      FD0006C0FF0007C2FF0007C0FF009BE5FF00FEFFFE00FFFFFF00FFFEFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FEFEFD00B2B1B300766D
      6100EBAE6200F6B96E00FAD2A100F8CC9500F8C28000F7C78A00F9D3A500F8C3
      8000F5B46400A284610078787800EEEEEE00FEFFFE00FFFFFE00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFEFF00FEFFFF00FBFEFF0065D7
      FE0005C0FE0008C1FF0004C1FF0046D1FE00F2FBFF00FDFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFE00ECECEB007979
      7B008C786000EFB06200F6B76900F8C07E00F9C68800F9C48200F6BA7100F9B7
      6400BD94630069656100C5C5C500FDFDFD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FEFEFF00A7E9
      FF000AC1FE0006C1FF0007C2FE001AC4FF00CDF3FE00FDFEFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FEFEFE00DAD9
      DA007476750083746100CD9D6200E8AD6100F0B06100EBAE6200DCA56300A185
      61006A686700B3B3B300FDFDFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FEFFFD00D5F4
      FF001BC5FE0004C1FF0004C0FE0007C1FE0083DEFF00FCFEFE00FEFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FDFE
      FE00E7E6E600A0A0A0006C6B69006D675F0072675B0071675C006B6763008584
      8300CDCFCF00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3FC
      FF009CE6FE008BE1FE008AE1FE008BE2FF00A6E8FF00FDFEFF00FDFFFE00FFFE
      FF00FEFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FEFF
      FF00FEFEFE00FCFDFE00EEEDED00C8C7C600B8B7B800BDBEBF00DCDCDC00FAFA
      FB00FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFF
      FF00FDFFFF00FDFEFE00FDFEFE00FCFEFE00FCFEFE00FEFFFF00FFFEFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000140000000100010000000000F00000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
  end
end
