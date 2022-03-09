program neural_app;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uNeuron in 'uNeuron.pas',
  uNeuralLayer in 'uNeuralLayer.pas',
  uMnistReader in 'uMnistReader.pas',
  uDatabase in 'uDatabase.pas',
  uTypes in 'uTypes.pas',
  uNeuralNetwork in 'uNeuralNetwork.pas';

{$R *.res}

begin
  InitDatabase;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
