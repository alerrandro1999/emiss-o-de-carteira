unit UnitRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, frxClass,
  frxDBSet, FireDAC.Comp.DataSet, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, frxRich, frxCross, frxOLE, frxBarcode, frxChBox, frxGradient,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TForm1 = class(TForm)
    painel: TPanel;
    Panel1: TPanel;
    edt_pesquisa: TEdit;
    Label1: TLabel;
    btn_pesquisa: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    Label2: TLabel;
    DBText1: TDBText;
    rel_ds_carteira: TfrxDBDataset;
    rel_carteira: TfrxReport;
    lbl_aviso: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    DBText2: TDBText;
    procedure btn_pesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UnitData;

procedure TForm1.btn_pesquisaClick(Sender: TObject);
var
nome_membro : string;
begin
    DataModule1.FDQuery3.Close;
    DataModule1.FDQuery3.Params.Clear;
    DataModule1.FDQuery3.SQL.Add('');
    DataModule1.FDQuery3.SQL.Clear;
    DataModule1.FDQuery3.SQL.Add('SELECT ID_MEMBRO, TB_MEMBROS.ID_MEMBRO, TB_MEMBROS.NOME, TB_CONGREGACAO.ID_CONGREGACAO, TB_CONGREGACAO.CONGREGACAO');
    DataModule1.FDQuery3.SQL.Add('FROM TB_MEMBROS');
    DataModule1.FDQuery3.SQL.Add('INNER JOIN TB_CONGREGACAO on TB_MEMBROS.ID_CONGREGACAO = TB_CONGREGACAO.ID_CONGREGACAO');
    DataModule1.FDQuery3.SQL.Add('WHERE NOME LIKE ''%'+edt_pesquisa.Text+'%''');

    DataModule1.FDQuery3.Open();

    if DataModule1.FDQuery3.IsEmpty then
    begin
      ShowMessage('Nehnum dado encontrado');
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  self := nil;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
 if DataModule1.FDConnection1.Connected = false then
 begin
 btn_pesquisa.Enabled := false;
 lbl_aviso.Visible := true;
 end;
end;

procedure TForm1.Panel2Click(Sender: TObject);
var
  id_membro : Integer;
begin
    id_membro := DBCtrlGrid1.DataSource.DataSet.FieldByName('ID_MEMBRO').AsInteger;
    DataModule1.FDQuery1.Close;
    DataModule1.FDQuery1.Params;
    DataModule1.FDQuery1.SQL.Add('');
    DataModule1.FDQuery1.SQL.Clear;
    DataModule1.FDQuery1.SQL.Add('SELECT TB_MEMBROS.ID_MEMBRO, TB_MEMBROS.NOME, TB_MEMBROS.CPF, TB_MEMBROS.RG, TB_MEMBROS.DATA_NASCIMENTO, TB_MEMBROS.DATA_ADIMISAO_IGREJA, TB_MEMBROS.VALIDADOR, TB_SEXO.ID_SEXO, TB_SEXO.SEXO,');
    DataModule1.FDQuery1.SQL.Add('TB_ESTADO_CIVIL.ID_ESTADO_CIVIL, TB_ESTADO_CIVIL.ESTADO_CIVIL, TB_FUNCAO_ECLESIASTICA.ID_FUNCAO_ECLESIASTICA,TB_FUNCAO_ECLESIASTICA.FUNCAO_ECLESIASTICA,');
    DataModule1.FDQuery1.SQL.Add('TB_CONGREGACAO.CONGREGACAO, TB_CONGREGACAO.ID_CONGREGACAO, TB_FOTO.ARQUIVO_CONTEUDO, TB_ORGAO_EMISSOR.ORGAO_EMISSOR,TB_ORGAO_EMISSOR.ID_ORGAO_EMISSOR, TB_BATISMO_AGUA.ID_BATISMO_AGUA, TB_BATISMO_AGUA.DATA_BATISMO_AGUA');
    DataModule1.FDQuery1.SQL.Add('FROM TB_MEMBROS');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_SEXO ON TB_SEXO.ID_SEXO = TB_MEMBROS.ID_SEXO');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_ORGAO_EMISSOR ON TB_MEMBROS.ID_ORGAO_EMISSOR = TB_ORGAO_EMISSOR.ID_ORGAO_EMISSOR');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_ESTADO_CIVIL ON TB_MEMBROS.ID_ESTADO_CIVIL = TB_ESTADO_CIVIL.ID_ESTADO_CIVIL');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_FUNCAO_ECLESIASTICA ON TB_MEMBROS.ID_FUNCAO_ECLESIASTICA = TB_FUNCAO_ECLESIASTICA.ID_FUNCAO_ECLESIASTICA');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_CONGREGACAO ON TB_MEMBROS.ID_CONGREGACAO = TB_CONGREGACAO.ID_CONGREGACAO');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_FOTO ON TB_MEMBROS.CPF = TB_FOTO.COD_MEMBRO');
    DataModule1.FDQuery1.SQL.Add('LEFT JOIN TB_BATISMO_AGUA ON TB_MEMBROS.CPF = TB_BATISMO_AGUA.COD_MEMBRO');
    DataModule1.FDQuery1.SQL.Add('WHERE TB_MEMBROS.ID_MEMBRO = :id_teste ');
    DataModule1.FDQuery1.ParamByName('id_teste').AsInteger := id_membro;
    DataModule1.FDQuery1.Open();
    rel_carteira.ShowReport();
end;

end.
