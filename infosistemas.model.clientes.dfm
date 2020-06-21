object DMClientes: TDMClientes
  OldCreateOrder = False
  Height = 227
  Width = 285
  object CdsClientes: TClientDataSet
    PersistDataPacket.Data = {
      840100009619E0BD01000000180000000D000000000003000000840103435046
      0100490004000100055749445448020002000E00044E4F4D4501004900040001
      00055749445448020002001E000A4944454E5449444144450100490004000100
      0557494454480200020014000854454C45464F4E450100490004000100055749
      445448020002001400044D41494C010049000400010005574944544802000200
      1E000343455001004900040001000557494454480200020009000A4C4F475241
      444F55524F0100490004000100055749445448020002002800064E554D45524F
      02000100040000000B434F4D504C454D454E544F010049000000010005574944
      5448020002000F000642414952524F0100490004000100055749445448020002
      001E00064349444144450100490004000100055749445448020002001E000255
      4601004900040001000557494454480200020002000450414953010049000400
      0100055749445448020002001E0001000D44454641554C545F4F524445520200
      8200010000000100}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CPF'
        Attributes = [faRequired]
        DataType = ftString
        Size = 14
      end
      item
        Name = 'NOME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'IDENTIDADE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TELEFONE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MAIL'
        Attributes = [faRequired]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'CEP'
        Attributes = [faRequired]
        DataType = ftString
        Size = 9
      end
      item
        Name = 'LOGRADOURO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 40
      end
      item
        Name = 'NUMERO'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'COMPLEMENTO'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'BAIRRO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'CIDADE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'UF'
        Attributes = [faRequired]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'PAIS'
        Attributes = [faRequired]
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
        Fields = 'CPF'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    Params = <>
    StoreDefs = True
    BeforePost = CdsClientesBeforePost
    AfterPost = CdsClientesAfterPost
    Left = 48
    Top = 40
    object CdsClientesCPF: TStringField
      FieldName = 'CPF'
      Required = True
      OnValidate = CdsClientesCPFValidate
      EditMask = '999.999.909-99;1;_'
      Size = 14
    end
    object CdsClientesNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 30
    end
    object CdsClientesIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
      Required = True
    end
    object CdsClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Required = True
      EditMask = '!\(99\)00000-0000;1;_'
    end
    object CdsClientesMAIL: TStringField
      FieldName = 'MAIL'
      Required = True
      Size = 30
    end
    object CdsClientesCEP: TStringField
      FieldName = 'CEP'
      Required = True
      EditMask = '99999-999;1;_'
      Size = 9
    end
    object CdsClientesLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Required = True
      Size = 40
    end
    object CdsClientesNUMERO: TSmallintField
      FieldName = 'NUMERO'
      Required = True
    end
    object CdsClientesCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 15
    end
    object CdsClientesBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Required = True
      Size = 30
    end
    object CdsClientesCIDADE: TStringField
      FieldName = 'CIDADE'
      Required = True
      Size = 30
    end
    object CdsClientesUF: TStringField
      FieldName = 'UF'
      Required = True
      Size = 2
    end
    object CdsClientesPAIS: TStringField
      FieldName = 'PAIS'
      Required = True
      Size = 30
    end
  end
  object DsrClientes: TDataSource
    DataSet = CdsClientes
    Left = 112
    Top = 40
  end
end
