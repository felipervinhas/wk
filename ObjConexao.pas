unit ObjConexao;

interface

uses

  FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.Forms, FireDAC.Comp.DataSet;

type

   TConexaoBanco = class
      private
       FConexaoBanco : TFDConnection;
      public
       FQry      : TFDQuery;

       constructor Create;
       destructor  Destroy; override;

       function GetConexao : TFDConnection;
       property ConexaoBanco : TFDConnection   read GetConexao;
       Procedure CriarTabelas;

   end;

implementation

{ TConexaoBanco }

constructor TConexaoBanco.Create;
var
  Phys : TFDPhysMySQLDriverLink;
begin
  try
    fConexaoBanco := TFDConnection.Create(nil);
    Phys := TFDPhysMySQLDriverLink.Create(nil);
    fConexaoBanco.LoginPrompt := false;
    with fConexaoBanco do
    begin
     params.Database:= 'wk';
     params.UserName:= 'root';
     params.Password:= '';
     params.DriverID:= 'MySQL';

     Params.Add('Server=Localhost');
     Params.Add('Port=3306');

     Phys.VendorHome := '';
     Connected := true;

    end;
  finally

  end;
end;

procedure TConexaoBanco.CriarTabelas;
begin
  try
    FConexaoBanco.ExecSQL('CREATE TABLE clientes' +
                          '( ID INT NOT NULL AUTO_INCREMENT ,' +
                          '  NOME VARCHAR(300) NOT NULL ,' +
                          '  CIDADE VARCHAR(250) NOT NULL ,' +
                          '  ESTADO VARCHAR(2) NOT NULL ,' +
                          '  PRIMARY KEY (ID));');
  Except

  end;


  try
    FConexaoBanco.ExecSQL('CREATE TABLE produtos' +
                          '( ID INT NOT NULL AUTO_INCREMENT ,' +
                          '  DESCRICAO VARCHAR(300) NOT NULL ,' +
                          '  PRECO_VENDA  DECIMAL(7,2) NOT NULL ,' +
                          '  PRIMARY KEY (ID));');
  Except

  end;

  try

    FConexaoBanco.ExecSQL('CREATE TABLE pedido' +
                          '( PEDIDO INT NOT NULL AUTO_INCREMENT ,' +
                          '  DATA_PEDIDO DATE NOT NULL ,' +
                          '  ID_CLIENTE INT NULL DEFAULT 0,' +
                          '  VALOR_TOTAL DECIMAL(7,2) NULL DEFAULT 0,' +
                          '  PRIMARY KEY (PEDIDO),' +
                          '  FOREIGN KEY (ID_CLIENTE)' +
                          '  REFERENCES CLIENTES(ID));');

  Except

  end;

  try

    FConexaoBanco.ExecSQL('CREATE TABLE pedido_itens' +
                          '( PEDIDO INT NOT NULL ,' +
                          '  ID_ITEM INT NOT NULL AUTO_INCREMENT,' +
                          '  ID_PRODUTO INT NULL DEFAULT 0,' +
                          '  QUANTIDADE DECIMAL(7,2) NOT NULL DEFAULT 0,' +
                          '  VALOR_UNITARIO DECIMAL(7,2) NOT NULL DEFAULT 0,' +
                          '  VALOR_TOTAL DECIMAL(7,2) NOT NULL DEFAULT 0,' +
                          '  PRIMARY KEY (ID_ITEM),' +
                          '  FOREIGN KEY (Pedido)' +
                          '  REFERENCES Pedido (Pedido)' +
                          '  ON DELETE CASCADE);');
  Except

  end;

    try

    FConexaoBanco.ExecSQL('CREATE TRIGGER `pedidos_delete` BEFORE DELETE ON `pedido`' +
                          ' FOR EACH ROW DELETE FROM pedido_itens' +
                          '    WHERE pedido_itens.PEDIDO = OLD.PEDIDO');
  Except

  end;
end;

destructor TConexaoBanco.Destroy;
begin
  FConexaoBanco.Free;
  inherited;
end;

function TConexaoBanco.GetConexao: TFDConnection;
begin
   Result := FConexaoBanco;
end;


end.
