program ProjetoRelatorio;

uses
  Vcl.Forms,
  UnitRelatorio in 'UnitRelatorio.pas' {Form1},
  UnitData in 'UnitData.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Mensagem';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
