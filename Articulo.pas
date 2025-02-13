unit Articulo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Buttons, Data.Win.ADODB, Data.DB;

type
  TFormArticulo = class(TForm)
    btnNewArticulo: TSpeedButton;
    LAgArticulo: TLabel;
    LAgMarca: TLabel;
    Articulo: TEdit;
    Marca: TEdit;
    Panel1: TPanel;
    Label1: TLabel;
    procedure btnNewArticuloClick(Sender: TObject);
    function DejarDatos(): String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormArticulo: TFormArticulo;

implementation

{$R *.dfm}

uses Empresa, DMDatos;

procedure TFormArticulo.btnNewArticuloClick(Sender: TObject);
var sentencia, Texto: String;
begin
 {Comprobamos las columnas}
    //vemos si existe nombre
  if Articulo.Text = '' then
    begin
      sentencia := ' ';
    end
  else
    begin
      sentencia := 'NombreArticulo ' ;
    end;
    //comprobar si existe marca
     if Marca.Text <> '' then
    begin
      if sentencia= '' then
        begin
          sentencia := 'Marca ' ;
        end
      else
        begin
           sentencia := sentencia + ', Marca ' ;
        end;
    end
  else
    begin
      sentencia := sentencia +  '';
    end;
{Comprobamos las filas}
     if Articulo.Text <> '' then
    begin

      Texto := QuotedSTR(Articulo.Text) ;
    end
  else
    begin
      Texto := ' ';
    end;
  if Marca.Text <> '' then
    begin
    if Texto <> '' then
      begin
        Texto := Texto + ', ' +  QuotedSTR(Marca.Text) ;
      end
    else
      begin
        QuotedSTR(Marca.Text) ;
      end;
    end
  else
    begin
      Texto := Texto + '';
    end;
    DatosDM.ADOQueryArticulo.SQL.Text := 'INSERT INTO Articulo (' + sentencia + ')'+
                                        'VALUES (' + Texto + ')';
    DatosDM.ADOQueryArticulo.ExecSQL;
  if MessageDlg('�Desea agregar un nuevo articulo?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DejarDatos();
    end
  else
    begin
      DejarDatos();
      close;
    end;
 Form2.VisibilizarTablas();
end;

function TFormArticulo.DejarDatos: String;
begin
  Articulo.Text := '';
  Marca.Text:='';
end;
end.
