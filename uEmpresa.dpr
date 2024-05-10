program uEmpresa;

uses
  Vcl.Forms,
  Empresa in 'Empresa.pas' {Form2},
  Articulo in 'Articulo.pas' {FormArticulo},
  Proveedor in 'Proveedor.pas' {FormProveedor},
  Cliente in 'Cliente.pas' {FormCliente},
  DMDatos in 'DMDatos.pas' {DatosDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatosDM, DatosDM);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFormArticulo, FormArticulo);
  Application.CreateForm(TFormProveedor, FormProveedor);
  Application.CreateForm(TFormCliente, FormCliente);
  Application.Run;
end.
