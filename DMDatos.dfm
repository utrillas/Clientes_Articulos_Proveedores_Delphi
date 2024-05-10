object DatosDM: TDatosDM
  Height = 600
  Width = 800
  object DataSourceProveedor: TDataSource
    DataSet = ADOQueryProveedor
    Left = 192
    Top = 96
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=GRUPOCIE-2024;Persist Security Info' +
      '=True;User ID=sa;Initial Catalog=Empresa;Data Source=CARMEN-UTRI' +
      'LLAS\SQLEXPRESS'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 314
    Top = 19
  end
  object ADOQueryProveedor: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Proveedor')
    Left = 454
    Top = 96
  end
  object ADOQueryCliente: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Cliente')
    Left = 461
    Top = 154
  end
  object ADOQueryArticulo: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Articulo')
    Left = 461
    Top = 221
  end
  object DataSourceArticulo: TDataSource
    DataSet = ADOQueryArticulo
    Left = 192
    Top = 230
  end
  object DataSourceCliente: TDataSource
    DataSet = ADOQueryCliente
    Left = 186
    Top = 154
  end
end
