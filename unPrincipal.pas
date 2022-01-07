unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, ObjPedido, ObjPedidoItens,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.ExtCtrls, ObjConexao, System.UITypes;

type
  TFPedido = class(TForm)
    LabelPedido: TLabel;
    EditPedido: TEdit;
    LabelData: TLabel;
    EditData: TEdit;
    LabelCodigoCliente: TLabel;
    GridPedidoItens: TDBGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GrdPedidos: TDBGrid;
    Pedidos: TFDQuery;
    dsPedidos: TDataSource;
    PedidosPEDIDO: TFDAutoIncField;
    PedidosDATA_PEDIDO: TDateField;
    PedidosID_CLIENTE: TIntegerField;
    PedidosVALOR_TOTAL: TBCDField;
    GridPedido: TGridPanel;
    LabelNome: TLabel;
    BtnConfirmarPedido: TButton;
    Pedido_Itens: TFDQuery;
    dsPedido_Itens: TDataSource;
    Pedido_ItensPEDIDO: TIntegerField;
    Pedido_ItensID_ITEM: TFDAutoIncField;
    Pedido_ItensID_PRODUTO: TIntegerField;
    Pedido_ItensQUANTIDADE: TBCDField;
    Pedido_ItensVALOR_UNITARIO: TBCDField;
    Pedido_ItensVALOR_TOTAL: TBCDField;
    Label1: TLabel;
    Pedido_ItensDESCRICAO: TStringField;
    PedidosDESCRICAO_CLIENTE: TStringField;
    GridPanel1: TGridPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditCodigo_Produto: TEdit;
    EditDescricao: TEdit;
    EditQuantidade: TEdit;
    PanelProduto: TPanel;
    Label5: TLabel;
    EditValor_Unitario: TEdit;
    BtnConfirmarItens: TButton;
    LabelValor: TLabel;
    EditCodigoCliente: TEdit;
    EditNomeCliente: TEdit;
    EditValor_Total: TEdit;
    PanelTop: TPanel;
    btnInserir: TButton;
    BtnInicializarCadastros: TButton;
    Label6: TLabel;
    LabelWK: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridPedidoItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPedidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnConfirmarPedidoClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Pedido_ItensCalcFields(DataSet: TDataSet);
    procedure PedidosCalcFields(DataSet: TDataSet);
    procedure BtnConfirmarItensClick(Sender: TObject);
    procedure EditValor_UnitarioExit(Sender: TObject);
    procedure EditCodigo_ProdutoExit(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure EditCodigoClienteExit(Sender: TObject);
    procedure BtnInicializarCadastrosClick(Sender: TObject);
    procedure Pedido_ItensAfterScroll(DataSet: TDataSet);
    procedure BtnConfirmarPedidoExit(Sender: TObject);
    procedure Pedido_ItensBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }

    FConexao : TConexaoBanco;
    FPedido : TPedido;
    FPedidoItens : TPedidoItens;

  public
    { Public declarations }
  end;

var
  FPedido: TFPedido;

implementation

{$R *.dfm}

procedure TFPedido.BtnConfirmarPedidoClick(Sender: TObject);
begin
  if (EditData.Text = '') then
  begin
    ShowMessage('Preencha Corretamente o Campo Data do Pedido');
    EditData.SetFocus;
    Abort;
  end;
  if (EditPedido.Text = '') then
  begin
    FPedido.Pedido := -1
  end
  else
  FPedido.Pedido := StrToInt(EditPedido.Text);

  FPedido.Data_Pedido := StrToDate(EditData.Text);
  FPedido.ID_Cliente := StrToInt(EditCodigoCliente.Text);

  if NOT (FPedido.Search(EditPedido.Text)) then
  begin
    FPedido.Pedido := FPedido.Insert;
    EditPedido.Text := FPedido.Pedido.ToString
  end
  else
  FPedido.Edit(EditPedido.Text);

  Pedido_itens.close;
  Pedido_itens.open;

  BtnConfirmarPedido.Caption := 'Confirmar';
  EditCodigo_Produto.SetFocus;
end;

procedure TFPedido.BtnConfirmarPedidoExit(Sender: TObject);
begin
  BtnConfirmarPedido.Caption := 'Confirmar';
end;

procedure TFPedido.GridPedidoItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_delete then
  begin
      if MessageDlg('Deseja realmente Excluir o Item do Pedido?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
      begin
          if FPedidoItens.Delete(Pedido_ItensID_ITEM.AsString) then
          begin
            ShowMessage('Pedido Excluido com Sucesso!!!');
            Pedido_Itens.Close;
            Pedido_Itens.Open;

            EditValor_Total.Text := FormatFloat('0.00',FPedidoItens.AtualizarValorTotal(PedidosPEDIDO.AsString));

          end;
      end;
  end;
  if Key = VK_RETURN then
  begin
    EditCodigo_Produto.SetFocus;
    BtnConfirmarItens.Caption := 'Alterando - Confirmar';
  end;
end;

procedure TFPedido.PedidosCalcFields(DataSet: TDataSet);
begin
  if PedidosID_CLIENTE.AsInteger <> 0 then
  begin
    PedidosDESCRICAO_CLIENTE.AsString := FPedido.Auxiliar('Select * from Clientes Where ID = ''' + PedidosID_CLIENTE.AsString + '''');
  end;
end;

procedure TFPedido.Pedido_ItensAfterScroll(DataSet: TDataSet);
begin
  if not (Pedido_Itens.IsEmpty) then
  begin
    FPedidoItens.Pedido := Pedido_ItensPEDIDO.AsInteger;
    FPedidoItens.ID_Item := Pedido_ItensID_ITEM.AsInteger;
    FPedidoItens.ID_Produto := Pedido_ItensID_PRODUTO.AsInteger;
    FPedidoItens.Quantidade := Pedido_ItensQUANTIDADE.AsCurrency;
    FPedidoItens.Valor_Unitario := Pedido_ItensVALOR_UNITARIO.AsCurrency;
    FPedidoItens.Valor_Total := Pedido_ItensVALOR_TOTAL.AsCurrency
  end
  else
  begin
    FPedidoItens.Pedido := PedidosPEDIDO.AsInteger;
    FPedidoItens.ID_Item := 0;
    FPedidoItens.ID_Produto := 0;
    FPedidoItens.Quantidade := 0;
    FPedidoItens.Valor_Unitario := 0;
    FPedidoItens.Valor_Total := 0;
  end;



  EditCodigo_Produto.Text := FPedidoItens.ID_Produto.ToString;
  EditDescricao.Text := Pedido_ItensDESCRICAO.AsString;
  EditQuantidade.Text := FormatFloat('0.00',FPedidoItens.Quantidade);
  EditValor_Unitario.Text := FormatFloat('0.00',FPedidoItens.Valor_Unitario);
end;

procedure TFPedido.Pedido_ItensBeforeOpen(DataSet: TDataSet);
begin
  Pedido_Itens.ParamByName('Pedido').AsString := FPedido.Pedido.ToString;
end;

procedure TFPedido.Pedido_ItensCalcFields(DataSet: TDataSet);
begin
  if Pedido_ItensID_PRODUTO.AsInteger <> 0 then
  begin
    Pedido_ItensDESCRICAO.AsString := FPedidoItens.Auxiliar('Select * from Produtos where id = ''' + Pedido_ItensID_PRODUTO.AsString + '''','DESCRICAO');
  end;
end;

procedure TFPedido.BtnConfirmarItensClick(Sender: TObject);
begin

  FPedidoItens.ID_Produto := StrToInt(EditCodigo_Produto.Text);
  FPedidoItens.Pedido := StrToInt(EditPedido.Text);
  FPedidoItens.Quantidade := StrToCurr(EditQuantidade.Text);
  FPedidoItens.Valor_Unitario := StrToCurr(EditValor_Unitario.Text);

  if (EditCodigo_Produto.Text = '') or  (EditCodigo_Produto.Text = '0') then
  begin
    ShowMessage('Preencha Corretamente o Código do Produto.');
    EditCodigo_Produto.SetFocus;
    abort;
  end;
  if (FPedidoItens.Quantidade <= 0) then
  begin
    ShowMessage('Preencha Corretamente a Quantidade');
    EditQuantidade.SetFocus;
    abort;
  end;
  if (FPedidoItens.Valor_Unitario <= 0) then
  begin
    ShowMessage('Preencha Corretamente o Valor Unitário');
    EditValor_Unitario.SetFocus;
    abort;
  end;

  if (FPedidoItens.ID_Item  = -1) or (FPedidoItens.ID_Item  = 0) then
  begin
    FPedidoItens.Insert
  end
  else
  FPedidoItens.Edit(FPedidoItens.ID_Item.ToString);

  EditValor_Total.Text := FormatFloat('0.00',FPedidoItens.AtualizarValorTotal(FPedido.Pedido.ToString));

  BtnConfirmarItens.Caption := 'Confirmar';

  Pedido_Itens.Close;
  Pedido_Itens.Open;

  if not (Pedido_Itens.IsEmpty) then
  begin
    GridPedidoItens.DataSource.DataSet.Locate('PEDIDO',EditPedido.Text ,[loCaseInsensitive])
  end;

end;

procedure TFPedido.btnInserirClick(Sender: TObject);
begin
  if (PageControl1.ActivePage = TabSheet1) then
  begin
    FPedido.Pedido := -1;
    BtnConfirmarPedido.Caption := 'Inserindo Pedido - Confirmar';
    PageControl1.ActivePage := TabSheet2;
    EditPedido.Text := '';
    EditCodigoCliente.Text := '';
    EditNomeCliente.Text := '';
    EditValor_Total.Text := '0,00';
    EditData.Text := DateToStr(now);
    EditData.SetFocus;
    abort;
  end;
  if (PageControl1.ActivePage = TabSheet2) then
  begin
    FPedidoItens.ID_Item := -1;
    BtnConfirmarItens.Caption := 'Inserindo - Confirmar';
    EditCodigo_Produto.Text := '';
    EditDescricao.Text := '';
    EditQuantidade.Text := '';
    EditValor_Unitario.Text := '';
    EditCodigo_Produto.SetFocus;
  end;

end;

procedure TFPedido.BtnInicializarCadastrosClick(Sender: TObject);
begin
FConexao.ConexaoBanco.ExecSQL('Delete from Produtos');

FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''FELIPE ROSLER VINHAS'', ''SANTA VITORIA DO PALMAR'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''NORBERTO LUCAS'', ''PELOTAS'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''JOAO FRANSCISCO CARDOSO'', ''SANTA VITORIA DO PALMAR'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''RUDINEI VINHAS'', ''PELOTAS'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''RAFAEL PEREIRA'', ''PELOTAS'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''PAULO ROTTA'', ''BOMBINHAS'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''MARIA AZAMBUJA'', ''CHUY'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''MATEUS TERRA'', ''SANTA VITORIA DO PALMAR'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''RAFAEL JORGE'', ''SAO PAULO'', ''SP'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''LUDOVICO'', ''RIO GRANDE'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''WAGNER MANCINE'', ''PORTO ALEGRE'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''FELIPE LUIS'', ''SALVADOR'', ''BA'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''PABLO ESTIMA'', ''PELOTAS'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''ANTONIO OPPTIZ'', ''PELOTAS'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''MARCELO MOGLIA'', ''BAGE'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''RICARDO WREGUE'', ''JAGUARAO'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''LUCAS SOUZA'', ''PINHEIRO MACHADO'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''FRANSCICO BASTOS'', ''URUGUAIANA'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''PAULO CARDOSO'', ''PORTO ALEGRE'', ''RS'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `clientes` (`NOME`, `CIDADE`, `ESTADO`) VALUES (''LETICIA PIO'', ''FLORIANOPOLIS'', ''SC'');');

FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''BANANA'', ''3'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''UVA'', ''8.9'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''MAÇA'', ''5'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''MELANCIA'', ''30'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''COCO'', ''8'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''FEIJAO'', ''9.4'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''ARROZ'', ''12.5'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''BROCOLIS'', ''0.9'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''ALFACE'', ''3'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''TOMATE'', ''8'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''REPOLHO'', ''3'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''CARNE MOIDA DE PRIMEIRA'', ''40'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''CARNE MOIDA DE SEGUNDA'', ''32'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''COSTELA MINGA'', ''28'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''COCA COLA'', ''8'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''FANTA'', ''5'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''FANTA UVA'', ''5'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''BIS'', ''5.4'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''CREME DENTAL COLGATE'', ''6'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''NEGRESCO'', ''3.3'');');
FConexao.ConexaoBanco.ExecSQL('INSERT INTO `produtos` (`DESCRICAO`, `PRECO_VENDA`) VALUES (''BONO CHOCOLATE'', ''3.4'');');

end;

procedure TFPedido.EditCodigoClienteExit(Sender: TObject);
begin
  if (EditCodigoCliente.Text <> inttostr(FPedido.ID_Cliente)) then
  begin
    EditNomeCliente.Text := FPedido.Auxiliar('Select * from Clientes where id = ''' + EditCodigoCliente.Text + '''');
  end;

end;

procedure TFPedido.EditCodigo_ProdutoExit(Sender: TObject);
begin
  if EditCodigo_Produto.Text <> '' then
  begin
    EditDescricao.Text := FPedidoItens.Auxiliar('Select DESCRICAO from Produtos Where ID = ''' + EditCodigo_Produto.Text + '''','DESCRICAO');
  end;
  EditQuantidade.SetFocus;
end;

procedure TFPedido.EditValor_UnitarioExit(Sender: TObject);
var
  vlcValorProduto  : Currency;
  vlcValorUnitario : Currency;
  vlcQuantidade    : Currency;
begin
  if (EditValor_Unitario.Text <> '') and (EditQuantidade.Text <> '') then
  begin
    vlcValorUnitario := StrToCurr(EditValor_Unitario.Text);
    vlcQuantidade    := StrToCurr(EditQuantidade.Text);
    vlcValorProduto := vlcQuantidade * vlcValorUnitario;
    FPedidoItens.Valor_Total := vlcValorProduto
  end
  else
  FPedidoItens.Valor_Total := 0;
end;

procedure TFPedido.FormCreate(Sender: TObject);
begin
  FPedido := TPedido.Create;
  FPedidoItens := TPedidoItens.Create;
end;

procedure TFPedido.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if (Key = VK_ESCAPE) and (PageControl1.ActivePage = TabSheet2) then
  begin
    PageControl1.ActivePage := TabSheet1;

    Pedidos.Close;
    Pedidos.Open;

    Pedido_Itens.Close;
    Pedido_itens.open;
  end;
  if (Key = VK_INSERT) then
  begin
    btnInserirClick(btnInserir);
  end;
end;

procedure TFPedido.FormShow(Sender: TObject);
begin
  ShowMessage('Dicas para Instalação' + #13 + #13 +
              'Criar Banco de Dados Mysql: wk' + #13 + #13 +
              ' Server: Localhost' + #13 + #13 +
              ' Porta: 3306' + #13 + #13 +
              ' Usuário: Root' + #13 + #13 +
              ' Senha: Sem Senha' + #13 + #13 +
              ' Local Dll: Mesma Exe');

  if (FConexao = nil) then
      FConexao := TConexaoBanco.Create;

  FConexao.CriarTabelas;
  Pedidos.Connection := FConexao.ConexaoBanco;
  Pedido_Itens.Connection := FConexao.ConexaoBanco;
  Pedidos.Open;

  PageControl1.ActivePage := TabSheet1;

  GrdPedidos.Columns[0].Width := trunc(GrdPedidos.Width * 10 / 100);
  GrdPedidos.Columns[0].Title.Caption := 'Pedido';
  GrdPedidos.Columns[1].Width := trunc(GrdPedidos.Width * 12 / 100);
  GrdPedidos.Columns[1].Title.Caption := 'Dt.Pedido';
  GrdPedidos.Columns[2].Width := trunc(GrdPedidos.Width * 53 / 100);
  GrdPedidos.Columns[2].Title.Caption := 'Cliente';
  GrdPedidos.Columns[3].Width := trunc(GrdPedidos.Width * 0 / 100);
  GrdPedidos.Columns[3].Title.Caption := 'Cliente';
  GrdPedidos.Columns[4].Width := trunc(GrdPedidos.Width * 20 / 100);
  GrdPedidos.Columns[4].Title.Caption := 'Valor Total';

  GridPedidoItens.Columns[0].Width := trunc(GridPedidoItens.Width * 0 / 100);
  GridPedidoItens.Columns[0].Title.Caption := 'Pedido';
  GridPedidoItens.Columns[1].Width := trunc(GridPedidoItens.Width * 5 / 100);
  GridPedidoItens.Columns[1].Title.Caption := 'Ord.';
  GridPedidoItens.Columns[2].Width := trunc(GridPedidoItens.Width * 10 / 100);
  GridPedidoItens.Columns[2].Title.Caption := 'Cód.Prod.';
  GridPedidoItens.Columns[3].Width := trunc(GridPedidoItens.Width * 40 / 100);
  GridPedidoItens.Columns[3].Title.Caption := 'Descrição';
  GridPedidoItens.Columns[4].Width := trunc(GridPedidoItens.Width * 15 / 100);
  GridPedidoItens.Columns[4].Title.Caption := 'Qtd.';
  GridPedidoItens.Columns[5].Width := trunc(GridPedidoItens.Width * 10 / 100);
  GridPedidoItens.Columns[5].Title.Caption := 'Vlr.Unit.';
  GridPedidoItens.Columns[6].Width := trunc(GridPedidoItens.Width * 15 / 100);
  GridPedidoItens.Columns[6].Title.Caption := 'Vlr.Total';


  if not (Pedidos.IsEmpty) then
  begin
  GrdPedidos.DataSource.DataSet.Locate('PEDIDO',PedidosPEDIDO.AsString,[loCaseInsensitive])
  end;
end;

procedure TFPedido.GrdPedidosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    PageControl1.ActivePage := TabSheet2;

    if FPedido.Search(PedidosPEDIDO.AsString) then
    begin
      Pedido_itens.Close;
      Pedido_itens.open;
      EditPedido.Text := PedidosPEDIDO.AsString;
      EditData.Text := PedidosDATA_PEDIDO.AsString;
      EditCodigoCliente.Text := PedidosID_CLIENTE.AsString;
      EditNomeCliente.Text := PedidosDESCRICAO_CLIENTE.AsString;
      EditValor_Total.Text := FormatFloat('0.00',PedidosVALOR_TOTAL.AsCurrency);

      BtnConfirmarPedido.Caption := 'Alterando - Confirmar';

    end;
    EditPedido.SetFocus;
  end;
  if Key = vk_delete then
  begin
      if MessageDlg('Deseja realmente Excluir o Pedido?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
      begin
          if FPedido.Delete(PedidosPEDIDO.AsString) then
          begin
            ShowMessage('Pedido Excluido com Sucesso!!!');
            Pedidos.Close;
            Pedidos.Open;
          end;
      end;
  end;
end;

end.
