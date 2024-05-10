unit Empresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.UITypes, Vcl.DBCtrls;

type
  TForm2 = class(TForm)
    GridArticulo: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    PArticulo: TTabSheet;
    PCliente: TTabSheet;
    PProveedor: TTabSheet;
    GridProveedor: TDBGrid;
    Label1: TLabel;
    ImageCollection1: TImageCollection;
    btnAgregar: TSpeedButton;
    btnBorrar: TSpeedButton;
    btnBuscar: TSpeedButton;
    btnSalida: TSpeedButton;
    btnPrimero: TSpeedButton;
    btnUltimo: TSpeedButton;
    btnAvanzar: TSpeedButton;
    btnRetroceder: TSpeedButton;
    Panel3: TPanel;
    LColumna: TLabel;
    EColumna: TEdit;
    LName: TLabel;
    ETexto: TEdit;
    btnRefrest: TSpeedButton;
    CheckCol: TCheckBox;
    BtnAgregarLinea: TButton;
    btnAceptar: TButton;
    GridCliente: TDBGrid;
    btnModificar: TSpeedButton;
    ComboBox1: TComboBox;
    procedure btnSalidaClick(Sender: TObject);
    procedure btnPrimeroClick(Sender: TObject);
    procedure btnRetrocederClick(Sender: TObject);
    procedure btnAvanzarClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    function DarDatos (Columna, Texto:String):String;
    function DarConexion(): TADOQuery;
    function DarTabla():String;
    procedure btnRefrestClick(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    function DejarColumnas():String;
    function IniciarConexion(): String;
    procedure FormCreate(Sender: TObject);
    procedure BtnAgregarLineaClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    function VisibilizarTablas(): String;
    procedure btnModificarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Columna, Texto : String;

implementation

{$R *.dfm}

uses Articulo, Cliente, Proveedor, DMDatos;

{Para cuando se inicializa el programa se creen las conexiones}
procedure TForm2.FormCreate(Sender: TObject);
begin
  IniciarConexion();
  VisibilizarTablas();
end;

{Aceptar las modificaciones/nueva linea}
procedure TForm2.btnAceptarClick(Sender: TObject);
begin
     if PageControl1.ActivePage = PArticulo then
      begin
        DatosDM.ADOQueryArticulo.Post;
      end
    else if PageControl1.ActivePage = PCliente then
      begin
        DatosDM.ADOQueryCliente.Post;
      end
    else
      begin
        DatosDM.ADOQueryProveedor.Post;
      end;
end;

procedure TForm2.btnAgregarClick(Sender: TObject);
var tabla: String;
begin
tabla := DarTabla();
  if tabla = 'Articulo' then
    begin
      FormArticulo.ShowModal;

    end
  else if tabla = 'Cliente' then
    begin
      FormCliente.ShowModal;
      btnRefrestClick(nil);
    end
  else
    begin
      FormProveedor.ShowModal;
    end;
end;

{Añadir una linea a la tabla}
procedure TForm2.BtnAgregarLineaClick(Sender: TObject);
begin
     if PageControl1.ActivePage = PArticulo then
      begin
        DatosDM.ADOQueryArticulo.Append;
      end
    else if PageControl1.ActivePage = PCliente then
      begin
        DatosDM.ADOQueryCliente.Append;
      end
    else
      begin
        DatosDM.ADOQueryProveedor.Append;
      end;
end;

{Para avanzar en los datos}
procedure TForm2.btnAvanzarClick(Sender: TObject);
  begin
    if PageControl1.ActivePage = PArticulo then
      begin
        DatosDM.ADOQueryArticulo.Next;
      end
    else if PageControl1.ActivePage = PCliente then
      begin
        DatosDM.ADOQueryCliente.Next;
      end
    else
      begin
        DatosDM.ADOQueryProveedor.Next;
      end;
  end;

{Botón de borrado de registros}
procedure TForm2.btnBorrarClick(Sender: TObject);
var condicion: String;
var conexion: TADOQuery;
var tabla: String;
var Grid: TDBGrid;
  begin
   conexion := DarConexion();
   if MessageDlg('¿seguro que quiere borrar el registro?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        conexion.Delete;
        ShowMessage('Se ha borrado correctamente el/los registro/s');
      end;
  end;

{Buscar un dato}
procedure TForm2.btnBuscarClick(Sender: TObject);
var condicion: String;
var conexion: TADOQuery;
var tabla: String;
  begin
    condicion := DarDatos(EColumna.Text, ETexto.Text);
    conexion := DarConexion();
    tabla := DarTabla();

    if (condicion <> '') AND (tabla <> '') then
     begin
      conexion.SQL.Clear;
      conexion.SQL.Text:='SELECT * FROM ' + tabla
      + ' WHERE ' + condicion;
      conexion.Open;
     end;
  DejarColumnas();
  end;

{Botón para ir al primer registro}
procedure TForm2.btnPrimeroClick(Sender: TObject);
begin
  if PageControl1.ActivePage = PArticulo then
    begin
       DatosDM.ADOQueryArticulo.First;
    end
  else if PageControl1.ActivePage = PCliente then
    begin
       DatosDM.ADOQueryCliente.First;
    end
  else
    begin
       DatosDM.ADOQueryProveedor.First;
    end;
  end;

{Botón para ir al anterior registro}
procedure TForm2.btnRetrocederClick(Sender: TObject);
begin
  if PageControl1.ActivePage = PArticulo then
    begin
       DatosDM.ADOQueryArticulo.Prior;
    end
  else if PageControl1.ActivePage = PCliente then
    begin
       DatosDM.ADOQueryCliente.Prior;
    end
  else
    begin
       DatosDM.ADOQueryProveedor.Prior;
    end;
  end;

{Botón para ir al último registro}
procedure TForm2.btnUltimoClick(Sender: TObject);
begin
  if PageControl1.ActivePage = PArticulo then
    begin
       DatosDM.ADOQueryArticulo.Last;
    end
  else if PageControl1.ActivePage = PCliente then
    begin
       DatosDM.ADOQueryCliente.Last;
    end
  else
    begin
       DatosDM.ADOQueryProveedor.Last;
    end;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  if Form2.ComboBox1.ItemIndex = 0 then
    begin
      Form2.PageControl1.ActivePage := PArticulo;
      Form2.Color := clGreen;
    end
  else if Form2.ComboBox1.ItemIndex = 1  then
    begin
      Form2.PageControl1.ActivePage := PCliente;
      Form2.Color := clBlue;
    end
  else if Form2.ComboBox1.ItemIndex = 2 then
    begin
      Form2.PageControl1.ActivePage := PProveedor;
      Form2.Color := clYellow;
    end;


end;

{Conexion}
  function TForm2.DarConexion(): TADOQuery;
begin
  Result := nil;
  if PageControl1.ActivePage = PArticulo then
    begin
      Result :=  DatosDM.ADOQueryArticulo;
    end
  else if PageControl1.ActivePage = PCliente then
    begin
      Result :=  DatosDM.ADOQueryCliente;
    end
  else if PageControl1.ActivePage = PProveedor then
       
    begin
     Result :=  DatosDM.ADOQueryProveedor;
    end;
end;

{Función para recoger los datos de los edit}
//***AQUI SE PODRIA PONER LO DEL COMBOBOX PARA DECIRLE QUE TABLA ES***
function TForm2.DarDatos(Columna, Texto: String): String;
var Filtro: String;
begin;
Filtro := '';
  if (EColumna.Text <> '') AND (ETexto.Text <> '') then
    begin
        Filtro := ' ' + EColumna.Text + ' = ' + QuotedSTR(ETexto.Text) ;
    end
  else
    ShowMessage('Introduzca los datos');
  Result := Filtro;
end;

{Forma de buscar la tabla}
function TForm2.DarTabla: String;
  begin
    if PageControl1.ActivePage = PArticulo then
    begin
      Result := 'Articulo';
    end
    else if PageControl1.ActivePage = PCliente then
    begin
      Result := 'Cliente';
    end
    else
    begin
     Result := 'Proveedor';
    end;
  end;

{Para mantener las columas}
function TForm2.DejarColumnas: String;
begin
  if CheckCol.Checked = True then
    begin
      ETexto.Text := '';
    end
  else
    begin
      EColumna.Text := '';
      ETexto.Text := '';
    end;
end;

{Se crea función para que se conecten por codigo por la base de datos}
function TForm2.IniciarConexion: String;
begin
  DatosDM.ADOConnection1.Open;
  DatosDM.ADOQueryArticulo.Open;
  DatosDM.ADOQueryCliente.Open;
  DatosDM.ADOQueryProveedor.Open;
end;

procedure TForm2.btnModificarClick(Sender: TObject);
 var PProveedor: Tform;
begin
     if PageControl1.ActivePage = PArticulo then
    begin
      //hola
    end
  else if PageControl1.ActivePage = PCliente then
    begin
      //hola
    end
  else
    begin
      FormProveedor.ShowModal;
    end;
end;

{Para visibilizar las tablas}
function TForm2.VisibilizarTablas: String;
var conexion: TADOQuery;
var tabla : String;
begin
    conexion := DarConexion();
    tabla := DarTabla();
     begin
      conexion.SQL.Clear;
      conexion.SQL.Text:='SELECT * FROM ' + tabla;
      conexion.Open;
     end;
end;

{Refrescar las tablas}
procedure TForm2.btnRefrestClick(Sender: TObject);
begin
  VisibilizarTablas();
end;

{Botón de salir de la aplicación}
procedure TForm2.btnSalidaClick(Sender: TObject);
  begin
    Close;
  end;
end.
