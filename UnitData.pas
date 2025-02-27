unit UnitData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, frxClass,
  frxDBSet, FireDAC.Comp.DataSet, Dialogs;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1NOME: TStringField;
    FDQuery1CPF: TStringField;
    FDQuery1RG: TStringField;
    FDQuery1DATA_NASCIMENTO: TDateField;
    FDQuery1ID_SEXO: TIntegerField;
    FDQuery1SEXO: TStringField;
    FDQuery1ID_ESTADO_CIVIL: TIntegerField;
    FDQuery1ESTADO_CIVIL: TStringField;
    FDQuery1ID_FUNCAO_ECLESIASTICA: TIntegerField;
    FDQuery1FUNCAO_ECLESIASTICA: TStringField;
    FDQuery1CONGREGACAO: TStringField;
    FDQuery1ARQUIVO_CONTEUDO: TBlobField;
    FDQuery1ID_CONGREGACAO: TIntegerField;
    FDQuery1DATA_BATISMO_AGUA: TDateField;
    FDQuery1ORGAO_EMISSOR: TStringField;
    FDQuery1DATA_ADIMISAO_IGREJA: TDateField;
    FDQuery1VALIDADOR: TStringField;
    FDQuery1ID_MEMBRO: TIntegerField;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    FDQuery3ID_MEMBRO: TFDAutoIncField;
    FDQuery3NOME: TStringField;
    DataSource3: TDataSource;
    FDQuery2ID_MEMBRO: TFDAutoIncField;
    FDQuery2NOME: TStringField;
    FDQuery3ID_CONGREGACAO: TIntegerField;
    FDQuery3CONGREGACAO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  try
       FDConnection1.Connected := true;
       FDConnection1.Params.Add('db_ieda.mysql.dbaas.com.br');
       FDQuery3.Open();
   except
     begin
       FDConnection1.Params.Add('');
       FDConnection1.Connected := false;
       ShowMessage('Sem conex�o com a internet');
     end;
   end;
  end;
end.
