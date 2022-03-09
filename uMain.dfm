object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Artificial Neural Networks Sample Application'
  ClientHeight = 539
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object sbMain: TStatusBar
    Left = 0
    Top = 520
    Width = 797
    Height = 19
    Panels = <>
  end
  object pnlLoadDataset: TPanel
    Left = 0
    Top = 0
    Width = 797
    Height = 520
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object gbMnistDataset: TGroupBox
      Left = 0
      Top = 0
      Width = 797
      Height = 153
      Align = alTop
      Caption = 'MNIST Dataset'
      TabOrder = 0
      object lbNeuronType: TLabel
        Left = 6
        Top = 96
        Width = 67
        Height = 15
        Caption = 'Neuron Type'
      end
      object lbLayerCount: TLabel
        Left = 132
        Top = 96
        Width = 64
        Height = 15
        Caption = 'Layer Count'
      end
      object lbInputCount: TLabel
        Left = 258
        Top = 96
        Width = 64
        Height = 15
        Caption = 'Input Count'
      end
      object lbNeuronCount: TLabel
        Left = 384
        Top = 96
        Width = 76
        Height = 15
        Caption = 'Neuron Count'
      end
      object btnLoadDataset: TButton
        Left = 606
        Top = 51
        Width = 90
        Height = 25
        Caption = 'Load Dataset'
        TabOrder = 0
        OnClick = btnLoadDatasetClick
      end
      object btnLoadImage: TButton
        Left = 510
        Top = 51
        Width = 90
        Height = 25
        Caption = 'Image File'
        TabOrder = 1
        OnClick = btnLoadImageClick
      end
      object btnLoadLabel: TButton
        Left = 510
        Top = 20
        Width = 90
        Height = 25
        Caption = 'Label File'
        TabOrder = 2
        OnClick = btnLoadLabelClick
      end
      object btnTrainNetwork: TButton
        Left = 510
        Top = 116
        Width = 90
        Height = 25
        Caption = 'Train Network'
        TabOrder = 3
        OnClick = btnTrainNetworkClick
      end
      object edtImageFile: TButtonedEdit
        Left = 6
        Top = 52
        Width = 498
        Height = 23
        RightButton.Visible = True
        TabOrder = 4
        Text = 
          'C:\Users\huseyin\Documents\RAD Studio\Projects\neural_app\data\t' +
          'rain-images.idx3-ubyte'
      end
      object edtLabelFile: TButtonedEdit
        Left = 6
        Top = 22
        Width = 498
        Height = 23
        RightButton.Visible = True
        TabOrder = 5
        Text = 
          'C:\Users\huseyin\Documents\RAD Studio\Projects\neural_app\data\t' +
          'rain-labels.idx1-ubyte'
      end
      object cbNeuronType: TComboBox
        Left = 6
        Top = 117
        Width = 120
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 6
        Text = 'Sinus'
        Items.Strings = (
          'Binary'
          'Sinus'
          'Value')
      end
      object edLayerCount: TSpinEdit
        Left = 132
        Top = 117
        Width = 120
        Height = 24
        MaxValue = 5
        MinValue = 2
        TabOrder = 7
        Value = 2
      end
      object edInputCount: TSpinEdit
        Left = 258
        Top = 117
        Width = 120
        Height = 24
        MaxValue = 5
        MinValue = 2
        TabOrder = 8
        Value = 4
      end
      object edNeuronCount: TSpinEdit
        Left = 384
        Top = 117
        Width = 120
        Height = 24
        MaxValue = 5
        MinValue = 2
        TabOrder = 9
        Value = 3
      end
    end
    object gbPlayground: TGroupBox
      Left = 0
      Top = 153
      Width = 797
      Height = 367
      Align = alClient
      Caption = 'Playground'
      TabOrder = 1
      object Panel1: TPanel
        Left = 2
        Top = 17
        Width = 793
        Height = 348
        Align = alClient
        Caption = 'Coming Soon..'
        Enabled = False
        TabOrder = 0
      end
    end
  end
  object dlgFileOpen: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 748
    Top = 18
  end
end
