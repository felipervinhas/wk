program WK;

uses
  Vcl.Forms,
  unPrincipal in 'unPrincipal.pas' {FPedido},
  ObjPedido in 'ObjPedido.pas',
  ObjConexao in 'ObjConexao.pas',
  ObjPedidoItens in 'ObjPedidoItens.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPedido, FPedido);
  Application.Run;
end.
