unit DMDatos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDatosDM = class(TDataModule)
    DataSourceProveedor: TDataSource;
    ADOConnection1: TADOConnection;
    ADOQueryProveedor: TADOQuery;
    ADOQueryCliente: TADOQuery;
    ADOQueryArticulo: TADOQuery;
    DataSourceArticulo: TDataSource;
    DataSourceCliente: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DatosDM: TDatosDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Empresa;

{$R *.dfm}

end.
