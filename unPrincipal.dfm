object FPedido: TFPedido
  Left = 0
  Top = 0
  Caption = 'WK Technology'
  ClientHeight = 535
  ClientWidth = 850
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 43
    Width = 844
    Height = 489
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Lista de Pedidos'
      object Label6: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 443
        Width = 830
        Height = 14
        Align = alBottom
        Caption = 'Para acessar os dados do Pedido selecionar utilize a tecla ENTER'
        ExplicitWidth = 410
      end
      object GrdPedidos: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 830
        Height = 434
        Align = alClient
        DataSource = dsPedidos
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Verdana'
        TitleFont.Style = []
        OnKeyUp = GrdPedidosKeyUp
        Columns = <
          item
            Expanded = False
            FieldName = 'PEDIDO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_PEDIDO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_CLIENTE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_CLIENTE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR_TOTAL'
            Visible = True
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dados de Pedidos'
      ImageIndex = 1
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 443
        Width = 830
        Height = 14
        Align = alBottom
        Caption = 'Utilize ESC para retornar a Listagem de Pedidos'
        ExplicitWidth = 303
      end
      object GridPedidoItens: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 149
        Width = 830
        Height = 257
        Align = alClient
        DataSource = dsPedido_Itens
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Verdana'
        TitleFont.Style = []
        OnKeyDown = GridPedidoItensKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'PEDIDO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_ITEM'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_PRODUTO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR_UNITARIO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR_TOTAL'
            Visible = True
          end>
      end
      object GridPedido: TGridPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 830
        Height = 70
        Align = alTop
        ColumnCollection = <
          item
            Value = 15.891107504290330000
          end
          item
            Value = 15.891107504290330000
          end
          item
            Value = 10.000000000000000000
          end
          item
            Value = 42.457259754602870000
          end
          item
            Value = 15.760525236816460000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = LabelPedido
            Row = 0
          end
          item
            Column = 1
            Control = LabelData
            Row = 0
          end
          item
            Column = 2
            Control = LabelCodigoCliente
            Row = 0
          end
          item
            Column = 0
            Control = EditPedido
            Row = 1
          end
          item
            Column = 1
            Control = EditData
            Row = 1
          end
          item
            Column = 3
            Control = LabelNome
            Row = 0
          end
          item
            Column = 4
            Control = LabelValor
            Row = 0
          end
          item
            Column = 2
            Control = EditCodigoCliente
            Row = 1
          end
          item
            Column = 3
            Control = EditNomeCliente
            Row = 1
          end
          item
            Column = 4
            Control = EditValor_Total
            Row = 1
          end>
        RowCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        TabOrder = 1
        object LabelPedido: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 126
          Height = 28
          Align = alClient
          Caption = 'Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowFrame
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 45
          ExplicitHeight = 14
        end
        object LabelData: TLabel
          AlignWithMargins = True
          Left = 136
          Top = 4
          Width = 125
          Height = 28
          Align = alClient
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowFrame
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 31
          ExplicitHeight = 14
        end
        object LabelCodigoCliente: TLabel
          AlignWithMargins = True
          Left = 267
          Top = 4
          Width = 77
          Height = 28
          Align = alClient
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowFrame
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 45
          ExplicitHeight = 14
        end
        object EditPedido: TEdit
          AlignWithMargins = True
          Left = 4
          Top = 38
          Width = 126
          Height = 28
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          ExplicitHeight = 22
        end
        object EditData: TEdit
          AlignWithMargins = True
          Left = 136
          Top = 38
          Width = 125
          Height = 28
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          ExplicitHeight = 22
        end
        object LabelNome: TLabel
          AlignWithMargins = True
          Left = 350
          Top = 4
          Width = 346
          Height = 28
          Align = alClient
          Anchors = []
          Caption = 'Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowFrame
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 46
          ExplicitHeight = 14
        end
        object LabelValor: TLabel
          AlignWithMargins = True
          Left = 702
          Top = 4
          Width = 124
          Height = 28
          Align = alClient
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Valor Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowFrame
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 754
          ExplicitWidth = 72
          ExplicitHeight = 14
        end
        object EditCodigoCliente: TEdit
          AlignWithMargins = True
          Left = 267
          Top = 38
          Width = 77
          Height = 28
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnExit = EditCodigoClienteExit
          ExplicitHeight = 22
        end
        object EditNomeCliente: TEdit
          AlignWithMargins = True
          Left = 350
          Top = 38
          Width = 346
          Height = 28
          Align = alClient
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          ExplicitHeight = 22
        end
        object EditValor_Total: TEdit
          AlignWithMargins = True
          Left = 702
          Top = 38
          Width = 124
          Height = 28
          TabStop = False
          Align = alClient
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          ExplicitHeight = 22
        end
      end
      object BtnConfirmarPedido: TButton
        AlignWithMargins = True
        Left = 3
        Top = 412
        Width = 830
        Height = 25
        Align = alBottom
        Caption = 'Confirmar'
        TabOrder = 2
        OnClick = BtnConfirmarPedidoClick
        OnExit = BtnConfirmarPedidoExit
      end
      object PanelProduto: TPanel
        Left = 0
        Top = 76
        Width = 836
        Height = 70
        Align = alTop
        Color = clTeal
        ParentBackground = False
        TabOrder = 3
        object GridPanel1: TGridPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 747
          Height = 62
          Align = alClient
          ColumnCollection = <
            item
              Value = 17.021276595744680000
            end
            item
              Value = 48.936170212765950000
            end
            item
              Value = 17.021276595744680000
            end
            item
              Value = 17.021276595744680000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = Label2
              Row = 0
            end
            item
              Column = 1
              Control = Label3
              Row = 0
            end
            item
              Column = 2
              Control = Label4
              Row = 0
            end
            item
              Column = 0
              Control = EditCodigo_Produto
              Row = 1
            end
            item
              Column = 1
              Control = EditDescricao
              Row = 1
            end
            item
              Column = 2
              Control = EditQuantidade
              Row = 1
            end
            item
              Column = 3
              Control = Label5
              Row = 0
            end
            item
              Column = 3
              Control = EditValor_Unitario
              Row = 1
            end>
          RowCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end
            item
              SizeStyle = ssAuto
            end>
          TabOrder = 0
          ExplicitLeft = -196
          ExplicitTop = 44
          object Label2: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 121
            Height = 24
            Align = alClient
            Caption = 'C'#243'd.Produto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 81
            ExplicitHeight = 14
          end
          object Label3: TLabel
            AlignWithMargins = True
            Left = 131
            Top = 4
            Width = 358
            Height = 24
            Align = alClient
            Caption = 'Descri'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 65
            ExplicitHeight = 14
          end
          object Label4: TLabel
            AlignWithMargins = True
            Left = 495
            Top = 4
            Width = 121
            Height = 24
            Align = alClient
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 76
            ExplicitHeight = 14
          end
          object EditCodigo_Produto: TEdit
            AlignWithMargins = True
            Left = 4
            Top = 34
            Width = 121
            Height = 24
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnExit = EditCodigo_ProdutoExit
            ExplicitHeight = 22
          end
          object EditDescricao: TEdit
            AlignWithMargins = True
            Left = 131
            Top = 34
            Width = 358
            Height = 24
            TabStop = False
            Align = alClient
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            ExplicitHeight = 22
          end
          object EditQuantidade: TEdit
            AlignWithMargins = True
            Left = 495
            Top = 34
            Width = 121
            Height = 24
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            ExplicitHeight = 22
          end
          object Label5: TLabel
            AlignWithMargins = True
            Left = 622
            Top = 4
            Width = 121
            Height = 24
            Align = alClient
            Caption = 'Valor Unit'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 92
            ExplicitHeight = 14
          end
          object EditValor_Unitario: TEdit
            AlignWithMargins = True
            Left = 622
            Top = 34
            Width = 121
            Height = 24
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnExit = EditValor_UnitarioExit
            ExplicitHeight = 22
          end
        end
        object BtnConfirmarItens: TButton
          AlignWithMargins = True
          Left = 757
          Top = 4
          Width = 75
          Height = 62
          Align = alRight
          Caption = 'Confirmar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = BtnConfirmarItensClick
        end
      end
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 40
    Align = alTop
    TabOrder = 1
    object LabelWK: TLabel
      Left = 188
      Top = 1
      Width = 537
      Height = 38
      Align = alClient
      Alignment = taCenter
      Caption = 'WK Technology'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -20
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 174
      ExplicitHeight = 25
    end
    object btnInserir: TButton
      AlignWithMargins = True
      Left = 728
      Top = 4
      Width = 118
      Height = 32
      Align = alRight
      Caption = 'INS - Inserir'
      TabOrder = 0
      TabStop = False
      OnClick = btnInserirClick
    end
    object BtnInicializarCadastros: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 181
      Height = 32
      Align = alLeft
      Caption = 'Inicializar Cadastros'
      TabOrder = 1
      TabStop = False
      OnClick = BtnInicializarCadastrosClick
      ExplicitLeft = 12
      ExplicitTop = 8
    end
  end
  object Pedidos: TFDQuery
    OnCalcFields = PedidosCalcFields
    SQL.Strings = (
      
        'Select PEDIDO.*, clientes.NOME, clientes.CIDADE, clientes.ESTADO' +
        ' from PEDIDO left join clientes ON clientes.ID = PEDIDO.ID_CLIEN' +
        'TE')
    Left = 248
    Top = 240
    object PedidosPEDIDO: TFDAutoIncField
      FieldName = 'PEDIDO'
      Origin = 'PEDIDO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object PedidosDATA_PEDIDO: TDateField
      FieldName = 'DATA_PEDIDO'
      Origin = 'DATA_PEDIDO'
      Required = True
    end
    object PedidosID_CLIENTE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
    end
    object PedidosVALOR_TOTAL: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      currency = True
      Precision = 7
      Size = 2
    end
    object PedidosDESCRICAO_CLIENTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'DESCRICAO_CLIENTE'
      Size = 500
      Calculated = True
    end
  end
  object dsPedidos: TDataSource
    DataSet = Pedidos
    Left = 336
    Top = 240
  end
  object Pedido_Itens: TFDQuery
    BeforeOpen = Pedido_ItensBeforeOpen
    AfterScroll = Pedido_ItensAfterScroll
    OnCalcFields = Pedido_ItensCalcFields
    SQL.Strings = (
      'Select *'
      'from pedido_itens'
      'Where Pedido=:Pedido')
    Left = 248
    Top = 296
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
    object Pedido_ItensPEDIDO: TIntegerField
      FieldName = 'PEDIDO'
      Required = True
    end
    object Pedido_ItensID_ITEM: TFDAutoIncField
      FieldName = 'ID_ITEM'
      ReadOnly = True
    end
    object Pedido_ItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object Pedido_ItensQUANTIDADE: TBCDField
      FieldName = 'QUANTIDADE'
      Precision = 7
      Size = 2
    end
    object Pedido_ItensVALOR_UNITARIO: TBCDField
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = ',0.00'
      Precision = 7
      Size = 2
    end
    object Pedido_ItensVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = ',0.00'
      Precision = 7
      Size = 2
    end
    object Pedido_ItensDESCRICAO: TStringField
      FieldKind = fkCalculated
      FieldName = 'DESCRICAO'
      Size = 150
      Calculated = True
    end
  end
  object dsPedido_Itens: TDataSource
    DataSet = Pedido_Itens
    Left = 336
    Top = 296
  end
end
