unit ObjPedido;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Inifiles, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, ObjConexao,
  System.SysUtils;

  type
    CCliente = record
      FCliente : String;
      FCidade : String;
      FEstado : String;
    end;
  type
    TPedido= class

    procedure SetData_Pedido(const Value: TDateTime);
    procedure SetID_Cliente(const Value: Integer);
    procedure SetPedido(const Value: Integer);
    procedure SetValor_Total(const Value: Currency);

    private
      FConexao : TConexaoBanco;
      FPedido : Integer;
      FData_Pedido : TDateTime;
      FID_Cliente : Integer;
      FValor_Total : Currency;

    public

      property Pedido :Integer read FPedido write SetPedido;
      property Data_Pedido :TDateTime read FData_Pedido write SetData_Pedido;
      property ID_Cliente :Integer read FID_Cliente write SetID_Cliente;
      property Valor_Total :Currency read FValor_Total write SetValor_Total;

      constructor Create;
      destructor Destroy;

      function Insert : Integer;
      function Edit(Ppedido : string) : Boolean;
      function Delete(Ppedido : string) : Boolean;
      Function Search(Ppedido : string) : Boolean;
      function Auxiliar(SQL : String) : String;

    end;


implementation

{TPedido}


function TPedido.Auxiliar(SQL: String): String;
var
  Qry : TFDQuery;
begin
  try

    if (FConexao = nil) then
        FConexao := TConexaoBanco.Create;

    Qry := TFDQuery.Create(Nil);
    Qry.Connection := FConexao.ConexaoBanco;

    try

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := SQL;
      Qry.Open;
      if not (Qry.IsEmpty) then
      begin
        Result := Qry.FieldByName('NOME').AsString + ' - ' +
                  Qry.FieldByName('CIDADE').AsString + '/' +
                  Qry.FieldByName('ESTADO').AsString
      end
      Else
      begin
        Result := 'Cliente não encontrado';
      end;


    Except
      Result := '';
    end;

  finally
    Qry.Free;
  end;
end;

constructor TPedido.Create;
begin

end;

function TPedido.Delete(Ppedido : string): Boolean;
var
  Qry : TFDQuery;
begin
  try

    if (FConexao = nil) then
        FConexao := TConexaoBanco.Create;


    Qry := TFDQuery.Create(Nil);
    Qry.Connection := FConexao.ConexaoBanco;

    try

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'DELETE FROM `pedido` WHERE pedido = ' + Ppedido + '';
      Qry.OpenOrExecute;

      Result := true;
    Except
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;

destructor TPedido.Destroy;
begin

end;

function TPedido.Edit(Ppedido : string): Boolean;
var
  Qry : TFDQuery;
begin
  try

    if (FConexao = nil) then
        FConexao := TConexaoBanco.Create;

    Qry := TFDQuery.Create(Nil);
    Qry.Connection := FConexao.ConexaoBanco;

    try

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'UPDATE `pedido`' +
                      '  SET `DATA_PEDIDO` = ''' + FormatDateTime('yyyy-mm-dd',FData_Pedido) + ''',' +
                      '      `ID_CLIENTE` = ''' + IntToStr(FID_Cliente) + '''' +
                      ' WHERE `pedido`.`PEDIDO` = ''' + pPedido + '''';
      Qry.OpenOrExecute;

      Result := true;
    Except
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;

function TPedido.Insert: Integer;
var
  Qry : TFDQuery;
begin
  try
    if (FConexao = nil) then
        FConexao := TConexaoBanco.Create;
    Qry := TFDQuery.Create(Nil);
    Qry.Connection := FConexao.ConexaoBanco;

    try

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'INSERT INTO `pedido`' +
                      '(`DATA_PEDIDO`, `ID_CLIENTE`)' +
                      ' VALUES' +
                      '(''' + FormatDateTime('yyyy-mm-dd',FData_Pedido) + ''',' +
                      '''' + IntToStr(FID_Cliente) + ''');';
      Qry.ExecSQL;

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'Select Pedido from Pedido order by pedido desc LIMIT 0, 1';
      Qry.Open;
      Result := Qry.Fields[0].AsInteger;
    Except
      Result := 0;
    end;

  finally
    Qry.Free;
  end;
end;

function TPedido.Search(Ppedido: string): Boolean;
var
  Qry : TFDQuery;
begin
  try

    try
      FConexao := TConexaoBanco.Create;
      Qry := TFDQuery.Create(nil);
      Qry.Connection := FConexao.ConexaoBanco;

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'SELECT * FROM `pedido` WHERE pedido = ' + Ppedido + '';
      Qry.Open;

      if (Qry.IsEmpty) then
      begin
        Result := False;
      end
      else
      Result := true;
    Except
      Qry.Free;
    end;

  finally
    //FControle.Qry.Free;
  end;
end;


procedure TPedido.SetData_Pedido(const Value: TDateTime);
begin
  FData_Pedido := Value;
end;

procedure TPedido.SetID_Cliente(const Value: Integer);
begin
  FID_Cliente := Value;
end;

procedure TPedido.SetPedido(const Value: Integer);
begin
  FPedido := Value;
end;

procedure TPedido.SetValor_Total(const Value: Currency);
begin
  FValor_Total := Value;
end;

end.
