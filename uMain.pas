unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin;

type
  TfrmMain = class(TForm)
    sbMain: TStatusBar;
    pnlLoadDataset: TPanel;
    edtLabelFile: TButtonedEdit;
    btnLoadLabel: TButton;
    btnLoadImage: TButton;
    edtImageFile: TButtonedEdit;
    btnLoadDataset: TButton;
    btnTrainNetwork: TButton;
    dlgFileOpen: TFileOpenDialog;
    gbMnistDataset: TGroupBox;
    cbNeuronType: TComboBox;
    lbNeuronType: TLabel;
    lbLayerCount: TLabel;
    edLayerCount: TSpinEdit;
    lbInputCount: TLabel;
    edInputCount: TSpinEdit;
    lbNeuronCount: TLabel;
    edNeuronCount: TSpinEdit;
    gbPlayground: TGroupBox;
    Panel1: TPanel;
    procedure btnLoadLabelClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnLoadDatasetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTrainNetworkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

Uses uTypes, uMnistReader, uNeuralNetwork, uDatabase, Math;

procedure TfrmMain.btnLoadLabelClick(Sender: TObject);
begin
  if dlgFileOpen.Execute then
    edtLabelFile.Text := dlgFileOpen.FileName;
end;

procedure TfrmMain.btnTrainNetworkClick(Sender: TObject);
var
  NeuralNetwork: CNeuralNetwork;
  InputValues: TByteArray;
  OutputValues: TDecimalArray;
  NeuronType: TNeuronType;
  LayerCount,
  InputCount,
  NeuronCount: Byte;
  ImageRecord: TImageRecord;
  ImageRecordList: TImageRecordList;
  I: Integer;
begin
  ImageRecordList := TImageRecordList.Create;

  NeuronType := TNeuronType(cbNeuronType.ItemIndex);
  LayerCount := edLayerCount.Value;
  InputCount := edInputCount.Value;
  NeuronCount := edNeuronCount.VaLue;

  Database.SetImageRecordList(ImageRecordList);

  for I := 0 to ImageRecordList.Count-1 do
  begin
    ImageRecord := ImageRecordList[I];
    InputValues := ImageRecord.ContentAsArray;

    NeuralNetwork := CNeuralNetwork.Create(NeuronType, LayerCount, InputCount, NeuronCount, InputValues);

    OutputValues := NeuralNetwork.GetOutputValues;

    NeuralNetwork.Destroy;

    ImageRecord.Value := MaxValue(OutputValues);

    Database.SaveImageRecord(ImageRecord);
  end;
end;

procedure TfrmMain.btnLoadImageClick(Sender: TObject);
begin
  if dlgFileOpen.Execute then
    edtImageFile.Text := dlgFileOpen.FileName;
end;

procedure TfrmMain.btnLoadDatasetClick(Sender: TObject);
var
  MnistReader: CMnistReader;
begin
  MnistReader := CMnistReader.Create;
  MnistReader.Init(edtLabelFile.Text, edtImageFile.Text);

  MnistReader.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  edtLabelFile.Text := ExtractFilePath(Application.ExeName) + 'data\train-labels.idx1-ubyte';
  edtImageFile.Text := ExtractFilePath(Application.ExeName) + 'data\train-images.idx3-ubyte';
end;

end.
