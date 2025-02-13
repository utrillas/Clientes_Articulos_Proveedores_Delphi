unit Proveedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFormProveedor = class(TForm)
    btnModificarP: TSpeedButton;
    Panel1: TPanel;
    LAgArticulo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    PVendedor: TDBEdit;
    PTelefono: TDBEdit;
    PEmpresa: TDBEdit;
    procedure btnModificarPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProveedor: TFormProveedor;

implementation

{$R *.dfm}

uses Empresa, DMDatos;
procedure TFormProveedor.btnModificarPClick(Sender: TObject);
begin
  DatosDM.ADOQueryProveedor.Post;
  ShowMessage('Dato/s modificado/s correctamente');
  close;
end;
end.
