unit ObjPedidoItens;

interface

uses Data.DB, FireDAC.Comp.Client,
  Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.DataSet, ObjConexao,
  System.SysUtils;

  type
    TPedidoItens = class

    procedure SetID_Item(const Value: Integer);
    procedure SetID_Produto(const Value: Integer);
    procedure SetPedido(const Value: Integer);
    procedure SetQuantidade(const Value: Currency);
    procedure SetValor_Total(const Value: Currency);
    procedure SetValor_Unitario(const Value: Currency);

    private
      FConexao : TConexaoBanco;
      FPedido : Integer;
      FID_Item : Integer;
      FID_Produto : Integer;
      FQuantidade : Currency;
      FValor_Unitario : Currency;
      FValor_Total : Currency;

    public

      property Pedido :Integer read FPedido write SetPedido;
      property ID_Item :Integer read FID_Item write SetID_Item;
      property ID_Produto :Integer read FID_Produto write SetID_Produto;
      property Quantidade :Currency read FQuantidade write SetQuantidade;
      property Valor_Unitario :Currency read FValor_Unitario write SetValor_Unitario;
      property Valor_Total :Currency read FValor_Total write SetValor_Total;

      constructor Create;
      destructor Destroy;

      function Insert : Boolean;
      function Edit(Ppedido : string) : Boolean;
      function Delete(Pid_Item : string) : Boolean;
      function Search(Ppedido : string) : Boolean;
      function Auxiliar(SQL, Campo : String) : String;
      Function AtualizarValorTotal(Ppedido : String) : Currency;
    end;


implementation

{TPedido}


constructor TPedidoItens.Create;
begin

end;

function TPedidoItens.Delete(Pid_Item : string): Boolean;
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
      Qry.SQL.Text := 'DELETE FROM `pedido_itens` WHERE ID_Item = ' + Pid_Item + '';
      Qry.OpenOrExecute;

      Result := true;
    Except
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;

destructor TPedidoItens.Destroy;
begin

end;

function TPedidoItens.Edit(Ppedido : string): Boolean;
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
      Qry.SQL.Text := 'UPDATE `pedido_itens`' +
                      ' SET `ID_PRODUTO` = ''' + IntToStr(FID_Produto) + ''',' +
                      '     `QUANTIDADE` = ''' + CurrToStr(FQuantidade) + ''',' +
                      '     `VALOR_UNITARIO` = ''' + CurrToStr(FValor_Unitario) + ''',' +
                      '     `VALOR_TOTAL` = ''' + CurrToStr(FValor_Total) + '''' +
                      ' WHERE `pedido_itens`.`ID_ITEM` = ''' + IntToStr(FID_Item) + ''';';
      Qry.OpenOrExecute;

      Result := true;
    Except
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;

function TPedidoItens.Insert: Boolean;
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
      Qry.SQL.Text := 'INSERT INTO `pedido_itens`' +
                      ' (`PEDIDO`,' +
                      '  `ID_PRODUTO`,' +
                      '  `QUANTIDADE`,' +
                      '  `VALOR_UNITARIO`,' +
                      '  `VALOR_TOTAL`)' +
                      '  VALUES' +
                      '  (''' +  IntToStr(FPedido) + ''',' +
                      '''' + IntToStr(FID_Produto) + ''',' +
                      '''' + StringReplace(CurrToStr(FQuantidade),',','.',[rfReplaceAll]) + ''',' +
                      '''' + StringReplace(CurrToStr(FValor_Unitario),',','.',[rfReplaceAll]) + ''',' +
                      '''' + StringReplace(CurrToStr(FValor_Total),',','.',[rfReplaceAll]) + ''')';
      Qry.OpenOrExecute;

      Result := true;
    Except
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;

function TPedidoItens.Search(Ppedido: string): Boolean;
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
      Qry.SQL.Text := 'SELECT * FROM `pedido_itens` WHERE pedido = ' + Ppedido + '';
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
    Qry.Free;
  end;
end;

Function TPedidoItens.AtualizarValorTotal(Ppedido : String) : Currency;
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
      Qry.SQL.Text := 'UPDATE pedido' +
                      ' SET Valor_Total = (SELECT SUM(Valor_Total)' +
                      ' FROM Pedido_Itens' +
                      ' WHERE Pedido_Itens.Pedido = ''' + Ppedido + '''' +
                      ' GROUP BY Pedido_Itens.Pedido)' +
                      ' WHERE Pedido.Pedido = ''' + Ppedido + '''';

      Qry.ExecSQL;


      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'Select Valor_Total From Pedido Where Pedido = ''' + Ppedido + '''';
      Qry.Open;
      Result := Qry.Fields[0].AsCurrency;

    Except
    end;

  finally
    Qry.Free;
  end;
end;

function TPedidoItens.Auxiliar(SQL, Campo: String): String;
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

      if (Qry.FieldByName(Campo).AsString <> '') then
      begin
        Result := Qry.FieldByName(Campo).AsString
      end
      else
      Result := '';

    Except
      Result := '';
    end;

  finally
    Qry.Free;
  end;
end;

procedure TPedidoItens.SetID_Item(const Value: Integer);
begin
  FID_Item := Value;
end;

procedure TPedidoItens.SetID_Produto(const Value: Integer);
begin
  FID_Produto := Value;
end;

procedure TPedidoItens.SetPedido(const Value: Integer);
begin
  FPedido := Value;
end;

procedure TPedidoItens.SetQuantidade(const Value: Currency);
begin
  FQuantidade := Value;
end;

procedure TPedidoItens.SetValor_Total(const Value: Currency);
begin
  FValor_Total := Value;
end;

procedure TPedidoItens.SetValor_Unitario(const Value: Currency);
begin
  FValor_Unitario := Value;
end;

end.
