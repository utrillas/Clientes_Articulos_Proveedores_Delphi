unit Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFormCliente = class(TForm)
    Panel1: TPanel;
    btnAgClientes: TSpeedButton;
    Label1: TLabel;
    LAgArticulo: TLabel;
    EClNewNombre: TEdit;
    Label2: TLabel;
    EClNewDireccion: TEdit;
    Label3: TLabel;
    EClNewTelefono: TEdit;
    procedure btnAgClientesClick(Sender: TObject);
    function DejarDatos() : String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCliente: TFormCliente;

implementation

{$R *.dfm}

uses Empresa, DMDatos;

{Bot�n para a�adir un nuevo cliente}
procedure TFormCliente.btnAgClientesClick(Sender: TObject);
var sentencia, Texto: String;
begin

    //vemos si existe nombre
  if EClNewNombre.Text = '' then
    begin
      sentencia := ' ';
    end
  else
    begin
      sentencia := 'NombreCompleto ' ;
    end;
    //vemos si existe direccion
  if EClNewDireccion.Text <> '' then
    begin
      if sentencia= '' then
        begin
          sentencia := 'Direccion ' ;
        end
      else
        begin
           sentencia := sentencia + ', Direccion ' ;
        end;
    end
  else
    begin
      sentencia := sentencia +  '';
    end;
    //vemos si existe telefono
  if EClNewTelefono.Text <> '' then
    begin
      if sentencia= '' then
        begin
          sentencia := 'Telefono ' ;
        end
      else
        begin
           sentencia := sentencia + ', Telefono ' ;
        end;
    end
  else
    begin
      sentencia := sentencia + '';
    end;
   //Vamos a a�adir el Nombre
  if EClNewNombre.Text <> '' then
    begin

      Texto := QuotedSTR(EClNewNombre.Text) ;
    end
  else
    begin
      Texto := ' ';
    end;
  if EClNewDireccion.Text <> '' then
    begin
      if Texto <> '' then
        begin
            Texto := Texto + ',' + QuotedSTR(EClNewDireccion.Text);
        end
      else
        QuotedSTR(EClNewDireccion.Text);
    end
  else
    begin
      Texto := Texto + '';
    end;
  if EClNewTelefono.Text <> '' then
    begin
    if Texto <> '' then
      begin
        Texto := Texto + ', ' +  QuotedSTR(EClNewTelefono.Text) ;
      end
    else
      begin
        QuotedSTR(EClNewTelefono.Text) ;
      end;
    end
  else
    begin
      Texto := Texto + '';
    end;
    //hacemos la query
   DatosDM.ADOQueryCliente.SQL.Text := 'INSERT INTO Cliente (' + sentencia + ')'+
            'VALUES (' + Texto + ')';
   DatosDM.ADOQueryCliente.ExecSQL;
  DejarDatos();
  if MessageDlg('�Desea agregar un nuevo cliente?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DejarDatos();
    end
  else
    begin
      DejarDatos();
      close;
    end;

 end;
function TFormCliente.DejarDatos: String;
begin
  EClNewNombre.Text := '';
  EClNewDireccion.Text:='';
  EClNewTelefono.Text:='';
end;

end.
